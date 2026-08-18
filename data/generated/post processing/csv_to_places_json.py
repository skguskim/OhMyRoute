#!/usr/bin/env python3
"""merged_places.csv + merged_place_profiles.csv를 places.json(프로토타입 시드 포맷)으로 변환한다.

merge_gwangju_tourapi.py와 같은 폴더(generated 밑의 하위 폴더)에 두고 실행하면,
한 단계 위(generated)에서 merged_places.csv / merged_place_profiles.csv를 읽어
같은 곳에 places.json을 만든다.

사용법:
    python csv_to_places_json.py
"""

from __future__ import annotations

import csv
import json
from pathlib import Path

# merge_gwangju_tourapi.py와 동일한 방식: 스크립트 자신의 위치 기준으로 한 단계 위(generated)를 찾는다.
DATA_DIR = Path(__file__).resolve().parent.parent
OUTPUT_DIR = DATA_DIR.parent

VECTOR_KEYS = ("nature", "culture", "art", "food", "activity", "sports", "healing", "festival")

# places.json은 "광주광역시"처럼 정식 명칭을 쓰는데, CSV의 region은 "광주"처럼 축약형이라 변환이 필요하다.
REGION_MAP = {
    "광주": "광주광역시",
    "전남": "전라남도",
    "전북": "전라북도",
}


def parse_bool(value: str) -> bool | None:
    value = (value or "").strip()
    if value == "":
        return None
    return value.lower() == "true"


def parse_float(value: str) -> float | None:
    value = (value or "").strip()
    return float(value) if value else None


def parse_int(value: str) -> int | None:
    value = (value or "").strip()
    return int(float(value)) if value else None


def normalize_region(value: str) -> str:
    value = (value or "").strip()
    if value in REGION_MAP:
        return REGION_MAP[value]
    if value:
        print(f"[경고] 알 수 없는 region 값이라 그대로 둠: {value!r}")
    return value


def read_csv(path: Path) -> list[dict[str, str]]:
    if not path.exists():
        raise SystemExit(f"파일이 없습니다: {path}")
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def build_places_json(places_path: Path, profiles_path: Path) -> list[dict]:
    places = read_csv(places_path)
    profiles = read_csv(profiles_path)
    profile_by_key = {(p["source"], p["source_place_id"]): p for p in profiles}

    result = []
    skipped = 0
    for idx, place in enumerate(places, start=1):
        key = (place["source"], place["source_place_id"])
        profile = profile_by_key.get(key)
        if profile is None:
            print(f"[경고] 프로필이 없어서 건너뜀: {key} ({place.get('name')})")
            skipped += 1
            continue

        hashtags = [tag for tag in profile.get("hashtags", "").split("|") if tag]
        vector = [float(profile.get(k) or 0.0) for k in VECTOR_KEYS]

        result.append(
            {
                "id": idx - skipped,
                "source": place["source"],
                "sourcePlaceId": place["source_place_id"],
                "name": place["name"],
                "region": normalize_region(place["region"]),
                "category": place["category"],
                "description": place["description"],
                "hashtags": hashtags,
                "vector": vector,
                "latitude": parse_float(place["latitude"]),
                "longitude": parse_float(place["longitude"]),
                "durationMinutes": parse_int(place["duration_minutes"]),
                "indoor": parse_bool(place["indoor"]),
                "rainOk": parse_bool(place["rain_ok"]),
                "familyFriendly": parse_bool(place["family_friendly"]),
                "publicTransportScore": parse_float(place["public_transport_score"]),
                "roadAddress": place["road_address"],
                "phone": place["phone"],
                "websiteUrl": place["website_url"],
                "imageUrl": place["image_url"],
                "parkingAvailable": parse_bool(place["parking_available"]),
                "wheelchairAccessible": parse_bool(place["wheelchair_accessible"]),
                "petFriendly": parse_bool(place["pet_friendly"]),
                "requiresReservation": parse_bool(place["requires_reservation"]),
                "priceMin": parse_int(place["price_min"]),
                "priceMax": parse_int(place["price_max"]),
            }
        )
    return result


def main() -> int:
    places_path = DATA_DIR / "merged_places.csv"
    profiles_path = DATA_DIR / "merged_place_profiles.csv"
    output_path = OUTPUT_DIR / "places.json"

    data = build_places_json(places_path, profiles_path)
    output_path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"{len(data)}개 장소 -> {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
