-- 프로토타입 확인용 샘플 데이터입니다.
-- schema.sql 실행 후 실행하세요.

with inserted as (
  insert into public.places (
    source, source_place_id, name, region, category, description,
    latitude, longitude, duration_minutes, indoor, rain_ok,
    family_friendly, public_transport_score
  ) values
    ('prototype', 'acc', '국립아시아문화전당', '광주 동구', '문화·예술',
      '전시와 공연, 넓은 실내외 공간을 함께 경험하는 도심 문화 거점',
      35.1469, 126.9198, 100, true, true, true, 0.95),
    ('prototype', 'yangnim', '양림동 역사문화마을', '광주 남구', '역사·산책',
      '근대 건축과 골목, 작은 전시 공간을 천천히 연결해 걷는 마을',
      35.1412, 126.9144, 90, false, false, true, 0.82),
    ('prototype', 'mudeungsan', '무등산 국립공원', '광주 북구', '자연·트레킹',
      '광주를 대표하는 산과 숲길에서 풍경과 트레킹을 즐기는 코스',
      35.1338, 126.9903, 180, false, false, false, 0.55),
    ('prototype', 'champions', '광주-기아 챔피언스필드', '광주 북구', '스포츠',
      '야구 팬의 열기와 경기 전후 지역 먹거리를 함께 즐기는 장소',
      35.1682, 126.8891, 210, false, false, true, 0.78),
    ('prototype', 'songjeong', '1913 송정역시장', '광주 광산구', '시장·음식',
      '광주송정역 가까이에서 로컬 간식과 시장의 분위기를 만나는 곳',
      35.1373, 126.7915, 60, false, true, true, 1.0),
    ('prototype', 'biennale', '광주비엔날레 전시관', '광주 북구', '현대미술',
      '현대미술을 중심으로 새로운 시각과 이야기를 발견하는 전시 공간',
      35.1824, 126.8898, 90, true, true, true, 0.68),
    ('prototype', 'juknokwon', '담양 죽녹원', '전남 담양', '자연·산책',
      '대숲 사이의 길을 걸으며 바람과 초록을 느끼는 대표적인 휴식 코스',
      35.3254, 126.9854, 100, false, false, true, 0.52),
    ('prototype', 'suncheon_garden', '순천만 국가정원', '전남 순천', '정원·생태',
      '계절별 정원과 생태 공간을 넓게 산책하며 하루를 보내는 여행지',
      34.9285, 127.4992, 180, false, false, true, 0.62),
    ('prototype', 'yeosu_night', '여수 낭만포차거리', '전남 여수', '음식·야경',
      '바다 야경을 배경으로 여수의 음식과 밤 분위기를 즐기는 거리',
      34.7416, 127.7360, 110, false, false, false, 0.72),
    ('prototype', 'mokpo_modern', '목포 근대역사문화공간', '전남 목포', '역사·도시',
      '근대 건축과 항구도시의 이야기를 골목과 전시로 이어 보는 공간',
      34.7884, 126.3831, 120, false, true, true, 0.76),
    ('prototype', 'hwasun_dolmen', '화순 고인돌 유적', '전남 화순', '역사·유적',
      '선사시대의 흔적과 자연 지형을 함께 살펴보는 야외 역사 탐방지',
      34.9777, 126.9307, 100, false, false, true, 0.32),
    ('prototype', 'gokseong_train', '곡성 섬진강기차마을', '전남 곡성', '체험·가족',
      '기차와 놀이, 계절 풍경을 한 공간에서 즐기는 가족형 체험 여행지',
      35.2784, 127.3067, 150, false, false, true, 0.42)
  on conflict (source, source_place_id) do update set
    name = excluded.name,
    region = excluded.region,
    category = excluded.category,
    description = excluded.description,
    latitude = excluded.latitude,
    longitude = excluded.longitude,
    duration_minutes = excluded.duration_minutes,
    indoor = excluded.indoor,
    rain_ok = excluded.rain_ok,
    family_friendly = excluded.family_friendly,
    public_transport_score = excluded.public_transport_score,
    updated_at = now()
  returning id, source_place_id
)
insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector,
  semantic_text, labeling_confidence, labeling_evidence
)
select
  i.id,
  d.hashtags,
  d.tag_scores,
  d.preference_vector::extensions.vector(8),
  d.semantic_text,
  0.85,
  jsonb_build_array(jsonb_build_object('source', 'prototype', 'note', 'MVP 수동 라벨'))
from inserted i
join (
  values
    ('acc', array['#예술','#전시','#실내','#비오는날'],
      '{"nature":0.05,"culture":0.85,"art":0.98,"food":0.15,"activity":0.25,"sports":0.05,"healing":0.35,"festival":0.55}'::jsonb,
      '[0.05,0.85,0.98,0.15,0.25,0.05,0.35,0.55]', '문화 예술 전시 실내 비오는 날'),
    ('yangnim', array['#근대문화','#골목산책','#사진','#카페'],
      '{"nature":0.25,"culture":0.92,"art":0.75,"food":0.5,"activity":0.4,"sports":0.05,"healing":0.8,"festival":0.5}'::jsonb,
      '[0.25,0.92,0.75,0.5,0.4,0.05,0.8,0.5]', '근대문화 골목 산책 사진 카페'),
    ('mudeungsan', array['#자연','#트레킹','#전망','#힐링'],
      '{"nature":1.0,"culture":0.45,"art":0.1,"food":0.1,"activity":0.85,"sports":0.15,"healing":0.95,"festival":0.15}'::jsonb,
      '[1.0,0.45,0.1,0.1,0.85,0.15,0.95,0.15]', '자연 산 숲길 트레킹 전망 힐링'),
    ('champions', array['#야구','#KIA','#응원','#야간'],
      '{"nature":0.05,"culture":0.12,"art":0.08,"food":0.45,"activity":0.55,"sports":1.0,"healing":0.2,"festival":0.7}'::jsonb,
      '[0.05,0.12,0.08,0.45,0.55,1.0,0.2,0.7]', '야구 KIA 스포츠 응원 야간'),
    ('songjeong', array['#시장','#로컬푸드','#간식','#기차여행'],
      '{"nature":0.05,"culture":0.5,"art":0.25,"food":1.0,"activity":0.35,"sports":0.12,"healing":0.45,"festival":0.65}'::jsonb,
      '[0.05,0.5,0.25,1.0,0.35,0.12,0.45,0.65]', '전통시장 로컬 음식 간식 기차'),
    ('biennale', array['#현대미술','#전시','#실내','#문화'],
      '{"nature":0.05,"culture":0.65,"art":1.0,"food":0.15,"activity":0.25,"sports":0.05,"healing":0.35,"festival":0.55}'::jsonb,
      '[0.05,0.65,1.0,0.15,0.25,0.05,0.35,0.55]', '현대미술 전시 실내 문화'),
    ('juknokwon', array['#대나무숲','#산책','#힐링','#사진'],
      '{"nature":0.98,"culture":0.45,"art":0.2,"food":0.3,"activity":0.5,"sports":0.05,"healing":0.95,"festival":0.25}'::jsonb,
      '[0.98,0.45,0.2,0.3,0.5,0.05,0.95,0.25]', '대나무 숲 산책 힐링 사진'),
    ('suncheon_garden', array['#정원','#생태','#산책','#가족'],
      '{"nature":1.0,"culture":0.45,"art":0.25,"food":0.35,"activity":0.55,"sports":0.05,"healing":0.95,"festival":0.4}'::jsonb,
      '[1.0,0.45,0.25,0.35,0.55,0.05,0.95,0.4]', '정원 생태 자연 산책 가족'),
    ('yeosu_night', array['#여수밤바다','#로컬푸드','#야경','#친구'],
      '{"nature":0.5,"culture":0.25,"art":0.15,"food":1.0,"activity":0.45,"sports":0.1,"healing":0.65,"festival":1.0}'::jsonb,
      '[0.5,0.25,0.15,1.0,0.45,0.1,0.65,1.0]', '여수 바다 야경 음식 야간'),
    ('mokpo_modern', array['#근대역사','#항구','#골목','#박물관'],
      '{"nature":0.25,"culture":1.0,"art":0.7,"food":0.65,"activity":0.45,"sports":0.05,"healing":0.65,"festival":0.6}'::jsonb,
      '[0.25,1.0,0.7,0.65,0.45,0.05,0.65,0.6]', '목포 근대역사 항구 골목 박물관'),
    ('hwasun_dolmen', array['#세계유산','#역사','#야외','#탐방'],
      '{"nature":0.65,"culture":1.0,"art":0.25,"food":0.2,"activity":0.55,"sports":0.05,"healing":0.7,"festival":0.15}'::jsonb,
      '[0.65,1.0,0.25,0.2,0.55,0.05,0.7,0.15]', '고인돌 세계유산 역사 야외 탐방'),
    ('gokseong_train', array['#기차','#체험','#가족','#레트로'],
      '{"nature":0.8,"culture":0.35,"art":0.15,"food":0.45,"activity":0.9,"sports":0.2,"healing":0.75,"festival":0.5}'::jsonb,
      '[0.8,0.35,0.15,0.45,0.9,0.2,0.75,0.5]', '기차 체험 가족 레트로 자연')
) as d(source_place_id, hashtags, tag_scores, preference_vector, semantic_text)
  on d.source_place_id = i.source_place_id
on conflict (place_id) do update set
  hashtags = excluded.hashtags,
  tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector,
  semantic_text = excluded.semantic_text,
  labeling_confidence = excluded.labeling_confidence,
  labeling_evidence = excluded.labeling_evidence,
  updated_at = now();

-- 샘플은 운영 검증 완료 데이터가 아니므로 reviewed 단계로만 표시합니다.
update public.places
set quality_status = 'reviewed',
    last_verified_at = now()
where source = 'prototype';
