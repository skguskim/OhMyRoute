# OhMyRoute (오매루트)

<p align="center">
  <img src="./assets/ohmyroute-logo.png" alt="오매루트 OhMyRoute 로고" width="360">
</p>


오매루트는 광주·전남의 관광지, 음식점, 야구 콘텐츠를 사용자의 취향과 일정에 맞춰 추천하고 하나의 이동 경로로 구성하는 웹 기반 여행 MVP이다. 장소 탐색부터 이동, 현장 경험, 기록까지 여러 서비스에 흩어진 여행 과정을 한 화면에서 이어 주는 것을 목표로 한다.

## 프로젝트 배경

광주·전남에는 관광·문화·음식·스포츠 자원이 풍부하지만, 장소 정보와 이동 경로, 현장 설명, 후기 서비스가 서로 분리되어 있다. 특히 짧은 일정의 개별 여행자나 야구 관람 전후의 방문객은 제한된 시간 안에 무엇을 보고 어떻게 이동할지 직접 조합해야 한다.

오매루트는 다음 흐름을 하나의 서비스로 연결한다.

```text
여행 조건·취향 입력 → 맞춤 장소와 일정 추천 → 프리뷰 → 지도 안내
→ 현장 스탬프 → 리뷰·리워드 → 다음 추천을 위한 피드백
```

주요 대상 사용자는 다음과 같다.

- 짧은 일정으로 광주·전남을 방문하는 국내 개별 여행자
- KIA 타이거즈 경기 전후 반나절 코스를 찾는 야구 관람객
- 쉬운 설명, 이동 편의, 접근성 정보가 필요한 외국인·고령자·저시력 사용자

## 현재 구현 현황

현재 저장소는 별도 빌드 과정 없이 브라우저에서 실행하는 웹 MVP이며, 기상청 날씨와 AI 도슨트는 `start_server.ps1`의 서버 프록시를 사용한다.

아래 표는 기획자료의 전체 서비스 범위와 실제 코드 상태를 구분한 것이다.

| 영역 | 상태 | 현재 구현 내용 |
| --- | --- | --- |
| 여행 조건 입력 | 구현 완료 | 출발·도착 일시, 최대 2박 3일, 이동수단, 동행자, 날씨 조건 입력 |
| 선호도 입력 | 구현 완료 | 8축 슬라이더와 선택형 한 줄 여행 요청 제공 |
| 장소 추천 | 구현 완료 | 사용자·장소 벡터의 코사인 유사도와 상황별 가중치를 결합한 순위 산정 |
| 자연어 요청 | 데모 구현 | 한국어 키워드, 제외 표현, 이동 강도를 브라우저 규칙으로 해석하며 외부 LLM은 사용하지 않음 |
| 여행 일정 | 데모 구현 | 거리와 예상 이동시간을 이용한 휴리스틱 방문 순서, Day 탭, 점심·저녁 자동 배치 |
| KIA 특화 추천 | 구현 완료 | 2026년 실제 광주 홈경기 DB, 경기 상태·변경 시각, 실제 경기일 복수 선택, 선수 추천 맛집과 챔피언스필드 먹거리 반영 |
| 지도 | 부분 구현 | Kakao Maps 마커·연결선·길찾기 링크 제공, 키가 없으면 SVG 대체 지도 사용 |
| 날씨 | 부분 구현 | 기상청 단기예보를 우선 사용하고 범위 밖 날짜는 중기예보로 보충해 Day별 날씨 반영, 실패 시 추천은 계속 진행 |
| AI 도슨트 | 부분 구현 | Gemini Interactions API를 기본으로 사용하고 OpenAI Responses API로 전환 가능, 현재 일정·장소 데이터에 근거해 답변 |
| 여행 프리뷰 | 데모 구현 | 추천 장소 이미지와 설명을 재생하는 슬라이드형 프리뷰이며 생성형 AI 영상은 아님 |
| 스탬프·리뷰 | 데모 구현 | GPS 100m 인증, 7종 테마 공통 스탬프와 챔피언스필드 전용 스탬프, 코스 리뷰와 방문 기록을 브라우저 `localStorage`에 저장 |
| 리워드 | 데모 구현 | 코스당 1회 지역 식당 10% 쿠폰을 발급하며 실제 지역화폐·가맹점 시스템과는 연결되지 않음 |
| 데이터 저장소 | 구현 완료 | 장소·음식점·KIA 광주 홈경기는 로컬 JSON, 스탬프·리뷰·저장 루트는 브라우저 `localStorage` 사용 |
| 접근성·다국어 | 미구현 | 쉬운 설명, 음성 안내, 다국어, 저시력 모드는 향후 구현 필요 |

테마 스탬프 최종 도안은 `assets/stamps/themes/`의 SVG 파일로 관리한다. 파일명과 `viewBox`를 유지하면 앱 코드를 수정하지 않고 디자인만 교체할 수 있다.

현재 앱의 로컬 데이터에는 정제된 광주 공식 관광지 72개, 음식점 43개, 챔피언스필드 먹거리 13개, 2026년 KIA 정규시즌 광주 홈경기 69건이 포함되어 있다. 관광지는 현재 모두 검수 전 `draft` 상태이다.

### KIA 광주 홈경기 DB

- `data/baseball_games.json`: KIA 타이거즈 공식 일정에서 확인한 2026년 정규시즌 광주-기아 챔피언스필드 홈경기 69건(3월 시범경기 제외)
- 상태는 `scheduled`, `in_progress`, `completed`, `cancelled`, `postponed`로 구분
- 여행 기간의 `scheduled`/`in_progress` 경기만 직관일로 선택 가능하며 경기 없음·종료·취소·연기는 선택 불가 사유를 표시
- 2026년 8월 11일부터 9월 6일까지 광주 홈경기는 폭염 대응 변경 시각인 19시를 경기별 데이터로 저장

공식 월별 일정 API 응답 JSON을 다시 받은 뒤 아래처럼 실행하면 로컬 JSON을 갱신할 수 있다. API 인증 헤더 값은 저장소에 넣지 않는다.

```powershell
node .\scripts\import_kia_home_games.mjs `
  .\tmp\kia-202603.json .\tmp\kia-202604.json .\tmp\kia-202605.json `
  .\tmp\kia-202606.json .\tmp\kia-202607.json .\tmp\kia-202608.json `
  .\tmp\kia-202609.json --synced-at=2026-08-14T00:00:00+09:00
```

## 추천 방식

사용자와 장소는 아래 순서를 갖는 8차원 선호 벡터로 표현한다.

```text
[자연·풍경, 문화·역사, 예술·전시, 음식·로컬,
 체험·활동, 스포츠·야구, 휴식·산책, 축제·야간]
```

기본 추천 점수는 사용자 벡터와 장소 벡터의 코사인 유사도를 중심으로 계산한다. 여기에 날씨, 동행자, 이동수단, 야구 선호도 같은 상황 점수와 한 줄 요청의 키워드 적합도를 더한다. 한 줄 요청을 비우면 슬라이더와 선택 조건만으로 추천한다.

현재 추천은 다음과 같은 한계가 있다.

- 값이 `0`, `0.5`, `1`처럼 몇 단계로만 반복되면 서로 비슷한 벡터가 많아져 동점과 유사한 추천이 자주 발생할 수 있음
- 장소 태그는 자동 생성 결과를 그대로 신뢰하지 않고 근거·신뢰도와 함께 사람 검수 필요
- 리뷰와 스탬프는 저장되지만 아직 다음 추천 점수에 학습 데이터로 반영되지 않음

## 앞으로 구현할 기능

### 2026-08-10 회의 내용

#### P0 — 추천 알고리즘과 데이터 수정

- 사용자·장소 선호도 벡터의 합이 `1`이 되도록 정규화하고 기존 데이터도 같은 기준으로 재계산
- 자연·풍경/문화·역사 값이 `0`, `0.5`, `1`일 때 추천 결과가 동일하게 나오는 현상의 원인과 가중치 계산 오류 확인
- 선호도를 입력하지 않은 사용자를 위한 예외 처리 및 랜덤·인기·기본 코스 중 대체 추천 정책 결정
- 장소별 데이터 개수와 카테고리 비율을 통일하고 현재 약 `실내 4 : 실외 6`인 구성의 불균형 조정 (확실치않음)
- 장소 운영시간과 휴무일을 일정에 반영하고, 실제 운영정보를 검증한 뒤 평일·주말 제외 로직 QA
- 데이터셋별 사용 항목과 활용 횟수를 추적해 출처와 함께 표시
- 광주 공식 관광지 72개의 운영시간, 좌표, 접근성, 출처를 검수한 뒤 `draft` 해제

#### P0 — UI/UX 간소화

- 전체 화면의 문장과 안내 텍스트를 줄이고 핵심 행동 중심으로 재구성
- 장소 카드를 누르면 상세 설명을 보여주되 추천 이유는 하단에 1~2줄로 요약
- 긴 도슨트 설명은 기본 화면에서 숨기고 스탬프 또는 플로팅 버튼을 통해 별도로 제공
- 출발지 목록에서 `광주송정역`을 최상단에 배치하고 첫 화면에서 우선 노출
- `광주종합버스터미널` 명칭을 `광주종합버스터미널(유스퀘어)`로 변경
- 스포츠·야구 선호도 조절 UI를 최상단에 배치하고 `아주 높음` 선택 시 야구 전용 기능을 명확히 노출 (일정 중 언제 야구 직관을 하는지)

#### P1 — 일정 변경과 야구 기능

- 실제 체류 시간에 따라 이후 방문 시간과 장소를 자동으로 다시 계산
- 코스 밖의 추천 장소를 추가할 때 기존 일정에서 교체할 장소를 선택하는 화면 구현
- 사용자가 장소에 도착하거나 스탬프를 인증했을 때 해당 장소 중심으로 AI 도슨트 자동 활성화

#### P2 — 후순위 기능

- 선택되지 않은 추천 장소도 지도에 별도 마커로 표시
- 한국어·영어·중국어·일본어 번역과 TTS, 쉬운 한국어, 큰 글씨·고대비 모드 제공
- 장소 이미지와 일정으로 10~20초 생성형 여행 프리뷰 제작
- 사용자 계정과 서버 저장소를 도입해 여러 기기에서 여행 기록 동기화
- 지역화폐·가맹점과 연계 가능한 실제 리워드 정책 및 부정 사용 방지 설계

### 중장기 기술 고도화

- GitHub Pages 배포 데이터 목록과 배포 후 로딩 상태 자동 점검
- API 키를 브라우저에 직접 노출하지 않도록 날씨·경로 API용 서버리스 프록시 구성
- Kakao Mobility 또는 ODsay로 장소 간 실제 이동시간 비용 행렬 생성
- 시간창, 식사시간, 체류시간, 출발·도착 제약을 포함한 TSP/VRP 최적화
- HyperCLOVA X 등을 활용해 관광 원문을 8축 점수로 변환하고 근거 문장·신뢰도 저장
- 공식 관광 자료를 검색하는 RAG 기반 AI 도슨트와 출처 표시형 질의응답 구현
- 방문·저장·스탬프·리뷰 이벤트를 반영한 협업 필터링 및 개인화 재추천
- 고정 테스트 사용자와 정답 코스를 이용한 추천 품질 평가 지표 구축

## 실행 방법

지도와 로컬 JSON 화면만 확인할 때는 다음처럼 정적 서버를 사용할 수 있다.

```powershell
py -m http.server 4173
```

기상청 날씨와 AI 도슨트를 포함한 전체 기능은 포함된 실행 스크립트로 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File ".\start_server.ps1"
```

서버가 실행되면 브라우저에서 [http://localhost:4173](http://localhost:4173)에 접속

## GitHub Pages 배포

`main` 브랜치에 푸시하면 `.github/workflows/pages.yml`이 정적 사이트를 GitHub Pages로 배포

GitHub Pages는 정적 호스팅이므로 `/api/weather`, `/api/docent` 서버 프록시는 실행되지 않는다. 배포 환경에서 두 기능을 사용하려면 `start_server.ps1`과 같은 역할의 별도 백엔드를 배포하고 프런트엔드의 API 경로를 연결해야 한다.

저장소의 **Settings → Pages → Build and deployment → Source**를 `GitHub Actions`로 설정
배포 주소가 만들어지면 Kakao Developers의 **JavaScript SDK 도메인**에도 해당 Pages 주소의 origin(예: `https://사용자명.github.io`)을 등록해야 지도가 표시됨

## 카카오맵 연결

결과 화면은 `config.js`의 `kakaoJavaScriptKey`로 Kakao Maps JavaScript SDK를 불러옴

1. Kakao Developers에서 앱 생성
2. 앱 관리 페이지의 **[카카오맵] → [사용 설정]**에서 상태를 **ON**으로 설정
3. **[앱] → [플랫폼 키] → [JavaScript 키] → [JavaScript SDK 도메인]**에 `http://localhost:4173` 등록
4. 해당 JavaScript 키를 `config.js`의 `kakaoJavaScriptKey`에 입력. REST API 키가 아니라 JavaScript 키
5. 서버를 다시 실행하거나 브라우저에서 `Ctrl+F5`로 새로고침

키가 없거나 SDK 인증/로딩에 실패하면 결과 화면의 상태 배지가 **Kakao 설정 확인 · SVG 지도**로 바뀌고 자동으로 SVG 대체 지도를 표시. 카카오맵에서는 출발지와 추천 장소 마커, 장소 순서 라벨, 연결선, 마커 정보창을 볼 수 있으며 일정 카드를 펼치면 다음 장소까지 카카오맵 길찾기를 열 수 있음.

## AI 도슨트 연동

계획서의 Gemini 기반 예시를 우선 반영해 기본 제공자는 Gemini로 설정한다. API 키는 `config.js`나 브라우저 코드에 넣지 않는다.

```dotenv
AI_PROVIDER=gemini
GEMINI_API_KEY=YOUR_GEMINI_API_KEY
GEMINI_MODEL=gemini-3.6-flash
```

OpenAI로 전환할 때는 다음처럼 제공자와 키·모델을 바꾼다.

```dotenv
AI_PROVIDER=openai
OPENAI_API_KEY=YOUR_OPENAI_API_KEY
OPENAI_MODEL=gpt-5.4-mini
```

`start_server.ps1`이 `/api/docent`에서 선택한 제공자의 API를 대리 호출한다. 브라우저는 현재 여행 기간, 출발지, 날씨, 일정별 장소명·설명·추천 이유만 전달하며 서버는 최근 대화 6개와 함께 답변을 생성한다. 두 제공자 모두 API 응답 저장을 비활성화하며 키 누락, 잘못된 제공자, 잘못된 요청, 속도 제한, 응답 지연, 상위 API 오류를 사용자 안내로 구분한다.

현재 구현은 로컬 장소 데이터 기반 답변이며 공식 관광 원문 검색이나 출처 링크를 붙이는 RAG는 포함하지 않는다.

## 기상청 날씨 연동

공공데이터포털에서 **기상청_단기예보 조회서비스**와 **기상청_중기예보 조회서비스**를 모두 활용신청한 후 일반 인증키를 `.env`에 입력

```dotenv
KMA_API_SERVICE_KEY=YOUR_DATA_GO_KR_SERVICE_KEY
```

`start_server.ps1`이 `.env`를 읽고 `/api/weather`에서 기상청 API를 대리 호출하므로 인증키가 브라우저에 노출되지 않음. Encoding/Decoding 인증키 모두 사용할 수 있으며, 키를 바꾼 뒤에는 서버를 다시 시작해야 함.

앱은 먼저 사용자가 고른 출발지의 위도·경도를 기상청 격자 `nx/ny`로 변환하고 단기예보의 12시·18시 `TMP`, `SKY`, `PTY`, `POP`을 조회함. 단기예보에 없는 여행 날짜는 광주·전남 중기육상예보와 광주 중기기온예보로 자동 보충해 오전·오후 날씨, 강수확률, 최저·최고기온을 표시함. 비·눈 또는 강수확률 60% 이상이면 해당 Day만 우천 조건으로 판단하고 `rainOk` 장소 중 실내 관광지에 추가 우선순위를 부여함. 두 예보 범위 밖 날짜, 인증키 누락·미등록, 통신 오류가 발생하면 일정 추천은 계속하고 날씨만 미반영 상태로 안내.

날씨 로직 자동 검증:

```powershell
node --test .\tests\weather.test.mjs
```


### 광주관광 공식 페이지에서 장소 수집

인증키가 없어도 광주관광 공식 페이지에서 공개된 장소 초안을 수집 가능

```powershell
.\scripts\run_data_pipeline.cmd collect-gwangju --limit 100
```

이 명령은 분야별 장소를 고르게 가져와 다음 파일 생성

- `gwangju_official_places.csv`
- `gwangju_official_place_profiles.csv`
- `gwangju_official_operating_info_review.csv`
- `gwangju_official_quality_report.json`

현재 정제본에는 광주 공식 장소 72개가 들어 있으며 자연·경관, 역사·전통, 문화·예술, 체험·스포츠, 도보·산책, 공원·정원 6개 분야와 광주 5개 구를 포함합니다. 음식·로컬 장소는 별도 음식점 DB와의 중복을 피하기 위해 제외했으며, 현재 장소의 품질 상태는 모두 `draft`입니다.

더 넓은 TourAPI 데이터를 수집하려면 다음 설정을 사용함

1. `.env.example`을 `.env`로 복사
2. 공공데이터포털에서 발급받은 일반 인증키를 `TOUR_API_SERVICE_KEY`에 입력
3. 다음 명령을 실행

```powershell
.\scripts\run_data_pipeline.cmd collect --limit 100
```

수집기는 장소 기본정보와 상세정보를 합치고, 8축 해시태그 초안을 생성한 뒤 품질검사와 데이터 적재용 SQL 생성까지 수행함

자동 라벨은 `quality_status=draft`로 저장되며 사람의 검수를 거쳐 사용

### 현재 광주 공식 장소 CSV 다시 검사

```powershell
.\scripts\run_data_pipeline.cmd validate `
  --places .\data\generated\gwangju_official_places.csv `
  --profiles .\data\generated\gwangju_official_place_profiles.csv `
  --report .\data\generated\gwangju_official_quality_report.json
```

광주 30개 우선 수집 대상은 `data/curated/gwangju_candidate_queue.csv`에 정리되어 있음

## 파일 구조

```text
index.html              화면 구조
styles.css              반응형 디자인
app.js                  추천, 필터, 경로 로직
config.js               카카오맵·기상청 API 연결 설정
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
```


## 기획상 활용 예정 데이터

- `A-DS02` 한국 관광지 질의응답 데이터(KVQA)
- `A-DS03` 관광 이미지-텍스트 데이터
- `A-DS05` 여행 로그 데이터
- `A-DS10` 여행 패턴 데이터
- `A-DS13` TourAPI 관광정보
- `A-DS17` 문화·관광 이동 및 교통 데이터

## ⭐ Contributors | 팀원

- 팀명: 인지용이지용
- 소속: 서울과학기술대학교 인공지능응용학과

<table>
  <tr>
    <td align="center" width="160">
      <a href="https://github.com/fireeat">
        <img src="https://github.com/fireeat.png" width="100" alt="강하리 GitHub 프로필"><br>
        <strong>강하리</strong><br>
        <sub>@fireeat</sub>
      </a>
    </td>
    <td align="center" width="160">
      <a href="https://github.com/skguskim">
        <img src="https://github.com/skguskim.png" width="100" alt="김나현 GitHub 프로필"><br>
        <strong>김나현</strong><br>
        <sub>@skguskim</sub>
      </a>
    </td>
    <td align="center" width="160">
      <a href="https://github.com/seoultech22">
        <img src="https://github.com/seoultech22.png" width="100" alt="윤영준 GitHub 프로필"><br>
        <strong>윤영준</strong><br>
        <sub>@seoultech22</sub>
      </a>
    </td>
    <td align="center" width="160">
      <a href="https://github.com/BotanicalHouse">
        <img src="https://github.com/BotanicalHouse.png" width="100" alt="이재현 GitHub 프로필"><br>
        <strong>이재현</strong><br>
        <sub>@BotanicalHouse</sub>
      </a>
    </td>
  </tr>
</table>
