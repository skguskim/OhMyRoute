#!/usr/bin/env python3
"""gwangju_official_*.csv 와 tourapi_*.csv를 병합한다.

두 소스에 같은 장소(이름이 동일)가 겹치면 gwangju_official(공식) 쪽을 우선시하고,
tourapi 쪽 중복 행은 places/profiles/operating_info_review 세 파일 모두에서
같은 source_place_id 기준으로 함께 제거한다. (중복 여부는 places 파일의
name 컬럼으로만 판단하고, 그 결과를 세 파일에 동일하게 적용한다.)

사용법:
    이 스크립트가 있는 폴더의 한 단계 위(= generated 폴더)에 원본 CSV 6개가 있다고 가정한다.
    예: generated/scripts/merge_gwangju_tourapi.py, generated/*.csv
 
        python merge_gwangju_tourapi.py
 
    어느 위치에서 실행하든(cwd와 무관) 스크립트 파일 자신의 경로를 기준으로 찾는다.
    입력도 DATA_DIR(generated), 출력도 같은 폴더에 저장된다.
"""
 
from __future__ import annotations
 
import csv
from pathlib import Path
 
# 이 스크립트는 generated 폴더 밑의 하위 폴더 안에 있으므로,
# 실행 위치(cwd)에 의존하지 않고 스크립트 자신의 경로를 기준으로 한 단계 위(generated)를 찾는다.
DATA_DIR = Path(__file__).resolve().parent.parent
 
OFFICIAL_PREFIX = "gwangju_official"
TOURAPI_PREFIX = "tourapi"
CSV_LIST = ["places", "place_profiles", "operating_info_review"]
 
# (출력 파일명, official 파일명, tourapi 파일명) - CSV_LIST로부터 생성
FILE_PAIRS = tuple(
    (f"merged_{name}.csv", f"{OFFICIAL_PREFIX}_{name}.csv", f"{TOURAPI_PREFIX}_{name}.csv")
    for name in CSV_LIST
)
# 위 쌍 중 "장소 목록"에 해당하는 파일 - 중복 판정(이름 매칭)은 이 파일 기준으로 한다.
PLACES_INDEX = CSV_LIST.index("places")
 
 
def read_csv(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    with path.open(encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames or []
        rows = list(reader)
    return fieldnames, rows
 
 
def find_duplicate_tourapi_ids(official_places: list[dict], tourapi_places: list[dict]) -> set[str]:
    """이름이 official 쪽과 똑같은 tourapi 장소의 source_place_id를 찾는다.
    (공식 데이터를 우선하기로 했으므로, 겹치는 건 tourapi 쪽을 제거 대상으로 표시)"""
    official_names = {row["name"] for row in official_places}
    duplicate_ids = {
        row["source_place_id"] for row in tourapi_places if row["name"] in official_names
    }
    return duplicate_ids
 
 
def merge_pair(official_path: Path, tourapi_path: Path, output_path: Path, exclude_ids: set[str]) -> None:
    official_fields, official_rows = read_csv(official_path)
    tourapi_fields, tourapi_rows = read_csv(tourapi_path)
 
    if official_fields != tourapi_fields:
        raise SystemExit(
            f"컬럼 구조가 다릅니다:\n  {official_path.name}: {official_fields}\n  {tourapi_path.name}: {tourapi_fields}"
        )
 
    before = len(tourapi_rows)
    tourapi_rows = [row for row in tourapi_rows if row["source_place_id"] not in exclude_ids]
    removed = before - len(tourapi_rows)
 
    merged_rows = official_rows + tourapi_rows
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with output_path.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=official_fields)
        writer.writeheader()
        writer.writerows(merged_rows)
 
    # (source, source_place_id) 중복이 실제로 없는지 마지막으로 검증
    ids = [(row["source"], row["source_place_id"]) for row in merged_rows]
    dupe_count = len(ids) - len(set(ids))
 
    print(
        f"{output_path.name}: official {len(official_rows)} + tourapi {len(tourapi_rows)}"
        f" (중복 {removed}건 제외) = 총 {len(merged_rows)}행"
        + (f"  [경고] (source, source_place_id) 중복 {dupe_count}건 남아있음" if dupe_count else "")
    )
 
 
def main() -> int:
    input_dir = DATA_DIR
    output_dir = DATA_DIR
 
    # 중복 판정은 places 파일 기준으로 한 번만 계산해서, 세 파일 모두에 동일하게 적용한다.
    _, official_places, tourapi_places = FILE_PAIRS[PLACES_INDEX]
    _, official_place_rows = read_csv(input_dir / official_places)
    _, tourapi_place_rows = read_csv(input_dir / tourapi_places)
    exclude_ids = find_duplicate_tourapi_ids(official_place_rows, tourapi_place_rows)
 
    if exclude_ids:
        print(f"이름이 겹치는 장소 {len(exclude_ids)}건 발견 -> 공식(gwangju_official) 우선, tourapi 쪽 제외\n")
 
    for output_name, official_name, tourapi_name in FILE_PAIRS:
        merge_pair(
            input_dir / official_name,
            input_dir / tourapi_name,
            output_dir / output_name,
            exclude_ids,
        )
 
    return 0
 
 
if __name__ == "__main__":
    raise SystemExit(main())
