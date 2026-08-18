#!/usr/bin/env python3
"""AI Hub 전통 문양 후보를 장소별 스탬프 자산으로 로컬 연결한다.

원본 ZIP은 읽기만 한다. 선택한 소수 이미지는 Git에서 제외된
assets/local-stamps/patterns에 풀고, 장소 매핑은 data/local-stamps에 기록한다.
"""

from __future__ import annotations

import argparse
import hashlib
import io
import json
import zipfile
from collections import defaultdict
from pathlib import Path
from statistics import median
from typing import Any

from PIL import Image, ImageChops, ImageOps


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MANIFEST = ROOT / "data" / "local-stamps" / "aihub-pattern-manifest.jsonl"
DEFAULT_ASSET_DIR = ROOT / "assets" / "local-stamps" / "patterns"
DEFAULT_MAPPING = ROOT / "data" / "local-stamps" / "stamp-patterns.json"

CATEGORY_PATTERN_TYPES = {
    "자연·경관": ("자연산수문", "식물문", "동물문"),
    "공원·정원": ("식물문", "자연산수문", "동물문"),
    "도보·산책": ("자연산수문", "식물문", "기하문"),
    "역사·전통": ("복합문", "문자문", "기하문"),
    "문화·예술": ("기하문", "복합문", "인공물문"),
    "체험·스포츠": ("동물문", "기하문", "인공물문"),
    "스포츠·야구": ("동물문", "기하문", "복합문"),
    "음식·로컬": ("식물문", "기하문", "복합문"),
}


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def read_manifest(path: Path) -> list[dict[str, Any]]:
    return [
        json.loads(line)
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]


def place_key(place: dict[str, Any]) -> str:
    return str(place.get("sourcePlaceId") or place.get("id"))


def preferred_types(place: dict[str, Any]) -> tuple[str, ...]:
    category = str(place.get("category") or "")
    searchable = " ".join([
        str(place.get("name") or ""),
        " ".join(str(tag) for tag in place.get("hashtags") or []),
    ])
    if category in {"자연·경관", "공원·정원", "도보·산책"}:
        if any(term in searchable for term in ("정원", "수목", "숲", "공원", "꽃")):
            return ("식물문", "자연산수문", "동물문")
        if any(term in searchable for term in ("호수", "강", "광주천", "동굴", "#산", "생태")):
            return ("자연산수문", "식물문", "동물문")
    return CATEGORY_PATTERN_TYPES.get(category, ("복합문", "기하문", "식물문"))


def quality_score(record: dict[str, Any]) -> int:
    score = 0
    if record.get("pattern_symbol"):
        score += 3
    if record.get("symbolism"):
        score += 3
    if record.get("caption"):
        score += 2
    if record.get("keywords"):
        score += 1
    if record.get("source"):
        score += 1
    relic_name = str(record.get("relic_name") or "")
    if relic_name and "문양요소 없음" not in relic_name:
        score += 3
    return score


def stable_number(*parts: str) -> int:
    payload = "|".join(parts).encode("utf-8")
    return int.from_bytes(hashlib.sha256(payload).digest()[:8], "big")


def choose_patterns(
    places: list[dict[str, Any]],
    records: list[dict[str, Any]],
) -> dict[str, dict[str, Any]]:
    by_type: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for record in records:
        if record.get("image_zip_path") or record.get("image_path"):
            by_type[str(record.get("pattern_type") or "미분류")].append(record)
    for candidates in by_type.values():
        candidates.sort(key=lambda item: (-quality_score(item), str(item.get("record_id"))))

    used: set[str] = set()
    result: dict[str, dict[str, Any]] = {}
    all_types = tuple(sorted(by_type))
    for place in sorted(places, key=place_key):
        key = place_key(place)
        type_order = list(preferred_types(place))
        if type_order:
            offset = stable_number(key, "pattern-type") % len(type_order)
            type_order = type_order[offset:] + type_order[:offset]
        type_order.extend(pattern_type for pattern_type in all_types if pattern_type not in type_order)

        chosen: dict[str, Any] | None = None
        for pattern_type in type_order:
            candidates = [
                record for record in by_type.get(pattern_type, [])
                if str(record.get("record_id")) not in used
            ]
            if not candidates:
                continue
            top_quality = quality_score(candidates[0])
            shortlist = [record for record in candidates if quality_score(record) >= top_quality - 1][:80]
            chosen = min(
                shortlist,
                key=lambda item: stable_number(key, str(item.get("record_id"))),
            )
            break
        if chosen is None:
            raise RuntimeError(f"{key}에 연결할 문양 후보가 없습니다.")
        used.add(str(chosen.get("record_id")))
        result[key] = chosen
    return result


def extract_assets(
    selected: dict[str, dict[str, Any]],
    asset_dir: Path,
) -> dict[str, str]:
    asset_dir.mkdir(parents=True, exist_ok=True)
    asset_urls: dict[str, str] = {}
    archives: dict[str, zipfile.ZipFile] = {}
    try:
        for record in selected.values():
            record_id = str(record["record_id"])
            entry_name = str(record.get("image_entry") or "")
            image_path = str(record.get("image_path") or "")
            file_name = f"{record['pattern_file_name']}.webp"
            target = asset_dir / file_name
            if image_path:
                payload = Path(image_path).read_bytes()
            else:
                zip_path = str(record["image_zip_path"])
                archive = archives.get(zip_path)
                if archive is None:
                    archive = zipfile.ZipFile(zip_path)
                    archives[zip_path] = archive
                payload = archive.read(entry_name)
            normalize_pattern_image(payload, target)
            asset_urls[record_id] = f"./assets/local-stamps/patterns/{file_name}"
    finally:
        for archive in archives.values():
            archive.close()
    return asset_urls


def normalize_pattern_image(payload: bytes, target: Path) -> None:
    with Image.open(io.BytesIO(payload)) as source:
        image = source.convert("RGB")
    width, height = image.size
    corners = [
        image.getpixel((0, 0)),
        image.getpixel((max(0, width - 1), 0)),
        image.getpixel((0, max(0, height - 1))),
        image.getpixel((max(0, width - 1), max(0, height - 1))),
    ]
    background = tuple(int(median(pixel[channel] for pixel in corners)) for channel in range(3))
    difference = ImageChops.difference(image, Image.new("RGB", image.size, background)).convert("L")
    mask = difference.point(lambda value: 255 if value > 18 else 0)
    bbox = mask.getbbox()
    if bbox:
        left, top, right, bottom = bbox
        padding = max(8, int(max(right - left, bottom - top) * 0.08))
        bbox = (
            max(0, left - padding),
            max(0, top - padding),
            min(width, right + padding),
            min(height, bottom + padding),
        )
        image = image.crop(bbox)
    normalized = ImageOps.pad(
        image,
        (384, 384),
        method=Image.Resampling.LANCZOS,
        color=background,
        centering=(0.5, 0.5),
    )
    normalized.save(target, format="WEBP", quality=88, method=6)


def public_pattern(record: dict[str, Any], asset_url: str) -> dict[str, str]:
    return {
        "asset": asset_url,
        "patternType": str(record.get("pattern_type") or "전통문양"),
        "patternSymbol": str(record.get("pattern_symbol") or ""),
        "relicName": str(record.get("relic_name") or ""),
        "source": str(record.get("source") or ""),
        "patternFileName": str(record.get("pattern_file_name") or ""),
    }


def build_mapping(
    places: list[dict[str, Any]],
    selected: dict[str, dict[str, Any]],
    asset_urls: dict[str, str],
) -> dict[str, Any]:
    by_place: dict[str, dict[str, str]] = {}
    by_category: dict[str, dict[str, str]] = {}
    places_by_key = {place_key(place): place for place in places}
    for key, record in selected.items():
        item = public_pattern(record, asset_urls[str(record["record_id"])])
        by_place[key] = item
        category = str(places_by_key[key].get("category") or "")
        by_category.setdefault(category, item)
    return {
        "version": 1,
        "dataset": "AI Hub 한국 전통 문양 데이터",
        "datasetUrl": "https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&dataSetSn=71809",
        "localOnly": True,
        "placeCount": len(by_place),
        "places": by_place,
        "categories": by_category,
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="AI Hub 전통 문양을 장소별 로컬 스탬프로 연결합니다.")
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--places", type=Path, default=ROOT / "data" / "places.json")
    parser.add_argument("--restaurants", type=Path, default=ROOT / "data" / "restaurants.json")
    parser.add_argument("--asset-dir", type=Path, default=DEFAULT_ASSET_DIR)
    parser.add_argument("--mapping", type=Path, default=DEFAULT_MAPPING)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    records = read_manifest(args.manifest)
    places = [*read_json(args.places), *read_json(args.restaurants)]
    selected = choose_patterns(places, records)
    asset_urls = extract_assets(selected, args.asset_dir)
    mapping = build_mapping(places, selected, asset_urls)
    args.mapping.parent.mkdir(parents=True, exist_ok=True)
    args.mapping.write_text(
        json.dumps(mapping, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"장소 매핑: {len(selected):,}곳")
    print(f"추출 자산: {len(set(asset_urls.values())):,}개")
    print(f"로컬 매핑: {args.mapping.resolve()}")
    print("원본 ZIP은 수정하지 않았고 로컬 자산은 Git에서 제외됩니다.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
