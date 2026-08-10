-- data_pipeline.py가 생성한 오매루트 장소 적재 SQL
-- 검수 후 Supabase SQL Editor에서 실행하세요.
begin;

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2783851', '경암근린공원', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 하남대로54번안길 133 (하남동)', null, 35.1783221177, 126.8000977994, '광주 광산구청 도시공원과 062-960-8712', null, 'http://tong.visitkorea.or.kr/cms/resource/84/3528384_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#공원','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '경암근린공원 #공원 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2783851'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127069', '관덕정의 각궁', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 사직길 49', null, 35.1419253355, 126.9118638245, '062-671-8383', null, 'http://tong.visitkorea.or.kr/cms/resource/46/3350246_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '관덕정의 각궁', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127069'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '128158', '광주 경찰충혼탑', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 사직길 49', null, 35.142541996, 126.9155968119, '062-675-3280', null, 'http://tong.visitkorea.or.kr/cms/resource/37/3366737_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주 경찰충혼탑', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '128158'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2605353', '광주 송정동 떡갈비 골목', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 광산로29번길', null, 35.1397152706, 126.7943076079, '전남광주통합특별시 광산구청 062-960-8114', null, 'http://tong.visitkorea.or.kr/cms/resource/89/3367489_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#전통음식','#느린여행']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '광주 송정동 떡갈비 골목 #전통음식 #느린여행', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2605353'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2822573', '광주 수완호수공원', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 장신로82번길 57 공원관리사무소', null, 35.1879824765, 126.8202596628, '광주광역시 광산구청 공원녹지과 062-960-8705', null, 'http://tong.visitkorea.or.kr/cms/resource/65/2822565_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#바다','#공원','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '광주 수완호수공원 #바다 #공원 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2822573'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127325', '광주 충효동 왕버들 군', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 충효샘길 7 (충효동)', null, 35.1848719954, 127.0009520932, '062-410-6140', null, 'http://tong.visitkorea.or.kr/cms/resource/50/3350350_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주 충효동 왕버들 군 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127325'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2489843', '광주 평촌마을', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 평촌길 15', null, 35.1756287576, 127.0105542557, '062-266-2287', null, 'http://tong.visitkorea.or.kr/cms/resource/88/3367188_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#느린여행','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '광주 평촌마을 #느린여행 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2489843'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2605351', '광주폴리', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 비엔날레로 111', null, 35.1826203741, 126.890259159, '062-608-4260', null, 'http://tong.visitkorea.or.kr/cms/resource/94/3367394_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주폴리', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2605351'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126329', '광주호', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 충효샘길 7 (충효동)', null, 35.1840804198, 127.0010882121, '062-613-7892', null, 'http://tong.visitkorea.or.kr/cms/resource/04/3368304_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주호 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126329'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126425', '국립 5·18 민주묘지', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 민주로 200 (운정동)', null, 35.2325767086, 126.9415422558, '062-268-0518', null, 'http://tong.visitkorea.or.kr/cms/resource/81/1587681_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#민주인권','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '국립 5·18 민주묘지 #민주인권 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126425'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621334', '금남로', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 금남로 일대 (금남로5가)', null, 35.1538517467, 126.9106747413, '전남광주통합특별시 동구청 관광진흥과 062-613-3633', null, 'http://tong.visitkorea.or.kr/cms/resource/73/3459973_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '금남로', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621334'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127356', '너릿재공원', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 남문로 48-8 (선교동)', null, 35.0803774303, 126.9535616807, '화순군 관광기획팀 061-379-3501', null, 'http://tong.visitkorea.or.kr/cms/resource/10/3366810_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공원','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '너릿재공원 #공원 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127356'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2470068', '녹색에너지체험관 (광주전남지역본부)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 첨단과기로 123', null, 35.2274311559, 126.8416345612, '062-602-0001', null, 'http://tong.visitkorea.or.kr/cms/resource/88/3040988_image2_1.jpg', 90, false, false, true, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#아이동반','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.0,0.0,0.0]'::extensions.vector(8),
  '녹색에너지체험관 (광주전남지역본부) #체험 #아이동반 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2470068'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614773', '덕산너덜 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '수목원정원사업소 지질공원과 062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/17/2917917_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#등산','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.75,0.0]'::extensions.vector(8),
  '덕산너덜 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614773'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1620893', '도림사(광주)', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 도림하길 33 (도덕동)', null, 35.1666995405, 126.7007374404, '062-940-8225', null, 'http://tong.visitkorea.or.kr/cms/resource/40/3366540_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '도림사(광주)', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1620893'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2565865', '동리단길 카페거리', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 동명동', null, 35.1492525371, 126.9267289927, '전남광주통합특별시 관광안내소 062-365-8733', null, 'http://tong.visitkorea.or.kr/cms/resource/70/3337270_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#카페']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '동리단길 카페거리 #카페', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2565865'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1620808', '두남제', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 광산동 277', null, 35.2437804781, 126.7462953738, '062-960-8225', null, 'http://tong.visitkorea.or.kr/cms/resource/71/3366471_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '두남제', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1620808'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3353800', '뜻모아센터', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 서하로245번길 42 (오치동) 3층 302호', null, 35.1892060356, 126.9076407902, '010-7173-0808', null, 'http://tong.visitkorea.or.kr/cms/resource/53/3353753_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '뜻모아센터 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3353800'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614783', '무등산 정상3봉 (무등산 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1442791515, 126.9888819591, '062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/78/2614778_image2_1.bmp', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#등산','#공원','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.75,0.0]'::extensions.vector(8),
  '무등산 정상3봉 (무등산 국가지질공원) #산 #등산 #공원 #주차가능', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614783'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1074432', '무등산 주상절리대', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 용연동 산 354-1', null, 35.1202403693, 126.9990150009, '062-227-1187', null, 'http://tong.visitkorea.or.kr/cms/resource/23/3029123_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#등산','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.0,0.0]'::extensions.vector(8),
  '무등산 주상절리대 #산 #등산 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1074432'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129201', '무양서원', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 산월로21번길 26', null, 35.2099969896, 126.8401045774, '062-960-8255', null, 'http://tong.visitkorea.or.kr/cms/resource/21/3033521_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#전통']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '무양서원 #전통', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129201'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614815', '백마능선 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '지질공원과 062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/14/2614814_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#등산','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.75,0.0]'::extensions.vector(8),
  '백마능선 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614815'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '742332', '부용정', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 칠석동 129', null, 35.0697627681, 126.8366333845, '전남광주통합특별시 남구 문화관광과 062-607-2332', null, 'http://tong.visitkorea.or.kr/cms/resource/18/3367718_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '부용정', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '742332'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2783824', '산동교친수공원', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 동림동 130-15', null, 35.1897079853, 126.8619975926, '전남광주통합특별시 북구청 공원녹지과 062-410-6441', null, 'http://tong.visitkorea.or.kr/cms/resource/20/3528420_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#산','#공원','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '산동교친수공원 #산 #공원 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2783824'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129199', '삼거동 고인돌', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 삼거동 산50', null, 35.1522951414, 126.6725736251, '전남광주통합특별시 송정역관광안내소 062-944-9044', null, 'http://tong.visitkorea.or.kr/cms/resource/00/3530000_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '삼거동 고인돌', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129199'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1622203', '상무시민공원', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 상무공원로 101', null, 35.1537505721, 126.8403948478, '062-360-7513', null, 'http://tong.visitkorea.or.kr/cms/resource/42/3367442_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공원','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '상무시민공원 #공원 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1622203'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614819', '새인봉 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/17/2614817_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#등산','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.75,0.0]'::extensions.vector(8),
  '새인봉 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614819'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614826', '서석대 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '무등산생태문화관리사무소 062-613-7851', null, 'http://tong.visitkorea.or.kr/cms/resource/21/2614821_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#등산','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.75,0.0]'::extensions.vector(8),
  '서석대 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614826'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127062', '선교기념비', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 제중로 56 (양림동)', null, 35.1396061822, 126.9135887299, '전남광주통합특별시 남구 문화관광과 062-607-2311', null, 'http://tong.visitkorea.or.kr/cms/resource/49/3344449_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '선교기념비 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127062'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3353909', '소잉(에이핸즈협동조합)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 첨단연신로108번길 31-15 (신용동) 1층', null, 35.2077143361, 126.8650829796, '0507-1390-2510', null, 'http://tong.visitkorea.or.kr/cms/resource/08/3353808_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '소잉(에이핸즈협동조합) #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3353909'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621168', '고싸움놀이전수교육관', '광주 남구', '남구', '문화·예술', null, '전남광주통합특별시 남구 고싸움로 2', null, 35.0697294541, 126.837538861, null, null, 'http://tong.visitkorea.or.kr/cms/resource/87/3367587_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#교육','#레저','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 1.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,1.0,0.0,0.0,0.0]'::extensions.vector(8),
  '고싸움놀이전수교육관 #예술 #교육 #레저 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621168'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130032', '광산문화원', '광주 광산구', '광산구', '문화·예술', null, '전남광주통합특별시 광산구 상무대로 265', null, 35.1424455318, 126.7951296891, null, null, 'http://tong.visitkorea.or.kr/cms/resource/02/3366502_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광산문화원 #산 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130032'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130391', '광주 동구문화원', '광주 동구', '동구', '문화·예술', null, '전남광주통합특별시 동구 예술길 18-1', null, 35.150118962, 126.9181741721, null, null, 'http://tong.visitkorea.or.kr/cms/resource/81/3367381_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주 동구문화원 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130391'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130208', '광주 북구문화원', '광주 북구', '북구', '문화·예술', null, '전남광주통합특별시 북구 향토문화로 65 (중흥동)', null, 35.1728940911, 126.9136656663, null, null, 'http://tong.visitkorea.or.kr/cms/resource/01/3421301_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주 북구문화원 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130208'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130808', '광주 송정다가치문화도서관', '광주 광산구', '광산구', '문화·예술', null, '전남광주통합특별시 광산구 송정공원로 8-13', null, 35.1449147758, 126.7998069918, null, null, 'http://tong.visitkorea.or.kr/cms/resource/27/1587327_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주 송정다가치문화도서관 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130808'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2733545', '광주 전통문화관', '광주 동구', '동구', '문화·예술', null, '전남광주통합특별시 동구 의재로 222', null, 35.1336797291, 126.9523771168, null, null, 'http://tong.visitkorea.or.kr/cms/resource/46/2733546_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#전통','#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주 전통문화관 #전통 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2733545'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130033', '광주광역시 서구문화원', '광주 서구', '서구', '문화·예술', null, '전남광주통합특별시 서구 풍금로 182', null, 35.1318478187, 126.8599131134, null, null, 'http://tong.visitkorea.or.kr/cms/resource/51/3367251_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주광역시 서구문화원 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130033'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2779116', '광주비엔날레전시관', '광주 북구', '북구', '문화·예술', null, '전남광주통합특별시 북구 비엔날레로 111 (용봉동)', null, 35.1826203741, 126.890259159, null, null, 'http://tong.visitkorea.or.kr/cms/resource/79/3351379_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주비엔날레전시관 #박물관 #예술 #전시 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2779116'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129761', '광주시립미술관', '광주 북구', '북구', '문화·예술', null, '전남광주통합특별시 북구 하서로 52', null, 35.1832174547, 126.8858428681, null, null, 'http://tong.visitkorea.or.kr/cms/resource/11/3368411_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#전시','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주시립미술관 #예술 #전시 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129761'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '969963', '광주야외음악당', '광주 서구', '서구', '문화·예술', null, '전남광주통합특별시 서구 내방로 111 (치평동)', null, 35.160019493, 126.8513576102, null, null, 'http://tong.visitkorea.or.kr/cms/resource/64/3367264_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#공연','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주야외음악당 #예술 #공연 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '969963'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3380159', '광주자동차극장', '광주 북구', '북구', '문화·예술', null, '전남광주통합특별시 북구 우치로 649 (생용동)', null, 35.2206801686, 126.9024237945, null, null, null, 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#예술','#공연','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광주자동차극장 #예술 #공연 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3380159'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2009775', '국립아시아문화전당', '광주 동구', '동구', '문화·예술', null, '전남광주통합특별시 동구 문화전당로 38 (광산동)', null, 35.1460861028, 126.9192936186, null, null, 'http://tong.visitkorea.or.kr/cms/resource/59/3083359_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '국립아시아문화전당 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2009775'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130807', '금호평생교육관', '광주 남구', '남구', '문화·예술', null, '전남광주통합특별시 남구 중앙로 15', null, 35.1450970088, 126.9005647433, null, null, 'http://tong.visitkorea.or.kr/cms/resource/93/3366693_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#교육','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.75,0.0,0.0,0.0]'::extensions.vector(8),
  '금호평생교육관 #예술 #교육 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130807'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1745001', '빛고을시민문화관', '광주 남구', '남구', '문화·예술', null, '전남광주통합특별시 남구 천변좌로338번길 7', null, 35.1479301594, 126.9086750662, null, null, 'http://tong.visitkorea.or.kr/cms/resource/05/3366705_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#야경','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.75}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.75]'::extensions.vector(8),
  '빛고을시민문화관 #예술 #야경 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1745001'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2605338', '수피아여자중고등학교', '광주 남구', '남구', '문화·예술', null, '전남광주통합특별시 남구 백서로 13 (양림동)', null, 35.1368703131, 126.9096335919, null, null, 'http://tong.visitkorea.or.kr/cms/resource/79/3366679_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '수피아여자중고등학교 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2605338'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130639', '우제길미술관', '광주 동구', '동구', '문화·예술', null, '전남광주통합특별시 동구 의재로 140-6', null, 35.1317742306, 126.9430502112, null, null, 'http://tong.visitkorea.or.kr/cms/resource/53/3510753_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#전시','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '우제길미술관 #예술 #전시 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130639'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2755010', '5·18민주화운동 기록관', '광주 동구', '동구', '문화·예술', null, '전남광주통합특별시 동구 금남로 221 (금남로3가)', null, 35.1496023298, 126.9167687536, null, null, 'http://tong.visitkorea.or.kr/cms/resource/32/3532032_image2_1.jpg', 90, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#민주인권','#예술','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '5·18민주화운동 기록관 #민주인권 #예술 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2755010'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3460731', '광주여성영화제', '광주 동구', '동구', '축제·공연', null, '전남광주통합특별시 동구 중앙로160번길 16-7 (불로동)', null, 35.1468609363, 126.9146634529, '062-515-6560', null, 'http://tong.visitkorea.or.kr/cms/resource/26/3460726_image2_1.jpg', 120, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공연','#참여형','#축제']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 1.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.75,0.0,0.0,1.0]'::extensions.vector(8),
  '광주여성영화제 #공연 #참여형 #축제', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3460731'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '131450', '광주북구청소년수련관', '광주 북구', '북구', '체험·스포츠', null, '전남광주통합특별시 북구 대천로 86 (문흥동)', null, 35.1848927862, 126.9166678776, null, null, 'http://tong.visitkorea.or.kr/cms/resource/16/1892816_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '광주북구청소년수련관 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '131450'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2739385', '광주시패밀리랜드 카라반캠핑장', '광주 북구', '북구', '체험·스포츠', null, '전남광주통합특별시 북구 우치로 677 (생용동)', null, 35.2237436949, 126.9014654688, null, null, 'http://tong.visitkorea.or.kr/cms/resource/42/2739842_image2_1.JPG', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '광주시패밀리랜드 카라반캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2739385'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2728916', '승촌보오토캠핑장', '광주 남구', '남구', '체험·스포츠', null, '전남광주통합특별시 남구 승촌보길 90 (승촌동)', null, 35.0660063695, 126.7611512602, null, null, 'http://tong.visitkorea.or.kr/cms/resource/87/2728987_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '승촌보오토캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2728916'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2661532', '시민의 숲 야영장', '광주 북구', '북구', '체험·스포츠', null, '전남광주통합특별시 북구 추암로 190 (월출동)', null, 35.2327865214, 126.8662155837, null, null, 'http://tong.visitkorea.or.kr/cms/resource/31/2661531_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#숲','#체험','#스포츠']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '시민의 숲 야영장 #숲 #체험 #스포츠', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2661532'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1622267', '염주실내수영장', '광주 서구', '서구', '체험·스포츠', null, '전남광주통합특별시 서구 금화로 278 (풍암동)', null, 35.1366531569, 126.879180734, null, null, 'http://tong.visitkorea.or.kr/cms/resource/14/1587814_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '염주실내수영장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1622267'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2763536', '주노글램핑 인 광주시', '광주 서구', '서구', '체험·스포츠', null, '전남광주통합특별시 서구 상무자유로 29-1 (치평동)', null, 35.1535227638, 126.8370562598, null, null, 'http://tong.visitkorea.or.kr/cms/resource/20/2763420_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '주노글램핑 인 광주시 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2763536'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2718673', '휴파크 광산점', '광주 광산구', '광산구', '체험·스포츠', null, '전남광주통합특별시 광산구 탑동길 345 (지산동)', null, 35.1953634646, 126.7303952125, null, null, 'http://tong.visitkorea.or.kr/cms/resource/00/3033500_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#체험','#스포츠']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '휴파크 광산점 #산 #체험 #스포츠', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2718673'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621202', '무안요(광주)', '광주 동구', '동구', '쇼핑·시장', null, '전남광주통합특별시 동구 중앙로196번길 15-6 (궁동)', null, 35.1498495384, 126.9176242274, null, null, 'http://tong.visitkorea.or.kr/cms/resource/65/1587565_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '무안요(광주) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621202'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2783789', '비아5일시장', '광주 광산구', '광산구', '쇼핑·시장', null, '전남광주통합특별시 광산구 비아중앙로 26-1 (비아동)', null, 35.2213982286, 126.8252806044, null, null, 'http://tong.visitkorea.or.kr/cms/resource/60/3528360_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '비아5일시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2783789'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2765207', '상무화훼단지', '광주 서구', '서구', '쇼핑·시장', null, '전남광주통합특별시 서구 마륵벽진길 23 (마륵동)', null, 35.1428074499, 126.8455168899, null, null, 'http://tong.visitkorea.or.kr/cms/resource/27/3528427_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '상무화훼단지 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2765207'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2783783', '서부농수산물도매시장', '광주 서구', '서구', '쇼핑·시장', null, '전남광주통합특별시 서구 매월2로 16 (매월동)', null, 35.1161856771, 126.8586608367, null, null, 'http://tong.visitkorea.or.kr/cms/resource/21/3528421_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#산','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '서부농수산물도매시장 #산 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2783783'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2783776', '월곡시장', '광주 광산구', '광산구', '쇼핑·시장', null, '전남광주통합특별시 광산구 사암로 300 (월곡동)', null, 35.1713258469, 126.8096610164, null, null, 'http://tong.visitkorea.or.kr/cms/resource/69/3551369_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '월곡시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2783776'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127480', '가거도', '광주', null, '관광지', null, '전남광주통합특별시 신안군 흑산면 가거도길 38-2', null, 34.0520609879, 125.1263860145, '061-246-5400', null, 'http://tong.visitkorea.or.kr/cms/resource/28/3572128_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가거도', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127480'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126273', '가계해수욕장', '광주', null, '관광지', null, '전남광주통합특별시 진도군 고군면 신비의바닷길 47 (고군면)', null, 34.4354594945, 126.3547412438, '061-540-6605', null, 'http://tong.visitkorea.or.kr/cms/resource/36/3079736_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가계해수욕장 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126273'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127423', '가마골계곡', '광주', null, '관광지', null, '전남광주통합특별시 담양군 용면 용소길 261', null, 35.445187367, 127.0227046757, '061-380-3492', null, 'http://tong.visitkorea.or.kr/cms/resource/35/3027135_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가마골계곡 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127423'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126289', '가마미해수욕장', '광주', null, '관광지', null, '전남광주통합특별시 영광군 홍농읍 가마미로 355', null, 35.399729392, 126.4090769892, '061-356-1020', null, 'http://tong.visitkorea.or.kr/cms/resource/63/3018763_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가마미해수욕장 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126289'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2615324', '가사동백숲해변', '광주', null, '관광지', null, '전남광주통합특별시 완도군 약산면 해동리', null, 34.3698373475, 126.9277952875, '061-550-6401', null, 'http://tong.visitkorea.or.kr/cms/resource/77/3591577_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#숲','#바다','#주차가능']::text[],
  '{"nature": 1.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가사동백숲해변 #숲 #바다 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2615324'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1916695', '가사해수욕장', '광주', null, '관광지', null, '전남광주통합특별시 완도군 약산면', null, 34.370487281, 126.9281702396, null, null, 'http://tong.visitkorea.or.kr/cms/resource/24/3382824_image2_1.JPG', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가사해수욕장', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1916695'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1957336', '가산서원', '광주', null, '관광지', null, '전남광주통합특별시 장성군 삼서면 영장로 2015', null, 35.2313226604, 126.6931003984, '061-390-7240', null, 'http://tong.visitkorea.or.kr/cms/resource/35/3347635_image2_1.JPG', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#전통','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.75, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.75,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가산서원 #산 #전통 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1957336'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2732489', '가야금산조테마공원', '광주', null, '관광지', null, '전남광주통합특별시 영암군 영암읍 기찬랜드로 19-10', null, 34.7919693222, 126.6856118867, '061-471-8500', null, 'http://tong.visitkorea.or.kr/cms/resource/96/3382096_image2_1.JPG', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '가야금산조테마공원 #산 #공원', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2732489'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3013529', '가야정원', '광주', null, '관광지', null, '전남광주통합특별시 순천시 해룡면 농주리 230-10', null, 34.861908939, 127.5222504674, '0507-1417-2202', null, null, 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#정원','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '가야정원 #정원 #공원', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3013529'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129024', '갈두마을(땅끝마을)', '광주', null, '관광지', null, '전남광주통합특별시 해남군 송지면 땅끝마을길 82', null, 34.2998052878, 126.5285847288, '송지면 061-531-3162', null, 'http://tong.visitkorea.or.kr/cms/resource/36/3061236_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#느린여행','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '갈두마을(땅끝마을) #느린여행 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129024'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1957338', '강덕사', '광주', null, '관광지', null, '전남광주통합특별시 강진군 군동면 호라길 199-39', null, 34.654422834, 126.802682706, '강진군 문화관광과 061-430-3310', null, 'http://tong.visitkorea.or.kr/cms/resource/29/3381529_image2_1.JPG', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강덕사 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1957338'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1349796', '강진 백사어촌체험마을', '광주', null, '관광지', null, '전남광주통합특별시 강진군 대구면 청자해안길 253', null, 34.4928741381, 126.7939012802, '061-432-0641', null, null, 90, false, false, true, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#체험','#느린여행','#아이동반','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.0,0.75,0.0]'::extensions.vector(8),
  '강진 백사어촌체험마을 #체험 #느린여행 #아이동반 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1349796'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2515265', '강진 백운동별서정원', '광주', null, '관광지', null, '전남광주통합특별시 강진군 성전면 월하안운길 100-63', null, 34.7420918349, 126.6998840655, '061-430-3312', null, 'http://tong.visitkorea.or.kr/cms/resource/77/3537777_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#정원','#공원','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '강진 백운동별서정원 #정원 #공원 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2515265'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '128952', '강진 병영마을 옛 담장', '광주', null, '관광지', null, '전남광주통합특별시 강진군 병영면 지로리 291-1번지 등', null, 34.7148913023, 126.8182354193, '강진군 문화유적팀 061-430-3363', null, 'http://tong.visitkorea.or.kr/cms/resource/46/3537746_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#느린여행']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '강진 병영마을 옛 담장 #느린여행', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '128952'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129693', '강진 삼인리 비자나무', '광주', null, '관광지', null, '전남광주통합특별시 강진군 병영면 동삼인길 28-10', null, 34.7148441009, 126.8191381191, '061-430-3363', null, 'http://tong.visitkorea.or.kr/cms/resource/00/3538100_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진 삼인리 비자나무', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129693'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1350167', '강진 서중어촌체험마을', '광주', null, '관광지', null, '전남광주통합특별시 강진군 마량면 까막섬로 75-7', null, 34.4536620901, 126.8076232442, '061-433-8525', null, null, 90, false, false, true, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#체험','#느린여행','#아이동반','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.0,0.75,0.0]'::extensions.vector(8),
  '강진 서중어촌체험마을 #체험 #느린여행 #아이동반 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1350167'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2515789', '강진 오감통', '광주', null, '관광지', null, '전남광주통합특별시 강진군 강진읍 오감길 2 2동', null, 34.6391324006, 126.773588414, '음악창작소 061-433-3636', null, 'http://tong.visitkorea.or.kr/cms/resource/70/3381570_image2_1.JPG', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진 오감통', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2515789'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '128151', '강진다원', '광주', null, '관광지', null, '전남광주통합특별시 강진군 성전면 백운로 93-25', null, 34.7409031836, 126.7061613195, '061-432-5500', null, 'http://tong.visitkorea.or.kr/cms/resource/07/3558407_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진다원 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '128151'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129692', '강진마도진만호성지', '광주', null, '관광지', null, '전남광주통합특별시 강진군 마량면 마량리 988-5번지 일대', null, 34.4533428163, 126.8157780917, '061-430-3363', null, 'http://tong.visitkorea.or.kr/cms/resource/71/3537771_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진마도진만호성지', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129692'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126645', '강진만', '광주', null, '관광지', null, '전남광주통합특별시 강진군 신전면 벌정리', null, 34.595223382, 126.770150892, '061-430-5386', null, 'http://tong.visitkorea.or.kr/cms/resource/79/3538079_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진만', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126645'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127111', '강진영랑생가', '광주', null, '관광지', null, '전남광주통합특별시 강진군 강진읍 영랑생가길 15', null, 34.6421930307, 126.7652918469, '061-430-3377', null, 'http://tong.visitkorea.or.kr/cms/resource/12/3558412_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진영랑생가', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127111'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1624164', '강진향교', '광주', null, '관광지', null, '전남광주통합특별시 강진군 강진읍 향교로 140', null, 34.6503616614, 126.7714883256, '강진군 문화관광과 061-430-3310', null, 'http://tong.visitkorea.or.kr/cms/resource/22/3381522_image2_1.JPG', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#전통','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진향교 #전통 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1624164'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2638437', '개구리생태공원', '광주', null, '관광지', null, '전남광주통합특별시 담양군 담양읍 담양88로 428', null, 35.3235008359, 127.0047510306, '061-380-3086', null, 'http://tong.visitkorea.or.kr/cms/resource/58/3571558_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#자연','#공원','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '개구리생태공원 #자연 #공원 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2638437'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127147', '개천사', '광주', null, '관광지', null, '전남광주통합특별시 화순군 춘양면 변천길 389', null, 34.9044716088, 126.9153916468, '061-373-1301', null, 'http://tong.visitkorea.or.kr/cms/resource/99/3583399_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '개천사 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127147'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2032450', '거금생태숲', '광주', null, '관광지', null, '전남광주통합특별시 고흥군 금산면 거금일주로 1877', null, 34.4538883157, 127.2156652719, '061-830-6988', null, 'http://tong.visitkorea.or.kr/cms/resource/04/3375904_image2_1.JPG', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#자연','#숲','#주차가능']::text[],
  '{"nature": 1.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '거금생태숲 #자연 #숲 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2032450'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126283', '거문도', '광주', null, '관광지', null, '전남광주통합특별시 여수시 삼산면 거문길 103', null, 34.0274901869, 127.308948058, '061-659-1261', null, 'http://tong.visitkorea.or.kr/cms/resource/49/3027249_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '거문도 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126283'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129151', '거문도 등대', '광주', null, '관광지', null, '전남광주통합특별시 여수시 거문도등대길 299 항로표지관리소', null, 34.0084314114, 127.3219612742, '061-666-0906', null, 'http://tong.visitkorea.or.kr/cms/resource/71/3548971_image2_1.JPG', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '거문도 등대', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129151'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '988129', '거문도 신선바위', '광주', null, '관광지', null, '전남광주통합특별시 여수시 삼산면 거문리', null, 34.0123585069, 127.3072485707, '032-930-0312', null, 'http://tong.visitkorea.or.kr/cms/resource/38/3549238_image2_1.JPG', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '거문도 신선바위', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '988129'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2723663', '거문도해수욕장', '광주', null, '관광지', null, '전남광주통합특별시 여수시 삼산면 덕촌리 322', null, 34.0199742783, 127.3043097534, '061-659-1257', null, 'http://tong.visitkorea.or.kr/cms/resource/03/3549303_image2_1.JPG', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array[]::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '거문도해수욕장', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2723663'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2752372', '거북선공원', '광주', null, '관광지', null, '전남광주통합특별시 여수시 거북선공원2길 10', null, 34.7606283453, 127.6667403776, null, null, 'http://tong.visitkorea.or.kr/cms/resource/95/3372895_image2_1.JPG', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공원']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '거북선공원 #공원', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2752372'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1623643', '강진군도서관', '광주', null, '문화·예술', null, '전남광주통합특별시 강진군 강진읍 남문길 10', null, 34.640490518, 126.7697553845, null, null, 'http://tong.visitkorea.or.kr/cms/resource/58/3589458_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진군도서관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1623643'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1778079', '강진아트홀', '광주', null, '문화·예술', null, '전남광주통합특별시 강진군 강진읍 영랑로1길 9', null, 34.6382074538, 126.7705248168, null, null, 'http://tong.visitkorea.or.kr/cms/resource/39/3589439_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '강진아트홀 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1778079'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2612901', '고산 윤선도 박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 해남군 해남읍 녹우당길 130', null, 34.5502315216, 126.620851215, null, null, 'http://tong.visitkorea.or.kr/cms/resource/51/3383051_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '고산 윤선도 박물관 #산 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2612901'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129996', '고흥문화원', '광주', null, '문화·예술', null, '전남광주통합특별시 고흥군 고흥읍 고흥로 1892-67', null, 34.6124080728, 127.2975208647, null, null, 'http://tong.visitkorea.or.kr/cms/resource/66/3375866_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '고흥문화원 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129996'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2605786', '고흥분청문화박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 고흥군 두원면 분청문화박물관길 99', null, 34.6278595774, 127.3244875637, null, null, 'http://tong.visitkorea.or.kr/cms/resource/70/3344670_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '고흥분청문화박물관 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2605786'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3351638', '곡성기차마을 생태학습관', '광주', null, '문화·예술', null, '전남광주통합특별시 곡성군 오곡면 기차마을로 252-16', null, 35.2812191216, 127.3065559809, null, null, 'http://tong.visitkorea.or.kr/cms/resource/68/3385368_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#자연','#예술','#교육','#느린여행','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.75,0.0,0.75,0.0,0.75,0.0]'::extensions.vector(8),
  '곡성기차마을 생태학습관 #자연 #예술 #교육 #느린여행 #실내 #비오는날', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3351638'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1054221', '곡성레저문화센터', '광주', null, '문화·예술', null, '전남광주통합특별시 곡성군 곡성읍 곡성로 855 (곡성읍)', null, 35.2801301942, 127.2971596157, null, null, 'http://tong.visitkorea.or.kr/cms/resource/43/3026943_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#레저','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.75,0.0,0.0,0.0]'::extensions.vector(8),
  '곡성레저문화센터 #예술 #레저 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1054221'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129991', '곡성문화원', '광주', null, '문화·예술', null, '전남광주통합특별시 곡성군 곡성읍 곡성로 855', null, 35.2804829367, 127.2974151402, null, null, 'http://tong.visitkorea.or.kr/cms/resource/23/3587223_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '곡성문화원 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129991'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2733394', '광양 역사문화관', '광주', null, '문화·예술', null, '전남광주통합특별시 광양시 광양읍 매천로 829', null, 34.9758111359, 127.5860086407, null, null, null, 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#역사','#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광양 역사문화관 #역사 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2733394'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2782651', '광양매화문화관', '광주', null, '문화·예술', null, '전남광주통합특별시 광양시 다압면 지막1길 21', null, 35.0767465293, 127.7181222254, null, null, 'http://tong.visitkorea.or.kr/cms/resource/04/3345104_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광양매화문화관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2782651'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129987', '광양문화원', '광주', null, '문화·예술', null, '전남광주통합특별시 광양시 광양읍 매천로 829', null, 34.975866687, 127.5861308504, null, null, 'http://tong.visitkorea.or.kr/cms/resource/45/2515545_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광양문화원 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129987'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130205', '광양시문화예술회관', '광주', null, '문화·예술', null, '전남광주통합특별시 광양시 광양읍 향교길 9-30', null, 34.9799634742, 127.5875972838, null, null, 'http://tong.visitkorea.or.kr/cms/resource/90/3587190_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광양시문화예술회관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130205'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2732668', '광양예술창고', '광주', null, '문화·예술', null, '전남광주통합특별시 광양시 광양읍 순광로 664', null, 34.9682620238, 127.588325297, null, null, 'http://tong.visitkorea.or.kr/cms/resource/00/3552400_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광양예술창고 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2732668'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130559', '구례향제줄풍류전수관', '광주', null, '문화·예술', null, '전남광주통합특별시 구례군 구례읍 봉성산길 16', null, 35.2084078164, 127.4627690718, null, null, 'http://tong.visitkorea.or.kr/cms/resource/67/3587367_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '구례향제줄풍류전수관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130559'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129896', '국립해양유산연구소', '광주', null, '문화·예술', null, '전남광주통합특별시 목포시 남농로 136', null, 34.791834429, 126.421687956, null, null, 'http://tong.visitkorea.or.kr/cms/resource/10/3533710_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#산','#바다','#예술','#실내','#비오는날']::text[],
  '{"nature": 1.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[1.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '국립해양유산연구소 #산 #바다 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129896'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '705052', '귀족호도박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 장흥군 장흥읍 남부관광로 56-90', null, 34.6750057964, 126.919096969, null, null, 'http://tong.visitkorea.or.kr/cms/resource/74/693174_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '귀족호도박물관 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '705052'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3090707', '규남박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 화순군 이서면 백아로 3109', null, 35.1101984314, 127.0799247775, null, null, 'http://tong.visitkorea.or.kr/cms/resource/92/3090692_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '규남박물관 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3090707'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1994953', '김대중 노벨평화상 기념관', '광주', null, '문화·예술', null, '전남광주통합특별시 목포시 삼학로92번길 68', null, 34.7828349612, 126.3922741039, null, null, 'http://tong.visitkorea.or.kr/cms/resource/73/3534373_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#역사','#박물관','#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 1.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,1.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '김대중 노벨평화상 기념관 #역사 #박물관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1994953'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129986', '나주문화원', '광주', null, '문화·예술', null, '전남광주통합특별시 나주시 시청길 22 (송월동)', null, 35.0159556319, 126.711576325, null, null, 'http://tong.visitkorea.or.kr/cms/resource/88/3590188_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '나주문화원 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129986'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130913', '남포미술관', '광주', null, '문화·예술', null, '전남광주통합특별시 고흥군 영남면 팔영로 1081', null, 34.6037034299, 127.4572293239, null, null, 'http://tong.visitkorea.or.kr/cms/resource/24/3552724_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남포미술관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130913'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2732508', '낭산김준연선생기념관', '광주', null, '문화·예술', null, '전남광주통합특별시 영암군 영암읍 영암로 1498', null, 34.7924499783, 126.6949360532, null, null, 'http://tong.visitkorea.or.kr/cms/resource/09/3379609_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#역사','#박물관','#예술','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 1.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,1.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '낭산김준연선생기념관 #산 #역사 #박물관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2732508'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2650448', '농부네 텃밭도서관', '광주', null, '문화·예술', null, '전남광주통합특별시 광양시 진상면 청도길 19', null, 35.0144231169, 127.7259370363, null, null, 'http://tong.visitkorea.or.kr/cms/resource/78/3587178_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '농부네 텃밭도서관 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2650448'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2371605', '다산박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 강진군 도암면 다산로 766-20', null, 34.5764473762, 126.7499697869, null, null, 'http://tong.visitkorea.or.kr/cms/resource/63/3381563_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '다산박물관 #산 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2371605'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2784213', '담양곤충박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 담양군 담양읍 담양88로 428', null, 35.3224481934, 127.0057009732, null, null, null, 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '담양곤충박물관 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2784213'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129988', '담양문화원', '광주', null, '문화·예술', null, '전남광주통합특별시 담양군 담양읍 죽향문화로 35', null, 35.309513061, 126.9772427091, null, null, 'http://tong.visitkorea.or.kr/cms/resource/39/3378139_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '담양문화원 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129988'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2553930', '담양우표박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 담양군 대전면 대치9길 16', null, 35.2766069614, 126.8895957452, null, null, 'http://tong.visitkorea.or.kr/cms/resource/46/3378146_image2_1.JPG', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '담양우표박물관 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2553930'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1186650', '대나무 건강나라', '광주', null, '문화·예술', null, '전남광주통합특별시 담양군 금성면 원율길 12', null, 35.3525118943, 127.0312368377, null, null, 'http://tong.visitkorea.or.kr/cms/resource/36/3571436_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#숲','#예술','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '대나무 건강나라 #숲 #예술 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1186650'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130582', '도화헌미술관', '광주', null, '문화·예술', null, '전남광주통합특별시 고흥군 도화면 땅끝로 860-5', null, 34.4490462833, 127.3266001359, null, null, 'http://tong.visitkorea.or.kr/cms/resource/45/3552745_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '도화헌미술관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130582'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '130563', '땅끝해양자연사박물관', '광주', null, '문화·예술', null, '전남광주통합특별시 해남군 송지면 땅끝마을길 89', null, 34.3013245791, 126.5296623753, null, null, 'http://tong.visitkorea.or.kr/cms/resource/86/3564386_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#자연','#바다','#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 1.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[1.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '땅끝해양자연사박물관 #자연 #바다 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.47,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '130563'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2708333', '명량대첩해전사 기념전시관', '광주', null, '문화·예술', null, '전남광주통합특별시 해남군 문내면 관광레저로 12 전라우수영명량대첩공원', null, 34.5733544172, 126.3108224049, null, null, 'http://tong.visitkorea.or.kr/cms/resource/60/3081760_image2_1.jpg', 90, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#박물관','#예술','#전시','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '명량대첩해전사 기념전시관 #박물관 #예술 #전시 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2708333'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3012429', '남도영화제 시즌2 광양', '광주', null, '축제·공연', null, '전남광주통합특별시 광양시 중마중앙로 99 (중동)', null, 34.9390810874, 127.6976497858, '061-727-2272', null, 'http://tong.visitkorea.or.kr/cms/resource/59/3536359_image2_1.jpg', 120, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공연','#참여형','#축제']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 1.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.75,0.0,0.0,1.0]'::extensions.vector(8),
  '남도영화제 시즌2 광양 #공연 #참여형 #축제', '1.0.0',
  'import', 0.47,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3012429'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3506515', '담양 다미담주 페스티벌 쓰담쓰담 야시장', '광주', null, '축제·공연', null, '전남광주통합특별시 담양군 담양읍 담주4길 24-46', null, 35.3223061188, 126.980808736, '010-9903-0209', null, 'http://tong.visitkorea.or.kr/cms/resource/17/3559417_image2_1.jpg', 120, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공연','#시장','#참여형','#축제']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.75, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 1.0}'::jsonb,
  '[0.0,0.0,0.75,0.75,0.75,0.0,0.0,1.0]'::extensions.vector(8),
  '담양 다미담주 페스티벌 쓰담쓰담 야시장 #공연 #시장 #참여형 #축제', '1.0.0',
  'import', 0.5,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3506515'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3547386', '한국전력과 함께하는 2025 희망·사랑 나눔 콘서트', '광주', null, '축제·공연', null, '전남광주통합특별시 장성군 장성읍 문화로 110', null, 35.3016853956, 126.7675670383, '070-4242-0838', null, 'http://tong.visitkorea.or.kr/cms/resource/85/3547385_image2_1.jpg', 120, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공연','#참여형','#축제']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 1.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.75,0.0,0.0,1.0]'::extensions.vector(8),
  '한국전력과 함께하는 2025 희망·사랑 나눔 콘서트 #공연 #참여형 #축제', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3547386'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2737313', '2025섬진강국제실험예술제(SIEAF)', '광주', null, '축제·공연', null, '전남광주통합특별시 곡성군 죽곡면 섬진강로 1012', null, 35.1919998595, 127.3775297835, '010-2344-5004', null, 'http://tong.visitkorea.or.kr/cms/resource/61/3534861_image2_1.jpg', 120, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#공연','#참여형','#축제']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.0, "festival": 1.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.75,0.0,0.0,1.0]'::extensions.vector(8),
  '2025섬진강국제실험예술제(SIEAF) #예술 #공연 #참여형 #축제', '1.0.0',
  'import', 0.47,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2737313'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2737354', '가마골계곡 핫캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 용면 용소길 131', null, 35.4362301902, 127.0310319445, null, null, 'http://tong.visitkorea.or.kr/cms/resource/07/2737707_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '가마골계곡 핫캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2737354'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2740970', '가우도카라반펜션', '광주', null, '체험·스포츠', null, '전남광주통합특별시 강진군 대구면 저두바닷길 3', null, 34.5278201918, 126.7920644864, null, null, 'http://tong.visitkorea.or.kr/cms/resource/73/2741273_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '가우도카라반펜션 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2740970'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2752162', '거금해양낚시공원', '광주', null, '체험·스포츠', null, '전남광주통합특별시 고흥군 금산면 신촌내동길 18-132', null, 34.4694652638, 127.1045912779, null, null, 'http://tong.visitkorea.or.kr/cms/resource/92/2752192_image2_1.jpeg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#바다','#체험','#스포츠','#공원']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.75,0.75,0.75,0.0]'::extensions.vector(8),
  '거금해양낚시공원 #바다 #체험 #스포츠 #공원', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2752162'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2554912', '곡성기차마을 패러글라이딩', '광주', null, '체험·스포츠', null, '전남광주통합특별시 곡성군 오곡면 덕양서원길 42', null, 35.263612844, 127.3104671975, null, null, null, 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#체험','#스포츠','#자전거','#느린여행']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 1.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,1.0,0.75,0.0]'::extensions.vector(8),
  '곡성기차마을 패러글라이딩 #체험 #스포츠 #자전거 #느린여행', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2554912'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2739374', '국립천관산자연휴양림캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 장흥군 관산읍 칠관로 842-1150', null, 34.5453505689, 126.8996796143, null, null, 'http://tong.visitkorea.or.kr/cms/resource/45/2739945_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#자연','#산','#체험','#스포츠']::text[],
  '{"nature": 1.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[1.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '국립천관산자연휴양림캠핑장 #자연 #산 #체험 #스포츠', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2739374'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2727342', '굴전여가캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 여수시 돌산읍 돌산로 3017-15', null, 34.6924349035, 127.7650168484, null, null, 'http://tong.visitkorea.or.kr/cms/resource/36/2727636_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '굴전여가캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2727342'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2737326', '글램킹 글램핑', '광주', null, '체험·스포츠', null, '전남광주통합특별시 함평군 함평읍 장년길 40', null, 35.0942317798, 126.4768840574, null, null, 'http://tong.visitkorea.or.kr/cms/resource/73/3562073_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '글램킹 글램핑 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2737326'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2483594', '금오도 비렁길', '광주', null, '체험·스포츠', null, '전남광주통합특별시 여수시 남면 용머리길', null, 34.5371985513, 127.7111643607, null, null, 'http://tong.visitkorea.or.kr/cms/resource/62/3015562_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '금오도 비렁길 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2483594'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2743206', '금오도보금자리펜션', '광주', null, '체험·스포츠', null, '전남광주통합특별시 여수시 남면 금오로 1139', null, 34.5047839401, 127.7815868132, null, null, 'http://tong.visitkorea.or.kr/cms/resource/13/2743513_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '금오도보금자리펜션 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2743206'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2909143', '낭도야영장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 여수시 화정면 여산길 150', null, 34.6005580012, 127.541547029, null, null, 'http://tong.visitkorea.or.kr/cms/resource/33/2909133_image2_1.JPG', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '낭도야영장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2909143'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2481694', '느랭이골 글램핑', '광주', null, '체험·스포츠', null, '전남광주통합특별시 광양시 다압면 토끼재길 119-32', null, 35.0600705098, 127.7114232446, null, null, 'http://tong.visitkorea.or.kr/cms/resource/22/2844622_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '느랭이골 글램핑 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2481694'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2734187', '달빛담은캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 보성군 벌교읍 장암길 284-37', null, 34.8028109044, 127.4122477195, null, null, 'http://tong.visitkorea.or.kr/cms/resource/39/3069039_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠','#야경']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.75}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.75]'::extensions.vector(8),
  '달빛담은캠핑장 #체험 #스포츠 #야경', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2734187'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2013935', '담양 용마루길', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 용면 추월산로 735', null, 35.3875211686, 126.9930309983, null, null, 'http://tong.visitkorea.or.kr/cms/resource/28/3582028_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '담양 용마루길 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2013935'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2729195', '담양금성오토캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 금성면 불로리길 135-88', null, 35.3658521341, 127.0361027336, null, null, 'http://tong.visitkorea.or.kr/cms/resource/90/2729490_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '담양금성오토캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2729195'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '715953', '담양레이나 CC', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 담양읍 깊은실길 169 (담양읍)', null, 35.3100775539, 127.0164836657, null, null, null, 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '담양레이나 CC #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '715953'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2726659', '담양힐링파크', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 봉산면 탄금길 9-26', null, 35.2714781967, 126.9609673343, null, null, 'http://tong.visitkorea.or.kr/cms/resource/99/2726999_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠','#힐링']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.75,0.0]'::extensions.vector(8),
  '담양힐링파크 #체험 #스포츠 #힐링', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2726659'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2747474', '대덕힐링캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 영광군 법성면 대덕길2길 105', null, 35.3499357301, 126.4505884209, null, null, 'http://tong.visitkorea.or.kr/cms/resource/51/2748151_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠','#힐링']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.75,0.0]'::extensions.vector(8),
  '대덕힐링캠핑장 #체험 #스포츠 #힐링', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2747474'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2732467', '더스타오토캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 여수시 돌산읍 상하동길 268', null, 34.7186544685, 127.7809842316, null, null, null, 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '더스타오토캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2732467'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2748025', '돌풀마루', '광주', null, '체험·스포츠', null, '전남광주통합특별시 구례군 산동면 산수유꽃길로 117', null, 35.3286195113, 127.4777618694, null, null, 'http://tong.visitkorea.or.kr/cms/resource/96/2747596_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '돌풀마루 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2748025'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2729340', '드림캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 보성군 득량면 공룡로 751', null, 34.7030766173, 127.1883587419, null, null, 'http://tong.visitkorea.or.kr/cms/resource/89/2729889_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '드림캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2729340'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2729344', '들소리캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 영암군 신북면 들소리로 384-14', null, 34.9285205024, 126.6789452471, null, null, 'http://tong.visitkorea.or.kr/cms/resource/72/2729872_image2_1.JPG', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '들소리캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2729344'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2747041', '들음카라반펜션', '광주', null, '체험·스포츠', null, '전남광주통합특별시 장성군 북하면 가인길 59-9', null, 35.4350249176, 126.8766623316, null, null, 'http://tong.visitkorea.or.kr/cms/resource/81/2746981_image2_1.JPG', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '들음카라반펜션 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2747041'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2745698', '땅끝오토캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 해남군 송지면 갈산길 25-5', null, 34.3097651449, 126.5200158003, null, null, 'http://tong.visitkorea.or.kr/cms/resource/30/2746430_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '땅끝오토캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2745698'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2745702', '라온 캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 용면 금성산성길 548', null, 35.3761391716, 126.9958338161, null, null, 'http://tong.visitkorea.or.kr/cms/resource/13/2746413_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '라온 캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2745702'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2741004', '마루한캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 금성면 상신기길 108', null, 35.3150721527, 127.0586159215, null, null, 'http://tong.visitkorea.or.kr/cms/resource/90/2741290_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '마루한캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2741004'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2674994', '만연산 오감연결길', '광주', null, '체험·스포츠', null, '전남광주통합특별시 화순군 화순읍 진각로 276-33', null, 35.0772895397, 126.9919694778, null, null, 'http://tong.visitkorea.or.kr/cms/resource/88/2674988_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#체험','#스포츠']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '만연산 오감연결길 #산 #체험 #스포츠', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2674994'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2727280', '메타파크', '광주', null, '체험·스포츠', null, '전남광주통합특별시 담양군 금성면 금성산성길 260', null, 35.3708124358, 127.0215594513, null, null, 'http://tong.visitkorea.or.kr/cms/resource/66/2727666_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '메타파크 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2727280'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2739392', '목사골야영장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 곡성군 목사동면 용봉길 91-109', null, 35.1060528847, 127.3131459836, null, null, 'http://tong.visitkorea.or.kr/cms/resource/40/2739940_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '목사골야영장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2739392'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2728208', '몽돌바다캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 신안군 암태면 진작지길 139-63', null, 34.8739344235, 126.1371972607, null, null, 'http://tong.visitkorea.or.kr/cms/resource/38/2728338_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#바다','#체험','#스포츠']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '몽돌바다캠핑장 #바다 #체험 #스포츠', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2728208'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2747447', '무안황토갯벌랜드 캠핑장', '광주', null, '체험·스포츠', null, '전남광주통합특별시 무안군 해제면 황토갯벌길 54-20', null, 35.098181751, 126.3339299684, null, null, 'http://tong.visitkorea.or.kr/cms/resource/54/2747754_image2_1.jpg', 150, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#체험','#스포츠']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.75,0.0,0.0]'::extensions.vector(8),
  '무안황토갯벌랜드 캠핑장 #체험 #스포츠', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2747447'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2435007', '곡성 기차당 뚝방마켓', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 곡성군 곡성읍 곡성로 898', null, 35.2814328952, 127.3012647759, null, null, null, 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#시장','#마켓','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.75}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.75]'::extensions.vector(8),
  '곡성 기차당 뚝방마켓 #시장 #마켓 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2435007'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1434518', '곡성기차마을전통시장 (3, 8일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 곡성군 곡성읍 곡성로 856', null, 35.2798080307, 127.2984539545, null, null, 'http://tong.visitkorea.or.kr/cms/resource/67/2032567_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#전통','#시장','#느린여행','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.0,0.75,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '곡성기차마을전통시장 (3, 8일) #전통 #시장 #느린여행 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1434518'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132059', '공산장 (1, 6일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 나주시 공산면 공산로 120 (공산면)', null, 34.9429566034, 126.6091093957, null, null, 'http://tong.visitkorea.or.kr/cms/resource/64/1971564_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '공산장 (1, 6일) #산 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132059'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132054', '과역시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 고흥군 과역면 시장안길 15', null, 34.6794572169, 127.3622690801, null, null, 'http://tong.visitkorea.or.kr/cms/resource/15/3518715_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '과역시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132054'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1976858', '광양5일장 (1, 6일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 광양시 광양읍 백운로 3', null, 34.9711478468, 127.5903972633, null, null, 'http://tong.visitkorea.or.kr/cms/resource/08/3050908_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광양5일장 (1, 6일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1976858'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3010413', '김미영 돌산갓김치', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 여수시 돌산읍 향일암로 57', null, 34.5939771211, 127.8026854999, null, null, 'http://tong.visitkorea.or.kr/cms/resource/83/3010383_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#시장','#전통음식','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '김미영 돌산갓김치 #산 #시장 #전통음식 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3010413'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1976875', '나주목사고을시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 나주시 청동길 14 (삼도동)', null, 35.0370340097, 126.7235497464, null, null, 'http://tong.visitkorea.or.kr/cms/resource/84/3548284_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '나주목사고을시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1976875'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2717546', '남도상회', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 광양시 눈소9길 55 (마동)', null, 34.9464750697, 127.7187894096, null, null, 'http://tong.visitkorea.or.kr/cms/resource/36/3548136_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남도상회 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2717546'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2758168', '남악시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 무안군 삼향읍 남악5로52번길 13-7', null, 34.8103692926, 126.4728107716, null, null, 'http://tong.visitkorea.or.kr/cms/resource/61/3535461_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남악시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2758168'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132092', '남창장 (2, 7일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 해남군 북평면 달량진길 52-10', null, 34.4042535393, 126.6270624955, null, null, null, 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남창장 (2, 7일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132092'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132167', '남평장 (1, 6일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 나주시 남평읍 지석로 21', null, 35.0456544424, 126.8405197515, null, null, null, 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남평장 (1, 6일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132167'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132067', '녹차골보성향토시장 (2, 7일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 보성군 보성읍 현충로 42-1', null, 34.7656343875, 127.0772586154, null, null, 'http://tong.visitkorea.or.kr/cms/resource/82/3027182_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '녹차골보성향토시장 (2, 7일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132067'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132093', '능주전통시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 화순군 능주면 학포로 1955', null, 34.990929286, 126.959771698, null, null, 'http://tong.visitkorea.or.kr/cms/resource/64/3536164_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#전통','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '능주전통시장 #전통 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132093'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132061', '대치장 (3, 8일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 담양군 대전면 대치8길 28-12', null, 35.2754209258, 126.8861071953, null, null, 'http://tong.visitkorea.or.kr/cms/resource/45/3582045_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '대치장 (3, 8일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132061'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132070', '덕양시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 여수시 소라면 하세동길 12-2', null, 34.7979985577, 127.6320285789, null, null, 'http://tong.visitkorea.or.kr/cms/resource/99/3580299_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '덕양시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132070'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132073', '독천장(4, 9일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 영암군 미암면 독천1길 19', null, 34.7245388526, 126.5680822175, null, null, 'http://tong.visitkorea.or.kr/cms/resource/40/1971640_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '독천장(4, 9일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132073'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1343107', '동박새꿈정원', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 여수시 오동도로 238-32 오동도 등대', null, 34.7444819002, 127.7676180755, null, null, null, 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#정원','#시장','#공원','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '동박새꿈정원 #정원 #시장 #공원 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1343107'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2752133', '마량 놀토수산시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 강진군 마량면 미항로 164', null, 34.4490600303, 126.8198556151, null, null, 'http://tong.visitkorea.or.kr/cms/resource/80/2752180_image2_1.JPG', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '마량 놀토수산시장 #산 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2752133'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1143723', '목포 동부시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 목포시 산정로 174', null, 34.8041242271, 126.3921097173, null, null, 'http://tong.visitkorea.or.kr/cms/resource/55/3534255_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '목포 동부시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1143723'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1227095', '목포 신중앙시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 목포시 원산중앙로 51', null, 34.8102316343, 126.3775525232, null, null, 'http://tong.visitkorea.or.kr/cms/resource/47/3534247_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '목포 신중앙시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1227095'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1730879', '목포 청호시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 목포시 석현로 28', null, 34.8153651607, 126.4246260181, null, null, 'http://tong.visitkorea.or.kr/cms/resource/03/3060703_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '목포 청호시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1730879'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2765255', '목포농산물도매시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 목포시 영산로 648-23', null, 34.8219505394, 126.4252035854, null, null, 'http://tong.visitkorea.or.kr/cms/resource/62/3534262_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#산','#시장','#특산물','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '목포농산물도매시장 #산 #시장 #특산물 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2765255'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132064', '무안장 (4, 9일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 무안군 무안읍 면성1길 134', null, 34.9865799772, 126.4725176318, null, null, 'http://tong.visitkorea.or.kr/cms/resource/56/1971656_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '무안장 (4, 9일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132064'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2748736', '무안전통시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 무안군 무안읍 성내리 21-13', null, 34.9934958653, 126.4726341196, null, null, 'http://tong.visitkorea.or.kr/cms/resource/46/3582446_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#전통','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.75, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.75,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '무안전통시장 #전통 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2748736'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132069', '서시장 (4, 9일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 여수시 광무동', null, 34.7407955187, 127.7281966158, null, null, 'http://tong.visitkorea.or.kr/cms/resource/67/3580367_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '서시장 (4, 9일) #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132069'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3505810', '순천 웃장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 순천시 북문길 40 (동외동)', null, 34.9586141, 127.4849124008, null, null, null, 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '순천 웃장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3505810'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1343398', '여수 특산품전시판매장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 여수시 어항단지로 205 (봉산동)', null, 34.7307160898, 127.7280468858, null, null, 'http://tong.visitkorea.or.kr/cms/resource/22/3027322_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#전시','#시장','#특산물','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.75, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.75,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '여수 특산품전시판매장 #산 #전시 #시장 #특산물 #실내 #비오는날', '1.0.0',
  'import', 0.45,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1343398'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2783118', '여수수산시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 여수시 여객선터미널길 24 (교동)', null, 34.7381847622, 127.7317935902, null, null, 'http://tong.visitkorea.or.kr/cms/resource/06/2787606_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '여수수산시장 #산 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2783118'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2876922', '영광고추특화시장', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 영광군 영광읍 신남로 100-35', null, 35.2747616412, 126.4941225265, null, null, 'http://tong.visitkorea.or.kr/cms/resource/01/2876901_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#시장','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '영광고추특화시장 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2876922'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132166', '영산포풍물시장(5, 10일)', '광주', null, '쇼핑·시장', null, '전남광주통합특별시 나주시 풍물시장2길 12-14 (이창동)', null, 34.9915055499, 126.7078383684, null, null, 'http://tong.visitkorea.or.kr/cms/resource/36/1972036_image2_1.jpg', 70, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#시장','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '영산포풍물시장(5, 10일) #산 #시장 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132166'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

commit;
