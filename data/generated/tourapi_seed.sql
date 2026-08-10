-- data_pipeline.py가 생성한 오매루트 장소 적재 SQL
-- 검수 후 Supabase SQL Editor에서 실행하세요.
begin;

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2859186', '가배당', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 눌재로 434 1층', null, 35.1164268401, 126.8303772206, null, null, 'http://tong.visitkorea.or.kr/cms/resource/68/2859168_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '가배당 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2859186'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664961', '개마고원', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무대로 1094', null, 35.1525486232, 126.8814718006, null, null, 'http://tong.visitkorea.or.kr/cms/resource/04/2667904_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '개마고원 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664961'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2874038', '갤러리24', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 천변좌로 14', null, 35.1665193235, 126.8847961569, null, null, 'http://tong.visitkorea.or.kr/cms/resource/27/2874027_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#전시','#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '갤러리24 #전시 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2874038'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

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
values ('tourapi', '2664541', '계림동잔치집', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 무등로306번길 6-1 (계림동)', null, 35.1618648223, 126.916087951, null, null, 'http://tong.visitkorea.or.kr/cms/resource/22/3560822_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '계림동잔치집 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664541'
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
values ('tourapi', '2855133', '광후장어', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 임방울대로 503', null, 35.20501664, 126.818934354, null, null, 'http://tong.visitkorea.or.kr/cms/resource/22/2855122_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '광후장어 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855133'
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
values ('tourapi', '2484460', '금강한우전문식육식당', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 천변우하로 373', null, 35.1689075428, 126.8611343006, null, null, 'http://tong.visitkorea.or.kr/cms/resource/33/2484433_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#맛집','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '금강한우전문식육식당 #로컬푸드 #맛집 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2484460'
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
values ('tourapi', '135533', '금다연한정식', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무연하로 72', null, 35.1546367535, 126.8505022648, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#전통음식','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '금다연한정식 #로컬푸드 #전통음식 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '135533'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664557', '금당', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 송풍로17번길 15 (풍암동, 수정빌라)', null, 35.1195881994, 126.8662906332, null, null, 'http://tong.visitkorea.or.kr/cms/resource/61/2664561_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '금당 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664557'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1941044', '금수저은수저', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 신창로166번길 24', null, 35.1982483544, 126.8423102316, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '금수저은수저 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1941044'
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
values ('tourapi', '2664564', '김강심 칼국수', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 회재로 841 (매월동)', null, 35.1193853023, 126.8578441627, null, null, 'http://tong.visitkorea.or.kr/cms/resource/66/2664566_image2_1.JPG', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '김강심 칼국수 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664564'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664580', '꿀단지', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 회재로1186번길 11-1 (주월동)', null, 35.1309540109, 126.8916353311, null, null, 'http://tong.visitkorea.or.kr/cms/resource/85/2664585_image2_1.jpeg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '꿀단지 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664580'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2863187', '나룻배', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 시청서편로8번길 3', null, 35.1597583206, 126.8459497619, null, null, 'http://tong.visitkorea.or.kr/cms/resource/73/2863173_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '나룻배 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2863187'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2891314', '남가정', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 지호로 137-7', null, 35.1497277748, 126.9439080186, null, null, 'http://tong.visitkorea.or.kr/cms/resource/02/2891302_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남가정 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2891314'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2855152', '남쪽마을돌짜장', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 임곡로 523-7 (진곡동)', null, 35.2145428585, 126.7902894297, null, null, 'http://tong.visitkorea.or.kr/cms/resource/37/2855137_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#느린여행','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '남쪽마을돌짜장 #로컬푸드 #느린여행 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855152'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1948682', '남해가든', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 봉선로133번길 23', null, 35.125132749, 126.9096088878, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '남해가든 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1948682'
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
values ('tourapi', '2873397', '농성화로본점', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 군분로 228 (농성동)', null, 35.1512015711, 126.882571737, null, null, 'http://tong.visitkorea.or.kr/cms/resource/84/2873384_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '농성화로본점 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873397'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2863165', '다도해물나라', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 마륵복개로 57', null, 35.144635028, 126.8459195867, null, null, 'http://tong.visitkorea.or.kr/cms/resource/61/2863161_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '다도해물나라 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2863165'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664967', '당산나무집', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 봉선중길 4', null, 35.1298739108, 126.911439163, null, null, 'http://tong.visitkorea.or.kr/cms/resource/69/2664969_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '당산나무집 #산 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664967'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1948657', '대양꼬리곰탕', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 손재로 407', null, 35.2019415783, 126.7946088065, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '대양꼬리곰탕 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1948657'
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
values ('tourapi', '2664993', '두암골설렁탕', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 서방로107번길 88', null, 35.1738497635, 126.9269450241, null, null, 'http://tong.visitkorea.or.kr/cms/resource/97/2664997_image2_1.jpg', 60, true, true, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '두암골설렁탕 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664993'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2858992', '등촌', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 마륵로 23', null, 35.1433766515, 126.8349317011, null, null, 'http://tong.visitkorea.or.kr/cms/resource/83/2858983_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '등촌 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2858992'
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
values ('tourapi', '2664654', '루치아', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 월산로116번길 22-1', null, 35.1485854885, 126.8996369603, null, null, 'http://tong.visitkorea.or.kr/cms/resource/59/2664659_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '루치아 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664654'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2863149', '르시엘블루', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무대로 718', null, 35.1434240005, 126.8427698954, null, null, 'http://tong.visitkorea.or.kr/cms/resource/34/2863134_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '르시엘블루 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2863149'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2665153', '마리오셰프', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 제중로 42 (양림동)', null, 35.138311894, 126.9141887092, null, null, 'http://tong.visitkorea.or.kr/cms/resource/56/2665156_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '마리오셰프 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2665153'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873635', '막동이회관', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 남문로 614', null, 35.1257663872, 126.9319013467, null, null, 'http://tong.visitkorea.or.kr/cms/resource/28/2873628_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '막동이회관 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873635'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664666', '만찬코다리 봉선점', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 봉선중길 2, 1층 (봉선동)', null, 35.1297850288, 126.911250293, null, null, 'http://tong.visitkorea.or.kr/cms/resource/68/2664668_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '만찬코다리 봉선점 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664666'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2837862', '매월농원', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 전평길 66', null, 35.1195545349, 126.8463923933, null, null, 'http://tong.visitkorea.or.kr/cms/resource/27/2837827_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '매월농원 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2837862'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2837876', '맥문동', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 마륵로 24', null, 35.1426739587, 126.8352455795, null, null, 'http://tong.visitkorea.or.kr/cms/resource/68/2837868_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '맥문동 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2837876'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664683', '메타포', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 백서로 69 (양림동)', null, 35.1388090808, 126.9154108107, null, null, 'http://tong.visitkorea.or.kr/cms/resource/85/2664685_image2_1.png', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '메타포 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664683'
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
values ('tourapi', '2837793', '문라이즈531', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 삼소로 352', null, 35.2408773656, 126.871684341, null, null, 'http://tong.visitkorea.or.kr/cms/resource/79/2837779_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '문라이즈531 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2837793'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873789', '미꾸미꾸', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 대천로 143', null, 35.1871287177, 126.9209507758, null, null, 'http://tong.visitkorea.or.kr/cms/resource/81/2873781_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '미꾸미꾸 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873789'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2855179', '바칼', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 신창로138번길 31-5', null, 35.1965207431, 126.840563208, null, null, 'http://tong.visitkorea.or.kr/cms/resource/74/2855174_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '바칼 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855179'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873850', '밤실마을', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 밤실로 163-9', null, 35.161706816, 126.9343613395, null, null, null, 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#느린여행','#야간','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.75}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.75,0.75]'::extensions.vector(8),
  '밤실마을 #로컬푸드 #느린여행 #야간 #실내 #비오는날', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873850'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873868', '백년한우', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 연양로67번길 5', null, 35.2073173202, 126.8746432552, null, null, 'http://tong.visitkorea.or.kr/cms/resource/64/2873864_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '백년한우 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873868'
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
values ('tourapi', '2859006', '버킷문리버', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 삼도로 748 1층,2층', null, 35.1542349454, 126.7402870262, null, null, 'http://tong.visitkorea.or.kr/cms/resource/94/2858994_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '버킷문리버 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2859006'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2863121', '벗초밥', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 풍암순환로 150 (풍암동)', null, 35.1240491037, 126.8838861887, null, null, 'http://tong.visitkorea.or.kr/cms/resource/18/2863118_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '벗초밥 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2863121'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664701', '벽옥', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 군분로 73', null, 35.139658589, 126.8919767497, null, null, 'http://tong.visitkorea.or.kr/cms/resource/05/2664705_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '벽옥 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664701'
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
values ('tourapi', '2855279', '비아꽃게장', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 비아동원촌길 71', null, 35.2215121612, 126.8286386376, null, null, 'http://tong.visitkorea.or.kr/cms/resource/69/2855269_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#정원','#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '비아꽃게장 #정원 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855279'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873678', '빈드럭스', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 지호로124번길 32', null, 35.146975307, 126.943858092, null, null, 'http://tong.visitkorea.or.kr/cms/resource/58/2873658_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '빈드럭스 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873678'
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
values ('tourapi', '2859166', '산수쌈밥 동명점', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 동계로 11', null, 35.1529604109, 126.9242763393, null, null, 'http://tong.visitkorea.or.kr/cms/resource/61/2859161_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '산수쌈밥 동명점 #산 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2859166'
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
values ('tourapi', '2664710', '서석정', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 설죽로404번길 12', null, 35.1953135706, 126.9012578678, null, null, 'http://tong.visitkorea.or.kr/cms/resource/12/2664712_image2_1.png', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '서석정 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664710'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2849243', '서울곱창', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 송정로15번길 71', null, 35.1388209658, 126.7966102045, null, null, 'http://tong.visitkorea.or.kr/cms/resource/41/2849241_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '서울곱창 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2849243'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2863092', '서플라이', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무자유로 32', null, 35.1514452293, 126.8375590448, null, null, 'http://tong.visitkorea.or.kr/cms/resource/86/2863086_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '서플라이 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2863092'
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
values ('tourapi', '2837706', '세컨드원', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 임방울대로 611-25', null, 35.2128797425, 126.8250252842, null, null, 'http://tong.visitkorea.or.kr/cms/resource/97/2837697_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '세컨드원 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2837706'
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
values ('tourapi', '2848962', '솔밭솥밥', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 수완로50번길 44-3 1층', null, 35.1886714682, 126.830978141, null, null, 'http://tong.visitkorea.or.kr/cms/resource/51/2848651_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '솔밭솥밥 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2848962'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2823335', '송정골', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 광산로19번길 20', null, 35.1390986603, 126.7935243593, null, null, 'http://tong.visitkorea.or.kr/cms/resource/26/2823326_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '송정골 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2823335'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '134997', '송정떡갈비 1호점', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 광산로29번길 1', null, 35.1389542543, 126.7948298032, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#전통음식','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '송정떡갈비 1호점 #로컬푸드 #전통음식 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '134997'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '817409', '송학한정식', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무중앙로 101 (치평동)', null, 35.1559754455, 126.8477969146, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#전통음식','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '송학한정식 #로컬푸드 #전통음식 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '817409'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873596', '수완초밥', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 임방울대로 347', null, 35.191162725, 126.8233620865, null, null, 'http://tong.visitkorea.or.kr/cms/resource/85/2873585_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '수완초밥 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873596'
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
values ('tourapi', '2614828', '시무지기 폭포 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/76/3350476_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '시무지기 폭포 (무등산권 국가지질공원) #산 #등산 #공원 #주차가능', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614828'
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
values ('tourapi', '319722', '신광사(광주)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 삼정로66번길 42-10', null, 35.168922767, 126.9402606368, '062-261-1529', null, 'http://tong.visitkorea.or.kr/cms/resource/97/3367697_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '신광사(광주) #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '319722'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614834', '신선대와 억새평전 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '담양군 환경과 061-380-3077', null, 'http://tong.visitkorea.or.kr/cms/resource/30/2614830_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '신선대와 억새평전 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614834'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '250453', '쌍암공원', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 첨단중앙로182번길 23 (쌍암동)', null, 35.2234149822, 126.8439400132, '062-960-8705', null, 'http://tong.visitkorea.or.kr/cms/resource/78/3366478_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '쌍암공원 #공원 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '250453'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126334', '약사암(광주)', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 증심사길160번길 89 (운림동)', null, 35.1223174593, 126.9722478684, '062-222-9844', null, 'http://tong.visitkorea.or.kr/cms/resource/67/3510767_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '약사암(광주) #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126334'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '742356', '양과동정', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 양과동 166-1', null, 35.0866390922, 126.8634139313, '전남광주통합특별시 남구 문화관광과 062-607-2333', null, 'http://tong.visitkorea.or.kr/cms/resource/52/3454552_image2_1.png', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '양과동정', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '742356'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2603494', '양림동 펭귄마을공예거리', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 백서로 92-8 (양림동)', null, 35.1402200475, 126.9162912532, '062-674-5707~8', null, 'http://tong.visitkorea.or.kr/cms/resource/60/3351460_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공방체험','#느린여행','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.75, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.75,0.0,0.75,0.0]'::extensions.vector(8),
  '양림동 펭귄마을공예거리 #공방체험 #느린여행 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2603494'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2848014', '여수회수산', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 풍영로 95', null, 35.1806664883, 126.8114717341, null, null, 'http://tong.visitkorea.or.kr/cms/resource/04/2848004_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '여수회수산 #산 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2848014'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3433396', '연화식당', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 마륵복개로 147 (치평동, 아트빌)', null, 35.147973661, 126.8531022016, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#맛집','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '연화식당 #로컬푸드 #맛집 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3433396'
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
values ('tourapi', '1622537', '영사재', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 명곡길 170-30 (명도동)', null, 35.1946380905, 126.7032198592, '062-940-8225', null, 'http://tong.visitkorea.or.kr/cms/resource/27/3366527_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '영사재 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1622537'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2675030', '영산강 자전거길', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 서창둑길 377', null, 35.1384632138, 126.8287545923, '062-603-5359', null, 'http://tong.visitkorea.or.kr/cms/resource/23/3368223_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#자전거','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.75, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.75,0.0,0.0]'::extensions.vector(8),
  '영산강 자전거길 #산 #자전거 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2675030'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2554189', '영산강문화관', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 승촌보길 90 (승촌동)', null, 35.0659535982, 126.7611568167, '061-335-0866', null, 'http://tong.visitkorea.or.kr/cms/resource/48/3032248_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '영산강문화관 #산 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2554189'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2855289', '옛날에 금잔디', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 도산로9번길 54 옛날에금잔디', null, 35.1274332425, 126.7894361222, null, null, 'http://tong.visitkorea.or.kr/cms/resource/86/2855286_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#피크닉','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.75, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.75,0.0]'::extensions.vector(8),
  '옛날에 금잔디 #로컬푸드 #피크닉 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855289'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1620951', '오남제', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 임곡용동길 166 (신룡동)', null, 35.2150813011, 126.7674081089, '062-940-8225', null, 'http://tong.visitkorea.or.kr/cms/resource/58/3366558_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '오남제', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1620951'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873888', '오얏리 돌솥밥', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 밤실로 178', null, 35.1633677423, 126.9345585026, null, null, 'http://tong.visitkorea.or.kr/cms/resource/82/2873882_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '오얏리 돌솥밥 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873888'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2891330', '온고당', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 개산길 13-11', null, 35.1141245719, 126.8451648589, null, null, 'http://tong.visitkorea.or.kr/cms/resource/21/2891321_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '온고당 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2891330'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621014', '왕동저수지', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 본량동서로 259', null, 35.1950132321, 126.7142160986, '062-960-8507', null, 'http://tong.visitkorea.or.kr/cms/resource/63/3367363_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '왕동저수지', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621014'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2872518', '왕뼈사랑 광천점', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 무진대로 937', null, 35.161922589, 126.8829519905, null, null, 'http://tong.visitkorea.or.kr/cms/resource/03/2872503_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '왕뼈사랑 광천점 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2872518'
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
values ('tourapi', '2650751', '운림동 미술관거리', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 증심사길 9 (운림동)', null, 35.1342185802, 126.953699209, '062-670-7941', null, 'http://tong.visitkorea.or.kr/cms/resource/81/3366781_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#예술','#전시']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 1.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '운림동 미술관거리 #예술 #전시', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2650751'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1955608', '운암서원(광주)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1040', null, 35.1532028131, 126.9693640149, '062-410-8000', null, 'http://tong.visitkorea.or.kr/cms/resource/04/3367204_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '운암서원(광주) #전통 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1955608'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621689', '운천사마애여래좌상', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 금호운천길 85-15 (쌍촌동)', null, 35.1418410394, 126.8542355879, '062-375-0053', null, 'http://tong.visitkorea.or.kr/cms/resource/28/3367228_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '운천사마애여래좌상 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621689'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621652', '운천저수지', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 운천로 165 (쌍촌동) 일대', null, 35.1471654718, 126.8562352777, '광주광역시 서구 공원조성팀 062-360-7990', null, 'http://tong.visitkorea.or.kr/cms/resource/13/3367313_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '운천저수지 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621652'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '346906', '원각사(광주)', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 중앙로 197 (금남로4가)', null, 35.1508243988, 126.915907688, '062-223-3168', null, 'http://tong.visitkorea.or.kr/cms/resource/55/3029155_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '원각사(광주) #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '346906'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126350', '원효사(광주)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1514-35', null, 35.1486258304, 126.9857793462, '062-266-0326', null, 'http://tong.visitkorea.or.kr/cms/resource/44/3028444_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '원효사(광주) #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126350'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '129200', '월계동장고분', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 월계로 155 (월계동)', null, 35.2136021794, 126.8425514931, '전남광주통합특별시 역사민속박물관 062-613-5378', null, 'http://tong.visitkorea.or.kr/cms/resource/99/3528399_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '월계동장고분 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '129200'
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
values ('tourapi', '250450', '월봉서원·빙월당', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 광곡길 133', null, 35.2358674659, 126.7452012233, '광주광역시 광산구청 관광육성과 062-960-8255', null, 'http://tong.visitkorea.or.kr/cms/resource/31/3510731_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '월봉서원·빙월당 #전통 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '250450'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1955614', '유애서원', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 용아로 460 (흑석동)', null, 35.1844548426, 126.8051527542, '062-952-0075', null, 'http://tong.visitkorea.or.kr/cms/resource/10/3576610_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '유애서원 #전통', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1955614'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3510980', '유한회사더담희', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 용두마을길 6 (본촌동)', null, 35.2191965932, 126.8781870875, '010-9885-4928', null, null, 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  '유한회사더담희 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3510980'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614846', '의상봉 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/44/2614844_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '의상봉 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614846'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127060', '이장우가옥', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 양촌길 21', null, 35.1406171882, 126.9141331006, '광주광역시 남구 문화관광과 062-607-2331', null, 'http://tong.visitkorea.or.kr/cms/resource/60/3368360_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '이장우가옥', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127060'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614852', '입석대 (무등산권 국가지질공원)', '광주', null, '관광지', null, '전남광주통합특별시 화순군 이서면 영평리 산96', null, 35.1172379909, 127.0026147583, '무등산공원관리 사무소 062-365-1187', null, 'http://tong.visitkorea.or.kr/cms/resource/47/2614847_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '입석대 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614852'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2665091', '장독대', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 문화전당로 43 3층', null, 35.146355504, 126.9185742309, null, null, 'http://tong.visitkorea.or.kr/cms/resource/94/2665094_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '장독대 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2665091'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614858', '장불재 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '광주광역시푸른도시사업소 지질공원팀 062-613-7851', null, 'http://tong.visitkorea.or.kr/cms/resource/53/2614853_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '장불재 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614858'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873990', '재주당 본점', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 일곡마을로 148 1층', null, 35.2094867943, 126.8909112057, null, null, 'http://tong.visitkorea.or.kr/cms/resource/91/2873891_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '재주당 본점 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873990'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127065', '정엄정려비', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 서서평길 24', null, 35.1408366225, 126.9149969077, '062-607-2332', null, 'http://tong.visitkorea.or.kr/cms/resource/21/3367421_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '정엄정려비', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127065'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '132880', '제일반점', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 구성로 174', null, 35.1515409291, 126.912596852, null, null, 'http://tong.visitkorea.or.kr/cms/resource/80/3029180_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '제일반점 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '132880'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2687877', '조선대학교 장미원', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 조선대4길 2 (서석동)', null, 35.1412534704, 126.9285012591, '062-230-6223', null, 'http://tong.visitkorea.or.kr/cms/resource/40/3368240_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '조선대학교 장미원 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2687877'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1941079', '조선옥', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 효덕로 105', null, 35.096474833, 126.9073209181, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '조선옥 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1941079'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '819814', '종가집 설렁탕', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 시청로20번길 10', null, 35.1501428555, 126.8527799537, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '종가집 설렁탕 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '819814'
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
values ('tourapi', '2614861', '증심사 계곡 안산암질용암', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 증심사길 71 (운림동)', null, 35.1332076931, 126.9602458781, '062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/59/2614859_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '증심사 계곡 안산암질용암 #산', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614861'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126351', '증심사(광주)', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 증심사길 177', null, 35.1287583574, 126.9697618157, '0507-1427-0259', null, 'http://tong.visitkorea.or.kr/cms/resource/68/3368268_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '증심사(광주) #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126351'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2614870', '지공너덜 (무등산권 국가지질공원)', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1441458348, 126.9890013959, '062-613-7853', null, 'http://tong.visitkorea.or.kr/cms/resource/64/2614864_image2_1.bmp', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '지공너덜 (무등산권 국가지질공원) #산 #등산 #공원', '1.0.0',
  'import', 0.42,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2614870'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621151', '지산재', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 지산재길 51', null, 35.0817175985, 126.8736825915, '062-607-2332', null, 'http://tong.visitkorea.or.kr/cms/resource/78/3367778_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '지산재 #산', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621151'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664894', '진스가든', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 서문대로556번길 27 (송하동)', null, 35.1110507717, 126.8957882395, null, null, 'http://tong.visitkorea.or.kr/cms/resource/96/2664896_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '진스가든 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664894'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2665107', '진스통', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 충장로안길 26 (황금동)', null, 35.1476969757, 126.9159716496, null, null, 'http://tong.visitkorea.or.kr/cms/resource/13/2665113_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '진스통 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2665107'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2837812', '차차룸', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 일곡택지로99번길 33', null, 35.2101506109, 126.8910500657, null, null, 'http://tong.visitkorea.or.kr/cms/resource/98/2837798_image2_1.jpg', 60, true, true, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '차차룸 #로컬푸드 #실내 #비오는날', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2837812'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3032325', '창작농성골', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 농성동', null, 35.1532764973, 126.892068068, '광주 서구청 062-360-7114', null, 'http://tong.visitkorea.or.kr/cms/resource/06/3032306_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#공방','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.75, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.75,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '창작농성골 #공방 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3032325'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664916', '채미원', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 동계천로 167-7 1층', null, 35.1495302988, 126.9276344619, null, null, 'http://tong.visitkorea.or.kr/cms/resource/19/2664919_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '채미원 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664916'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2872329', '천지유삼계탕', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 풍금로 67', null, 35.1240014948, 126.8606326901, null, null, 'http://tong.visitkorea.or.kr/cms/resource/09/2872309_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '천지유삼계탕 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2872329'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2859032', '청수민물장어', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 마륵로 27', null, 35.1436682904, 126.8352205572, null, null, 'http://tong.visitkorea.or.kr/cms/resource/20/2859020_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '청수민물장어 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2859032'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '742535', '청풍쉼터', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1550 (금곡동)', null, 35.1619794786, 126.9622283138, '062-613-7845', null, 'http://tong.visitkorea.or.kr/cms/resource/15/3367215_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '청풍쉼터 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '742535'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2855307', '초돈', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 수완로74번길 30-6', null, 35.1912656105, 126.8304586779, null, null, 'http://tong.visitkorea.or.kr/cms/resource/98/2855298_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '초돈 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855307'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2664942', '최다연샤브샤브', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 풍암1로21번길 3-16 1층 (풍암동)', null, 35.1262543181, 126.8784282829, null, null, 'http://tong.visitkorea.or.kr/cms/resource/45/2664945_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '최다연샤브샤브 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2664942'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2855332', '최주원육개장 본점', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 풍영정길 53 강변애', null, 35.1818168472, 126.8404941376, null, null, 'http://tong.visitkorea.or.kr/cms/resource/18/2855318_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '최주원육개장 본점 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855332'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '126385', '충민사', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 무등로 1050', null, 35.1519696177, 126.9692640546, '062-266-0718', null, 'http://tong.visitkorea.or.kr/cms/resource/76/3367576_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '충민사 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '126385'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1330521', '충장로', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 서석로 37 (충장로1가)', null, 35.1465610212, 126.9176493076, '전남광주통합특별시 동구청 일자리경제과 062-608-2713', null, 'http://tong.visitkorea.or.kr/cms/resource/99/3351399_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '충장로 #주차가능', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1330521'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '250447', '취병조형유허비', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 비아안길 19', null, 35.2208120504, 126.8173729858, '전남광주통합특별시 광산구청 문화체육과 062-960-8252', null, 'http://tong.visitkorea.or.kr/cms/resource/03/3528403_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '취병조형유허비', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '250447'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2864821', '친츠', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무누리로 15 2층', null, 35.1443682937, 126.8401006633, null, null, 'http://tong.visitkorea.or.kr/cms/resource/15/2864815_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '친츠 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2864821'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2855353', '칠봉이짬뽕', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 목련로394번길 23-26', null, 35.1849080549, 126.8339696374, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '칠봉이짬뽕 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2855353'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1620851', '칠송정', '광주 광산구', '광산구', '관광지', null, '전남광주통합특별시 광산구 광곡길 73', null, 35.2369950633, 126.7420486971, '062-960-8252', null, 'http://tong.visitkorea.or.kr/cms/resource/34/3530034_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '칠송정', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1620851'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2668001', '카페 궁', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 송도로85번길 22 (도산동)', null, 35.1264666417, 126.786850264, null, null, 'http://tong.visitkorea.or.kr/cms/resource/03/2668003_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#카페','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '카페 궁 #로컬푸드 #카페 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2668001'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873259', '카페얼씨', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 송강로 49', null, 35.1632935748, 126.9831569868, null, null, 'http://tong.visitkorea.or.kr/cms/resource/50/2873250_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#카페','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '카페얼씨 #로컬푸드 #카페 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873259'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873737', '카페지즈', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 동산길 42', null, 35.1300411957, 126.9490886098, null, null, 'http://tong.visitkorea.or.kr/cms/resource/26/2873726_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#카페','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '카페지즈 #로컬푸드 #카페 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873737'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3456289', '카페진정성', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 문화전당로 38 (광산동)', null, 35.1460861028, 126.9192936186, null, null, 'http://tong.visitkorea.or.kr/cms/resource/41/3454441_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type1', 'draft')
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
  array['#로컬푸드','#카페','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '카페진정성 #로컬푸드 #카페 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3456289'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3510971', '컬러브릿지협동조합', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 백서로 101-2 (양림동)', null, 35.1411366209, 126.9169078423, '010-9444-3214', null, null, 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  '컬러브릿지협동조합', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3510971'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2758779', '탱고아구찜', '광주 북구', '북구', '음식·로컬', null, '전남광주통합특별시 북구 설죽로471번길 12 (삼각동)', null, 35.201082309, 126.8980441185, null, null, 'http://tong.visitkorea.or.kr/cms/resource/47/2791147_image2_1.JPG', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '탱고아구찜 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2758779'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1019266', '팔도강산', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 지호로127번길 9 (지산동)', null, 35.1499943952, 126.9429636505, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, null, 'draft')
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
  array['#산','#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '팔도강산 #산 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1019266'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2779095', '퍼니스카페&라운지', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 천변좌하로 192 (치평동)', null, 35.1558919535, 126.8378227995, null, null, 'http://tong.visitkorea.or.kr/cms/resource/58/2781158_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#카페','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 1.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '퍼니스카페&라운지 #로컬푸드 #카페 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2779095'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2668049', '퍼스트네팔', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 서석로7번길 6-44', null, 35.146230472, 126.9157967018, null, null, 'http://tong.visitkorea.or.kr/cms/resource/53/2668053_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '퍼스트네팔 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2668049'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2774008', '푸른길분수공원', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 동명로67번길 22-44', null, 35.153621491, 126.9268760931, '전남광주통합특별시 종합관광안내소 062-233-9370', null, 'http://tong.visitkorea.or.kr/cms/resource/09/3528409_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type1', 'draft')
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
  '푸른길분수공원 #공원 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2774008'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2752366', '푸른마을공동체센터', '광주 동구', '동구', '관광지', null, '전남광주통합특별시 동구 동명로67번길 29 (산수동) 3층', null, 35.1530215418, 126.9258956386, '062-608-8980', null, 'http://tong.visitkorea.or.kr/cms/resource/38/3548038_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '푸른마을공동체센터 #느린여행', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2752366'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1622215', '풍암호수', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 풍암동 460', null, 35.1276401393, 126.8705150584, '062-360-7225', null, 'http://tong.visitkorea.or.kr/cms/resource/72/3367472_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:27:26+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#바다','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '풍암호수 #바다 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1622215'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '742398', '필문 이선제부조묘', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 구만산길 34 (원산동)', null, 35.0928769754, 126.8454986925, '062-607-2333', null, 'http://tong.visitkorea.or.kr/cms/resource/67/3366767_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '필문 이선제부조묘', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '742398'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873620', '하마네아구찜 수완본점', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 수완로14번길 27 1층', null, 35.1872049363, 126.8291422288, null, null, 'http://tong.visitkorea.or.kr/cms/resource/04/2873604_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '하마네아구찜 수완본점 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873620'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2873020', '하지메', '광주 서구', '서구', '음식·로컬', null, '전남광주통합특별시 서구 상무민주로 16', null, 35.152014966, 126.8587349354, null, null, null, 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, null, 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '하지메 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2873020'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '1621611', '학산사', '광주 서구', '서구', '관광지', null, '전남광주통합특별시 서구 불암길 82-100 (서창동)', null, 35.1091722542, 126.8393154996, '전남광주통합특별시 서구 문화예술팀 062-360-7670', null, 'http://tong.visitkorea.or.kr/cms/resource/99/3367299_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#산','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.0,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '학산사 #산 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '1621611'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2665138', '한우꽃', '광주 남구', '남구', '음식·로컬', null, '전남광주통합특별시 남구 백운로 67-2', null, 35.1396032678, 126.9054838907, null, null, 'http://tong.visitkorea.or.kr/cms/resource/43/2665143_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#정원','#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.75, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.75,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '한우꽃 #정원 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.4,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2665138'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2847995', '해궁', '광주 광산구', '광산구', '음식·로컬', null, '전남광주통합특별시 광산구 풍영로229번길 53', null, 35.1920374167, 126.8109381644, null, null, 'http://tong.visitkorea.or.kr/cms/resource/82/2847982_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '해궁 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2847995'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127322', '환벽당', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 환벽당길 10 (충효동)', null, 35.1857719297, 127.003104658, '전남광주통합특별시 북구청 062-510-1500', null, 'http://tong.visitkorea.or.kr/cms/resource/80/3028480_image2_1.jpg', 90, false, false, false, null, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '환벽당', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127322'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '127401', '환벽당 ·조대', '광주 북구', '북구', '관광지', null, '전남광주통합특별시 북구 환벽당길 10 (충효동)', null, 35.1855608382, 127.0028269101, '전남광주통합특별시 북구청 문화예술과 062-410-6622', null, 'http://tong.visitkorea.or.kr/cms/resource/47/3350747_image2_1.jpg', 90, false, false, false, false, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T21:26:27+00:00'::timestamptz, null, 'Type3', 'draft')
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
  '환벽당 ·조대', '1.0.0',
  'import', 0.35,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '127401'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '2837756', '황솔촌 충장점', '광주 동구', '동구', '음식·로컬', null, '전남광주통합특별시 동구 중앙로160번길 16-10', null, 35.1470831279, 126.9142884809, null, null, 'http://tong.visitkorea.or.kr/cms/resource/53/2837753_image2_1.jpg', 60, true, true, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#로컬푸드','#실내','#비오는날','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.75, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.0}'::jsonb,
  '[0.0,0.0,0.0,0.75,0.0,0.0,0.0,0.0]'::extensions.vector(8),
  '황솔촌 충장점 #로컬푸드 #실내 #비오는날 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '2837756'
on conflict (place_id) do update set
  hashtags = excluded.hashtags, tag_scores = excluded.tag_scores,
  preference_vector = excluded.preference_vector, semantic_text = excluded.semantic_text,
  taxonomy_version = excluded.taxonomy_version, labeling_method = excluded.labeling_method,
  labeling_confidence = excluded.labeling_confidence, labeling_evidence = excluded.labeling_evidence,
  reviewed_at = excluded.reviewed_at, updated_at = now();

insert into public.places (source, source_place_id, name, region, sigungu, category, description, road_address, lot_address, latitude, longitude, phone, website_url, image_url, duration_minutes, indoor, rain_ok, family_friendly, parking_available, wheelchair_accessible, pet_friendly, requires_reservation, price_min, price_max, status, public_transport_score, source_url, source_updated_at, last_verified_at, license, quality_status)
values ('tourapi', '3029394', '효천물빛노닐터', '광주 남구', '남구', '관광지', null, '전남광주통합특별시 남구 효천로 140 (임암동)', null, 35.1037955152, 126.8649522567, '062-603-5480', null, 'http://tong.visitkorea.or.kr/cms/resource/74/3029374_image2_1.jpg', 90, false, false, false, true, null, null, null, null, null, 'active', 0.5, 'https://www.data.go.kr/data/15101578/openapi.do', '2026-06-30T18:44:28+00:00'::timestamptz, null, 'Type3', 'draft')
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
  array['#야경','#주차가능']::text[],
  '{"nature": 0.0, "culture": 0.0, "art": 0.0, "food": 0.0, "activity": 0.0, "sports": 0.0, "healing": 0.0, "festival": 0.75}'::jsonb,
  '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.75]'::extensions.vector(8),
  '효천물빛노닐터 #야경 #주차가능', '1.0.0',
  'import', 0.38,
  '[{"source": "tourapi", "source_url": "https://www.data.go.kr/data/15101578/openapi.do", "note": "규칙 기반 라벨 초안. 사람 교차검수 필요"}]'::jsonb, null
from public.places p
where p.source = 'tourapi' and p.source_place_id = '3029394'
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

commit;
