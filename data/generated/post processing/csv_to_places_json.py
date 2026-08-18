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
import html
import json
import re
from pathlib import Path

# merge_gwangju_tourapi.py와 동일한 방식: 스크립트 자신의 위치 기준으로 한 단계 위(generated)를 찾는다.
DATA_DIR = Path(__file__).resolve().parent.parent
OUTPUT_DIR = DATA_DIR.parent

VECTOR_KEYS = (
    "nature","culture", "art", "food", "activity", "sports", 
    # "healing", "festival"
    # 벡터 삭제
)

# places.json은 "광주광역시"처럼 정식 명칭을 쓰는데, CSV의 region은 "광주"처럼 축약형이라 변환이 필요하다.
REGION_MAP = {
    "광주": "광주광역시",
    "전남": "전라남도",
    "전북": "전라북도",
}
PARKING_NONE_VALUES = {"없음", "불가", "불가능", "주차 불가", "주차불가"}
PARKING_GENERIC_YES_VALUES = {
    "있음", "보유", "무료", "유료", "가능", "주차 가능", "주차가능",
    "주차시설 있음", "주차장 있음", "주차장 있음/유료",
}

TIME_RANGE_RE = re.compile(r'(\d{1,2}:\d{2})\s*[~\-–∼]\s*(\d{1,2}:\d{2})')
ALWAYS_OPEN_KEYWORDS = ("상시", "24시간", "24 시간", "연중무휴")
NO_RESTRICTION_KEYWORDS = ("제약사항 없음",)
NOTE_KEYWORDS = ("사전요청", "사전연락", "사전허가", "전화문의", "단체관람", "이용 제한")


def normalize_parking(value: str) -> str | None:
    value = (value or "").strip()
    if not value or value in PARKING_NONE_VALUES:
        return None
    if value in PARKING_GENERIC_YES_VALUES:
        return "주차 가능"
    return value

def normalize_hhmm(text: str) -> str:
    h, m = text.split(":")
    return f"{int(h):02d}:{m}"


def clean_operating_text(raw: str) -> str:
    text = html.unescape(raw or "")
    text = re.sub(r'<br\s*/?>', ' / ', text, flags=re.IGNORECASE)
    text = re.sub(r'[\r\n]+', ' / ', text)
    text = re.sub(r'\s+', ' ', text).strip()
    return text


def parse_last_admission(text: str, closes_at: str | None) -> str | None:
    m = re.search(r'입장\s*마감\s*(\d{1,2}:\d{2})', text)
    if m:
        return normalize_hhmm(m.group(1))
    m = re.search(r'(\d{1,2}:\d{2})\s*분?\s*입장\s*마감', text)
    if m:
        return normalize_hhmm(m.group(1))
    if closes_at:
        h, mi = map(int, closes_at.split(":"))
        m = re.search(r'(?:종료|마감)\s*(\d+)\s*시간\s*전', text)
        if m:
            total = h * 60 + mi - int(m.group(1)) * 60
            return f"{(total // 60) % 24:02d}:{total % 60:02d}"
        m = re.search(r'(?:종료|마감)\s*(\d+)\s*분\s*전', text)
        if m:
            total = h * 60 + mi - int(m.group(1))
            return f"{(total // 60) % 24:02d}:{total % 60:02d}"
    return None


def parse_operating_hours(raw: str) -> dict:
    raw = (raw or "").strip()
    if not raw:
        return {
            "is24h": None, "opensAt": None, "closesAt": None, "lastAdmissionAt": None,
            "operatingNotes": None, "hoursParseStatus": "empty", "operatingHoursRaw": None,
        }

    text = clean_operating_text(raw)
    is_24h = any(kw in text for kw in ALWAYS_OPEN_KEYWORDS)
    no_restriction = any(kw in text for kw in NO_RESTRICTION_KEYWORDS)

    matches = TIME_RANGE_RE.findall(text)
    opens_at = closes_at = None
    if matches:
        opens_at, closes_at = normalize_hhmm(matches[0][0]), normalize_hhmm(matches[0][1])
    elif is_24h:
        opens_at, closes_at = "00:00", "24:00"

    if len(matches) >= 2:
        status = "multiple_ranges_took_first"
    elif matches or is_24h:
        status = "structured"
    elif no_restriction:
        status = "no_restriction"
    else:
        status = "unparsed"

    last_admission_at = parse_last_admission(text, closes_at)

    notes = [m.strip() for m in re.findall(r'\(([^)]*)\)', text) if m.strip()]
    notes += [kw for kw in NOTE_KEYWORDS if kw in text]
    operating_notes = " / ".join(dict.fromkeys(notes)) or None

    return {
        "is24h": is_24h or None,
        "opensAt": opens_at,
        "closesAt": closes_at,
        "lastAdmissionAt": last_admission_at,
        "operatingNotes": operating_notes,
        "hoursParseStatus": status,
        "operatingHoursRaw": raw,
    }


CLOSED_ALWAYS_OPEN = ("연중무휴", "상시개방", "상시 개방")


def parse_closed_days(raw: str) -> dict:
    raw = (raw or "").strip()
    if not raw:
        return {"closedWeekdays": [], "closedHolidays": False, "daysParseStatus": "empty", "closedDaysRaw": None}
    text = clean_operating_text(raw)
    if text == "없음" or any(kw in text for kw in CLOSED_ALWAYS_OPEN):
        return {"closedWeekdays": [], "closedHolidays": False, "daysParseStatus": "no_closure", "closedDaysRaw": raw}
    weekdays = sorted(set(re.findall(r'([월화수목금토일])요일', text)))
    holidays = any(kw in text for kw in ("공휴일", "설날", "추석", "명절", "신정", "1월 1일", "1월1일", "설(", "추석("))
    status = "structured" if (weekdays or holidays) else "unparsed"
    return {"closedWeekdays": weekdays, "closedHolidays": holidays, "daysParseStatus": status, "closedDaysRaw": raw}

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


def build_places_json(places_path: Path, profiles_path: Path, operating_path: Path) -> list[dict]:
    places = read_csv(places_path)
    profiles = read_csv(profiles_path)
    operating_rows = read_csv(operating_path)
    profile_by_key = {(p["source"], p["source_place_id"]): p for p in profiles}
    operating_by_key = {(o["source"], o["source_place_id"]): o for o in operating_rows}

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
        operating = operating_by_key.get(key, {})
        hours_info = parse_operating_hours(operating.get("operating_hours_raw", ""))
        days_info = parse_closed_days(operating.get("closed_days_raw", ""))
        parking_info = normalize_parking(operating.get("parking_raw", ""))

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
                "operatingHoursRaw": hours_info["operatingHoursRaw"],
                "is24h": hours_info["is24h"],
                "opensAt": hours_info["opensAt"],
                "closesAt": hours_info["closesAt"],
                "lastAdmissionAt": hours_info["lastAdmissionAt"],
                "operatingNotes": hours_info["operatingNotes"],
                "hoursParseStatus": hours_info["hoursParseStatus"],
                "closedDaysRaw": days_info["closedDaysRaw"],
                "closedWeekdays": days_info["closedWeekdays"],
                "closedHolidays": days_info["closedHolidays"],
                "daysParseStatus": days_info["daysParseStatus"],
                "parkingInfo": parking_info,         # 추가
            }
        )
    return result


def main() -> int:
    places_path = DATA_DIR / "merged_places.csv"
    profiles_path = DATA_DIR / "merged_place_profiles.csv"
    operating_path = DATA_DIR / "merged_operating_info_review.csv"
    output_path = OUTPUT_DIR / "places.json"
    data = build_places_json(places_path, profiles_path, operating_path)

    output_path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"{len(data)}개 장소 -> {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
