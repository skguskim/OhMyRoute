import os
import time
import urllib.request
import urllib.error
import urllib.parse
import json
import pandas as pd
import re
from pathlib import Path
from datetime import datetime
from typing import Any, List

ROOT_DIR = Path(".").resolve()
GENERATED_DIR = ROOT_DIR / "OhMyRoute" / "data" / "generated"
TOUR_API_BASE = "https://apis.data.go.kr/B551011/KorService2"

CONTENT_TYPE_CATEGORY = {
    "12": "관광지", "14": "문화·예술", "15": "축제·공연",
    "28": "체험·스포츠", "38": "쇼핑·시장", "39": "음식·로컬",
}

DEFAULT_DURATION = {
    "관광지": 90, "문화·예술": 90, "축제·공연": 120,
    "체험·스포츠": 150, "쇼핑·시장": 70, "음식·로컬": 60,
}

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
        "#역사": ("역사", "유적", "사적", "기념관"),
        "#문화유산": ("문화재", "문화유산", "세계유산"),
        "#근대문화": ("근대", "일제", "개화"),
        "#민주인권": ("5·18", "5.18", "민주", "인권"),
        "#전통": ("전통", "한옥", "서원", "향교", "사찰"),
        "#박물관": ("박물관", "기념관", "전시관"),
    },
    "art": {
        "#예술": ("예술", "미술", "작가"),
        "#전시": ("전시", "갤러리", "박물관", "미술관"),
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

VECTOR_KEYS = list(LABEL_RULES.keys())

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

OPERATING_REVIEW_FIELDS = (
    "source", "source_place_id", "name", "operating_hours_raw", "closed_days_raw", "fees_raw",
    "parking_raw", "pet_raw", "public_transport_raw", "source_url",
)

def load_classification_map(csv_path: Path) -> dict:
    code_map = {}
    if not csv_path.exists():
        return code_map
    
    # df = pd.read_csv(csv_path, encoding="utf-8-sig")
    # 로 하면 NA가 자연경관 코드가 아니라 NaN으로 들어가서 오류 발생. keep_default_na=False 옵션 추가
    # data_pipline에서는 dictReader로 읽어와서 문제없던 것.
    df = pd.read_csv(
        csv_path,
        encoding="utf-8-sig",
        dtype=str,
        keep_default_na=False
    )
    for _, row in df.iterrows():
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
            
    return code_map

def load_dotenv(path: Path = ROOT_DIR / "OhMyRoute" / ".env") -> None:
    if not os.path.exists(path):
        return
    with open(path, "r", encoding="utf-8") as f:
        for raw_line in f:
            line = raw_line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            os.environ.setdefault(key.strip(), value.strip().strip('"').strip("'"))

def api_get(endpoint: str, params: dict, service_key: str, timeout: int = 30) -> dict:
    common = {
        "serviceKey": urllib.parse.unquote(service_key.strip()),
        "MobileOS": "ETC",
        "MobileApp": "TestClient",
        "_type": "json",
    }
    query = urllib.parse.urlencode({**common, **{k: v for k, v in params.items() if v not in (None, "")}})
    url = f"{TOUR_API_BASE}/{endpoint}?{query}"
    request = urllib.request.Request(url, headers={"User-Agent": "TestClient/1.0"})
    
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            raw = response.read().decode("utf-8", errors="replace")
        return json.loads(raw)
    except Exception:
        return {}

def as_items(payload: dict) -> list:
    response = payload.get("response", payload)
    if not isinstance(response, dict):
        return []
        
    header = response.get("header", {})
    code = str(header.get("resultCode", "0000"))
    if code not in {"0000", "0"}:
        return []
        
    body = response.get("body", {}) or {}
    container = body.get("items", {}) or {}
    item = container.get("item", []) if isinstance(container, dict) else []
    
    if isinstance(item, dict):
        return [item]
    elif isinstance(item, list):
        return item
        
    return []

def fetch_place_data(content_id: str) -> dict:
    load_dotenv()
    service_key = os.environ.get("TOUR_API_SERVICE_KEY", "").strip()
    if not service_key:
        return {}

    merged = {"contentid": content_id}
    
    c_payload = api_get("detailCommon2", {"contentId": content_id}, service_key)
    c_rows = as_items(c_payload)
    if c_rows:
        merged.update(c_rows[0])
        
    content_type = merged.get("contenttypeid")
    if content_type:
        i_payload = api_get("detailIntro2", {"contentId": content_id, "contentTypeId": content_type}, service_key)
        i_rows = as_items(i_payload)
        if i_rows:
            merged.update(i_rows[0])
            
    return merged

def is_valid_match(keyword: str, text: str) -> bool:
    if keyword not in text:
        return False
    if keyword == "산":
        cleaned_text = re.sub(r'산책|생산|계산|예산|우산|산업|특산|수산|농산|유산|동산', '', text)
        return keyword in cleaned_text
    if keyword == "밤":
        cleaned_text = re.sub(r'밤나무', '', text)
        return keyword in cleaned_text
    if keyword == "꽃":
        cleaned_text = re.sub(r'눈꽃|꽃게', '', text)
        return keyword in cleaned_text
    return True

def generate_profile(place: dict, classification_map: dict) -> dict:
    title_category = f"{place.get('name', '')} {place.get('category', '')}".lower()
    full_text = f"{title_category} {place.get('description', '')}".lower()
    
    hashtags = []
    
    for code_key in ("lclsSystm1", "lclsSystm2", "lclsSystm3"):
        code_val = str(place.get(code_key, "")).strip()
        # if code_val in classification_map:
        #    tag_name = f"#{classification_map[code_val]}"
        if code_val:
            name_val = classification_map.get(code_val, code_val)
            tag_name = f"#{name_val}"
            if tag_name not in hashtags:
                hashtags.append(tag_name)

    profile_data = {
        "source": place.get("source", "tourapi"),
        "source_place_id": place.get("source_place_id", ""),
        "taxonomy_version": "1.0",
        "labeling_method": "rule_based",
        "labeling_confidence": 0.0,
        "labeling_evidence": "",
        "reviewed_at": datetime.now().isoformat()
    }
    
    total_score = 0.0
    
    for dimension in VECTOR_KEYS:
        hit_tags = []
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
                        
        if hit_tags:
            hashtags.extend(hit_tags[:10])
            
        hits = strong_hits + (body_hits * 0.2)
        
        if hits == 0:
            score = 0.0
        elif strong_hits >= 2 or hits >= 1.5:
            score = 1.0
        elif strong_hits >= 1 or hits >= 0.8:
            score = 0.75
        else:
            score = 0.5
            
        profile_data[dimension] = score
        total_score += score

    if str(place.get("indoor", "")).lower() == "true":
        hashtags.extend(["#실내", "#비오는날"])
    if str(place.get("family_friendly", "")).lower() == "true":
        hashtags.append("#아이동반")
    if str(place.get("parking_available", "")).lower() == "true":
        hashtags.append("#주차가능")
    if str(place.get("wheelchair_accessible", "")).lower() == "true":
        hashtags.append("#휠체어")
    if str(place.get("pet_friendly", "")).lower() == "true":
        hashtags.append("#반려동물")

    hashtags = list(dict.fromkeys(hashtags))[:10]
    
    profile_data["hashtags"] = ",".join(hashtags)
    profile_data["semantic_text"] = f"{title_category} {full_text} {profile_data['hashtags']}".strip()
    profile_data["labeling_confidence"] = min(1.0, round(total_score / len(VECTOR_KEYS), 2))
    
    return profile_data

def build_data_pipeline(raw_data_list: List[dict], output_dir: Path, classification_map: dict) -> None:
    places, profiles, reviews = [], [], []
    
    for raw in raw_data_list:
        content_id = str(raw.get("contentid", ""))
        content_type = str(raw.get("contenttypeid", ""))
        category = CONTENT_TYPE_CATEGORY.get(content_type, "기타")
        
        op_hours = raw.get("usetime") or raw.get("usetimeculture") or raw.get("opentimefood") or raw.get("usetimeleports") or ""
        rest_days = raw.get("restdate") or raw.get("restdateculture") or raw.get("restdatefood") or raw.get("restdateleports") or ""
        fees = raw.get("usefee") or raw.get("usefeeculture") or raw.get("usefeeleports") or ""
        parking = raw.get("parking") or raw.get("parkingculture") or raw.get("parkingfood") or raw.get("parkingleports") or ""
        pet = raw.get("chkpet") or raw.get("chkpetculture") or raw.get("chkpetleports") or ""

        place_data = {
            "source": "tourapi",
            "source_place_id": content_id,
            "name": raw.get("title", ""),
            "region": raw.get("areacode", ""),
            "sigungu": raw.get("sigungucode", ""),
            "category": category,
            "description": raw.get("overview", "").replace("<br>", "\n").replace("<br/>", "\n"),
            "road_address": raw.get("addr1", ""),
            "latitude": raw.get("mapy", ""),
            "longitude": raw.get("mapx", ""),
            "duration_minutes": DEFAULT_DURATION.get(category, 60),
            "source_updated_at": raw.get("modifiedtime", ""),
            "last_verified_at": datetime.now().isoformat(),
            "lclsSystm1": raw.get("lclsSystm1"),
            "lclsSystm2": raw.get("lclsSystm2"),
            "lclsSystm3": raw.get("lclsSystm3"),
        }
        for field in PLACE_FIELDS:
            place_data.setdefault(field, "")
        places.append(place_data)
        
        profile_data = generate_profile(place_data, classification_map)
        for field in PROFILE_FIELDS:
            profile_data.setdefault(field, "")
        profiles.append(profile_data)
        
        review_data = {
            "source": "tourapi",
            "source_place_id": content_id,
            "name": raw.get("title", ""),
            "operating_hours_raw": op_hours,
            "closed_days_raw": rest_days,
            "fees_raw": fees,
            "parking_raw": parking,
            "pet_raw": pet,
        }
        for field in OPERATING_REVIEW_FIELDS:
            review_data.setdefault(field, "")
        reviews.append(review_data)

    df_places = pd.DataFrame(places, columns=PLACE_FIELDS)
    df_profiles = pd.DataFrame(profiles, columns=PROFILE_FIELDS)
    df_reviews = pd.DataFrame(reviews, columns=OPERATING_REVIEW_FIELDS)
    
    output_dir.mkdir(parents=True, exist_ok=True)
    df_places.to_csv(output_dir / "test_places.csv", index=False, encoding="utf-8-sig")
    df_profiles.to_csv(output_dir / "test_place_profiles.csv", index=False, encoding="utf-8-sig")
    df_reviews.to_csv(output_dir / "test_operating_info_review.csv", index=False, encoding="utf-8-sig")
    
    print(f"\n파이프라인 처리 완료. 총 {len(raw_data_list)}개의 데이터가 {output_dir}에 저장되었습니다.")

if __name__ == "__main__":
    TARGET_IDS = ["1778079", "126329"]
    
    # 분류 코드 CSV 파일 경로 지정 (필요 시 경로 수정)
    class_csv_path = GENERATED_DIR / "tourapi_classification_codes.csv"
    classification_map = load_classification_map(class_csv_path)
    
    collected_data = []
    for cid in TARGET_IDS:
        print(f"[{cid}] API 데이터 수집 중...")
        data = fetch_place_data(cid)
        if data and "title" in data:
            collected_data.append(data)
            
    if collected_data:
        build_data_pipeline(collected_data, GENERATED_DIR / "test code", classification_map)
    else:
        print("파이프라인을 실행할 유효한 데이터가 없습니다.")

'''
lclsSystm1Cd,lclsSystm1Nm,lclsSystm2Cd,lclsSystm2Nm,lclsSystm3Cd,lclsSystm3Nm,rnum
AC,숙박,AC01,호텔,AC010100,호텔,1
AC,숙박,AC02,콘도미니엄,AC020100,콘도,2
이 형태의 
tourapi_classification_codes.csv를 활용해서 라벨링할거야.
'''