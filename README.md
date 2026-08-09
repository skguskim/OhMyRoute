# 오매루트 선호 벡터 추천 MVP

광주·전남 장소의 해시태그 가중치 벡터와 사용자 선호 벡터를 비교해 추천 장소와 간단한 루트를 보여주는 웹 프로토타입
테스트용 문구 (디코 알람 가는지)

## 온라인 데모 배포

`main` 브랜치에 푸시하면 `.github/workflows/pages.yml`이 정적 사이트를 GitHub Pages로 자동 배포합니다.

저장소의 **Settings → Pages → Build and deployment → Source**를 `GitHub Actions`로 설정하세요. 배포 주소가 만들어지면 Kakao Developers의 **JavaScript SDK 도메인**에도 해당 Pages 주소의 origin(예: `https://사용자명.github.io`)을 등록해야 지도가 표시됩니다.

## 바로 실행하기

Python 3이 설치된 Windows에서는 `서버실행.bat`를 더블클릭합니다. 직접 실행하려면 프로젝트 폴더에서 아래 명령 중 하나를 사용합니다.

```powershell
py -m http.server 4173
```

```powershell
python -m http.server 4173
```

macOS 또는 Linux에서는 다음 명령을 사용합니다.

```bash
python3 -m http.server 4173
```

브라우저에서 `http://localhost:4173/`에 접속합니다. HTML 파일을 직접 더블클릭하면 브라우저 보안 정책 때문에 JSON 로딩이 실패할 수 있습니다. 자세한 내용은 `실행방법.txt`를 확인하세요.

## 현재 구현 범위

- 8축 선호 슬라이더
- 선택형 한 줄 여행 요청: 한국어 키워드·제외 표현·이동 강도를 브라우저에서 해석해 추천에 추가 반영
- 출발지 도착 날짜·시각과 다시 떠나는 날짜·시각, 이동수단, 동행자, 날씨 조건
- 일정 범위에 포함되는 약 12시 점심·약 18시 저녁 음식점 자동 배치
- 일반 음식점과 KIA 선수 추천 음식점을 합친 단일 음식점 DB
- 스포츠·야구 취향이 `매우 선호`(76~100)일 때 선수 추천 맛집 가중치 강화 및 현역 추천 선수 표시
- 선택한 출발지의 기상청 5km 격자 기준 12시·18시 단기예보 연동
- 출발 장소를 유지한 입력 화면 → 분석 로딩 → 별도 결과 화면 전환
- 장소 선호 벡터 간 코사인 유사도 계산
- 비, 가족, 대중교통 조건 필터
- 추천 지도, 일정 타임라인, 장소별 추천 이유 표시
- 일정 카드 펼치기, 루트 저장, 인쇄/PDF
- 입력한 실제 여행 시간과 최대 2박 3일 날짜 범위에 따른 방문 순서 및 Day 탭 구성
- 추천 장소 이미지 기반 영상형 프리뷰 재생·일시정지
- GPS 100m 인증 여행 스탬프, 데모 위치, 로컬 수집 기록 저장
- 코스 리뷰 작성, 당시 선호 벡터·추천 경로·스탬프 기록 저장, 코스당 1회 시연용 지역 식당 10% 쿠폰 발급
- 로컬 샘플 데이터와 Supabase RPC 모드 전환

한 줄 요청은 선택 사항입니다. 비워 두면 기존 슬라이더 추천과 동일하게 계산하며, 입력하면 `비 오는 날`, `아이와 실내 체험`, `등산 말고 산책`, `이동 적게`, `카페 한 곳 포함` 같은 표현을 장소 점수·필터·거리 페널티·추천 이유에 반영합니다. 외부 AI API나 DB 없이도 정적 배포에서 동작합니다.

선호 벡터 순서는 반드시 아래와 같이 유지합니다.

```text
[자연·풍경, 문화·역사, 예술·전시, 음식·로컬,
 체험·활동, 스포츠·야구, 휴식·산책, 축제·야간]
```

## Supabase 연결

1. Supabase 프로젝트를 만듭니다.
2. SQL Editor에서 `supabase/schema.sql`을 실행합니다.
3. 이어서 `supabase/seed.sql`을 실행합니다.
4. `config.js`를 다음처럼 수정합니다.

```javascript
window.OMAEROUTE_CONFIG = {
  useSupabase: true,
  supabaseUrl: "https://PROJECT_REF.supabase.co",
  anonKey: "YOUR_ANON_KEY",
};
```

브라우저에는 `anon` 또는 publishable key만 넣고 `service_role` 키는 절대 넣지 마세요. 장소 데이터의 수정과 대량 적재는 서버 또는 Supabase SQL Editor에서 처리해야 합니다.

## 카카오맵 연결

결과 화면은 `config.js`의 `kakaoJavaScriptKey`로 Kakao Maps JavaScript SDK를 불러옵니다.

1. Kakao Developers에서 앱을 생성합니다.
2. 앱 관리 페이지의 **[카카오맵] → [사용 설정]**에서 상태를 **ON**으로 설정합니다.
3. **[앱] → [플랫폼 키] → [JavaScript 키] → [JavaScript SDK 도메인]**에 `http://localhost:4173`을 등록합니다.
4. 해당 JavaScript 키를 `config.js`의 `kakaoJavaScriptKey`에 입력합니다. REST API 키가 아니라 JavaScript 키여야 합니다.
5. 서버를 다시 실행하거나 브라우저에서 `Ctrl+F5`로 새로고침합니다.

키가 없거나 SDK 인증/로딩에 실패하면 결과 화면의 상태 배지가 **Kakao 설정 확인 · SVG 지도**로 바뀌고 자동으로 SVG 대체 지도를 표시합니다. 카카오맵에서는 출발지와 추천 장소 마커, 장소 순서 라벨, 연결선, 마커 정보창을 볼 수 있으며 일정 카드를 펼치면 다음 장소까지 카카오맵 길찾기를 열 수 있습니다.

## 기상청 날씨 연동

공공데이터포털에서 **기상청_단기예보 조회서비스** 활용신청 후 일반 인증키를 `config.js`에 입력합니다.

```javascript
window.OMAEROUTE_CONFIG = {
  // 기존 설정 생략
  kmaServiceKey: "YOUR_DATA_GO_KR_SERVICE_KEY",
};
```

앱은 사용자가 고른 출발지의 위도·경도를 기상청 격자 `nx/ny`로 변환하고, 현재 시점의 최신 발표본에서 선택 날짜의 12시·18시 `TMP`, `SKY`, `PTY`, `POP`을 조회합니다. 비·눈 또는 강수확률 60% 이상이면 우천 조건을 추천 필터에 반영합니다. 예보 범위 밖 날짜, 인증키 누락, 통신 오류가 발생하면 일정 추천은 계속하고 날씨만 미반영 상태로 안내합니다.

정적 브라우저에서 직접 호출하면 인증키가 개발자도구에 노출됩니다. 로컬 해커톤 시연 외의 실제 배포에서는 브라우저가 자체 `/api/weather`를 호출하고 서버·서버리스 함수가 기상청 API를 대리 호출하도록 구성하세요.

## 실제 데이터로 교체하는 순서

1. TourAPI 데이터를 `places` 형식으로 정규화합니다.
2. KVQA와 여행로그를 장소명, 주소, 좌표로 장소에 연결합니다.
3. 고정된 태그 사전을 기준으로 LLM이 `tag_scores` JSON을 생성하게 합니다.
4. `tag_scores`를 위의 고정 순서로 배열화해 `preference_vector`에 적재합니다.
5. 30~50개 장소를 사람이 검수한 뒤 전체 데이터를 처리합니다.
6. 방문, 저장, 스탬프, 리뷰 행동은 `user_place_events`에 원본 그대로 축적합니다.

## 데이터 파이프라인

별도 Python 설치가 없어도 Codex 번들 Python을 찾아 실행하는 Windows 실행기가 포함되어 있습니다. `.cmd` 파일을 사용하므로 PowerShell 실행 정책의 영향을 받지 않습니다.

### 기존 12개 샘플 변환·검사

```powershell
.\scripts\run_data_pipeline.cmd bootstrap
```

다음 파일이 `data/generated`에 생성됩니다.

- `bootstrap_places.csv`
- `bootstrap_place_profiles.csv`
- `bootstrap_quality_report.json`
- `bootstrap_seed.sql`

### TourAPI에서 광주 장소 수집

인증키가 없어도 광주관광 공식 페이지에서 공개된 장소 초안을 수집할 수 있습니다.

```powershell
.\scripts\run_data_pipeline.cmd collect-gwangju --limit 42
```

이 명령은 분야별 장소를 고르게 가져와 다음 파일을 생성합니다.

- `gwangju_official_places.csv`
- `gwangju_official_place_profiles.csv`
- `gwangju_official_operating_info_review.csv`
- `gwangju_official_quality_report.json`
- `gwangju_official_seed.sql`

현재 생성본에는 광주 공식 장소 42개가 들어 있으며 자연·역사·문화·음식·체험·도보·공원 7개 분야와 광주 5개 구를 포함합니다. 모두 검수 전 `draft` 상태입니다.

운영시간과 휴무일의 표현 방식이 장소마다 달라 원문을 검수 CSV에 보존합니다. 사람이 확인한 뒤 `place_opening_hours` 형식으로 확정합니다.

더 넓은 TourAPI 데이터를 수집하려면 다음 설정을 사용합니다.

1. `.env.example`을 `.env`로 복사합니다.
2. 공공데이터포털에서 발급받은 일반 인증키를 `TOUR_API_SERVICE_KEY`에 입력합니다.
3. 다음 명령을 실행합니다.

```powershell
.\scripts\run_data_pipeline.cmd collect --limit 100
```

수집기는 장소 기본정보와 상세정보를 합치고, 8축 해시태그 초안을 생성한 뒤 품질검사와 Supabase 적재 SQL 생성까지 수행합니다. 자동 라벨은 `quality_status=draft`로 저장되므로 사람의 검수 전에는 추천 RPC 결과에 포함되지 않습니다.

### 수정한 CSV 다시 검사

```powershell
.\scripts\run_data_pipeline.cmd validate `
  --places .\data\generated\tourapi_places.csv `
  --profiles .\data\generated\tourapi_place_profiles.csv `
  --report .\data\generated\tourapi_quality_report.json
```

광주 30개 우선 수집 대상은 `data/curated/gwangju_candidate_queue.csv`에 정리되어 있습니다.

## 파일 구조

```text
index.html              화면 구조
styles.css              반응형 디자인
app.js                  추천, 필터, 경로 로직
config.js               Supabase 공개 연결 설정
data/places.json        로컬 샘플 장소 벡터
data/restaurants.json   일반·KIA 선수 추천 통합 음식점 DB
data/stadium_foods.json 챔피언스필드 내부 먹거리 전용 DB
data/curated/stadium_food_source_audit.json 구장 먹거리 크롤링·검수 출처 기록
data/DATA_GUIDE.md      실제 데이터 출처·필드·검수 기준
data/templates/         장소·태그·운영시간 수집용 CSV
data/tag_taxonomy.json  8축 점수와 통제 해시태그 사전
data/curated/           검수 대상 장소 큐
data/generated/         변환·검사·SQL 생성 결과
scripts/data_pipeline.py 수집·라벨·검사·SQL 생성기
scripts/verify_stadium_food_db.mjs 구장 먹거리 DB 품질 검사
supabase/schema.sql     테이블, RPC, RLS
supabase/seed.sql       Supabase 확인용 샘플 데이터
```

샘플 장소의 운영시간, 접근성 등은 기능 검증용 값이므로 실제 서비스 전에는 공공데이터와 현장 정보를 기준으로 검증해야 합니다.
# Windows 무설치 실행 (현재 권장)

Windows에서는 Python 설치 없이 `서버실행.bat`를 더블클릭하면 됩니다. Windows 기본 PowerShell로 정적 서버를 실행하며 브라우저에서 `http://localhost:4173/`을 자동으로 엽니다.

직접 실행하려면 프로젝트 폴더에서 다음 명령을 사용합니다.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\start_server.ps1
```
