-- data_pipeline.py가 생성한 오매루트 장소 적재 SQL
-- 검수 후 Supabase SQL Editor에서 실행하세요.
begin;

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'acc', '국립아시아문화전당', '광주 동구', '동구', '문화·예술', '전시와 공연, 넓은 실내외 공간을 함께 경험하는 도심 문화 거점', null, null, 35.1469, 126.9198, null, null, null, 100, true, true, true, null, null, null, null, null, null, 'active', 0.95, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.05, "culture": 0.85, "art": 0.98, "food": 0.15, "activity": 0.25, "sports": 0.05, "healing": 0.35, "festival": 0.55}'::jsonb,
  '[0.05,0.85,0.98,0.15,0.25,0.05,0.35,0.55]'::extensions.vector(8),
  '국립아시아문화전당 전시와 공연, 넓은 실내외 공간을 함께 경험하는 도심 문화 거점 #예술 #전시 #실내 #비오는날', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'acc'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'yangnim', '양림동 역사문화마을', '광주 남구', '남구', '역사·산책', '근대 건축과 골목, 작은 전시 공간을 천천히 연결해 걷는 마을', null, null, 35.1412, 126.9144, null, null, null, 90, false, false, true, null, null, null, null, null, null, 'active', 0.82, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#근대문화','#골목산책','#사진','#카페']::text[],
  '{"nature": 0.25, "culture": 0.92, "art": 0.75, "food": 0.5, "activity": 0.4, "sports": 0.05, "healing": 0.8, "festival": 0.5}'::jsonb,
  '[0.25,0.92,0.75,0.5,0.4,0.05,0.8,0.5]'::extensions.vector(8),
  '양림동 역사문화마을 근대 건축과 골목, 작은 전시 공간을 천천히 연결해 걷는 마을 #근대문화 #골목산책 #사진 #카페', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'yangnim'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'mudeungsan', '무등산 국립공원', '광주 북구', '북구', '자연·트레킹', '광주를 대표하는 산과 숲길에서 풍경과 트레킹을 즐기는 코스', null, null, 35.1338, 126.9903, null, null, null, 180, false, false, false, null, null, null, null, null, null, 'active', 0.55, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#자연','#트레킹','#전망','#힐링']::text[],
  '{"nature": 1.0, "culture": 0.45, "art": 0.1, "food": 0.1, "activity": 0.85, "sports": 0.15, "healing": 0.95, "festival": 0.15}'::jsonb,
  '[1.0,0.45,0.1,0.1,0.85,0.15,0.95,0.15]'::extensions.vector(8),
  '무등산 국립공원 광주를 대표하는 산과 숲길에서 풍경과 트레킹을 즐기는 코스 #자연 #트레킹 #전망 #힐링', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'mudeungsan'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'champions', '광주-기아 챔피언스필드', '광주 북구', '북구', '스포츠', '야구 팬의 열기와 경기 전후 지역 먹거리를 함께 즐기는 장소', null, null, 35.1682, 126.8891, null, null, null, 210, false, false, true, null, null, null, null, null, null, 'active', 0.78, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#야구','#KIA','#응원','#야간']::text[],
  '{"nature": 0.05, "culture": 0.12, "art": 0.08, "food": 0.45, "activity": 0.55, "sports": 1.0, "healing": 0.2, "festival": 0.7}'::jsonb,
  '[0.05,0.12,0.08,0.45,0.55,1.0,0.2,0.7]'::extensions.vector(8),
  '광주-기아 챔피언스필드 야구 팬의 열기와 경기 전후 지역 먹거리를 함께 즐기는 장소 #야구 #KIA #응원 #야간', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'champions'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'songjeong', '1913 송정역시장', '광주 광산구', '광산구', '시장·음식', '광주송정역 가까이에서 로컬 간식과 시장의 분위기를 만나는 곳', null, null, 35.1373, 126.7915, null, null, null, 60, false, true, true, null, null, null, null, null, null, 'active', 1, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#시장','#로컬푸드','#간식','#기차여행']::text[],
  '{"nature": 0.05, "culture": 0.5, "art": 0.25, "food": 1.0, "activity": 0.35, "sports": 0.12, "healing": 0.45, "festival": 0.65}'::jsonb,
  '[0.05,0.5,0.25,1.0,0.35,0.12,0.45,0.65]'::extensions.vector(8),
  '1913 송정역시장 광주송정역 가까이에서 로컬 간식과 시장의 분위기를 만나는 곳 #시장 #로컬푸드 #간식 #기차여행', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'songjeong'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'biennale', '광주비엔날레 전시관', '광주 북구', '북구', '현대미술', '현대미술을 중심으로 새로운 시각과 이야기를 발견하는 전시 공간', null, null, 35.1824, 126.8898, null, null, null, 90, true, true, true, null, null, null, null, null, null, 'active', 0.68, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#현대미술','#전시','#실내','#문화']::text[],
  '{"nature": 0.05, "culture": 0.65, "art": 1.0, "food": 0.15, "activity": 0.25, "sports": 0.05, "healing": 0.35, "festival": 0.55}'::jsonb,
  '[0.05,0.65,1.0,0.15,0.25,0.05,0.35,0.55]'::extensions.vector(8),
  '광주비엔날레 전시관 현대미술을 중심으로 새로운 시각과 이야기를 발견하는 전시 공간 #현대미술 #전시 #실내 #문화', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'biennale'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'juknokwon', '담양 죽녹원', '전남 담양', '담양', '자연·산책', '대숲 사이의 길을 걸으며 바람과 초록을 느끼는 대표적인 휴식 코스', null, null, 35.3254, 126.9854, null, null, null, 100, false, false, true, null, null, null, null, null, null, 'active', 0.52, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#대나무숲','#산책','#힐링','#사진']::text[],
  '{"nature": 0.98, "culture": 0.45, "art": 0.2, "food": 0.3, "activity": 0.5, "sports": 0.05, "healing": 0.95, "festival": 0.25}'::jsonb,
  '[0.98,0.45,0.2,0.3,0.5,0.05,0.95,0.25]'::extensions.vector(8),
  '담양 죽녹원 대숲 사이의 길을 걸으며 바람과 초록을 느끼는 대표적인 휴식 코스 #대나무숲 #산책 #힐링 #사진', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'juknokwon'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'suncheon_garden', '순천만 국가정원', '전남 순천', '순천', '정원·생태', '계절별 정원과 생태 공간을 넓게 산책하며 하루를 보내는 여행지', null, null, 34.9285, 127.4992, null, null, null, 180, false, false, true, null, null, null, null, null, null, 'active', 0.62, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#정원','#생태','#산책','#가족']::text[],
  '{"nature": 1.0, "culture": 0.45, "art": 0.25, "food": 0.35, "activity": 0.55, "sports": 0.05, "healing": 0.95, "festival": 0.4}'::jsonb,
  '[1.0,0.45,0.25,0.35,0.55,0.05,0.95,0.4]'::extensions.vector(8),
  '순천만 국가정원 계절별 정원과 생태 공간을 넓게 산책하며 하루를 보내는 여행지 #정원 #생태 #산책 #가족', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'suncheon_garden'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'yeosu_night', '여수 낭만포차거리', '전남 여수', '여수', '음식·야경', '바다 야경을 배경으로 여수의 음식과 밤 분위기를 즐기는 거리', null, null, 34.7416, 127.736, null, null, null, 110, false, false, false, null, null, null, null, null, null, 'active', 0.72, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#여수밤바다','#로컬푸드','#야경','#친구']::text[],
  '{"nature": 0.5, "culture": 0.25, "art": 0.15, "food": 1.0, "activity": 0.45, "sports": 0.1, "healing": 0.65, "festival": 1.0}'::jsonb,
  '[0.5,0.25,0.15,1.0,0.45,0.1,0.65,1.0]'::extensions.vector(8),
  '여수 낭만포차거리 바다 야경을 배경으로 여수의 음식과 밤 분위기를 즐기는 거리 #여수밤바다 #로컬푸드 #야경 #친구', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'yeosu_night'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'mokpo_modern', '목포 근대역사문화공간', '전남 목포', '목포', '역사·도시', '근대 건축과 항구도시의 이야기를 골목과 전시로 이어 보는 공간', null, null, 34.7884, 126.3831, null, null, null, 120, false, true, true, null, null, null, null, null, null, 'active', 0.76, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#근대역사','#항구','#골목','#박물관']::text[],
  '{"nature": 0.25, "culture": 1.0, "art": 0.7, "food": 0.65, "activity": 0.45, "sports": 0.05, "healing": 0.65, "festival": 0.6}'::jsonb,
  '[0.25,1.0,0.7,0.65,0.45,0.05,0.65,0.6]'::extensions.vector(8),
  '목포 근대역사문화공간 근대 건축과 항구도시의 이야기를 골목과 전시로 이어 보는 공간 #근대역사 #항구 #골목 #박물관', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'mokpo_modern'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'hwasun_dolmen', '화순 고인돌 유적', '전남 화순', '화순', '역사·유적', '선사시대의 흔적과 자연 지형을 함께 살펴보는 야외 역사 탐방지', null, null, 34.9777, 126.9307, null, null, null, 100, false, false, true, null, null, null, null, null, null, 'active', 0.32, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#세계유산','#역사','#야외','#탐방']::text[],
  '{"nature": 0.65, "culture": 1.0, "art": 0.25, "food": 0.2, "activity": 0.55, "sports": 0.05, "healing": 0.7, "festival": 0.15}'::jsonb,
  '[0.65,1.0,0.25,0.2,0.55,0.05,0.7,0.15]'::extensions.vector(8),
  '화순 고인돌 유적 선사시대의 흔적과 자연 지형을 함께 살펴보는 야외 역사 탐방지 #세계유산 #역사 #야외 #탐방', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'hwasun_dolmen'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('prototype', 'gokseong_train', '곡성 섬진강기차마을', '전남 곡성', '곡성', '체험·가족', '기차와 놀이, 계절 풍경을 한 공간에서 즐기는 가족형 체험 여행지', null, null, 35.2784, 127.3067, null, null, null, 150, false, false, true, null, null, null, null, null, null, 'active', 0.42, null, null, '2026-07-21T04:43:38.340986+00:00'::timestamptz, 'prototype', 'reviewed')
on conflict (source, source_place_id) do update set
  name = excluded.name,
  region = excluded.region,
  sigungu = excluded.sigungu,
  category = excluded.category,
  description = excluded.description,
  road_address = excluded.road_address,
  lot_address = excluded.lot_address,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  phone = excluded.phone,
  website_url = excluded.website_url,
  image_url = excluded.image_url,
  duration_minutes = excluded.duration_minutes,
  indoor = excluded.indoor,
  rain_ok = excluded.rain_ok,
  family_friendly = excluded.family_friendly,
  parking_available = excluded.parking_available,
  wheelchair_accessible = excluded.wheelchair_accessible,
  pet_friendly = excluded.pet_friendly,
  requires_reservation = excluded.requires_reservation,
  price_min = excluded.price_min,
  price_max = excluded.price_max,
  status = excluded.status,
  public_transport_score = excluded.public_transport_score,
  source_url = excluded.source_url,
  source_updated_at = excluded.source_updated_at,
  last_verified_at = excluded.last_verified_at,
  license = excluded.license,
  quality_status = excluded.quality_status,
  updated_at = now();

insert into public.place_profiles (
  place_id, hashtags, tag_scores, preference_vector, semantic_text, taxonomy_version,
  labeling_method, labeling_confidence, labeling_evidence, reviewed_at
)
select p.id,
  array['#기차','#체험','#가족','#레트로']::text[],
  '{"nature": 0.8, "culture": 0.35, "art": 0.15, "food": 0.45, "activity": 0.9, "sports": 0.2, "healing": 0.75, "festival": 0.5}'::jsonb,
  '[0.8,0.35,0.15,0.45,0.9,0.2,0.75,0.5]'::extensions.vector(8),
  '곡성 섬진강기차마을 기차와 놀이, 계절 풍경을 한 공간에서 즐기는 가족형 체험 여행지 #기차 #체험 #가족 #레트로', '1.0.0',
  'manual', 0.85,
  '[{"source": "prototype", "note": "기존 MVP 수동 라벨"}]'::jsonb, '2026-07-21T04:43:38.340986+00:00'::timestamptz
from public.places p
where p.source = 'prototype' and p.source_place_id = 'gokseong_train'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

commit;
