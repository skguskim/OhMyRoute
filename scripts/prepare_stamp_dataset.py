#!/usr/bin/env python3
"""외부 AI Hub 전통 문양 데이터에서 로컬 전용 스탬프 학습 목록을 만든다.

원본 이미지와 JSON은 저장소 밖에 둔다. 이 스크립트는 파일을 복사하지 않고
절대경로와 선별 메타데이터만 data/local-stamps 아래에 기록한다. 해당 폴더는
.gitignore에 포함되어 있으므로 원본 및 AI Hub 라벨이 Git에 들어가지 않는다.
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import random
import sys
import zipfile
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any, Iterable


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_OUTPUT = ROOT / "data" / "local-stamps" / "aihub-pattern-manifest.jsonl"
DATASET_URL = (
    "https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&dataSetSn=71809"
)
IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp", ".bmp", ".tif", ".tiff"}
KNOWN_PATTERN_TYPES = (
    "인물문",
    "동물문",
    "식물문",
    "인공물문",
    "자연산수문",
    "문자문",
    "기하문",
    "복합문",
)


def load_dotenv(path: Path = ROOT / ".env") -> None:
    if not path.exists():
        return
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.strip()
        value = value.strip().strip('"').strip("'")
        if key and key not in os.environ:
            os.environ[key] = value


def iter_label_records(value: Any) -> Iterable[dict[str, Any]]:
    """AI Hub JSON 내부에서 pattern_file_name을 가진 레코드를 찾는다."""
    if isinstance(value, dict):
        images = value.get("images")
        if isinstance(images, dict) and images.get("pattern_file_name"):
            yield value
            return
        for nested in value.values():
            yield from iter_label_records(nested)
    elif isinstance(value, list):
        for nested in value:
            yield from iter_label_records(nested)


def is_pattern_bundle(path: Path, kind: str) -> bool:
    name = path.name
    return kind in name and "객체및문양" not in name


def image_index(source_dir: Path) -> dict[str, list[dict[str, str]]]:
    index: dict[str, list[dict[str, str]]] = defaultdict(list)
    for path in source_dir.rglob("*"):
        if path.is_file() and path.suffix.lower() in IMAGE_EXTENSIONS:
            index[path.stem.casefold()].append({
                "image_path": str(path.resolve()),
                "image_zip_path": "",
                "image_entry": "",
            })
    for zip_path in source_dir.rglob("*.zip"):
        if not is_pattern_bundle(zip_path, "문양이미지데이터"):
            continue
        try:
            with zipfile.ZipFile(zip_path) as archive:
                for entry in archive.infolist():
                    if entry.is_dir() or Path(entry.filename).suffix.lower() not in IMAGE_EXTENSIONS:
                        continue
                    index[Path(entry.filename).stem.casefold()].append({
                        "image_path": "",
                        "image_zip_path": str(zip_path.resolve()),
                        "image_entry": entry.filename,
                    })
        except (OSError, zipfile.BadZipFile):
            continue
    return index


def read_vertical_metadata(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        for row in csv.reader(handle):
            if not row or not row[0].strip():
                continue
            result[row[0].strip()] = ", ".join(value.strip() for value in row[1:]).strip()
    return result


def metadata_index(source_dir: Path) -> tuple[dict[str, dict[str, str]], Counter[str]]:
    index: dict[str, dict[str, str]] = {}
    stats: Counter[str] = Counter()
    for path in source_dir.rglob("*.csv"):
        stats["metadata_files"] += 1
        try:
            record = read_vertical_metadata(path)
        except (OSError, UnicodeError, csv.Error):
            stats["unreadable_metadata_files"] += 1
            continue
        pattern_file_name = first_text(record, "pattern_file_name")
        if not pattern_file_name:
            stats["metadata_missing_pattern_file_name"] += 1
            continue
        record["metadata_path"] = str(path.resolve())
        index[Path(pattern_file_name).stem.casefold()] = record
    stats["indexed_metadata"] = len(index)
    return index, stats


def iter_json_documents(source_dir: Path) -> Iterable[tuple[dict[str, Any], dict[str, str]]]:
    for path in source_dir.rglob("*.json"):
        try:
            payload = json.loads(path.read_text(encoding="utf-8-sig"))
        except (OSError, UnicodeError, json.JSONDecodeError):
            yield {}, {
                "label_path": str(path.resolve()),
                "label_zip_path": "",
                "label_entry": "",
                "error": "unreadable",
            }
            continue
        yield payload, {
            "label_path": str(path.resolve()),
            "label_zip_path": "",
            "label_entry": "",
            "error": "",
        }

    for zip_path in source_dir.rglob("*.zip"):
        if not is_pattern_bundle(zip_path, "문양라벨링데이터"):
            continue
        try:
            with zipfile.ZipFile(zip_path) as archive:
                for entry in archive.infolist():
                    if entry.is_dir() or Path(entry.filename).suffix.lower() != ".json":
                        continue
                    locator = {
                        "label_path": "",
                        "label_zip_path": str(zip_path.resolve()),
                        "label_entry": entry.filename,
                        "error": "",
                    }
                    try:
                        payload = json.loads(archive.read(entry).decode("utf-8-sig"))
                    except (OSError, UnicodeError, json.JSONDecodeError, KeyError):
                        locator["error"] = "unreadable"
                        yield {}, locator
                        continue
                    yield payload, locator
        except (OSError, zipfile.BadZipFile):
            continue


def first_text(mapping: Any, *keys: str) -> str:
    if not isinstance(mapping, dict):
        return ""
    for key in keys:
        value = mapping.get(key)
        if value is not None and str(value).strip():
            return str(value).strip()
    return ""


def normalize_record(
    record: dict[str, Any],
    label_locator: dict[str, str],
    images_by_stem: dict[str, list[dict[str, str]]],
) -> dict[str, Any]:
    images = record.get("images") or {}
    caption_kor = record.get("caption_kor") or {}
    pattern_file_name = first_text(images, "pattern_file_name")
    candidates = images_by_stem.get(Path(pattern_file_name).stem.casefold(), [])
    image_locator = candidates[0] if candidates else {
        "image_path": "",
        "image_zip_path": "",
        "image_entry": "",
    }

    return {
        "record_id": f"{first_text(images, 'relic_no')}:{pattern_file_name}",
        "pattern_file_name": pattern_file_name,
        **image_locator,
        "label_path": label_locator.get("label_path", ""),
        "label_zip_path": label_locator.get("label_zip_path", ""),
        "label_entry": label_locator.get("label_entry", ""),
        "metadata_path": "",
        "pattern_type": first_text(images, "pattern_type"),
        "pattern_type_detail": first_text(images, "pattern_type_detail_kor"),
        "pattern_symbol": first_text(images, "pattern_symbol"),
        "relic_name": first_text(images, "relic_name_kor", "relic_common_name_kor"),
        "relic_no": first_text(images, "relic_no"),
        "era": first_text(images, "era"),
        "material": first_text(images, "material"),
        "color": first_text(images, "color"),
        "source": first_text(images, "source"),
        "caption": first_text(caption_kor, "normal_kor", "description_kor", "context_kor"),
        "symbolism": first_text(caption_kor, "symbolism_kor"),
        "keywords": first_text(caption_kor, "keyword_kor"),
        "dataset": "AI Hub 한국 전통 문양 데이터",
        "dataset_url": DATASET_URL,
        "rights_scope": "AI Hub 이용조건 적용; 원본 데이터 저장소 미포함",
    }


def normalize_distributed_record(
    metadata: dict[str, str],
    captions: dict[str, Any],
    label_locator: dict[str, str],
    images_by_stem: dict[str, list[dict[str, str]]],
) -> dict[str, Any]:
    caption_kor = captions.get("caption_kor") or {}
    pattern_file_name = first_text(metadata, "pattern_file_name")
    candidates = images_by_stem.get(Path(pattern_file_name).stem.casefold(), [])
    image_locator = candidates[0] if candidates else {
        "image_path": "",
        "image_zip_path": "",
        "image_entry": "",
    }
    return {
        "record_id": f"{first_text(metadata, 'relic_no')}:{pattern_file_name}",
        "pattern_file_name": pattern_file_name,
        **image_locator,
        "label_path": label_locator.get("label_path", ""),
        "label_zip_path": label_locator.get("label_zip_path", ""),
        "label_entry": label_locator.get("label_entry", ""),
        "metadata_path": first_text(metadata, "metadata_path"),
        "pattern_type": first_text(metadata, "pattern_type"),
        "pattern_type_detail": first_text(metadata, "pattern_type_detail_kor"),
        "pattern_symbol": first_text(metadata, "pattern_symbol"),
        "pattern_usage": first_text(metadata, "pattern_usage"),
        "pattern_usage_detail": first_text(metadata, "pattern_usage_detail"),
        "relic_name": first_text(metadata, "relic_name_kor", "relic_common_name_kor"),
        "relic_no": first_text(metadata, "relic_no"),
        "era": first_text(metadata, "era"),
        "material": first_text(metadata, "material"),
        "color": first_text(metadata, "color"),
        "source": first_text(metadata, "source"),
        "caption": first_text(caption_kor, "normal_kor", "description_kor", "context_kor"),
        "symbolism": first_text(caption_kor, "symbolism_kor"),
        "keywords": first_text(caption_kor, "keyword_kor"),
        "dataset": "AI Hub 한국 전통 문양 데이터",
        "dataset_url": DATASET_URL,
        "rights_scope": "AI Hub 이용조건 적용; 원본 데이터 저장소 미포함",
    }


def collect_records(
    source_dir: Path | None = None,
    *,
    images_dir: Path | None = None,
    labels_dir: Path | None = None,
    metadata_dir: Path | None = None,
) -> tuple[list[dict[str, Any]], Counter[str]]:
    if source_dir is None and (images_dir is None or labels_dir is None or metadata_dir is None):
        raise ValueError("source_dir 또는 images_dir, labels_dir, metadata_dir가 필요합니다.")
    images_dir = images_dir or source_dir
    labels_dir = labels_dir or source_dir
    metadata_dir = metadata_dir or source_dir
    assert images_dir is not None and labels_dir is not None and metadata_dir is not None

    images_by_stem = image_index(images_dir)
    metadata_by_stem, metadata_stats = metadata_index(metadata_dir)
    records: list[dict[str, Any]] = []
    stats: Counter[str] = Counter(metadata_stats)
    seen: set[str] = set()

    for payload, label_locator in iter_json_documents(labels_dir):
        stats["json_files"] += 1
        if label_locator.get("error"):
            stats["unreadable_json_files"] += 1
            continue

        nested_records = list(iter_label_records(payload))
        if nested_records:
            normalized_records = [
                normalize_record(raw_record, label_locator, images_by_stem)
                for raw_record in nested_records
            ]
        else:
            label_name = label_locator.get("label_entry") or label_locator.get("label_path", "")
            stem = Path(label_name).stem.casefold()
            metadata = metadata_by_stem.get(stem)
            if metadata is None:
                stats["missing_metadata"] += 1
                continue
            normalized_records = [
                normalize_distributed_record(metadata, payload, label_locator, images_by_stem)
            ]

        for record in normalized_records:
            dedupe_key = record["record_id"] or f"{record['label_path']}:{record['pattern_file_name']}"
            if dedupe_key in seen:
                stats["duplicate_records"] += 1
                continue
            seen.add(dedupe_key)
            if not record["pattern_type"]:
                stats["missing_pattern_type"] += 1
            if not record["image_path"] and not record["image_zip_path"]:
                stats["missing_pattern_image"] += 1
            records.append(record)

    stats["indexed_images"] = sum(len(paths) for paths in images_by_stem.values())
    stats["unique_records"] = len(records)
    return records, stats


def balanced_sample(
    records: list[dict[str, Any]], per_type: int, seed: int
) -> list[dict[str, Any]]:
    if per_type <= 0:
        return sorted(records, key=lambda item: (item["pattern_type"], item["record_id"]))

    grouped: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for record in records:
        grouped[record["pattern_type"] or "미분류"].append(record)

    rng = random.Random(seed)
    selected: list[dict[str, Any]] = []
    ordered_types = [*KNOWN_PATTERN_TYPES, *sorted(set(grouped) - set(KNOWN_PATTERN_TYPES))]
    for pattern_type in ordered_types:
        candidates = sorted(grouped.get(pattern_type, []), key=lambda item: item["record_id"])
        rng.shuffle(candidates)
        selected.extend(candidates[:per_type])
    return sorted(selected, key=lambda item: (item["pattern_type"], item["record_id"]))


def write_manifest(
    output_path: Path,
    selected: list[dict[str, Any]],
    all_records: list[dict[str, Any]],
    stats: Counter[str],
    source_dirs: Path | dict[str, Path],
    per_type: int,
    seed: int,
) -> None:
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with output_path.open("w", encoding="utf-8", newline="\n") as handle:
        for record in selected:
            handle.write(json.dumps(record, ensure_ascii=False) + "\n")

    summary_path = output_path.with_suffix(".summary.json")
    source_summary: str | dict[str, str]
    if isinstance(source_dirs, Path):
        source_summary = str(source_dirs.resolve())
    else:
        source_summary = {key: str(path.resolve()) for key, path in source_dirs.items()}
    summary = {
        "source_dir": source_summary,
        "output_path": str(output_path.resolve()),
        "dataset_url": DATASET_URL,
        "selection": {"per_type": per_type, "seed": seed},
        "counts": dict(stats),
        "available_by_pattern_type": dict(Counter(r["pattern_type"] or "미분류" for r in all_records)),
        "selected_by_pattern_type": dict(Counter(r["pattern_type"] or "미분류" for r in selected)),
        "selected_records": len(selected),
        "warning": "Local-only derivative metadata. Do not commit or redistribute.",
    }
    summary_path.write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="저장소 밖 AI Hub 전통 문양 원본을 스캔해 로컬 전용 균형 목록을 만듭니다."
    )
    parser.add_argument(
        "--source",
        type=Path,
        help="이미지·라벨·메타데이터가 함께 있는 폴더. 개별 경로 옵션보다 우선하지 않습니다.",
    )
    parser.add_argument(
        "--images-dir",
        type=Path,
        help="VS_문양이미지데이터 ZIP이 있는 폴더",
    )
    parser.add_argument(
        "--labels-dir",
        type=Path,
        help="VL_문양라벨링데이터 ZIP이 있는 폴더",
    )
    parser.add_argument(
        "--metadata-dir",
        type=Path,
        help="Other.zip에서 꺼낸 메타데이터 CSV 최상위 폴더",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=DEFAULT_OUTPUT,
        help=f"JSONL 출력 경로(기본값: {DEFAULT_OUTPUT})",
    )
    parser.add_argument(
        "--per-type",
        type=int,
        default=150,
        help="문양 유형별 최대 선별 수. 0이면 전부 기록합니다. 기본값: 150",
    )
    parser.add_argument("--seed", type=int, default=20260817, help="재현 가능한 표본 추출 시드")
    return parser.parse_args()


def main() -> int:
    load_dotenv()
    args = parse_args()
    env_source = os.getenv("AIHUB_TRADITIONAL_PATTERN_DIR", "").strip()
    source_dir = args.source or (Path(env_source) if env_source else None)
    images_env = os.getenv("AIHUB_TRADITIONAL_PATTERN_IMAGES_DIR", "").strip()
    labels_env = os.getenv("AIHUB_TRADITIONAL_PATTERN_LABELS_DIR", "").strip()
    metadata_env = os.getenv("AIHUB_TRADITIONAL_PATTERN_METADATA_DIR", "").strip()
    images_dir = args.images_dir or (Path(images_env) if images_env else source_dir)
    labels_dir = args.labels_dir or (Path(labels_env) if labels_env else source_dir)
    metadata_dir = args.metadata_dir or (Path(metadata_env) if metadata_env else source_dir)

    source_paths = {
        "images": images_dir,
        "labels": labels_dir,
        "metadata": metadata_dir,
    }
    missing_inputs = [key for key, path in source_paths.items() if path is None or not path.is_dir()]
    if missing_inputs:
        print(
            "AI Hub 입력 폴더를 찾을 수 없습니다: " + ", ".join(missing_inputs) + ". "
            "--images-dir, --labels-dir, --metadata-dir를 지정하세요.",
            file=sys.stderr,
        )
        return 2

    resolved_paths = {key: path.resolve() for key, path in source_paths.items() if path is not None}
    output_path = args.output.resolve()
    for path in resolved_paths.values():
        if path == ROOT or ROOT in path.parents:
            print("AI Hub 원본 폴더는 저장소 밖에 두어야 합니다.", file=sys.stderr)
            return 2

    if args.per_type < 0:
        print("--per-type은 0 이상이어야 합니다.", file=sys.stderr)
        return 2


    records, stats = collect_records(
        images_dir=resolved_paths["images"],
        labels_dir=resolved_paths["labels"],
        metadata_dir=resolved_paths["metadata"],
    )
    if not records:
        print(
            "연결 가능한 AI Hub 문양 레코드를 찾지 못했습니다. "
            "순수 문양 이미지 ZIP, 문양 라벨 ZIP, 메타데이터 CSV 경로를 확인하세요.",
            file=sys.stderr,
        )
        return 3

    selected = balanced_sample(records, args.per_type, args.seed)
    write_manifest(
        output_path,
        selected,
        records,
        stats,
        resolved_paths,
        args.per_type,
        args.seed,
    )

    print(f"원본 레코드: {len(records):,}")
    print(f"선별 레코드: {len(selected):,}")
    print(f"이미지 경로 누락: {stats['missing_pattern_image']:,}")
    print(f"로컬 목록: {output_path}")
    print("원본 파일은 복사하지 않았습니다.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
