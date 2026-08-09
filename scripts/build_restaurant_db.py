"""Build the single runtime restaurant database used by the web app.

The first run migrates the legacy KIA recommendation CSV and the general
restaurant rows that used to live in data/places.json. Later runs read and
refresh data/restaurants.json directly. Kakao address geocoding is optional
and uses KAKAO_REST_API_KEY from the environment.
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import time
import urllib.parse
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PLACES_PATH = ROOT / "data" / "places.json"
RESTAURANTS_PATH = ROOT / "data" / "restaurants.json"
LEGACY_KIA_PATH = ROOT / "outputs" / "archive" / "kia_player_restaurants_legacy_20260806.csv"

# KIA Tigers official 2026 roster pages checked on 2026-08-06.
# This includes first team, Futures, and development/reserve groups.
CURRENT_KIA_PLAYERS = {
    "곽도규",
    "김건국",
    "김규성",
    "김도영",
    "김도현",
    "김석환",
    "김선빈",
    "김태형",
    "김호령",
    "나성범",
    "변우혁",
    "양현종",
    "오선우",
    "유승철",
    "윤영철",
    "윤중현",
    "이의리",
    "최지민",
    "황동하",
}


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def write_json(path: Path, value) -> None:
    path.write_text(
        json.dumps(value, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def split_players(value: str) -> list[str]:
    return [item.strip() for item in re.split(r"[·,/]+", value or "") if item.strip()]


def general_restaurant(place: dict) -> dict:
    return {
        **place,
        "databaseType": "restaurant",
        "routeEligible": True,
        "branchName": "",
        "foodType": "",
        "playerRecommended": False,
        "recommendedPlayers": [],
        "activeRecommendedPlayers": [],
        "activePlayerRecommended": False,
        "baseballColumn": "",
        "recommendationContext": "",
        "recommendationSourceTitle": "",
        "recommendationSourceUrl": "",
        "recommendationSecondarySourceUrl": "",
        "recommendationConfidence": "",
        "recommendationVerificationStatus": "",
        "businessStatus": "",
        "rosterVerifiedAt": "",
        "rosterSourceUrl": "",
    }


def kia_restaurant(row: dict, index: int) -> dict:
    players = split_players(row.get("recommended_players", ""))
    active_players = [player for player in players if player in CURRENT_KIA_PLAYERS]
    branch = row.get("branch_name", "").strip()
    branch_for_name = "" if not branch or "확인 필요" in branch else f" {branch}"
    name = f"{row.get('restaurant_name', '').strip()}{branch_for_name}"
    hashtags = [tag.strip() for tag in row.get("hashtags", "").split("|") if tag.strip()]
    for tag in ("#로컬푸드", "#맛집", "#야구선수추천"):
        if tag not in hashtags:
            hashtags.append(tag)
    if active_players and "#현역선수추천" not in hashtags:
        hashtags.append("#현역선수추천")
    recommendation_context = row.get("recommendation_context", "").strip()
    description = recommendation_context or f"KIA 타이거즈 {row.get('recommended_players', '').strip()} 선수 추천 음식점"
    latitude = float(row["latitude"]) if row.get("latitude", "").strip() else None
    longitude = float(row["longitude"]) if row.get("longitude", "").strip() else None
    return {
        "id": 1000 + index,
        "source": "kia_player_recommendation",
        "sourcePlaceId": row.get("restaurant_id", "").strip() or f"kia-food-{index:03d}",
        "name": name,
        "region": "광주광역시" if row.get("region", "").strip() == "광주" else row.get("region", "").strip(),
        "category": "음식·로컬",
        "description": description,
        "hashtags": hashtags,
        "vector": [0.0, 0.0, 0.0, float(row.get("food_score") or 1), 0.0, float(row.get("sports_score") or 1), 0.0, 0.0],
        "latitude": latitude,
        "longitude": longitude,
        "durationMinutes": 60,
        "indoor": True,
        "rainOk": True,
        "familyFriendly": True,
        "publicTransportScore": 0.65,
        "roadAddress": row.get("address", "").strip(),
        "phone": "",
        "websiteUrl": row.get("secondary_source_url", "").strip(),
        "imageUrl": "",
        "parkingAvailable": None,
        "wheelchairAccessible": None,
        "petFriendly": None,
        "requiresReservation": None,
        "priceMin": None,
        "priceMax": None,
        "databaseType": "restaurant",
        "routeEligible": False,
        "branchName": branch,
        "foodType": row.get("category_draft", "").strip(),
        "playerRecommended": True,
        "recommendedPlayers": players,
        "activeRecommendedPlayers": active_players,
        "activePlayerRecommended": bool(active_players),
        "baseballColumn": row.get("baseball_column", "").strip(),
        "recommendationContext": recommendation_context,
        "recommendationSourceTitle": row.get("source_title", "").strip(),
        "recommendationSourceUrl": row.get("source_url", "").strip(),
        "recommendationSecondarySourceUrl": row.get("secondary_source_url", "").strip(),
        "recommendationConfidence": row.get("evidence_confidence", "").strip(),
        "recommendationVerificationStatus": row.get("verification_status", "").strip(),
        "businessStatus": row.get("business_status", "").strip(),
        "qualityStatus": row.get("quality_status", "").strip(),
        "reviewNotes": row.get("review_notes", "").strip(),
        "rosterVerifiedAt": "2026-08-06",
        "rosterSourceUrl": "https://tigers.co.kr/players/entry-status",
    }


def refresh_runtime_fields(restaurant: dict) -> None:
    players = restaurant.get("recommendedPlayers") or []
    if isinstance(players, str):
        players = split_players(players)
    restaurant["recommendedPlayers"] = players
    active_players = [player for player in players if player in CURRENT_KIA_PLAYERS]
    restaurant["activeRecommendedPlayers"] = active_players
    restaurant["activePlayerRecommended"] = bool(active_players)
    if restaurant.get("playerRecommended"):
        address = str(restaurant.get("roadAddress") or "")
        verification = str(restaurant.get("recommendationVerificationStatus") or "")
        restaurant["routeEligible"] = (
            "광주" in address
            and verification not in {"address_conflict", "branch_unknown", "business_status_unverified"}
        )
        restaurant["rosterVerifiedAt"] = "2026-08-06"
        restaurant["rosterSourceUrl"] = "https://tigers.co.kr/players/entry-status"
    else:
        restaurant["routeEligible"] = True
        restaurant["rosterSourceUrl"] = ""


def load_restaurants() -> list[dict]:
    places = read_json(PLACES_PATH)
    general = [general_restaurant(place) for place in places if place.get("category") == "음식·로컬"]

    if RESTAURANTS_PATH.exists():
        existing = read_json(RESTAURANTS_PATH)
        by_id = {str(item.get("sourcePlaceId") or item.get("id")): item for item in existing}
        for item in general:
            by_id.setdefault(str(item.get("sourcePlaceId") or item.get("id")), item)
        return list(by_id.values())

    if not LEGACY_KIA_PATH.exists():
        return general

    with LEGACY_KIA_PATH.open("r", encoding="utf-8-sig", newline="") as handle:
        legacy_rows = list(csv.DictReader(handle))
    return [*general, *(kia_restaurant(row, index) for index, row in enumerate(legacy_rows, start=1))]


def kakao_search(path: str, query: str, api_key: str) -> dict | None:
    url = f"https://dapi.kakao.com{path}?{urllib.parse.urlencode({'query': query, 'size': 1})}"
    request = urllib.request.Request(url, headers={"Authorization": f"KakaoAK {api_key}"})
    with urllib.request.urlopen(request, timeout=12) as response:
        payload = json.loads(response.read().decode("utf-8"))
    documents = payload.get("documents") or []
    return documents[0] if documents else None


def geocode_restaurant(restaurant: dict, api_key: str) -> bool:
    if restaurant.get("latitude") is not None and restaurant.get("longitude") is not None:
        return True
    address = str(restaurant.get("roadAddress") or "").strip()
    document = kakao_search("/v2/local/search/address.json", address, api_key) if address else None
    if not document:
        query = " ".join(
            value for value in [restaurant.get("name", ""), restaurant.get("branchName", ""), "광주"] if value
        )
        document = kakao_search("/v2/local/search/keyword.json", query, api_key) if query.strip() else None
    if not document:
        return False
    restaurant["longitude"] = float(document["x"])
    restaurant["latitude"] = float(document["y"])
    resolved_address = document.get("road_address_name") or document.get("address_name")
    if resolved_address:
        restaurant["geocodedAddress"] = resolved_address
    restaurant["geocodedAt"] = "2026-08-06"
    return True


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--geocode", action="store_true")
    args = parser.parse_args()

    restaurants = load_restaurants()
    geocoded = 0
    failed = []
    if args.geocode:
        api_key = os.environ.get("KAKAO_REST_API_KEY", "").strip()
        if not api_key:
            raise SystemExit("KAKAO_REST_API_KEY is required with --geocode")
        for restaurant in restaurants:
            if restaurant.get("latitude") is not None and restaurant.get("longitude") is not None:
                geocoded += 1
                continue
            try:
                if geocode_restaurant(restaurant, api_key):
                    geocoded += 1
                else:
                    failed.append(restaurant["name"])
            except Exception as error:  # keep the rest of the database usable
                failed.append(f"{restaurant['name']} ({error})")
            time.sleep(0.08)

    for restaurant in restaurants:
        refresh_runtime_fields(restaurant)
    restaurants.sort(key=lambda item: (not item.get("playerRecommended", False), str(item.get("name", ""))))
    write_json(RESTAURANTS_PATH, restaurants)

    places = read_json(PLACES_PATH)
    attractions = [place for place in places if place.get("category") != "음식·로컬"]
    write_json(PLACES_PATH, attractions)

    print(f"restaurants={len(restaurants)}")
    print(f"attractions={len(attractions)}")
    print(f"with_coordinates={sum(item.get('latitude') is not None and item.get('longitude') is not None for item in restaurants)}")
    print(f"player_recommended={sum(bool(item.get('playerRecommended')) for item in restaurants)}")
    print(f"active_player_recommended={sum(bool(item.get('activePlayerRecommended')) for item in restaurants)}")
    if args.geocode:
        print(f"geocoded_or_existing={geocoded}")
        print(f"geocode_failed={len(failed)}")
        for name in failed:
            print(f"  - {name}")


if __name__ == "__main__":
    main()
