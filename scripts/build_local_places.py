#!/usr/bin/env python3
"""검증된 장소·프로필 CSV를 정적 웹앱용 places.json으로 변환한다."""

from __future__ import annotations

import argparse
import csv
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_PLACES = ROOT / "data" / "generated" / "gwangju_official_places.csv"
DEFAULT_PROFILES = ROOT / "data" / "generated" / "gwangju_official_place_profiles.csv"
DEFAULT_OUTPUT = ROOT / "data" / "places.json"
VECTOR_FIELDS = ("nature", "culture", "art", "food", "activity", "sports", "healing", "festival")


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def parse_bool(value: str) -> bool:
    return str(value).strip().lower() in {"true", "1", "yes", "y"}


def parse_optional_bool(value: str) -> bool | None:
    text = str(value).strip().lower()
    if not text:
        return None
    return text in {"true", "1", "yes", "y"}


def parse_optional_number(value: str) -> int | float | None:
    text = str(value).strip()
    if not text:
        return None
    number = float(text)
    return int(number) if number.is_integer() else number


def build_local_places(places_path: Path, profiles_path: Path) -> list[dict[str, object]]:
    places = read_csv(places_path)
    profiles = read_csv(profiles_path)
    profile_by_key = {
        (row["source"].strip(), row["source_place_id"].strip()): row
        for row in profiles
    }

    if len(profile_by_key) != len(profiles):
        raise ValueError("프로필에 중복된 (source, source_place_id) 키가 있습니다.")

    output: list[dict[str, object]] = []
    place_keys: set[tuple[str, str]] = set()
    for place in places:
        key = (place["source"].strip(), place["source_place_id"].strip())
        if key in place_keys:
            raise ValueError(f"장소 중복 키: {key}")
        place_keys.add(key)

        profile = profile_by_key.get(key)
        if profile is None:
            raise ValueError(f"추천 프로필 누락: {key}")

        vector = [float(profile[field]) for field in VECTOR_FIELDS]
        if len(vector) != 8 or any(value < 0 or value > 1 for value in vector):
            raise ValueError(f"8축 벡터 범위 오류: {key}")

        output.append(
            {
                "id": f"{key[0]}:{key[1]}",
                "source": key[0],
                "sourcePlaceId": key[1],
                "name": place["name"].strip(),
                "region": place["region"].strip(),
                "category": place["category"].strip(),
                "description": place["description"].strip(),
                "hashtags": [
                    hashtag.strip()
                    for hashtag in profile["hashtags"].split("|")
                    if hashtag.strip()
                ],
                "vector": vector,
                "latitude": float(place["latitude"]),
                "longitude": float(place["longitude"]),
                "durationMinutes": int(float(place["duration_minutes"])),
                "indoor": parse_bool(place["indoor"]),
                "rainOk": parse_bool(place["rain_ok"]),
                "familyFriendly": parse_bool(place["family_friendly"]),
                "publicTransportScore": float(place["public_transport_score"]),
                "roadAddress": place["road_address"].strip(),
                "phone": place["phone"].strip(),
                "websiteUrl": place["website_url"].strip(),
                "imageUrl": place["image_url"].strip(),
                "parkingAvailable": parse_optional_bool(place["parking_available"]),
                "wheelchairAccessible": parse_optional_bool(place["wheelchair_accessible"]),
                "petFriendly": parse_optional_bool(place["pet_friendly"]),
                "requiresReservation": parse_optional_bool(place["requires_reservation"]),
                "priceMin": parse_optional_number(place["price_min"]),
                "priceMax": parse_optional_number(place["price_max"]),
            }
        )

    missing_places = sorted(set(profile_by_key) - place_keys)
    if missing_places:
        raise ValueError(f"장소가 없는 프로필: {missing_places}")

    return output


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--places", type=Path, default=DEFAULT_PLACES)
    parser.add_argument("--profiles", type=Path, default=DEFAULT_PROFILES)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()

    output = build_local_places(args.places, args.profiles)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(output, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"정적 장소 JSON 생성: {args.output} ({len(output)}곳)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
