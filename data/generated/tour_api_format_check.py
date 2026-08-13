import os
import time
import urllib.request
import urllib.error
import urllib.parse
import json
from pathlib import Path

ROOT_DIR = Path(".").resolve()
GENERATED_DIR = ROOT_DIR / "OhMyRoute" / "data" / "generated"

def fetch_json(url, max_retries=4, backoff_base=1.5):
    """429(Too Many Requests) 발생 시 지수 백오프로 재시도하며 JSON을 가져온다."""
    for attempt in range(1, max_retries + 1):
        req = urllib.request.Request(url, headers={"User-Agent": "TestClient/1.0"})
        try:
            with urllib.request.urlopen(req) as response:
                return json.loads(response.read().decode("utf-8"))
        except urllib.error.HTTPError as e:
            body = e.read().decode("utf-8", errors="replace")
            if e.code == 429 and "LIMITED_NUMBER_OF_SERVICE_REQUESTS_EXCEEDS_ERROR" in body:
                raise RuntimeError(f"일일 트래픽 초과 (재시도 무의미): {body}") from None
            if e.code == 429 and attempt < max_retries:
                wait = backoff_base ** attempt
                print(f"429 발생, {wait:.1f}초 대기 후 재시도 ({attempt}/{max_retries})")
                time.sleep(wait)
                continue
            raise

def load_dotenv(path=ROOT_DIR / "OhMyRoute" / ".env"):
    if not os.path.exists(path):
        return
    with open(path, "r", encoding="utf-8") as f:
        for raw_line in f:
            line = raw_line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            key = key.strip()
            value = value.strip().strip('"').strip("'")
            if key and key not in os.environ:
                os.environ[key] = value

def fetch_specific_raw_place(content_id: str):
    load_dotenv()
    service_key = os.environ.get("TOUR_API_SERVICE_KEY", "").strip()
    if not service_key:
        print("TOUR_API_SERVICE_KEY가 설정되지 않았습니다.")
        return

    base_url = "https://apis.data.go.kr/B551011/KorService2"
    merged = {"contentid": content_id}
    common_params = {
        "serviceKey": urllib.parse.unquote(service_key),
        "MobileOS": "ETC",
        "MobileApp": "TestClient",
        "_type": "json",
        "contentId": content_id
    }

#     list_query = urllib.parse.urlencode(common_params)
#     list_url = f"{base_url}/areaBasedList2?{list_query}"

#     list_data = fetch_json(list_url)

#     items = list_data.get("response", {}).get("body", {}).get("items", {}).get("item", [])
#     if not items:
#         print("조회된 장소가 없습니다.")
#         return

#     item = items[0] if isinstance(items, list) else items
#     content_id = item.get("contentid")
#     content_type = item.get("contenttypeid")
#     merged = dict(item)

#     detail_common_params = {
#     "serviceKey": urllib.parse.unquote(service_key),
#     "MobileOS": "ETC",
#     "MobileApp": "TestClient",
#     "_type": "json",
#     "contentId": content_id
# }
#     common_url = f"{base_url}/detailCommon2?{urllib.parse.urlencode(detail_common_params)}"
#     try:
#         c_data = fetch_json(common_url)
#         print("공통 정보 응답 데이터:", c_data)
#         c_items = c_data.get("response", {}).get("body", {}).get("items", {}).get("item", [])
#         if c_items:
#             merged.update(c_items[0] if isinstance(c_items, list) else c_items)
#     except Exception as e:
#         print(f"상세 공통 정보 조회 실패: {e}")

#     detail_intro_params = {
#         "serviceKey": urllib.parse.unquote(service_key),
#         "MobileOS": "ETC",
#         "MobileApp": "TestClient",
#         "_type": "json",
#         "numOfRows": 1,      # 추가
#         "pageNo": 1,         # 추가
#         "contentId": content_id,
#         "contentTypeId": content_type
#     }
#     intro_url = f"{base_url}/detailIntro2?{urllib.parse.urlencode(detail_intro_params)}"
#     try:
#         i_data = fetch_json(intro_url)
#         i_items = i_data.get("response", {}).get("body", {}).get("items", {}).get("item", [])
#         if i_items:
#             merged.update(i_items[0] if isinstance(i_items, list) else i_items)
#     except Exception as e:
#         print(f"상세 소개 정보 조회 실패: {e}")

#     print(json.dumps(merged, ensure_ascii=False, indent=2))


    common_url = f"{base_url}/detailCommon2?{urllib.parse.urlencode(common_params)}"
    
    try:
        c_data = fetch_json(common_url)
        print("공통 정보 응답 데이터:", c_data)
        c_items = c_data.get("response", {}).get("body", {}).get("items", {}).get("item", [])
        
        if c_items:
            item = c_items[0] if isinstance(c_items, list) else c_items
            merged.update(item)
            
    except Exception as e:
        print(f"상세 공통 정보 조회 실패: {e}")

    # 공통 정보에서 contentTypeId 추출
    content_type = merged.get("contenttypeid")

    # 2. 상세 소개 정보 조회
    if content_type:
        detail_intro_params = {
            "serviceKey": urllib.parse.unquote(service_key),
            "MobileOS": "ETC",
            "MobileApp": "TestClient",
            "_type": "json",
            "numOfRows": 1,      
            "pageNo": 1,         
            "contentId": content_id,
            "contentTypeId": content_type
        }
        intro_url = f"{base_url}/detailIntro2?{urllib.parse.urlencode(detail_intro_params)}"
        
        try:
            i_data = fetch_json(intro_url)
            i_items = i_data.get("response", {}).get("body", {}).get("items", {}).get("item", [])
            if i_items:
                merged.update(i_items[0] if isinstance(i_items, list) else i_items)
        except Exception as e:
            print(f"상세 소개 정보 조회 실패: {e}")
    else:
        print("contenttypeid를 확인할 수 없어 상세 소개 정보를 조회하지 않습니다.")

    # 최종 결과 출력
    print("\n=== 최종 Raw 데이터 ===")
    print(json.dumps(merged, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    # 확인하고자 하는 장소의 contentId(source_place_id)를 입력합니다.
    TARGET_CONTENT_ID = "1778079" 
    fetch_specific_raw_place("1778079")
    fetch_specific_raw_place("126329")
    