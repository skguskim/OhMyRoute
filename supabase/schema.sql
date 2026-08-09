-- 오매루트 선호 벡터 추천 MVP
-- Supabase Dashboard > SQL Editor에서 실행하세요.

create extension if not exists vector with schema extensions;

create table if not exists public.places (
  id bigint generated always as identity primary key,
  source text not null default 'prototype',
  source_place_id text not null,
  name text not null,
  region text not null,
  sigungu text,
  category text not null,
  description text not null default '',
  road_address text,
  lot_address text,
  latitude double precision not null,
  longitude double precision not null,
  phone text,
  website_url text,
  image_url text,
  duration_minutes integer not null default 90 check (duration_minutes > 0),
  indoor boolean not null default false,
  rain_ok boolean not null default false,
  family_friendly boolean not null default false,
  parking_available boolean,
  wheelchair_accessible boolean,
  pet_friendly boolean,
  requires_reservation boolean,
  price_min integer check (price_min >= 0),
  price_max integer check (price_max >= 0),
  status text not null default 'active'
    check (status in ('active', 'temporary_closed', 'permanent_closed', 'seasonal')),
  public_transport_score real not null default 0.5
    check (public_transport_score between 0 and 1),
  source_url text,
  source_updated_at timestamptz,
  last_verified_at timestamptz,
  license text,
  quality_status text not null default 'draft'
    check (quality_status in ('draft', 'reviewed', 'verified', 'rejected')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint places_price_range_check
    check (price_min is null or price_max is null or price_max >= price_min),
  unique (source, source_place_id)
);

-- schema.sql을 다시 실행해도 기존 프로토타입 테이블에 신규 열이 추가됩니다.
alter table public.places add column if not exists sigungu text;
alter table public.places add column if not exists road_address text;
alter table public.places add column if not exists lot_address text;
alter table public.places add column if not exists phone text;
alter table public.places add column if not exists website_url text;
alter table public.places add column if not exists image_url text;
alter table public.places add column if not exists parking_available boolean;
alter table public.places add column if not exists wheelchair_accessible boolean;
alter table public.places add column if not exists pet_friendly boolean;
alter table public.places add column if not exists requires_reservation boolean;
alter table public.places add column if not exists price_min integer check (price_min >= 0);
alter table public.places add column if not exists price_max integer check (price_max >= 0);
alter table public.places add column if not exists status text not null default 'active'
  check (status in ('active', 'temporary_closed', 'permanent_closed', 'seasonal'));
alter table public.places add column if not exists source_url text;
alter table public.places add column if not exists source_updated_at timestamptz;
alter table public.places add column if not exists last_verified_at timestamptz;
alter table public.places add column if not exists license text;
alter table public.places add column if not exists quality_status text not null default 'draft'
  check (quality_status in ('draft', 'reviewed', 'verified', 'rejected'));

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'places_price_range_check'
      and conrelid = 'public.places'::regclass
  ) then
    alter table public.places
      add constraint places_price_range_check
      check (price_min is null or price_max is null or price_max >= price_min);
  end if;
end
$$;

create table if not exists public.place_profiles (
  place_id bigint primary key references public.places(id) on delete cascade,
  hashtags text[] not null default '{}',
  tag_scores jsonb not null default '{}',

  -- 순서: 자연, 문화역사, 예술전시, 음식로컬,
  --       체험활동, 스포츠야구, 휴식산책, 축제야간
  preference_vector extensions.vector(8) not null,

  semantic_text text,
  semantic_embedding extensions.vector(512),
  embedding_model text,
  taxonomy_version text not null default '1.0.0',
  labeling_method text not null default 'manual'
    check (labeling_method in ('manual', 'llm', 'hybrid', 'import')),
  labeling_confidence real check (labeling_confidence between 0 and 1),
  labeling_evidence jsonb not null default '[]',
  reviewed_at timestamptz,
  updated_at timestamptz not null default now()
);

alter table public.place_profiles
  add column if not exists taxonomy_version text not null default '1.0.0';
alter table public.place_profiles
  add column if not exists labeling_method text not null default 'manual'
  check (labeling_method in ('manual', 'llm', 'hybrid', 'import'));
alter table public.place_profiles add column if not exists reviewed_at timestamptz;

create table if not exists public.place_sources (
  id bigint generated always as identity primary key,
  place_id bigint not null references public.places(id) on delete cascade,
  source text not null,
  source_place_id text not null,
  source_url text,
  license text,
  raw_payload jsonb not null default '{}',
  source_updated_at timestamptz,
  collected_at timestamptz not null default now(),
  verified_at timestamptz,
  unique (source, source_place_id)
);

create table if not exists public.place_opening_hours (
  place_id bigint not null references public.places(id) on delete cascade,
  day_of_week smallint not null check (day_of_week between 0 and 6),
  opens_at time,
  closes_at time,
  last_admission_at time,
  is_closed boolean not null default false,
  notes text,
  valid_from date,
  valid_until date,
  verified_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (place_id, day_of_week),
  check (valid_from is null or valid_until is null or valid_until >= valid_from),
  check (is_closed or (opens_at is not null and closes_at is not null))
);

create table if not exists public.route_edges (
  from_place_id bigint not null references public.places(id) on delete cascade,
  to_place_id bigint not null references public.places(id) on delete cascade,
  transport_mode text not null
    check (transport_mode in ('walk', 'transit', 'car', 'bicycle')),
  distance_m integer not null check (distance_m >= 0),
  duration_seconds integer not null check (duration_seconds > 0),
  provider text not null,
  provider_route_id text,
  collected_at timestamptz not null default now(),
  expires_at timestamptz,
  primary key (from_place_id, to_place_id, transport_mode, provider),
  check (from_place_id <> to_place_id)
);

create index if not exists places_active_verified_idx
  on public.places (region, category)
  where status = 'active' and quality_status = 'verified';

create index if not exists place_sources_place_idx
  on public.place_sources (place_id, collected_at desc);

create index if not exists route_edges_lookup_idx
  on public.route_edges (from_place_id, transport_mode, expires_at);

create table if not exists public.user_preferences (
  user_id uuid primary key references auth.users(id) on delete cascade,
  preference_vector extensions.vector(8) not null,
  constraints jsonb not null default '{}',
  updated_at timestamptz not null default now()
);

create table if not exists public.user_place_events (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  place_id bigint not null references public.places(id) on delete cascade,
  event_type text not null check (
    event_type in ('impression', 'click', 'save', 'visit', 'stamp', 'review', 'dismiss')
  ),
  rating real check (rating between 0 and 5),
  metadata jsonb not null default '{}',
  created_at timestamptz not null default now()
);

create index if not exists user_place_events_user_created_idx
  on public.user_place_events (user_id, created_at desc);

create index if not exists user_place_events_place_idx
  on public.user_place_events (place_id);

-- MVP 데이터는 작기 때문에 preference_vector는 정확 검색을 사용합니다.
-- 데이터가 충분히 커진 뒤 실행 계획과 지연시간을 확인하고 아래 인덱스를 추가하세요.
-- create index place_profiles_preference_hnsw_idx
--   on public.place_profiles using hnsw (preference_vector vector_cosine_ops);

create or replace function public.recommend_places(
  query_vector extensions.vector(8),
  match_count integer default 20,
  filter_rain_ok boolean default false,
  filter_family_friendly boolean default false,
  min_public_transport_score real default 0
)
returns table (
  place_id bigint,
  place_name text,
  region text,
  category text,
  description text,
  hashtags text[],
  preference_vector extensions.vector(8),
  latitude double precision,
  longitude double precision,
  duration_minutes integer,
  indoor boolean,
  rain_ok boolean,
  family_friendly boolean,
  public_transport_score real,
  similarity double precision
)
language sql
stable
set search_path = public, extensions
as $$
  select
    p.id,
    p.name,
    p.region,
    p.category,
    p.description,
    pp.hashtags,
    pp.preference_vector,
    p.latitude,
    p.longitude,
    p.duration_minutes,
    p.indoor,
    p.rain_ok,
    p.family_friendly,
    p.public_transport_score,
    1 - (pp.preference_vector <=> query_vector) as similarity
  from public.places p
  join public.place_profiles pp on pp.place_id = p.id
  where p.status = 'active'
    and p.quality_status in ('reviewed', 'verified')
    and (not filter_rain_ok or p.rain_ok)
    and (not filter_family_friendly or p.family_friendly)
    and p.public_transport_score >= min_public_transport_score
  order by pp.preference_vector <=> query_vector
  limit least(greatest(match_count, 1), 50);
$$;

alter table public.places enable row level security;
alter table public.place_profiles enable row level security;
alter table public.place_sources enable row level security;
alter table public.place_opening_hours enable row level security;
alter table public.route_edges enable row level security;
alter table public.user_preferences enable row level security;
alter table public.user_place_events enable row level security;

drop policy if exists "Public places are readable" on public.places;
create policy "Public places are readable"
  on public.places for select
  to anon, authenticated
  using (true);

drop policy if exists "Public place profiles are readable" on public.place_profiles;
create policy "Public place profiles are readable"
  on public.place_profiles for select
  to anon, authenticated
  using (true);

drop policy if exists "Public opening hours are readable" on public.place_opening_hours;
create policy "Public opening hours are readable"
  on public.place_opening_hours for select
  to anon, authenticated
  using (true);

drop policy if exists "Public route edges are readable" on public.route_edges;
create policy "Public route edges are readable"
  on public.route_edges for select
  to anon, authenticated
  using (true);

drop policy if exists "Users read own preferences" on public.user_preferences;
create policy "Users read own preferences"
  on public.user_preferences for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users insert own preferences" on public.user_preferences;
create policy "Users insert own preferences"
  on public.user_preferences for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users update own preferences" on public.user_preferences;
create policy "Users update own preferences"
  on public.user_preferences for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users read own events" on public.user_place_events;
create policy "Users read own events"
  on public.user_place_events for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users insert own events" on public.user_place_events;
create policy "Users insert own events"
  on public.user_place_events for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

grant execute on function public.recommend_places(
  extensions.vector,
  integer,
  boolean,
  boolean,
  real
) to anon, authenticated;
