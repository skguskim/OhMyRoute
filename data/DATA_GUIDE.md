# 오매루트 데이터 구축 가이드

## 1. 데이터 단위

장소 데이터의 한 행은 **방문 가능한 장소 한 곳**입니다. 같은 장소가 여러 출처에 존재하더라도 `places`에는 한 번만 저장하고, 출처별 원본과 갱신일은 `place_sources`에 따로 기록합니다.

추천 범위는 우선 **광주광역시 + 인접 전남 당일 이동권**으로 제한합니다. 광주 전용 추천을 평가할 때는 광주 5개 구와 전남 장소를 구분해 결과를 확인합니다.

## 2. 사용할 데이터

### A. 장소 기본정보 — 필수

- 출처와 출처 고유 ID
- 장소명, 대분류, 지역·시군구
- 도로명주소와 지번주소
- 위도·경도(WGS84)
- 한 줄 설명, 전화번호, 홈페이지, 대표 이미지
- 장소 상태: 운영 중, 임시 휴업, 폐업, 계절 운영

### B. 방문 가능 조건 — 필수

- 요일별 운영시간, 휴무일, 입장 마감
- 예상 체류시간
- 최소·최대 요금, 예약 필요 여부
- 실내 여부, 우천 가능 여부
- 가족 동반, 주차, 휠체어, 반려동물 가능 여부
- 대중교통 접근성 점수(0~1)

### C. 추천용 라벨 — 필수

- 통제된 해시태그
- 다음 8개 축의 점수(0~1)
  1. 자연·경관
  2. 문화·역사
  3. 예술·전시
  4. 음식·로컬
  5. 체험·활동
  6. 스포츠·야구
  7. 휴식·산책
  8. 축제·야간
- 점수를 부여한 근거 URL 또는 검수 메모
- 라벨 방식, 라벨 신뢰도, 분류체계 버전, 최종 검수일

### D. 추천 개선용 행동 데이터 — 서비스 사용 후 수집

- 추천 노출, 상세 클릭, 저장, 방문, 스탬프, 평점, 제외
- 추천 당시 사용자 선호 벡터와 이동 조건
- 추천 순위, 유사도 점수, 최종 선택 여부

정확한 집 주소나 불필요한 이동 이력은 저장하지 않습니다. 출발지는 역·터미널·관광지 ID 또는 충분히 둥글린 좌표로 저장하고, 사용자는 UUID로만 구분합니다.

### E. 음식점 통합 DB와 야구장 먹거리 DB

일반 음식점과 KIA 선수 추천 음식점의 단일 원본은 `data/restaurants.json`입니다. 입장권이 필요하고 시즌·경기일에 따라 매장 구성이 달라지는 **챔피언스필드 내부 먹거리**는 `data/stadium_foods.json`에서 별도로 관리합니다.

- 모든 음식점: 장소명, 주소, 좌표, 음식 분류, 8축 벡터, 방문 조건
- 선수 추천 음식점: `playerRecommended`, `recommendedPlayers`, 추천 출처와 검증 상태
- 현역 KIA 선수 추천: `activePlayerRecommended`, `activeRecommendedPlayers`, `rosterVerifiedAt`
- 일정 사용 가능 여부: `routeEligible`

선수 추천 관련 필드가 비어 있으면 일반 음식점입니다. 모든 사용자에게 전체 음식점 후보군을 열어 두고, 여행 취향 설정의 `스포츠·야구` 값이 `매우 선호` 구간(76~100)일 때만 선수 추천 메타데이터를 이용해 추천 점수를 크게 높입니다. `kia_player_restaurant_evidence.csv`와 `kia_player_restaurant_video_review.csv`는 DB가 아니라 출처 검수 자료입니다.

`data/stadium_foods.json`의 항목은 `stadiumFood=true`이고 야구 직관을 선택한 경우에만 일정 후보가 됩니다. 모든 항목에 `venueId`, `brandName`, `stallLocations`, `menuItems`, `coordinatePrecision`, `availabilityStatus`, `lastVerifiedAt`, `qualityStatus`, 출처 URL을 기록합니다. 매장별 정확 좌표가 공개되지 않은 경우 경기장 중심 좌표를 사용하고 `coordinatePrecision=venue_centroid`로 명시합니다. KIA 2026 공식 안내도에서 브랜드와 판매 구역을 확인한 항목은 `qualityStatus=verified`로 두되, 메뉴별 `availabilityStatus`와 `priceVerifiedAt`을 별도로 관리합니다. 당일 영업·품절·가격은 경기 당일 안내를 우선합니다.

## 3. 권장 출처 우선순위

1. [한국관광공사 국문 관광정보 서비스](https://www.data.go.kr/data/15101578/openapi.do): 장소 ID, 위치, 설명, 이미지, 행사·숙박·반려동물 정보의 기본 원본
2. [광주관광 공식 사이트](https://tour.gwangju.go.kr/home/main.cs): 광주 관광명소, 추천 코스, 현재 행사·축제와 지역 설명 검증
3. [전국문화축제표준데이터](https://www.data.go.kr/data/15013104/standard.do): 축제 기간, 장소, 주소, 좌표, 주최·주관 정보
4. [Kakao 지도 Web API](https://apis.map.kakao.com/web/documentation): 장소 검색과 주소↔좌표 교차검증. 사용 약관과 쿼터 범위 안에서 보조 출처로 사용
5. 현장·운영기관 홈페이지: 운영시간, 요금, 휴무, 예약, 접근성의 최종 검증
6. 사용자 행동 데이터: 실제 선호 학습과 추천 품질 평가

챔피언스필드 구장 먹거리의 브랜드와 판매 구역은 [KIA 타이거즈 2026 공식 경기장 안내도](https://tigers.co.kr/files/resource/2026/03/260330_fieldGuide.png)를 우선합니다. 현장 메뉴판이 확인된 가격은 관측일과 원본 URL을 함께 저장하며 공식 안내도와 현장 정보가 충돌하면 브랜드·위치는 공식 안내도를 우선합니다.

출처끼리 값이 다르면 운영기관의 최신 공지를 우선하고, `last_verified_at`과 검수 근거를 남깁니다.

## 4. 8축 점수 기준

모든 장소에 동일한 기준을 사용합니다.

| 점수 | 의미 |
| --- | --- |
| 0.00 | 관련 없음 |
| 0.25 | 약한 보조 요소 |
| 0.50 | 방문 경험의 의미 있는 일부 |
| 0.75 | 주요 방문 목적 |
| 1.00 | 장소의 핵심 정체성 |

각 장소는 1명이 초안을 만들고 다른 1명이 검수합니다. 의견 차이가 0.25를 넘는 축은 근거를 다시 확인합니다. 점수 배열 순서는 항상 `nature, culture, art, food, activity, sports, healing, festival`로 고정합니다.

## 5. 수집 파일

- `templates/places.csv`: 장소 기본정보와 방문 조건
- `templates/place_profiles.csv`: 해시태그와 8축 점수
- `templates/place_opening_hours.csv`: 요일별 운영시간
- `templates/route_edges.csv`: 장소 간 이동시간 캐시
- `tag_taxonomy.json`: 해시태그와 점수 축의 통제 사전
- `restaurants.json`: 일반 음식점과 KIA 선수 추천 음식점을 합친 단일 운영 DB

CSV 파일은 UTF-8로 저장합니다. 불명확한 값을 `0`이나 빈 문자열로 추측하지 말고 빈 값으로 둔 뒤 `quality_status=draft`로 표시합니다.

## 6. 최소 품질 통과 기준

`quality_status=verified`로 바꾸기 전에 다음을 확인합니다.

- `(source, source_place_id)`가 중복되지 않음
- 장소명·지역·좌표·설명·체류시간이 존재함
- 좌표가 실제 장소와 일치하고 WGS84 형식임
- 8축 점수가 모두 0~1이고 빠진 축이 없음
- 해시태그가 `tag_taxonomy.json`에 있거나 신규 태그 검수를 완료함
- 운영시간과 요금은 최근 90일 안에 검수했거나 갱신 필요 표시가 있음
- 출처 URL, 수집일, 최종 검수일이 존재함
- 폐업·임시휴업·행사 종료 장소가 활성 추천에 포함되지 않음

## 7. 구축 순서

1. 광주 장소 30개를 `places.csv`에 수집
2. 주소와 좌표를 카카오맵으로 교차검증
3. 운영시간과 방문 조건을 운영기관 사이트에서 확인
4. 8축 점수와 해시태그를 두 명이 검수
5. Supabase에 적재하고 추천 결과 20건을 수동 평가
6. 문제가 없으면 광주 100개, 인접 전남 50개로 확대
7. 실제 사용자 행동이 쌓이면 선호 벡터 업데이트에 반영

초기 목표는 데이터 양보다 **검증된 장소 30개**입니다. 임의 라벨 300개보다 기준이 일관된 30개가 추천 로직을 평가하기 좋습니다.

## 8. 자동 수집 실행

기존 샘플을 새 수집 구조로 변환하고 검사하려면 다음을 실행합니다.

```powershell
.\scripts\run_data_pipeline.cmd bootstrap
```

TourAPI 인증키를 `.env`에 설정한 후 광주 데이터를 수집하려면 다음을 실행합니다.

```powershell
.\scripts\run_data_pipeline.cmd collect --limit 100
혹은
.\scripts\run_data_pipeline.cmd collect --limit 20 --area-codes 5 38 --content-types 12 14 15 28
로 분야, 지역 설정
```

TourAPI 인증키가 아직 없으면 광주관광 공식 페이지에서 공개된 초안을 먼저 수집할 수 있습니다.

```powershell
.\scripts\run_data_pipeline.cmd collect-gwangju --limit 100
```

자동 생성되는 해시태그와 점수는 키워드 규칙 기반 초안입니다. `labeling_method=import`, `quality_status=draft`로 기록되며, 두 사람의 검수를 통과한 데이터만 `reviewed` 또는 `verified`로 변경합니다.


## 9. 데이터 베이스 구축 순서

자동 수집으로 받아온 후

1. csv_refine.py로 중복 제거
2. intact csv files 내의 파일 참고하여 벡터값 수정 후 csv(utf-8)로 저장
3. qoute_change.py로 따옴표 처리
4. 아래에 따라 json, sql 파일 재생성

sql, json 파일 후처리 후에 생성 시
```powershell
python scripts\data_pipeline.py validate --places data\generated\tourapi_places.csv --profiles data\generated\tourapi_place_profiles.csv --report data\generated\tourapi_quality_report.json

python scripts\data_pipeline.py build-sql --places data\generated\tourapi_places.csv --profiles data\generated\tourapi_place_profiles.csv --output data\generated\tourapi_seed.sql

python scripts\data_pipeline.py validate --places data\generated\gwangju_official_places.csv --profiles data\generated\gwangju_official_place_profiles.csv --report data\generated\gwangju_official_quality_report.json

python scripts\data_pipeline.py build-sql --places data\generated\gwangju_official_places.csv --profiles data\generated\gwangju_official_place_profiles.csv --output data\generated\gwangju_official_seed.sql
```
각각의 명령어를 터미널에 입력하면 됨.

5. merge_gwangju_tourapi.py로 병합된 csv 파일들 생성
6. csv_to_places_json.py로 병합된 장소들 json 파일 생성