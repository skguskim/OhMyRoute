-- KIA 타이거즈 선수 추천 음식점 DB 초안
-- 운영 places 테이블에 바로 넣지 않고, 주소·좌표·영업 상태 검수용 staging 테이블에 적재한다.

create table if not exists public.staging_kia_player_restaurants (
  restaurant_id text primary key,
  restaurant_name text not null,
  branch_name text,
  region text not null,
  sigungu text,
  address text,
  category_draft text,
  recommended_players text[] not null default '{}',
  baseball_column text not null,
  primary_relation_type text not null,
  recommendation_context text not null,
  source_title text not null,
  source_url text not null,
  source_published_at text,
  secondary_source_url text,
  source_directness text not null,
  evidence_confidence text not null check (evidence_confidence in ('high', 'medium-high', 'medium', 'low')),
  verification_status text not null,
  business_status text not null default '확인 필요',
  latitude double precision,
  longitude double precision,
  needs_geocoding boolean not null default true,
  address_review_needed boolean not null default false,
  food_score real not null default 1 check (food_score between 0 and 1),
  sports_score real not null default 1 check (sports_score between 0 and 1),
  hashtags text[] not null default '{}',
  quality_status text not null default 'draft' check (quality_status in ('draft', 'reviewed', 'verified', 'rejected')),
  review_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.staging_kia_player_restaurant_evidence (
  evidence_id text primary key,
  restaurant_id text not null references public.staging_kia_player_restaurants(restaurant_id) on delete cascade,
  player_name text not null,
  kia_context text not null,
  relation_type text not null check (relation_type in ('direct_recommendation', 'regular', 'official_curation', 'team_favorite', 'family_owned')),
  recommendation_context text not null,
  source_title text not null,
  source_url text not null,
  source_published_at text,
  source_origin text not null,
  source_directness text not null,
  confidence text not null check (confidence in ('high', 'medium-high', 'medium', 'low')),
  verification_status text not null,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (restaurant_id, player_name, source_url)
);

create table if not exists public.staging_kia_player_restaurant_video_review (
  review_id text primary key,
  video_id text not null,
  video_title text not null,
  source_url text not null,
  published_at text,
  segment text,
  player_name text,
  mentioned_restaurant text,
  decision text not null,
  relation_type text not null,
  confidence text not null check (confidence in ('high', 'medium-high', 'medium', 'low')),
  reason text not null,
  db_action text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

insert into public.staging_kia_player_restaurants (
  restaurant_id, restaurant_name, branch_name, region, sigungu, address,
  category_draft, recommended_players, baseball_column, primary_relation_type,
  recommendation_context, source_title, source_url, source_published_at, secondary_source_url,
  source_directness, evidence_confidence, verification_status, business_status,
  latitude, longitude, needs_geocoding, address_review_needed, food_score, sports_score,
  hashtags, quality_status, review_notes
) values
(
  'kia-food-001', '떡볶이 대통령', null, '광주', '북구', '광주 북구 호동로 7',
  '분식', array['윤영철']::text[], 'KIA 타이거즈 윤영철 추천', 'direct_recommendation',
  'KIA 공식 영상에서 윤영철이 떡볶이 대통령을 직접 추천. 최근 업체 정보로 주소와 메뉴를 교차확인.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=43s', '2025-02-18', 'https://www.diningcode.com/profile.php?rid=aOz7FvRAlCK8',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-002', '왕뼈사랑', '광천본점', '광주', '서구', '광주 서구 무진대로 937',
  '해장국·감자탕', array['윤영철']::text[], 'KIA 타이거즈 윤영철 추천', 'direct_recommendation',
  'KIA 공식 영상에서 윤영철이 왕뼈사랑을 직접 추천. 최근 업체 정보로 주소를 교차확인.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=65s', '2025-02-18', 'https://www.tabling.co.kr/place/677cc7f766de5f069875c4af',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-003', '돈구이 불붙었네', '운암점', '광주', '북구', '광주 북구 황계로 15',
  '돼지고기구이', array['최지민']::text[], 'KIA 타이거즈 최지민 추천', 'direct_recommendation',
  'KIA 공식 영상에서 최지민이 돈구이 불붙었네를 직접 추천. 최근 업체 정보로 주소와 메뉴를 교차확인.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=74s', '2025-02-18', 'https://www.diningcode.com/profile.php?rid=UcRYyzztlyK6',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-004', '차돌집', null, '광주', '서구', '광주 서구 내방로 308',
  '차돌박이구이', array['최지민', '윤영철']::text[], 'KIA 타이거즈 최지민·윤영철 추천', 'direct_recommendation',
  '광주시 가이드의 최지민 매핑과 KIA 공식 영상에서 윤영철이 직접 추천한 관계를 모두 보존.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=90s', '2025-02-18', 'https://www.tabling.co.kr/place/677ccf4e66de5f06988425ae',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-005', '25시참숯구이', null, '광주', '북구', '광주 북구 연양로105번길 7',
  '숯불구이', array['최지민']::text[], 'KIA 타이거즈 최지민 추천', 'direct_recommendation',
  'KIA 공식 영상에서 최지민이 25시참숯구이를 직접 추천. 최근 업체 정보로 주소와 메뉴를 교차확인.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=103s', '2025-02-18', 'https://www.siksinhot.com/P/394591',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-006', '삼일집', null, '광주', '북구', '광주 북구 호동로15번길 50',
  '돼지고기구이', array['황동하', '최지민']::text[], 'KIA 타이거즈 황동하·최지민 추천', 'direct_recommendation',
  '황동하 인터뷰와 KIA 공식 영상의 최지민 발화에서 각각 삼일집을 직접 추천.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=51s', '2025-02-18', 'https://v.daum.net/v/Ux1v2ge7AY',
  'KIA 공식 유튜브·선수 직접 발화 및 선수 인터뷰', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-007', '농성화로', '본점', '광주', '서구', '광주 서구 군분로221번길 2-16 1층',
  '돼지고기구이', array['나성범', '김선빈', '변우혁', '김도현']::text[], 'KIA 타이거즈 나성범·김선빈·변우혁·김도현 추천', 'direct_recommendation',
  '나성범·김선빈·변우혁의 기존 근거와 KIA 공식 영상에서 김도현이 직접 추천한 관계를 모두 보존.', '변우혁 인터뷰 - 농성화로 추천', 'https://v.daum.net/v/0knL6v5Jdi', '2023', 'https://m.mdilbo.com/detail/F6ACgr/737969',
  '선수 직접 인터뷰 및 구단 콘텐츠 보도', 'high', 'address_conflict', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '광주시 기사 주소와 최근 지도형 자료의 주소가 달라 최종 좌표 등록 전 지점 확인 필요.'
),
(
  'kia-food-008', '시골집', null, '광주', '서구', '광주 서구 내방로398번길 4',
  '돼지주물럭·한식', array['김도현']::text[], 'KIA 타이거즈 김도현 추천', 'direct_recommendation',
  'KIA 공식 영상에서 김도현이 시골집을 직접 추천. 최근 업체 정보로 주소와 메뉴를 교차확인.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=165s', '2025-02-18', 'https://www.tabling.co.kr/place/677cc7f666de5f069875c1fd',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-009', '돈의 맛', null, '광주', '서구', '광주 서구 상무오월로29번길 22',
  '돼지고기구이', array['양현종']::text[], 'KIA 타이거즈 양현종 추천', 'official_curation',
  '광주시 타슐랭 가이드 수록. 최근 업체 정보에서 삼겹살·생갈비 메뉴와 주소를 교차확인.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', 'https://polle.com/place/16HDTG/%EB%8F%88%EC%9D%98%EB%A7%9B',
  '광주시 공식 큐레이션', 'medium-high', 'official_secondary_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-010', '당산나무집', null, '광주', '남구', '광주 남구 봉선중길 4',
  '쌈밥·고기구이', array['양현종']::text[], 'KIA 타이거즈 양현종 추천', 'official_curation',
  '광주시 타슐랭 가이드 수록. 최근 관광정보에서 쌈밥·고기구이 메뉴와 주소를 교차확인.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', 'https://www.ktriptips.com/kor/food/2664967',
  '광주시 공식 큐레이션', 'medium-high', 'official_secondary_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-011', '이대포땔나무집', null, '광주', '북구', '광주 북구 중흥로 37',
  '숯불구이', array['김건국']::text[], 'KIA 타이거즈 김건국 추천', 'direct_recommendation',
  '김건국이 지인에게 추천한 광주 식당으로 보도됨.', '무등일보 - 김건국이 추천한 광주 맛집', 'https://www.mdilbo.com/detail/RFD998/745100', '2025-07-14', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000',
  '선수 추천 상황을 취재한 기사', 'medium-high', 'cross_checked', '확인 필요',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-012', '이헌한우', null, '광주', '북구', '광주 북구 대자실로 30 지하 1층',
  '한우구이', array['김선빈']::text[], 'KIA 타이거즈 김선빈 추천', 'direct_recommendation',
  '김선빈이 인터뷰에서 첫 번째 광주 맛집으로 직접 꼽음.', '김선빈 인터뷰 - 광주 맛집 추천', 'https://m.mdilbo.com/detail/F6ACgr/737969', '2025-02-03', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '동일 상호·지점 여부를 지도 등록 직전 재확인.'
),
(
  'kia-food-013', '오돌뼈와 막창골', null, '광주', '북구', '광주 북구 운용로 11',
  '오돌뼈·막창', array['곽도규']::text[], 'KIA 타이거즈 곽도규 단골·추천', 'regular',
  'MBC 공식 기사에서 곽도규의 단골집으로 소개됨.', 'MBC 전지적 참견 시점 - 곽도규 단골집', 'https://enews.imbc.com/Tpl/View/441350', '2024-12-21', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000',
  '방송 공식 기사', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-014', '진식당', null, '광주', '북구', '광주 북구 중흥로 105 1층',
  '한식', array['한승택', '김호령', '김석환']::text[], 'KIA 타이거즈 한승택·김호령·김석환 추천', 'direct_recommendation',
  'KIA 공식 영상에서 한승택과 김석환이 진식당을 직접 추천했고, 구단 공식 웹진의 김호령 추천도 함께 보존.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=358s', '2023-03-15', 'https://tigers.co.kr/files/webzine/2020/05/12/20200512100453.303-c02a8ca35192.2005.pdf',
  'KIA 공식 유튜브·선수 직접 발화 및 구단 공식 웹진', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '과거 웹진의 진식당과 현재 주소의 동일 지점 여부 최종 확인 필요.'
),
(
  'kia-food-015', '명화식육식당', null, '광주', '광산구', '광주 광산구 평동로 421',
  '애호박국밥·찌개', array['송후섭']::text[], 'KIA 타이거즈 송후섭 추천', 'direct_recommendation',
  'KIA 공식 영상에서 송후섭이 명화식육식당을 직접 추천. 최근 업체 정보로 주소와 메뉴를 교차확인.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=30s', '2023-03-15', 'https://www.diningcode.com/profile.php?rid=jYKppLiH5gkN',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-016', '산수쌈밥', null, '광주', '동구', '광주 동구 동계로 11',
  '쌈밥', array['김석환']::text[], 'KIA 타이거즈 김석환 추천', 'direct_recommendation',
  'KIA 공식 영상에서 김석환이 산수쌈밥을 직접 추천.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=130s', '2023-03-15', null,
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-017', '맛찬들왕소금구이', null, '광주', '서구', '광주 서구 시청로60번길 17-11',
  '돼지고기구이', array['김호령', '황동하']::text[], 'KIA 타이거즈 김호령·황동하 추천', 'direct_recommendation',
  'KIA 공식 영상에서 김호령이 맛찬들왕소금구이를 직접 추천했고, 황동하 인터뷰 근거도 함께 보존.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=5s', '2023-03-15', 'https://v.daum.net/v/Ux1v2ge7AY',
  'KIA 공식 유튜브·선수 직접 발화 및 선수 인터뷰', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-018', '광주보쌈', null, '광주', '동구', '광주 동구 서석로 29-5',
  '보쌈', array['이태규']::text[], 'KIA 타이거즈 이태규 추천', 'direct_recommendation',
  'KIA 공식 영상에서 이태규가 광주보쌈을 직접 추천. 최근 업체 정보로 주소를 교차확인.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=40s', '2023-03-15', 'https://tubemap.kr/place/p_709',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-019', '여수식육점', null, '광주', '서구', '광주 서구 구성로49번길 13',
  '식육식당·고기구이', array['이의리']::text[], 'KIA 타이거즈 이의리 추천', 'official_curation',
  '광주시 타슐랭 가이드에 이의리 추천 식당으로 수록.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', null,
  '광주시 공식 큐레이션', 'medium-high', 'business_status_unverified', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '동명 업체가 검색에 섞여 현재 영업과 정확한 매장 정보를 독립 확인하지 못함.'
),
(
  'kia-food-020', '송정떡갈비', '1호점', '광주', '광산구', '광주 광산구 광산로29번길 1',
  '떡갈비', array['김도영']::text[], 'KIA 타이거즈 김도영 추천', 'official_curation',
  '광주시 타슐랭 가이드 수록. 최근 업체 정보에서 떡갈비 메뉴와 주소를 교차확인.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', 'https://www.tabling.co.kr/place/677ccb3f66de5f06987ce9de',
  '광주시 공식 큐레이션', 'medium-high', 'official_secondary_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-021', '숯과닭발', '본점', '광주', '서구', '광주 서구 상일로64번길 20',
  '숯불닭발', array['최원준']::text[], 'KIA 타이거즈 최원준 추천', 'official_curation',
  '광주시 타슐랭 가이드 수록. 최근 업체 정보에서 숯불닭발·오돌뼈 메뉴와 주소를 교차확인.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', 'https://www.diningcode.com/profile.php?rid=x4jAA2brIE2G',
  '광주시 공식 큐레이션', 'medium-high', 'official_secondary_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-022', '만리장성', null, '광주', '북구', '광주 북구 임동 100-51',
  '중식', array['유승철']::text[], 'KIA 타이거즈 유승철 추천', 'official_curation',
  '광주시 타슐랭 가이드에 유승철 추천 식당으로 수록.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', null,
  '광주시 공식 큐레이션', 'medium-high', 'address_conflict', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '기사의 지번이 현재 다른 업소 정보와 충돌함. 공개 전 상호·주소·영업 여부를 반드시 재확인.'
),
(
  'kia-food-023', '대광식당', null, '광주', '서구', '광주 서구 상무대로695번길 15',
  '육전·한식', array['홍재호']::text[], 'KIA 타이거즈 홍재호 추천', 'official_curation',
  '광주시 타슐랭 가이드 수록. 최근 업체 정보에서 육전 메뉴와 주소를 교차확인.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', 'https://www.tabling.co.kr/place/677ccad966de5f06987c1a6e',
  '광주시 공식 큐레이션', 'medium-high', 'official_secondary_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-024', '전통나주곰탕', null, '광주', '서구', '광주 서구 내방로 398',
  '곰탕', array['이종범']::text[], 'KIA 타이거즈 이종범 단골·추천', 'regular',
  '광주시 가이드 수록 및 최근 방송 관련 업체 정보에서 이종범의 현역 시절 단골 맥락을 교차확인.', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', 'https://www.diningcode.com/profile.php?rid=tQatqDrGq8cd',
  '공식 큐레이션 및 방송 관련 교차자료', 'high', 'cross_checked', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-025', '본가네국밥', null, '광주', '북구', '광주 북구 서양로 37 1층',
  '국밥', array['황동하']::text[], 'KIA 타이거즈 황동하 추천', 'direct_recommendation',
  '황동하가 선수 인터뷰에서 정말 맛있다고 직접 추천.', '더그아웃 인터뷰 - KIA 황동하의 광주 맛집', 'https://v.daum.net/v/Ux1v2ge7AY', '2025-03', null,
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '기사의 상호와 최근 도로명 주소를 결합한 초안으로 지점 최종 확인 필요.'
),
(
  'kia-food-026', '은진식육식당', null, '광주', '북구', '광주 북구 신안동 145-3',
  '삼겹살·식육식당', array['오선우']::text[], 'KIA 타이거즈 오선우 추천', 'direct_recommendation',
  '오선우가 선수 인터뷰에서 광주 맛집으로 직접 추천.', '더그아웃 인터뷰 - KIA 오선우의 광주 맛집', 'https://v.daum.net/v/35PMnqiBLd', '2025-07', null,
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '지번 기반 초안. 도로명 주소와 현재 영업 여부를 추가 확인.'
),
(
  'kia-food-027', '청와대', null, '광주', '북구', '광주 북구 천변우로79번길 83',
  '중식', array['최지민', '곽도규']::text[], 'KIA 타이거즈 최지민·곽도규 방문·추천', 'team_favorite',
  'KIA 구단 영상 내용을 다룬 기사에서 최지민·곽도규가 방문한 선수 맛집으로 소개됨.', '무등일보 - KIA E-TV 속 선수 맛집', 'https://www.mdilbo.com/detail/xQQILD/721355', '2024-06-02', null,
  '구단 콘텐츠를 인용한 기사', 'medium-high', 'address_conflict', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '자료에 따라 경양로 126 표기가 있어 같은 지점인지 최종 확인 필요.'
),
(
  'kia-food-028', '독도횟집', null, '광주', '동구', '광주 동구 동계천로 67',
  '횟집', array['윤중현']::text[], 'KIA 타이거즈 윤중현 소개(선수 가족 운영)', 'family_owned',
  'KIA 공식 영상에서 윤중현이 가족 운영 식당인 독도횟집을 소개. 독립적인 제3자 추천과 구분해 사용.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=449s', '2023-03-15', 'https://tigers.co.kr/files/webzine/2021/10/10/20211010232700.3cd-de9151929033.%ED%98%B8%EB%9E%91%EC%9D%B4%EB%8A%94%20%EB%82%B4%EC%B9%9C%EA%B5%AC%202021%EB%85%84%2010%EC%9B%94%ED%98%B8.pdf',
  'KIA 공식 유튜브·선수 직접 소개', 'high', 'family_owned_source', '확인 필요',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '독립적인 제3자 추천이라기보다 선수 가족 운영 식당 소개임을 화면에 명시.'
),
(
  'kia-food-029', '영미오리탕', null, '광주', '북구', '광주 북구 경양로 126',
  '오리탕', array['서재응']::text[], '당시 KIA 타이거즈 서재응 추천', 'direct_recommendation',
  '2009년 당시 KIA 소속 서재응이 인터뷰에서 직접 추천.', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', null,
  '과거 선수 직접 인터뷰', 'high', 'historical_direct_source', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '추천 시점은 2009년. 현재 메뉴·운영 정보는 공개 전 재점검 권장.'
),
(
  'kia-food-030', '화정떡갈비', null, '광주', '광산구', '광주 광산구 광산로29번길 6',
  '떡갈비', array['김상훈']::text[], '당시 KIA 타이거즈 김상훈 추천', 'direct_recommendation',
  '2009년 당시 KIA 소속 김상훈이 인터뷰에서 화정식당을 직접 추천. 현 상호·주소는 화정떡갈비로 정리한 초안.', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', null,
  '과거 선수 직접 인터뷰', 'high', 'historical_direct_source', '최근 운영 흔적 확인',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '기사의 과거 상호 ''화정식당''과 현재 상호의 연속성 최종 확인 필요.'
),
(
  'kia-food-031', '광양숯불구이', null, '광주', '서구', '광주 서구 상무대로867번길 23',
  '한우숯불구이', array['최희섭', '김상현']::text[], '당시 KIA 타이거즈 최희섭 추천·김상현 단골', 'direct_recommendation',
  '2009년 당시 KIA 소속 최희섭이 직접 추천했고 김상현도 자주 찾는다고 소개됨.', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', null,
  '과거 선수 직접 인터뷰', 'high', 'historical_direct_source', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '추천 시점은 2009년. 현재 메뉴·운영 정보는 공개 전 재점검 권장.'
),
(
  'kia-food-032', '덮밥장사장', '전남대점', '광주', '북구', '광주 북구 우치로90번길 16 1층',
  '덮밥', array['최지민']::text[], 'KIA 타이거즈 최지민 추천', 'direct_recommendation',
  'KIA 공식 영상에서 최지민이 덮밥장사장 전남대점을 직접 추천. 최근 업체 정보로 지점과 주소를 교차확인.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=69s', '2025-02-18', 'https://www.diningcode.com/profile.php?rid=qldtOVG17Uzr',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-033', '구이마을', '한양대점', '서울', '성동구', '서울 성동구 마조로 15-2',
  '삼겹살·고기구이', array['김태형']::text[], 'KIA 타이거즈 김태형 추천', 'direct_recommendation',
  'KIA 공식 영상에서 김태형이 한양대 인근 구이마을을 직접 추천. 영상 속 가격은 촬영 당시 정보이므로 현재 가격으로 사용하지 않음.', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=131s', '2025-02-18', 'https://www.diningcode.com/profile.php?rid=1L2dgOHEWhE3',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '광주 외 지역 식당. 영상 속 가격은 역사 정보로만 보관.'
),
(
  'kia-food-034', '삼평식당', '동명점', '광주', '동구', '광주 동구 장동로 23-33 1층',
  '냉동삼겹살·막국수', array['유승철']::text[], 'KIA 타이거즈 유승철 추천', 'direct_recommendation',
  'KIA 공식 영상에서 유승철이 삼평식당 동명점을 직접 추천. 최근 업체 정보로 지점과 주소를 교차확인.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=89s', '2023-03-15', 'https://www.diningcode.com/profile.php?rid=speiBAQaIZNT',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'direct_source_confirmed', '최근 운영 흔적 확인',
  null, null, true, false, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', null
),
(
  'kia-food-035', '마포선장', '지점 확인 필요', '광주', null, null,
  '키조개삼합·해물', array['김규성']::text[], 'KIA 타이거즈 김규성 추천', 'direct_recommendation',
  'KIA 공식 영상에서 김규성이 마포선장을 직접 추천했으나 지점이 특정되지 않음.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=309s', '2023-03-15', 'https://www.diningcode.com/profile.php?rid=KKigLJf4VrMh',
  'KIA 공식 유튜브·선수 직접 발화', 'high', 'branch_unknown', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '영상에서 지점 미지정. 운암본점 폐업 정보와 상무직영점 운영 흔적이 혼재하여 공개 전 지점 확정 필요.'
),
(
  'kia-food-036', '왕솥뚜껑삼겹살&서울식사리', null, '광주', '서구', '광주 서구 상무대로 922',
  '솥뚜껑삼겹살', array['류지혁']::text[], 'KIA 타이거즈 류지혁 추천', 'direct_recommendation',
  'KIA 공식 영상의 발화와 최종 정리 카드에서 류지혁 추천 식당으로 확인. 현재 상호 표기가 달라 검수 대상으로 유지.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=297s', '2023-03-15', 'https://www.koobig.com/172336',
  'KIA 공식 유튜브·선수 직접 발화 및 영상 정리 카드', 'medium-high', 'name_transition_review', '최근 운영 흔적 확인',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '영상 표기 ''서울식사리''와 현재 검색 상호 ''왕솥뚜껑삼겹살&서울식사리''의 연속성 최종 확인 필요.'
),
(
  'kia-food-037', '서울깍두기', '지점 확인 필요', '광주', null, null,
  '설렁탕·국밥', array['홍종표']::text[], 'KIA 타이거즈 홍종표 추천', 'direct_recommendation',
  'KIA 공식 영상 최종 정리 카드에서 홍종표 추천 식당으로 확인했으나 지점은 특정되지 않음.', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=465s', '2023-03-15', null,
  'KIA 공식 유튜브·영상 정리 카드', 'medium-high', 'branch_unknown', '확인 필요',
  null, null, true, true, 1, 1,
  array['#로컬푸드', '#맛집', '#야구', '#스포츠']::text[], 'draft', '광주 내 동명 지점이 복수일 수 있어 운영 DB 반영 전 정확한 지점·주소 확인 필요.'
)
on conflict (restaurant_id) do update set
  restaurant_name = excluded.restaurant_name,
  branch_name = excluded.branch_name,
  address = excluded.address,
  category_draft = excluded.category_draft,
  recommended_players = excluded.recommended_players,
  baseball_column = excluded.baseball_column,
  primary_relation_type = excluded.primary_relation_type,
  recommendation_context = excluded.recommendation_context,
  source_title = excluded.source_title,
  source_url = excluded.source_url,
  source_published_at = excluded.source_published_at,
  secondary_source_url = excluded.secondary_source_url,
  source_directness = excluded.source_directness,
  evidence_confidence = excluded.evidence_confidence,
  verification_status = excluded.verification_status,
  business_status = excluded.business_status,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  needs_geocoding = excluded.needs_geocoding,
  address_review_needed = excluded.address_review_needed,
  hashtags = excluded.hashtags,
  quality_status = excluded.quality_status,
  review_notes = excluded.review_notes,
  updated_at = now();

insert into public.staging_kia_player_restaurant_evidence (
  evidence_id, restaurant_id, player_name, kia_context, relation_type,
  recommendation_context, source_title, source_url, source_published_at, source_origin,
  source_directness, confidence, verification_status, notes
) values
(
  'evidence-001', 'kia-food-001', '윤영철', 'KIA 타이거즈 선수', 'official_curation',
  '떡볶이 대통령 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-002', 'kia-food-002', '윤영철', 'KIA 타이거즈 선수', 'official_curation',
  '왕뼈사랑 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-003', 'kia-food-003', '최지민', 'KIA 타이거즈 선수', 'official_curation',
  '돈구이 불붙었네 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-004', 'kia-food-004', '최지민', 'KIA 타이거즈 선수', 'official_curation',
  '차돌집 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-005', 'kia-food-005', '최지민', 'KIA 타이거즈 선수', 'official_curation',
  '25시참숯구이 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-008', 'kia-food-008', '김도현', 'KIA 타이거즈 선수', 'official_curation',
  '시골집 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-009', 'kia-food-009', '양현종', 'KIA 타이거즈 선수', 'official_curation',
  '돈의 맛 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-010', 'kia-food-010', '양현종', 'KIA 타이거즈 선수', 'official_curation',
  '당산나무집 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-015', 'kia-food-015', '송후섭', 'KIA 타이거즈 선수', 'official_curation',
  '명화식육식당 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-016', 'kia-food-016', '김석환', 'KIA 타이거즈 선수', 'official_curation',
  '산수쌈밥 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-018', 'kia-food-018', '이태규', 'KIA 타이거즈 선수', 'official_curation',
  '광주보쌈 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-019', 'kia-food-019', '이의리', 'KIA 타이거즈 선수', 'official_curation',
  '여수식육점 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-020', 'kia-food-020', '김도영', 'KIA 타이거즈 선수', 'official_curation',
  '송정떡갈비 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-021', 'kia-food-021', '최원준', 'KIA 타이거즈 선수', 'official_curation',
  '숯과닭발 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-022', 'kia-food-022', '유승철', 'KIA 타이거즈 선수', 'official_curation',
  '만리장성 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-023', 'kia-food-023', '홍재호', 'KIA 타이거즈 선수', 'official_curation',
  '대광식당 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-024', 'kia-food-024', '이종범', 'KIA 타이거즈 선수', 'official_curation',
  '전통나주곰탕 추천 식당으로 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-006', 'kia-food-006', '황동하', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 삼일집을 광주 맛집으로 직접 언급', '더그아웃 인터뷰 - KIA 황동하의 광주 맛집', 'https://v.daum.net/v/Ux1v2ge7AY', '2025-03', '더그아웃 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-007a', 'kia-food-007', '나성범', 'KIA 타이거즈 선수', 'direct_recommendation',
  '구단 콘텐츠 관련 기사에서 농성화로와 선호 메뉴가 소개됨', '무등일보 - 나성범의 광주 맛집', 'https://www.mdilbo.com/detail/xQQILD/719211', '2024-05', '구단 콘텐츠 인용 보도',
  '선수 출연 콘텐츠를 인용한 기사', 'medium-high', 'cross_checked', null
),
(
  'evidence-007b', 'kia-food-007', '김선빈', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 농성화로를 두 번째 추천 식당으로 직접 언급', '김선빈 인터뷰 - 광주 맛집 추천', 'https://m.mdilbo.com/detail/F6ACgr/737969', '2025-02-03', '무등일보 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-007c', 'kia-food-007', '변우혁', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 농성화로를 직접 추천', '변우혁 인터뷰 - 농성화로 추천', 'https://v.daum.net/v/0knL6v5Jdi', '2023', '더그아웃 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-011', 'kia-food-011', '김건국', 'KIA 타이거즈 선수', 'direct_recommendation',
  '지인에게 이대포땔나무집을 추천한 상황이 기사에 소개됨', '무등일보 - 김건국이 추천한 광주 맛집', 'https://www.mdilbo.com/detail/RFD998/745100', '2025-07-14', '무등일보',
  '선수 추천 상황을 취재한 기사', 'medium-high', 'cross_checked', null
),
(
  'evidence-012', 'kia-food-012', '김선빈', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 이헌한우를 첫 번째 광주 맛집으로 직접 추천', '김선빈 인터뷰 - 광주 맛집 추천', 'https://m.mdilbo.com/detail/F6ACgr/737969', '2025-02-03', '무등일보 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-013', 'kia-food-013', '곽도규', 'KIA 타이거즈 선수', 'regular',
  '방송 공식 기사에서 곽도규의 단골집으로 소개', 'MBC 전지적 참견 시점 - 곽도규 단골집', 'https://enews.imbc.com/Tpl/View/441350', '2024-12-21', 'MBC 공식 기사',
  '방송 공식 기사', 'high', 'direct_source_confirmed', null
),
(
  'evidence-014a', 'kia-food-014', '한승택', 'KIA 타이거즈 선수', 'official_curation',
  '진식당 추천 식당으로 광주시 가이드에 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-014b', 'kia-food-014', '김호령', 'KIA 타이거즈 선수', 'direct_recommendation',
  'KIA 공식 웹진 답변에서 진식당을 직접 추천', 'KIA 타이거즈 공식 웹진 - 김호령 추천 식당', 'https://tigers.co.kr/files/webzine/2020/05/12/20200512100453.303-c02a8ca35192.2005.pdf', '2020-05', 'KIA 타이거즈 공식 웹진',
  '구단 공식 웹진 선수 답변', 'high', 'direct_source_confirmed', null
),
(
  'evidence-017a', 'kia-food-017', '김호령', 'KIA 타이거즈 선수', 'official_curation',
  '맛찬들왕소금구이 추천 식당으로 광주시 가이드에 수록', '광주광역시 온라인뉴스 - 선수들이 선정한 타슐랭 가이드', 'https://newscms.gwangju.go.kr/gallery.es?act=view&bid=0009&cg_code=C01&list_no=5120&mid=a40200000000', '2026-03-26', '광주광역시 공식 온라인뉴스',
  '공식 지자체 2차 큐레이션', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-017b', 'kia-food-017', '황동하', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 맛찬들왕소금구이를 광주 맛집으로 직접 언급', '더그아웃 인터뷰 - KIA 황동하의 광주 맛집', 'https://v.daum.net/v/Ux1v2ge7AY', '2025-03', '더그아웃 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-025', 'kia-food-025', '황동하', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 본가네국밥을 정말 맛있다고 직접 추천', '더그아웃 인터뷰 - KIA 황동하의 광주 맛집', 'https://v.daum.net/v/Ux1v2ge7AY', '2025-03', '더그아웃 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-026', 'kia-food-026', '오선우', 'KIA 타이거즈 선수', 'direct_recommendation',
  '인터뷰에서 은진식육식당을 광주 맛집으로 직접 추천', '더그아웃 인터뷰 - KIA 오선우의 광주 맛집', 'https://v.daum.net/v/35PMnqiBLd', '2025-07', '더그아웃 인터뷰',
  '선수 직접 인터뷰', 'high', 'direct_source_confirmed', null
),
(
  'evidence-027a', 'kia-food-027', '최지민', 'KIA 타이거즈 선수', 'team_favorite',
  '구단 영상 내용을 다룬 기사에서 선수 방문 맛집으로 소개', '무등일보 - KIA E-TV 속 선수 맛집', 'https://www.mdilbo.com/detail/xQQILD/721355', '2024-06-02', '구단 콘텐츠 인용 보도',
  '구단 콘텐츠를 인용한 기사', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-027b', 'kia-food-027', '곽도규', 'KIA 타이거즈 선수', 'team_favorite',
  '구단 영상 내용을 다룬 기사에서 선수 방문 맛집으로 소개', '무등일보 - KIA E-TV 속 선수 맛집', 'https://www.mdilbo.com/detail/xQQILD/721355', '2024-06-02', '구단 콘텐츠 인용 보도',
  '구단 콘텐츠를 인용한 기사', 'medium-high', 'official_secondary_confirmed', null
),
(
  'evidence-028', 'kia-food-028', '윤중현', 'KIA 타이거즈 선수', 'family_owned',
  'KIA 공식 웹진에서 선수 가족 운영 식당과 추천 메뉴를 소개', 'KIA 타이거즈 공식 웹진 - 윤중현 가족 식당', 'https://tigers.co.kr/files/webzine/2021/10/10/20211010232700.3cd-de9151929033.%ED%98%B8%EB%9E%91%EC%9D%B4%EB%8A%94%20%EB%82%B4%EC%B9%9C%EA%B5%AC%202021%EB%85%84%2010%EC%9B%94%ED%98%B8.pdf', '2021-10', 'KIA 타이거즈 공식 웹진',
  '구단 공식 웹진', 'high', 'family_owned_source', '독립 추천과 구분해 표시'
),
(
  'evidence-029', 'kia-food-029', '서재응', '당시 KIA 타이거즈 소속(2009)', 'direct_recommendation',
  '인터뷰에서 영미오리탕을 직접 추천', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', '일간스포츠 인터뷰',
  '과거 선수 직접 인터뷰', 'high', 'historical_direct_source', null
),
(
  'evidence-030', 'kia-food-030', '김상훈', '당시 KIA 타이거즈 소속(2009)', 'direct_recommendation',
  '인터뷰에서 당시 상호 화정식당을 직접 추천', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', '일간스포츠 인터뷰',
  '과거 선수 직접 인터뷰', 'high', 'historical_direct_source', '현재 상호 화정떡갈비와의 연속성 확인 필요'
),
(
  'evidence-031a', 'kia-food-031', '최희섭', '당시 KIA 타이거즈 소속(2009)', 'direct_recommendation',
  '인터뷰에서 광양숯불구이를 직접 추천', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', '일간스포츠 인터뷰',
  '과거 선수 직접 인터뷰', 'high', 'historical_direct_source', null
),
(
  'evidence-031b', 'kia-food-031', '김상현', '당시 KIA 타이거즈 소속(2009)', 'regular',
  '같은 기사에서 광양숯불구이를 자주 찾는 선수로 소개', '일간스포츠 - KIA 선수들이 추천한 광주 맛집', 'https://v.daum.net/v/20091014070103691', '2009-10-14', '일간스포츠 인터뷰',
  '과거 선수 인터뷰 기사', 'high', 'historical_direct_source', null
),
(
  'evidence-001-video', 'kia-food-001', '윤영철', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 떡볶이 대통령을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=43s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-002-video', 'kia-food-002', '윤영철', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 왕뼈사랑을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=65s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-003-video', 'kia-food-003', '최지민', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 돈구이 불붙었네를 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=74s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-004-yoon-video', 'kia-food-004', '윤영철', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 차돌집을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=90s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-005-video', 'kia-food-005', '최지민', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 25시참숯구이를 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=103s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-006-choi-video', 'kia-food-006', '최지민', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 삼일집을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=51s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-007-na-video', 'kia-food-007', '나성범', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 농성화로를 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=250s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-007-kimdoh-video', 'kia-food-007', '김도현', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 농성화로를 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=152s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-008-video', 'kia-food-008', '김도현', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 시골집을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=165s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-014-han-video', 'kia-food-014', '한승택', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 진식당을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=358s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-014-kimseok-video', 'kia-food-014', '김석환', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 진식당을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=126s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-015-video', 'kia-food-015', '송후섭', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 명화식육식당을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=30s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-016-video', 'kia-food-016', '김석환', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 산수쌈밥을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=130s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-017-video', 'kia-food-017', '김호령', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 맛찬들왕소금구이를 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=5s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-018-video', 'kia-food-018', '이태규', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 광주보쌈을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=40s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-028-video', 'kia-food-028', '윤중현', 'KIA 타이거즈 선수', 'family_owned',
  '영상에서 선수 가족이 운영하는 독도횟집을 소개', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=449s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 소개', 'high', 'family_owned_source', '독립 추천과 구분'
),
(
  'evidence-032-video', 'kia-food-032', '최지민', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 덮밥장사장 전남대점을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=69s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-033-video', 'kia-food-033', '김태형', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 구이마을 한양대점을 직접 추천', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=131s', '2025-02-18', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', '광주 외 지역'
),
(
  'evidence-034-video', 'kia-food-034', '유승철', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 삼평식당 동명점을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=89s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'direct_source_confirmed', null
),
(
  'evidence-035-video', 'kia-food-035', '김규성', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 마포선장을 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=309s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'high', 'branch_unknown', '지점 미지정'
),
(
  'evidence-036-video', 'kia-food-036', '류지혁', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상에서 서울식사리를 직접 추천', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=297s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'medium-high', 'name_transition_review', '현재 상호 연속성 확인 필요'
),
(
  'evidence-037-video', 'kia-food-037', '홍종표', 'KIA 타이거즈 선수', 'direct_recommendation',
  '영상 최종 정리 카드에서 서울깍두기 추천자로 표시', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=465s', '2023-03-15', 'KIA 타이거즈 공식 유튜브',
  'KIA 공식 영상·선수 직접 발화', 'medium-high', 'branch_unknown', '지점 미지정'
)
on conflict (evidence_id) do update set
  restaurant_id = excluded.restaurant_id,
  player_name = excluded.player_name,
  kia_context = excluded.kia_context,
  relation_type = excluded.relation_type,
  recommendation_context = excluded.recommendation_context,
  source_title = excluded.source_title,
  source_url = excluded.source_url,
  source_published_at = excluded.source_published_at,
  source_origin = excluded.source_origin,
  source_directness = excluded.source_directness,
  confidence = excluded.confidence,
  verification_status = excluded.verification_status,
  notes = excluded.notes,
  updated_at = now();

insert into public.staging_kia_player_restaurant_video_review (
  review_id, video_id, video_title, source_url, published_at,
  segment, player_name, mentioned_restaurant, decision, relation_type,
  confidence, reason, db_action
) values
(
  'video-2023-01', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=5s', '2023-03-15',
  '00:05', '김호령', '맛찬들왕소금구이', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-017 관계 추가'
),
(
  'video-2023-02', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=30s', '2023-03-15',
  '00:30', '송후섭', '명화식육식당', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-015 직접 근거 추가'
),
(
  'video-2023-03', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=40s', '2023-03-15',
  '00:40', '이태규', '광주보쌈', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-018 직접 근거 추가'
),
(
  'video-2023-04', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=50s', '2023-03-15',
  '00:50', '윤영철', '청년다방', 'excluded', 'corrected_non_recommendation',
  'high', '2025년 공식 영상에서 좋아하는 음식 발언이 맛집 추천처럼 편집된 것이라고 정정', '추천 DB 미반영'
),
(
  'video-2023-05', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=89s', '2023-03-15',
  '01:29', '유승철', '삼평식당 동명점', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-034 신규 추가'
),
(
  'video-2023-06', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=126s', '2023-03-15',
  '02:06', '김석환', '진식당', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-014 관계 추가'
),
(
  'video-2023-07', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=130s', '2023-03-15',
  '02:10', '김석환', '산수쌈밥', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-016 직접 근거 추가'
),
(
  'video-2023-08', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=250s', '2023-03-15',
  '04:10', '나성범', '농성화로', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-007 직접 근거 추가'
),
(
  'video-2023-09', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=297s', '2023-03-15',
  '04:57', '류지혁', '서울식사리', 'included_with_review', 'direct_recommendation',
  'medium-high', '영상 표기와 현재 상호의 연속성 검수 필요', 'kia-food-036 신규·주소검수'
),
(
  'video-2023-10', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=309s', '2023-03-15',
  '05:09', '김규성', '마포선장', 'included_with_review', 'direct_recommendation',
  'high', '추천은 직접 확인했으나 지점 미지정', 'kia-food-035 신규·지점검수'
),
(
  'video-2023-11', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=358s', '2023-03-15',
  '05:58', '한승택', '진식당', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-014 직접 근거 추가'
),
(
  'video-2023-12', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=449s', '2023-03-15',
  '07:29', '윤중현', '독도횟집', 'included_with_label', 'family_owned',
  'high', '선수 가족 운영 식당 소개', 'kia-food-028에 가족 운영 표시'
),
(
  'video-2023-13', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=465s', '2023-03-15',
  '07:45', '홍종표', '서울깍두기', 'included_with_review', 'direct_recommendation',
  'medium-high', '최종 정리 카드에서 확인했으나 지점 미지정', 'kia-food-037 신규·지점검수'
),
(
  'video-2023-14', 'klD5NF1d1ZQ', 'KIA 공식 영상 - 순도 100% 광주 현지인 맛집 추천', 'https://www.youtube.com/watch?v=klD5NF1d1ZQ&t=285s', '2023-03-15',
  '약 04:45', null, '팔미분식', 'excluded_pending_review', 'unresolved_mention',
  'low', '발화자·지점 및 광주 범위 여부를 안정적으로 확정하지 못함', '추천 DB 미반영'
),
(
  'video-2025-01', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=43s', '2025-02-18',
  '00:43', '윤영철', '떡볶이 대통령', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-001 직접 근거 추가'
),
(
  'video-2025-02', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=51s', '2025-02-18',
  '00:51', '최지민', '삼일집', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-006 관계 추가'
),
(
  'video-2025-03', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=65s', '2025-02-18',
  '01:05', '윤영철', '왕뼈사랑', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-002 직접 근거 추가'
),
(
  'video-2025-04', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=69s', '2025-02-18',
  '01:09', '최지민', '덮밥장사장 전남대점', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-032 신규 추가'
),
(
  'video-2025-05', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=74s', '2025-02-18',
  '01:14', '최지민', '돈구이 불붙었네', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-003 직접 근거 추가'
),
(
  'video-2025-06', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=90s', '2025-02-18',
  '01:30', '윤영철', '차돌집', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-004 관계 추가'
),
(
  'video-2025-07', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=103s', '2025-02-18',
  '01:43', '최지민', '25시참숯구이', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-005 직접 근거 추가'
),
(
  'video-2025-08', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=131s', '2025-02-18',
  '02:11', '김태형', '구이마을 한양대점', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-033 신규 추가(서울)'
),
(
  'video-2025-09', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=152s', '2025-02-18',
  '02:32', '김도현', '농성화로', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-007 관계 추가'
),
(
  'video-2025-10', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=165s', '2025-02-18',
  '02:45', '김도현', '시골집', 'included', 'direct_recommendation',
  'high', '선수 직접 추천', 'kia-food-008 직접 근거 추가'
),
(
  'video-2025-11', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA', '2025-02-18',
  '정정 맥락', '윤영철', '청년다방', 'excluded', 'corrected_non_recommendation',
  'high', '좋아하는 음식 발언이 맛집 추천처럼 편집되었다고 설명', '추천 DB 미반영'
),
(
  'video-2025-12', 'aNZ3LVyw4SA', 'KIA 공식 영상 - 광주 현지 선수들이 추천하는 맛집', 'https://www.youtube.com/watch?v=aNZ3LVyw4SA&t=128s', '2025-02-18',
  '약 02:08', '김태형', '삼일집', 'excluded', 'visit_mention_only',
  'medium-high', '함께 방문한 맥락이지 추천 식당으로 제시한 발화가 아님', '추천 관계 미추가'
),
(
  'video-rookie-01', 'VlYElV-_3g8', 'KIA 공식 영상 - 2026 신인들은 이것이 궁금하다', 'https://www.youtube.com/watch?v=VlYElV-_3g8&t=1248s', '2025-10-16',
  '20:48', '지현', null, 'excluded', 'request_for_recommendation',
  'high', '팬에게 광주 밥집 추천을 요청했을 뿐 특정 식당을 추천하지 않음', '추천 DB 미반영'
)
on conflict (review_id) do update set
  video_id = excluded.video_id,
  video_title = excluded.video_title,
  source_url = excluded.source_url,
  published_at = excluded.published_at,
  segment = excluded.segment,
  player_name = excluded.player_name,
  mentioned_restaurant = excluded.mentioned_restaurant,
  decision = excluded.decision,
  relation_type = excluded.relation_type,
  confidence = excluded.confidence,
  reason = excluded.reason,
  db_action = excluded.db_action,
  updated_at = now();
