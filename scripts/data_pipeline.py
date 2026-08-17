#!/usr/bin/env python3
"""오매루트 관광지 데이터 수집·정규화·검수·SQL 생성 파이프라인.

외부 패키지 없이 Python 표준 라이브러리만 사용한다.
TourAPI 인증키는 프로젝트 루트의 .env에 저장하고 저장소에는 커밋하지 않는다.
"""

from __future__ import annotations

import argparse
import csv
import html
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Iterable


ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "data"
DEFAULT_OUTPUT_DIR = DATA_DIR / "generated"
TOUR_API_BASE = "https://apis.data.go.kr/B551011/KorService2"
TOUR_API_SOURCE_URL = "https://www.data.go.kr/data/15101578/openapi.do"
GWANGJU_TOUR_BASE = "https://tour.gwangju.go.kr"
VECTOR_KEYS = ("nature", "culture", "art", "food", "activity", "sports", "healing", "festival")

GWANGJU_CATEGORIES = (
    ("nature.cs", "자연·경관"),
    ("history.cs", "역사·전통"),
    ("culture.cs", "문화·예술"),
    ("food.cs", "음식·로컬"),
    ("sports.cs", "체험·스포츠"),
    ("load.cs", "도보·산책"),
    ("park/003.cs", "공원·정원"),
)

PLACE_FIELDS = (
    "source", "source_place_id", "name", "region", "sigungu", "category", "description",
    "road_address", "lot_address", "latitude", "longitude", "phone", "website_url", "image_url",
    "duration_minutes", "indoor", "rain_ok", "family_friendly", "parking_available",
    "wheelchair_accessible", "pet_friendly", "requires_reservation", "price_min", "price_max",
    "status", "public_transport_score", "source_url", "source_updated_at", "last_verified_at",
    "license", "quality_status",
)

PROFILE_FIELDS = (
    "source", "source_place_id", "hashtags", *VECTOR_KEYS, "semantic_text", "taxonomy_version",
    "labeling_method", "labeling_confidence", "labeling_evidence", "reviewed_at",
)

HOUR_FIELDS = (
    "source", "source_place_id", "day_of_week", "opens_at", "closes_at", "last_admission_at",
    "is_closed", "notes", "valid_from", "valid_until", "verified_at",
)

OPERATING_REVIEW_FIELDS = (
    "source", "source_place_id", "name", "operating_hours_raw", "closed_days_raw", "fees_raw",
    "parking_raw", "pet_raw", "public_transport_raw", "source_url",
)

CONTENT_TYPE_CATEGORY = {
    "12": "관광지",
    "14": "문화·예술",
    "15": "축제·공연",
    "28": "체험·스포츠",
    "38": "쇼핑·시장",
    "39": "음식·로컬",
}

DEFAULT_DURATION = {
    "관광지": 90,
    "문화·예술": 90,
    "축제·공연": 120,
    "체험·스포츠": 150,
    "쇼핑·시장": 70,
    "음식·로컬": 60,
}

PROTOTYPE_SOURCE_IDS = {
    "국립아시아문화전당": "acc",
    "양림동 역사문화마을": "yangnim",
    "무등산 국립공원": "mudeungsan",
    "광주-기아 챔피언스필드": "champions",
    "1913 송정역시장": "songjeong",
    "광주비엔날레 전시관": "biennale",
    "담양 죽녹원": "juknokwon",
    "순천만 국가정원": "suncheon_garden",
    "여수 낭만포차거리": "yeosu_night",
    "목포 근대역사문화공간": "mokpo_modern",
    "화순 고인돌 유적": "hwasun_dolmen",
    "곡성 섬진강기차마을": "gokseong_train",
}

# LABEL_RULES에서 키워드를 매칭하고 is_valid_label()에서 검증하는 방식으로 라벨링을 수행.
LABEL_RULES = {
    "nature": {
        "#자연": ("자연", "생태", "국립공원"),
        "#산": ("등산", "봉우리"),
        "#무등산": ("무등산",),
        "#숲": ("숲", "수목", "대나무"),
        "#정원": ("정원", "꽃", "수목원"),
        "#전망": ("전망", "조망", "풍경", "일몰"),
        "#바다": ("바다", "해변", "해양", "호수", "하천"),
    },
    "culture": {
        "#역사": ("역사", "유적", "사적", "기념관", "조선"),
        "#문화유산": ("문화재", "문화유산", "세계유산"),
        "#근대문화": ("근대", "일제", "개화"),
        "#민주인권": ("5·18", "5.18", "민주", "인권"),
        "#전통": ("전통", "한옥", "서원", "향교", "사찰"),
        "#박물관": ("박물관", "기념관", "전시관"),
    },
    "art": {
        "#예술": ("예술", "미술", "작가"),
        "#전시": ("전시", "갤러리", "박물관", "미술관", "예술공간"),
        "#현대미술": ("현대미술", "비엔날레"),
        "#공연": ("공연", "극장", "콘서트", "음악"),
        "#미디어아트": ("미디어아트", "미디어 아트"),
        "#공방": ("공방", "도예", "창작"),
    },
    "food": {
        "#로컬푸드": ("로컬", "향토음식", "먹거리"),
        "#시장": ("시장", "상점가", "야시장"),
        "#맛집": ("맛집", "음식점", "식당"),
        "#카페": ("카페", "커피", "디저트"),
        "#전통음식": ("한정식", "떡갈비", "김치", "전통음식"),
        "#특산물": ("특산", "기념품", "농산물"),
    },
    "activity": {
        "#체험": ("체험", "참여", "만들기"),
        "#교육": ("교육", "해설", "학습"),
        "#공방체험": ("공방", "도예", "공예"),
        "#가족체험": ("어린이", "가족", "아이"),
        "#레저": ("레저", "놀이", "테마파크"),
        "#참여형": ("프로그램", "워크숍", "축제"),
    },
    "sports": {
        "#야구": ("야구", "챔피언스필드", "KIA"),
        "#축구": ("축구", "월드컵경기장"),
        "#스포츠": ("스포츠", "체육", "경기장"),
        "#응원": ("응원", "경기"),
        "#러닝": ("러닝", "달리기", "마라톤"),
        "#자전거": ("자전거", "라이딩"),
        "#등산": ("등산", "트레킹"),
    },
    "healing": {
        "#힐링": ("힐링", "휴식", "치유"),
        "#산책": ("산책", "걷기", "둘레길", "오솔길"),
        "#조용한": ("고요", "조용", "사색"),
        "#피크닉": ("피크닉", "잔디", "소풍"),
        "#공원": ("공원", "생태원", "정원"),
        "#느린여행": ("골목", "마을", "느린"),
    },
    "festival": {
        "#축제": ("축제", "페스티벌", "행사"),
        "#야간": ("야간", "밤", "저녁"),
        "#야경": ("야경", "조명", "빛"),
        "#공연": ("공연", "버스킹", "콘서트"),
        "#시즌한정": ("기간", "시즌", "계절"),
        "#마켓": ("마켓", "야시장", "장터"),
    },
}

JEONNAM_SIGUNGU = {
    "목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", 
    "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", 
    "함평군", "영광군", "장성군", "완도군", "진도군", "신안군"
}

JEONBUK_SIGUNGU = {
    "전주시", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", 
    "무주군", "장수군", "임실군", "순창군", "고창군", "부안군"
}

GWANGJU_SIGUNGU = {"광산구", "동구", "서구", "남구", "북구"}

class PipelineError(RuntimeError):
    pass


def load_dotenv(path: Path = ROOT / ".env") -> None:
    if not path.exists():
        return
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.strip()
        value = value.strip().strip("\"").strip("'")
        if key and key not in os.environ:
            os.environ[key] = value


def clean_text(value: Any) -> str:
    if value is None:
        return ""
    text = html.unescape(str(value))
    text = re.sub(r"<br\s*/?>", " ", text, flags=re.IGNORECASE)
    text = re.sub(r"<[^>]+>", " ", text)
    return re.sub(r"\s+", " ", text).strip()


def extract_url(value: Any) -> str:
    raw = html.unescape(str(value or ""))
    match = re.search(r'href=["\']([^"\']+)', raw, flags=re.IGNORECASE)
    if match:
        return match.group(1).strip()
    cleaned = clean_text(raw)
    match = re.search(r"https?://[^\s]+", cleaned)
    return match.group(0).rstrip(".,)") if match else ""


def load_classification_map(csv_path: Path) -> dict[str, str]:
    code_map = {}
    if not csv_path.exists():
        return code_map
    try:
        with csv_path.open("r", encoding="utf-8-sig", newline="") as handle:
            for row in csv.DictReader(handle):
                c1 = str(row.get("lclsSystm1Cd", "")).strip()
                n1 = str(row.get("lclsSystm1Nm", "")).strip()
                c2 = str(row.get("lclsSystm2Cd", "")).strip()
                n2 = str(row.get("lclsSystm2Nm", "")).strip()
                c3 = str(row.get("lclsSystm3Cd", "")).strip()
                n3 = str(row.get("lclsSystm3Nm", "")).strip()
                if c1 and n1:
                    code_map[c1] = n1
                if c2 and n2:
                    code_map[c2] = n2
                if c3 and n3:
                    code_map[c3] = n3
    except Exception:
        pass
    return code_map


def as_items(payload: dict[str, Any]) -> tuple[list[dict[str, Any]], int]:
    response = payload.get("response", payload)
    header = response.get("header", {})
    code = str(header.get("resultCode", "0000"))
    if code not in {"0000", "0"}:
        raise PipelineError(f"TourAPI 오류 {code}: {header.get('resultMsg', 'unknown error')}")
    body = response.get("body", {}) or {}
    container = body.get("items", {}) or {}
    item = container.get("item", []) if isinstance(container, dict) else []
    if isinstance(item, dict):
        rows = [item]
    elif isinstance(item, list):
        rows = item
    else:
        rows = []
    return rows, int(body.get("totalCount", len(rows)) or 0)


def api_get(endpoint: str, params: dict[str, Any], service_key: str, timeout: int = 30) -> dict[str, Any]:
    common = {
        "serviceKey": urllib.parse.unquote(service_key.strip()),
        "MobileOS": "ETC",
        "MobileApp": "OmaerouteDataBuilder",
        "_type": "json",
    }
    query = urllib.parse.urlencode({**common, **{k: v for k, v in params.items() if v not in (None, "")}})
    url = f"{TOUR_API_BASE}/{endpoint}?{query}"
    request = urllib.request.Request(url, headers={"User-Agent": "OmaerouteDataBuilder/1.0"})
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            raw = response.read().decode("utf-8", errors="replace")
    except urllib.error.HTTPError as error:
        detail = error.read().decode("utf-8", errors="replace")[:300]
        raise PipelineError(f"TourAPI HTTP {error.code}: {detail}") from error
    except urllib.error.URLError as error:
        raise PipelineError(f"TourAPI 연결 실패: {error.reason}") from error
    try:
        return json.loads(raw)
    except json.JSONDecodeError as error:
        raise PipelineError(f"TourAPI JSON 해석 실패: {raw[:300]}") from error


def fetch_html(url: str, timeout: int = 30) -> str:
    request = urllib.request.Request(url, headers={"User-Agent": "OmaerouteDataBuilder/1.0"})
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            return response.read().decode("utf-8", errors="replace")
    except urllib.error.HTTPError as error:
        raise PipelineError(f"광주관광 HTTP {error.code}: {url}") from error
    except urllib.error.URLError as error:
        raise PipelineError(f"광주관광 연결 실패: {error.reason}") from error


def match_clean(pattern: str, raw_html: str, flags: int = re.IGNORECASE | re.DOTALL) -> str:
    match = re.search(pattern, raw_html, flags)
    return clean_text(match.group(1)) if match else ""


def extract_detail_table(raw_html: str) -> dict[str, str]:
    values: dict[str, str] = {}
    pattern = r"<th[^>]*scope=[\"']row[\"'][^>]*>(.*?)</th>\s*<td[^>]*>(.*?)</td>"
    for match in re.finditer(pattern, raw_html, flags=re.IGNORECASE | re.DOTALL):
        key = clean_text(match.group(1))
        value = clean_text(match.group(2))
        if key and value:
            values[key] = value
    return values


def parse_price_bounds(value: str) -> tuple[int | str, int | str]:
    text = clean_text(value)
    if not text:
        return "", ""
    if "무료" in text:
        return 0, 0
    amounts = [int(number.replace(",", "")) for number in re.findall(r"([0-9][0-9,]*)\s*원", text)]
    if not amounts:
        return "", ""
    return min(amounts), max(amounts)


def parse_gwangju_detail(url: str, source_place_id: str, category: str) -> tuple[dict[str, Any], dict[str, Any]]:
    raw_html = fetch_html(url)
    table = extract_detail_table(raw_html)
    title = match_clean(r'<div[^>]*class=["\'][^"\']*titArea[^"\']*["\'][^>]*>.*?<h2[^>]*>(.*?)</h2>', raw_html)
    address = match_clean(r'<li[^>]*class=["\'][^"\']*addr[^"\']*["\'][^>]*>(.*?)</li>', raw_html)
    phone = match_clean(r'<li[^>]*class=["\'][^"\']*call[^"\']*["\'][^>]*>(.*?)</li>', raw_html)
    description = match_clean(r'<div[^>]*class=["\'][^"\']*detailTxt[^"\']*["\'][^>]*>(.*?)</div>', raw_html)
    latitude = match_clean(r"let\s+myMarkerLat\s*=\s*['\"]([^'\"]+)", raw_html)
    longitude = match_clean(r"let\s+myMarkerLng\s*=\s*['\"]([^'\"]+)", raw_html)
    image_path = match_clean(r'<div[^>]*class=["\'][^"\']*tourImgSlide[^"\']*["\'][^>]*>.*?<img[^>]+src=["\']([^"\']+)', raw_html)
    image_url = urllib.parse.urljoin(url, image_path) if image_path else ""

    homepage = ""
    button_block = re.search(r'<ul[^>]*class=["\'][^"\']*icoBtnList[^"\']*["\'][^>]*>(.*?)</ul>', raw_html, re.IGNORECASE | re.DOTALL)
    if button_block:
        for href in re.findall(r'href=["\']([^"\']+)', button_block.group(1), re.IGNORECASE):
            if href.startswith("http"):
                homepage = href
                break

    region, sigungu = normalize_region(address)
    searchable = f"{title} {category} {description} {' '.join(table.values())}"
    # 본문 텍스트 집합인 searchable은 먼저 계산하고 실내 확인
    indoor_markers = ("미술관", "박물관", "전시관", "공연장", "체험관", "실내")
    indoor = category in {"문화·예술", "음식·로컬"} and any(token in searchable for token in indoor_markers)
    parking = parse_optional_bool(table.get("주차시설", ""))
    pet = parse_optional_bool(table.get("애견동반", ""))
    wheelchair = True if any(token in searchable for token in ("휠체어", "장애인 전용", "경사로 있음", "엘리베이터 있음")) else ""
    family = any(token in searchable for token in ("어린이", "가족", "유모차", "수유실", "놀이시설"))
    reservation = parse_optional_bool(table.get("예약", "") or table.get("예약안내", ""))
    price_min, price_max = parse_price_bounds(table.get("이용요금", "") or table.get("요금", ""))
    transport_text = table.get("대중교통", "") + " " + table.get("버스정류장", "")
    if "지하철" in transport_text:
        transport_score = 0.9
    elif transport_text.strip():
        transport_score = 0.7
    else:
        transport_score = 0.5

    place = {
        "source": "gwangju_tour",
        "source_place_id": source_place_id,
        "name": title,
        "region": region,
        "sigungu": sigungu,
        "category": category,
        "description": description[:1000],
        "road_address": address,
        "lot_address": "",
        "latitude": latitude,
        "longitude": longitude,
        "phone": phone,
        "website_url": homepage,
        "image_url": image_url,
        "duration_minutes": DEFAULT_DURATION.get(category, 90),
        "indoor": indoor,
        "rain_ok": indoor,
        "family_friendly": family,
        "parking_available": parking,
        "wheelchair_accessible": wheelchair,
        "pet_friendly": pet,
        "requires_reservation": reservation,
        "price_min": price_min,
        "price_max": price_max,
        "status": "active",
        "public_transport_score": transport_score,
        "source_url": url,
        "source_updated_at": "",
        "last_verified_at": "",
        "license": "",
        "quality_status": "draft",
    }
    raw_record = {
        "source_place_id": source_place_id,
        "source_url": url,
        "title": title,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "detail_table": table,
        "collected_at": datetime.now(timezone.utc).isoformat(),
    }
    return place, raw_record


def operating_review_row(place: dict[str, Any], raw_record: dict[str, Any]) -> dict[str, Any]:
    table = raw_record.get("detail_table", {})
    return {
        "source": place.get("source", ""),
        "source_place_id": place.get("source_place_id", ""),
        "name": place.get("name", ""),
        "operating_hours_raw": table.get("이용시간", "") or table.get("영업시간", ""),
        "closed_days_raw": table.get("휴일", "") or table.get("휴무일", ""),
        "fees_raw": table.get("이용요금", "") or table.get("요금", ""),
        "parking_raw": table.get("주차시설", ""),
        "pet_raw": table.get("애견동반", ""),
        "public_transport_raw": " ".join(filter(None, (table.get("대중교통", ""), table.get("버스정류장", "")))),
        "source_url": place.get("source_url", ""),
    }


def parse_timestamp(value: Any) -> str:
    digits = re.sub(r"\D", "", str(value or ""))
    if len(digits) < 8:
        return ""
    fmt = "%Y%m%d%H%M%S" if len(digits) >= 14 else "%Y%m%d"
    try:
        parsed = datetime.strptime(digits[:14] if len(digits) >= 14 else digits[:8], fmt)
        return parsed.replace(tzinfo=timezone.utc).isoformat()
    except ValueError:
        return ""


def parse_optional_bool(value: Any) -> bool | str:
    text = clean_text(value).lower()
    if not text:
        return ""
    negative = ("불가", "없음", "안됨", "불가능", "미제공")
    positive = ("가능", "있음", "제공", "보유", "이용 가능")
    if any(token in text for token in negative):
        return False
    if any(token in text for token in positive):
        return True
    return ""


def normalize_region(address: str) -> tuple[str, str]:
    tokens = address.split()
    if not tokens:
        return ("", "")
    
    target_sigungu = tokens[1] if len(tokens) > 1 else ""
    if target_sigungu in GWANGJU_SIGUNGU:
        return ("광주", target_sigungu)
    if target_sigungu in JEONNAM_SIGUNGU:
        return ("전남", target_sigungu)
    if target_sigungu in JEONBUK_SIGUNGU:
        return ("전북", target_sigungu)

    region = " ".join(tokens[:2]) if len(tokens) >= 2 else tokens[0]
    sigungu = target_sigungu if any(target_sigungu.endswith(s) for s in ("시", "군", "구")) else ""

    return (region, sigungu)

def normalize_item(item: dict[str, Any]) -> dict[str, Any]:
    content_type = str(item.get("contenttypeid", ""))
    category = CONTENT_TYPE_CATEGORY.get(content_type, "기타")
    address = clean_text(item.get("addr1"))
    region, sigungu = normalize_region(address)
    parking_text = " ".join(clean_text(item.get(key)) for key in (
        "parking", "parkingculture", "parkingfood", "parkingleports", "parkingevent",
    ))
    indoor = content_type in {"14", "38", "39"}
    searchable = " ".join(clean_text(item.get(key)) for key in ("title", "overview", "lclsSystm1", "lclsSystm2", "lclsSystm3"))
    family = any(token in searchable for token in ("어린이", "가족", "아이", "체험"))
    return {
        "source": "tourapi",
        "source_place_id": clean_text(item.get("contentid")),
        "name": clean_text(item.get("title")),
        "region": region,
        "sigungu": sigungu,
        "category": category,
        "description": clean_text(item.get("overview"))[:1000],
        "road_address": " ".join(filter(None, (address, clean_text(item.get("addr2"))))),
        "lot_address": "",
        "latitude": clean_text(item.get("mapy")),
        "longitude": clean_text(item.get("mapx")),
        "phone": clean_text(item.get("tel") or item.get("infocenter")),
        "website_url": extract_url(item.get("homepage")),
        "image_url": clean_text(item.get("firstimage") or item.get("firstimage2")),
        "duration_minutes": DEFAULT_DURATION.get(category, 90),
        "indoor": indoor,
        "rain_ok": indoor,
        "family_friendly": family,
        "parking_available": parse_optional_bool(parking_text),
        "wheelchair_accessible": "",
        "pet_friendly": parse_optional_bool(item.get("chkpet") or item.get("chkpetculture") or item.get("chkpetfood")),
        "requires_reservation": parse_optional_bool(item.get("reservation")),
        "price_min": "",
        "price_max": "",
        "status": "active",
        "public_transport_score": 0.5,
        "source_url": extract_url(item.get("homepage")),
        "source_updated_at": parse_timestamp(item.get("modifiedtime")),
        "last_verified_at": "",
        "license": clean_text(item.get("cpyrhtDivCd")),
        "quality_status": "draft",
        "lclsSystm1": clean_text(item.get("lclsSystm1")),
        "lclsSystm2": clean_text(item.get("lclsSystm2")),
        "lclsSystm3": clean_text(item.get("lclsSystm3")),
    }


def is_valid_match(keyword: str, text: str) -> bool:
    if keyword not in text:
        return False
    if keyword == "산":
        # "산" 글자가 포함되어 있고, 동시에 "등산"이나 "봉우리"가 있는 경우에만 유효성 인정
        return ("산" in text) and ("등산" in text or "봉우리" in text)
    if keyword == "등산":
        cleaned_text = re.sub(r'무등산', '', text)
        return keyword in cleaned_text
    if keyword == "밤":
        cleaned_text = re.sub(r'밤나무', '', text)
        return keyword in cleaned_text
    if keyword == "꽃":
        cleaned_text = re.sub(r'눈꽃|꽃게', '', text)
        return keyword in cleaned_text
    return True

def score_profile(place: dict[str, Any], classification_map: dict[str, str] | None = None) -> dict[str, Any]:
    title_category = f"{place.get('name', '')} {place.get('category', '')}".lower()
    full_text = f"{title_category} {place.get('description', '')}".lower()
    hashtags: list[str] = []

    if classification_map:
        for code_key in ("lclsSystm1", "lclsSystm2", "lclsSystm3"):
            code_val = str(place.get(code_key, "")).strip()
            if code_val:
                name_val = classification_map.get(code_val, code_val)
                tag_name = f"#{name_val}"
                if tag_name not in hashtags:
                    hashtags.append(tag_name)

    scores: dict[str, float] = {}
    total_hits = 0
    for dimension in VECTOR_KEYS:
        hit_tags: list[str] = []
        strong_hits = 0
        body_hits = 0
        for tag, keywords in LABEL_RULES[dimension].items():
            for keyword in keywords:
                kw_lower = keyword.lower()
                if is_valid_match(kw_lower, title_category):
                    strong_hits += 1
                    if tag not in hit_tags:
                        hit_tags.append(tag)
                elif is_valid_match(kw_lower, full_text):
                    body_hits += 1
                    if tag not in hit_tags:
                        hit_tags.append(tag)
        hits = strong_hits + body_hits
        total_hits += hits
        if hits == 0:
            score = 0.0
        elif strong_hits >= 2 or hits >= 4:
            score = 1.0
        elif strong_hits >= 1 or hits >= 2:
            score = 0.75
        else:
            score = 0.5
        scores[dimension] = score
        hashtags.extend(hit_tags[:2])

    if str(place.get("indoor", "")).lower() == "true":
        hashtags.extend(("#실내", "#비오는날"))
    if str(place.get("family_friendly", "")).lower() == "true":
        hashtags.append("#아이동반")
    if str(place.get("parking_available", "")).lower() == "true":
        hashtags.append("#주차가능")
    if str(place.get("wheelchair_accessible", "")).lower() == "true":
        hashtags.append("#휠체어")
    if str(place.get("pet_friendly", "")).lower() == "true":
        hashtags.append("#반려동물")

    hashtags = list(dict.fromkeys(hashtags))[:10]
    confidence = min(0.60, 0.35 + total_hits * 0.025)
    evidence = [{
        "source": place.get("source", ""),
        "source_url": place.get("source_url", ""),
        "note": "규칙 기반 라벨 초안. 사람 교차검수 필요",
    }]
    return {
        "source": place.get("source", ""),
        "source_place_id": place.get("source_place_id", ""),
        "hashtags": "|".join(hashtags),
        **scores,
        "semantic_text": " ".join(filter(None, [place.get("name", ""), place.get("description", ""), " ".join(hashtags)])),
        "taxonomy_version": "1.0.0",
        "labeling_method": "import",
        "labeling_confidence": round(confidence, 2),
        "labeling_evidence": json.dumps(evidence, ensure_ascii=False),
        "reviewed_at": "",
    }


def write_csv(path: Path, fields: Iterable[str], rows: Iterable[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8-sig", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(fields), extrasaction="ignore")
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def fetch_detail(service_key: str, item: dict[str, Any], skip_details: bool) -> dict[str, Any]:
    if skip_details:
        return item
    content_id = item.get("contentid")
    content_type = item.get("contenttypeid")
    merged = dict(item)
    calls = (
        ("detailCommon2", {"contentId": content_id}),
        ("detailIntro2", {"contentId": content_id, "contentTypeId": content_type}),
    )
    for endpoint, params in calls:
        try:
            payload = api_get(endpoint, params, service_key)
            rows, _ = as_items(payload)
            if rows:
                merged.update(rows[0])
            time.sleep(0.05)
        except PipelineError as error:
            print(f"[경고] {content_id} {endpoint}: {error}", file=sys.stderr)
    return merged


def collect_tourapi(args: argparse.Namespace) -> tuple[Path, Path]:
    load_dotenv()
    service_key = os.environ.get("TOUR_API_SERVICE_KEY", "").strip()
    if not service_key:
        raise PipelineError("TOUR_API_SERVICE_KEY가 없습니다. .env.example을 복사해 .env에 인증키를 입력하세요.")
    output_dir = Path(args.output_dir)
    
    class_csv_path = output_dir / "tourapi_classification_codes.csv"
    classification_map = load_classification_map(class_csv_path)

    raw_items: list[dict[str, Any]] = []

    area_codes = args.area_codes if args.area_codes else ["5"]
    content_types = args.content_types if args.content_types else [""]

    for area_code in area_codes:
        for c_type in content_types:
            type_items: list[dict[str, Any]] = []
            page = 1
            total = None
            while len(type_items) < args.limit and (total is None or len(type_items) < total):
                params: dict[str, Any] = {
                    "numOfRows": min(100, args.limit - len(type_items)),
                    "pageNo": page,
                    "arrange": "A",
                    "areaCode": area_code,
                }
                if args.ldong_regn_code:
                    params["lDongRegnCd"] = args.ldong_regn_code
                
                if c_type:
                    params["contentTypeId"] = c_type

                payload = api_get("areaBasedList2", params, service_key)
                rows, total_count = as_items(payload)
                total = total_count
                if not rows:
                    break
                for row in rows:
                    if str(row.get("contenttypeid", "")) not in CONTENT_TYPE_CATEGORY:
                        continue
                    type_items.append(fetch_detail(service_key, row, args.skip_details))
                    if len(type_items) >= args.limit:
                        break
                page += 1
            raw_items.extend(type_items)

    if not raw_items:
        raise PipelineError("조건에 맞는 TourAPI 장소가 없습니다. 지역 코드와 인증키 상태를 확인하세요.")
    output_dir.mkdir(parents=True, exist_ok=True)
    raw_path = DATA_DIR / "raw" / f"tourapi_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    raw_path.write_text(json.dumps(raw_items, ensure_ascii=False, indent=2), encoding="utf-8")
    
    places = [normalize_item(item) for item in raw_items]
    profiles = [score_profile(place, classification_map) for place in places]
    
    places_path = output_dir / "tourapi_places.csv"
    profiles_path = output_dir / "tourapi_place_profiles.csv"
    write_csv(places_path, PLACE_FIELDS, places)
    write_csv(profiles_path, PROFILE_FIELDS, profiles)

    # [추가] TourAPI 수집 시에도 운영 정보 리뷰 CSV 파일 생성
    operating_reviews = []
    for item, place in zip(raw_items, places):
        # TourAPI 응답 데이터에서 운영 시간 및 휴무일 관련 필드 추출 매핑
        table = {
            "이용시간": item.get("opentimefood") or item.get("usetime") or "",
            "휴일": item.get("restdatefood") or item.get("restdate") or "",
            "이용요금": item.get("usefee") or "",
            "주차시설": item.get("parking") or item.get("parkingfood") or "",
            "애견동반": item.get("chkpet") or "",
            "대중교통": item.get("direction") or "",
        }
        raw_record = {"detail_table": table}
        operating_reviews.append(operating_review_row(place, raw_record))
        
    write_csv(
        output_dir / "tourapi_operating_info_review.csv",
        OPERATING_REVIEW_FIELDS,
        operating_reviews,
    )

    print(f"수집 완료: {len(places)}개 장소")
    print(f"원본: {raw_path}")
    return places_path, profiles_path


def collect_gwangju_official(args: argparse.Namespace) -> tuple[Path, Path]:
    output_dir = Path(args.output_dir)
    seen_ids: set[str] = set()
    detail_targets: list[tuple[str, str, str]] = []

    category_seen: dict[str, set[str]] = {endpoint: set() for endpoint, _ in GWANGJU_CATEGORIES}
    exhausted: set[str] = set()
    for page in range(1, args.pages_per_category + 1):
        for endpoint, category in GWANGJU_CATEGORIES:
            if len(detail_targets) >= args.limit:
                break
            if endpoint in exhausted:
                continue
            list_url = f"{GWANGJU_TOUR_BASE}/home/tour/info/{endpoint}?pageIndex={page}"
            list_html = fetch_html(list_url)
            page_ids = list(dict.fromkeys(re.findall(r"infoId=(\d+)", list_html)))
            new_ids = [info_id for info_id in page_ids if info_id not in category_seen[endpoint]]
            if not new_ids:
                exhausted.add(endpoint)
                continue
            category_seen[endpoint].update(new_ids)
            for info_id in new_ids:
                global_id = f"{endpoint}:{info_id}"
                if global_id in seen_ids:
                    continue
                seen_ids.add(global_id)
                detail_url = f"{GWANGJU_TOUR_BASE}/home/tour/info/{endpoint}?act=view&infoId={info_id}"
                detail_targets.append((global_id, detail_url, category))
                if len(detail_targets) >= args.limit:
                    break
            time.sleep(args.delay)
        if len(detail_targets) >= args.limit or len(exhausted) == len(GWANGJU_CATEGORIES):
            break

    places: list[dict[str, Any]] = []
    raw_records: list[dict[str, Any]] = []
    for index, (source_place_id, detail_url, category) in enumerate(detail_targets, start=1):
        try:
            place, raw_record = parse_gwangju_detail(detail_url, source_place_id, category)
            if place["name"] and "광주" in place["road_address"]:
                places.append(place)
                raw_records.append(raw_record)
                print(f"[{len(places):03d}/{args.limit:03d}] {place['name']}")
        except PipelineError as error:
            print(f"[경고] {detail_url}: {error}", file=sys.stderr)
        if index < len(detail_targets):
            time.sleep(args.delay)

    if not places:
        raise PipelineError("광주관광 공식 사이트에서 장소를 수집하지 못했습니다.")
    profiles = [score_profile(place) for place in places]
    output_dir.mkdir(parents=True, exist_ok=True)
    raw_path = DATA_DIR / "raw" / f"gwangju_tour_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    raw_path.write_text(json.dumps(raw_records, ensure_ascii=False, indent=2), encoding="utf-8")
    places_path = output_dir / "gwangju_official_places.csv"
    profiles_path = output_dir / "gwangju_official_place_profiles.csv"
    write_csv(places_path, PLACE_FIELDS, places)
    write_csv(profiles_path, PROFILE_FIELDS, profiles)
    write_csv(
        output_dir / "gwangju_official_operating_info_review.csv",
        OPERATING_REVIEW_FIELDS,
        (operating_review_row(place, raw) for place, raw in zip(places, raw_records)),
    )
    print(f"광주관광 공식 페이지 수집 완료: {len(places)}개 장소")
    print(f"원본: {raw_path}")
    return places_path, profiles_path


def bootstrap_local(args: argparse.Namespace) -> tuple[Path, Path]:
    source_path = DATA_DIR / "places.json"
    source = json.loads(source_path.read_text(encoding="utf-8"))
    places: list[dict[str, Any]] = []
    profiles: list[dict[str, Any]] = []
    now = datetime.now(timezone.utc).isoformat()
    for item in source:
        region = clean_text(item.get("region"))
        sigungu = region.split()[-1] if region else ""
        source_place_id = PROTOTYPE_SOURCE_IDS.get(item.get("name", ""), str(item["id"]))
        places.append({
            "source": "prototype",
            "source_place_id": source_place_id,
            "name": item.get("name", ""),
            "region": region,
            "sigungu": sigungu,
            "category": item.get("category", ""),
            "description": item.get("description", ""),
            "road_address": "",
            "lot_address": "",
            "latitude": item.get("latitude", ""),
            "longitude": item.get("longitude", ""),
            "phone": "",
            "website_url": "",
            "image_url": "",
            "duration_minutes": item.get("durationMinutes", 90),
            "indoor": item.get("indoor", False),
            "rain_ok": item.get("rainOk", False),
            "family_friendly": item.get("familyFriendly", False),
            "parking_available": "",
            "wheelchair_accessible": "",
            "pet_friendly": "",
            "requires_reservation": "",
            "price_min": "",
            "price_max": "",
            "status": "active",
            "public_transport_score": item.get("publicTransportScore", 0.5),
            "source_url": "",
            "source_updated_at": "",
            "last_verified_at": now,
            "license": "prototype",
            "quality_status": "reviewed",
        })
        vector = item.get("vector", [0] * 8)
        profiles.append({
            "source": "prototype",
            "source_place_id": source_place_id,
            "hashtags": "|".join(item.get("hashtags", [])),
            **dict(zip(VECTOR_KEYS, vector)),
            "semantic_text": " ".join([item.get("name", ""), item.get("description", ""), *item.get("hashtags", [])]),
            "taxonomy_version": "1.0.0",
            "labeling_method": "manual",
            "labeling_confidence": 0.85,
            "labeling_evidence": json.dumps([{"source": "prototype", "note": "기존 MVP 수동 라벨"}], ensure_ascii=False),
            "reviewed_at": now,
        })
    output_dir = Path(args.output_dir)
    places_path = output_dir / "bootstrap_places.csv"
    profiles_path = output_dir / "bootstrap_place_profiles.csv"
    write_csv(places_path, PLACE_FIELDS, places)
    write_csv(profiles_path, PROFILE_FIELDS, profiles)
    write_csv(output_dir / "bootstrap_place_opening_hours.csv", HOUR_FIELDS, [])
    print(f"기존 샘플 변환 완료: {len(places)}개 장소")
    return places_path, profiles_path


def add_issue(issues: list[dict[str, Any]], severity: str, row: int | str, field: str, message: str) -> None:
    issues.append({"severity": severity, "row": row, "field": field, "message": message})


def as_float(value: Any) -> float | None:
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def validate_dataset(places_path: Path, profiles_path: Path, report_path: Path) -> dict[str, Any]:
    places = read_csv(places_path)
    profiles = read_csv(profiles_path)
    issues: list[dict[str, Any]] = []
    place_keys: set[tuple[str, str]] = set()
    normalized_names: Counter[str] = Counter()
    required = ("source", "source_place_id", "name", "region", "category", "latitude", "longitude", "duration_minutes", "status", "quality_status")
    for index, row in enumerate(places, start=2):
        for field in required:
            if not str(row.get(field, "")).strip():
                add_issue(issues, "critical", index, field, "필수값 누락")
        key = (row.get("source", "").strip(), row.get("source_place_id", "").strip())
        if key in place_keys:
            add_issue(issues, "critical", index, "source_place_id", f"중복 키: {key}")
        place_keys.add(key)
        normalized_name = re.sub(r"\s+", "", row.get("name", "")).lower()
        normalized_names[normalized_name] += 1
        latitude, longitude = as_float(row.get("latitude")), as_float(row.get("longitude"))
        if latitude is None or longitude is None or not (33 <= latitude <= 39 and 124 <= longitude <= 132):
            add_issue(issues, "critical", index, "latitude/longitude", "대한민국 WGS84 범위를 벗어남")
        duration = as_float(row.get("duration_minutes"))
        if duration is None or duration <= 0:
            add_issue(issues, "high", index, "duration_minutes", "0보다 큰 체류시간 필요")
        for field in ("indoor", "rain_ok", "family_friendly"):
            if str(row.get(field, "")).lower() not in {"true", "false", "1", "0"}:
                add_issue(issues, "high", index, field, "true/false 값 필요")
        if row.get("quality_status") in {"reviewed", "verified"} and not row.get("source_url"):
            add_issue(issues, "medium", index, "source_url", "검수 데이터에 출처 URL 없음")

    for name, count in normalized_names.items():
        if name and count > 1:
            add_issue(issues, "medium", "all", "name", f"유사 중복 이름 {name}: {count}건")

    profile_keys: set[tuple[str, str]] = set()
    for index, row in enumerate(profiles, start=2):
        key = (row.get("source", "").strip(), row.get("source_place_id", "").strip())
        if key in profile_keys:
            add_issue(issues, "critical", index, "source_place_id", f"프로필 중복 키: {key}")
        profile_keys.add(key)
        if key not in place_keys:
            add_issue(issues, "critical", index, "source_place_id", "장소 마스터에 없는 프로필")
        for dimension in VECTOR_KEYS:
            value = as_float(row.get(dimension))
            if value is None or not (0 <= value <= 1):
                add_issue(issues, "critical", index, dimension, "점수는 0~1 숫자여야 함")
        evidence = row.get("labeling_evidence", "")
        try:
            json.loads(evidence or "[]")
        except json.JSONDecodeError:
            add_issue(issues, "high", index, "labeling_evidence", "유효한 JSON 필요")

    for missing in sorted(place_keys - profile_keys):
        add_issue(issues, "high", "all", "place_profiles", f"추천 프로필 누락: {missing}")

    severity_counts = Counter(issue["severity"] for issue in issues)
    completeness_fields = (
        "name", "region", "category", "description", "road_address", "latitude", "longitude", "phone",
        "website_url", "image_url", "parking_available", "wheelchair_accessible", "pet_friendly", "price_min",
        "source_url", "last_verified_at",
    )
    completeness = {
        field: {
            "filled": sum(1 for row in places if str(row.get(field, "")).strip()),
            "rate": round(sum(1 for row in places if str(row.get(field, "")).strip()) / len(places), 4) if places else 0,
        }
        for field in completeness_fields
    }
    vector_profile: dict[str, Any] = {}
    for dimension in VECTOR_KEYS:
        values = [value for row in profiles if (value := as_float(row.get(dimension))) is not None]
        vector_profile[dimension] = {
            "mean": round(sum(values) / len(values), 4) if values else None,
            "min": min(values) if values else None,
            "max": max(values) if values else None,
            "zero_count": sum(1 for value in values if value == 0),
        }
    report = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "places_file": str(places_path),
        "profiles_file": str(profiles_path),
        "place_rows": len(places),
        "profile_rows": len(profiles),
        "category_counts": dict(Counter(row.get("category", "") for row in places)),
        "region_counts": dict(Counter(row.get("region", "") for row in places)),
        "completeness": completeness,
        "vector_profile": vector_profile,
        "severity_counts": dict(severity_counts),
        "passed": severity_counts["critical"] == 0,
        "issues": issues,
    }
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"품질검사: 장소 {len(places)} / 프로필 {len(profiles)}")
    print("이슈: " + ", ".join(f"{key}={value}" for key, value in sorted(severity_counts.items())) if issues else "이슈: 없음")
    print(f"보고서: {report_path}")
    return report


def sql_text(value: Any) -> str:
    if value is None or str(value).strip() == "":
        return "null"
    return "'" + str(value).replace("'", "''") + "'"


def sql_number(value: Any, default: str = "null") -> str:
    parsed = as_float(value)
    if parsed is None:
        return default
    return str(int(parsed)) if parsed.is_integer() else str(parsed)


def sql_bool(value: Any, default: str = "null") -> str:
    text = str(value).strip().lower()
    if text in {"true", "1", "yes", "y"}:
        return "true"
    if text in {"false", "0", "no", "n"}:
        return "false"
    return default


def sql_array(pipe_value: str) -> str:
    values = [value.strip() for value in str(pipe_value or "").split("|") if value.strip()]
    return "array[" + ",".join(sql_text(value) for value in values) + "]::text[]"


def build_seed_sql(places_path: Path, profiles_path: Path, output_path: Path) -> None:
    places = read_csv(places_path)
    profiles = read_csv(profiles_path)
    profile_by_key = {(row["source"], row["source_place_id"]): row for row in profiles}
    lines = [
        "-- data_pipeline.py가 생성한 오매루트 장소 적재 SQL",
        "-- 검수 후 Supabase SQL Editor에서 실행하세요.",
        "begin;",
        "",
    ]
    text_fields = {
        "source", "source_place_id", "name", "region", "sigungu", "category", "description",
        "road_address", "lot_address", "phone", "website_url", "image_url", "status", "source_url",
        "source_updated_at", "last_verified_at", "license", "quality_status",
    }
    number_fields = {"latitude", "longitude", "duration_minutes", "price_min", "price_max", "public_transport_score"}
    bool_defaults_false = {"indoor", "rain_ok", "family_friendly"}
    bool_fields = bool_defaults_false | {"parking_available", "wheelchair_accessible", "pet_friendly", "requires_reservation"}
    db_fields = list(PLACE_FIELDS)
    for place in places:
        values: list[str] = []
        for field in db_fields:
            value = place.get(field, "")
            if field in text_fields:
                cast = "::timestamptz" if field in {"source_updated_at", "last_verified_at"} and value else ""
                values.append(sql_text(value) + cast)
            elif field in number_fields:
                default = "90" if field == "duration_minutes" else ("0.5" if field == "public_transport_score" else "null")
                values.append(sql_number(value, default))
            elif field in bool_fields:
                values.append(sql_bool(value, "false" if field in bool_defaults_false else "null"))
            else:
                values.append(sql_text(value))
        updates = [f"{field} = excluded.{field}" for field in db_fields if field not in {"source", "source_place_id"}]
        lines.extend((
            f"insert into public.places ({', '.join(db_fields)})",
            f"values ({', '.join(values)})",
            "on conflict (source, source_place_id) do update set",
            "  " + ",\n  ".join(updates) + ",\n  updated_at = now();",
            "",
        ))
        profile = profile_by_key.get((place["source"], place["source_place_id"]))
        if not profile:
            continue
        scores = {key: float(profile[key]) for key in VECTOR_KEYS}
        vector = "[" + ",".join(str(scores[key]) for key in VECTOR_KEYS) + "]"
        evidence = profile.get("labeling_evidence") or "[]"
        reviewed_at = sql_text(profile.get("reviewed_at"))
        if reviewed_at != "null":
            reviewed_at += "::timestamptz"
        lines.extend((
            "insert into public.place_profiles (",
            "  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,",
            "  labeling_method, labeling_confidence, labeling_evidence, reviewed_at",
            ")",
            "select p.id,",
            f"  {sql_array(profile.get('hashtags', ''))},",
            f"  {sql_text(json.dumps(scores, ensure_ascii=False))}::jsonb,",
            f"  {sql_text(vector)}::extensions.vector(8),",
            f"  {sql_text(profile.get('semantic_text'))}, {sql_text(profile.get('taxonomy_version') or '1.0.0')},",
            f"  {sql_text(profile.get('labeling_method') or 'import')}, {sql_number(profile.get('labeling_confidence'), '0.35')},",
            f"  {sql_text(evidence)}::jsonb, {reviewed_at}",
            "from public.places p",
            f"where p.source = {sql_text(place['source'])} and p.source_place_id = {sql_text(place['source_place_id'])}",
            "on conflict (place_id) do update set",
            "  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,",
            "  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,",
            "  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,",
            "  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,",
            "  reviewed_at = excluded.reviewed_at, updated_at = now();",
            "",
        ))
    lines.extend(("commit;", ""))
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Supabase SQL 생성: {output_path}")


def command_validate(args: argparse.Namespace) -> int:
    report = validate_dataset(Path(args.places), Path(args.profiles), Path(args.report))
    return 0 if report["passed"] else 1


def command_bootstrap(args: argparse.Namespace) -> int:
    places_path, profiles_path = bootstrap_local(args)
    output_dir = Path(args.output_dir)
    report = validate_dataset(places_path, profiles_path, output_dir / "bootstrap_quality_report.json")
    build_seed_sql(places_path, profiles_path, output_dir / "bootstrap_seed.sql")
    return 0 if report["passed"] else 1


def command_collect(args: argparse.Namespace) -> int:
    places_path, profiles_path = collect_tourapi(args)
    output_dir = Path(args.output_dir)
    report = validate_dataset(places_path, profiles_path, output_dir / "tourapi_quality_report.json")
    build_seed_sql(places_path, profiles_path, output_dir / "tourapi_seed.sql")
    return 0 if report["passed"] else 1


def command_collect_gwangju(args: argparse.Namespace) -> int:
    places_path, profiles_path = collect_gwangju_official(args)
    output_dir = Path(args.output_dir)
    report = validate_dataset(places_path, profiles_path, output_dir / "gwangju_official_quality_report.json")
    build_seed_sql(places_path, profiles_path, output_dir / "gwangju_official_seed.sql")
    return 0 if report["passed"] else 1


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="오매루트 데이터 구축 파이프라인")
    subparsers = parser.add_subparsers(dest="command", required=True)

    bootstrap = subparsers.add_parser("bootstrap", help="기존 places.json을 CSV·SQL로 변환하고 검사")
    bootstrap.add_argument("--output-dir", default=str(DEFAULT_OUTPUT_DIR))
    bootstrap.set_defaults(func=command_bootstrap)

    collect = subparsers.add_parser("collect", help="TourAPI 광주 장소를 수집하고 CSV·SQL 생성")
    collect.add_argument("--output-dir", default=str(DEFAULT_OUTPUT_DIR))
    collect.add_argument("--limit", type=int, default=100)
    collect.add_argument("--content-types", nargs="*", default=[])      # 수집 명령어에 --content-type 인자를 받을 수 있도록 함.
    collect.add_argument("--area-codes", nargs="*", default=[os.environ.get("TOUR_API_AREA_CODE", "5")])        # 수집 명령어에 --area-code 인자를 받을 수 있도록 함.
    collect.add_argument("--ldong-regn-code", default=os.environ.get("TOUR_API_LDONG_REGN_CD", ""))
    collect.add_argument("--skip-details", action="store_true")
    collect.set_defaults(func=command_collect)

    gwangju = subparsers.add_parser("collect-gwangju", help="인증키 없이 광주관광 공식 페이지의 장소 초안 수집")
    gwangju.add_argument("--output-dir", default=str(DEFAULT_OUTPUT_DIR))
    gwangju.add_argument("--limit", type=int, default=30)
    gwangju.add_argument("--pages-per-category", type=int, default=10)
    gwangju.add_argument("--delay", type=float, default=0.2)
    gwangju.set_defaults(func=command_collect_gwangju)

    validate = subparsers.add_parser("validate", help="장소·프로필 CSV 품질검사")
    validate.add_argument("--places", required=True)
    validate.add_argument("--profiles", required=True)
    validate.add_argument("--report", default=str(DEFAULT_OUTPUT_DIR / "quality_report.json"))
    validate.set_defaults(func=command_validate)

    sql = subparsers.add_parser("build-sql", help="장소·프로필 CSV를 Supabase SQL로 변환")
    sql.add_argument("--places", required=True)
    sql.add_argument("--profiles", required=True)
    sql.add_argument("--output", default=str(DEFAULT_OUTPUT_DIR / "seed.sql"))
    sql.set_defaults(func=lambda args: (build_seed_sql(Path(args.places), Path(args.profiles), Path(args.output)) or 0))
    return parser


def main() -> int:
    load_dotenv()
    parser = build_parser()
    args = parser.parse_args()
    try:
        return int(args.func(args))
    except (PipelineError, FileNotFoundError, KeyError, ValueError) as error:
        print(f"[오류] {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
