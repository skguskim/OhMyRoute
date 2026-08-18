# 스탬프 데이터 로컬 구축 가이드

## 원칙

- AI Hub 원본과 라벨은 이 저장소 밖에 보관합니다.
- 스크립트는 원본을 복사하지 않고 로컬 파일의 절대경로만 읽습니다.
- 선별 목록은 `data/local-stamps/`에 생성되며 Git에서 자동 제외됩니다.
- 저장소에는 직접 제작하고 권리 검수를 마친 최종 스탬프 자산만 포함합니다.
- 음식점·구장 먹거리는 개별 상표 대신 하나의 `광주 미식` 스탬프를 사용합니다.
- 관광지는 장소별 디자인을 만들지 않고 데이터 카테고리에 대응하는 고정 테마 디자인을 사용하며,
  AI Hub 문양은 같은 테마 안에서 공통 배경으로만 선택 적용합니다.
- 앱이 직접 사용하는 편집 가능한 최종 도안은 `assets/stamps/themes/*.svg`에 보관합니다.
  이 SVG는 직접 제작한 자산이며 AI Hub 원본·가공 이미지를 포함하지 않습니다.
- 다른 PC에서도 문양 배경이 보이도록 AI Hub의 유형·상징 정보를 참고해 재제작한 반복형 SVG를
  `assets/stamps/patterns/*.svg`에 제공합니다. 로컬 선별 문양이 있으면 해당 자산을 우선 사용합니다.
- 광주-기아 챔피언스필드 공식 로고는 학습 데이터에 섞지 않습니다. 공식 로고는
  장소 소개용 별도 자산으로 취급하고, 스탬프는 야구공·홈플레이트·구장 실루엣을
  활용한 오리지널 디자인으로 제작합니다.

## AI Hub에서 받을 파일

[한국 전통 문양 데이터](https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&dataSetSn=71809)에서
다음 두 종류를 우선 받습니다.

1. 문양 이미지 원본(`pattern_file_name`에 대응하는 이미지)
2. 객체 및 문양 이미지 캡셔닝 JSON(`images.pattern_file_name`이 포함된 라벨)

전체 유물 객체 이미지는 1차 스탬프 구축에는 필요하지 않습니다. AI Hub 파일 묶음상
분리가 불가능하면 전체를 받아도 되지만, 저장소 밖에서 압축을 해제합니다.

권장 위치 예시:

```text
C:\Users\nahyun\AIHub\traditional-patterns\
```

OneDrive 동기화 폴더와 이 Git 저장소 내부는 피하는 것이 좋습니다.

## 경로 연결

프로젝트 루트의 `.env`에 다음 한 줄을 추가합니다.

```dotenv
AIHUB_TRADITIONAL_PATTERN_DIR=C:\Users\nahyun\AIHub\traditional-patterns
```

`.env`는 이미 Git에서 제외되어 있습니다. 다른 사람의 컴퓨터에서는 각자 자신의
로컬 경로를 설정합니다.

## 로컬 선별 목록 만들기

```powershell
.\scripts\prepare_stamp_dataset.cmd
```

기본적으로 8개 문양 유형에서 각각 최대 150개를 선별해 최대 1,200개의 균형 목록을
만듭니다. 결과는 다음 두 파일이며 모두 Git에서 제외됩니다.

```text
data/local-stamps/aihub-pattern-manifest.jsonl
data/local-stamps/aihub-pattern-manifest.summary.json
```

원본 경로를 명령에서 직접 지정할 수도 있습니다.

```powershell
.\scripts\prepare_stamp_dataset.cmd `
  --source "C:\Users\nahyun\AIHub\traditional-patterns" `
  --per-type 150
```

## 검수 순서

1. 요약 파일에서 문양 유형별 수와 이미지 경로 누락 건수를 확인합니다.
2. 중복 유물과 같은 문양의 변형본이 학습·검증 세트에 동시에 들어가지 않도록
   `relic_no` 기준으로 묶습니다.
3. 작은 화면에서도 식별되는 대칭형·강한 외곽선 문양을 우선합니다.
4. 문양을 단색화·도장화한 결과를 사람이 검수합니다.
5. 장소마다 최종 후보 하나를 확정한 뒤에만 서비스 자산으로 내보냅니다.

AI Hub 원본 데이터와 라벨을 다른 사람에게 전달하거나 저장소에 올리지 않습니다.
외부 공개 결과물에는 AI Hub 사업 결과를 활용했다는 출처를 표시하고, 상용화 전에는
최신 데이터 이용정책과 개별 브랜드 자산 사용 권리를 다시 확인합니다.
