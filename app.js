import {
  buildMidWeatherForecast,
  buildWeatherForecast,
  latestKmaBase,
  latestKmaMidBase,
  latLonToKmaGrid,
  mergeWeatherForecasts,
  normalizeKmaServiceKey,
  precipitationTypeLabel,
  previousKmaBase,
  previousKmaMidBase,
  weatherSuitabilityScore,
} from "./weather.mjs";

const AXES = [
  { key: "nature", label: "자연·풍경", emoji: "🌿" },
  { key: "culture", label: "문화·역사", emoji: "🏛" },
  { key: "art", label: "예술·전시", emoji: "🎨" },
  { key: "food", label: "음식·로컬", emoji: "🍚" },
  { key: "activity", label: "체험·활동", emoji: "🥾" },
  { key: "sports", label: "스포츠·야구", emoji: "⚾" },
];
const DISPLAY_AXIS_KEYS = ["sports", "nature", "culture", "art", "food", "activity"];
const AXIS_INDEX_BY_KEY = Object.fromEntries(AXES.map((axis, index) => [axis.key, index]));
const SPORTS_AXIS_INDEX = AXIS_INDEX_BY_KEY.sports;
const VERY_PREFERRED_THRESHOLD = 75;
const WALK_TIME_LIMIT_MIN = 40;
const WALK_TIME_LIMIT_MAX = 90;
const WALK_TIME_LIMIT_STEP = 10;
const WALK_TIME_LIMIT_DEFAULT = 60;
const MEAL_PARKING_DETOUR_LIMIT_MINUTES = 60;
const REVIEW_STORAGE_KEY = "omaeroute_reviews";
const REWARD_STORAGE_KEY = "omaeroute_rewards";
const CHAMPIONS_FIELD_STAMP_ASSET = "./assets/champions-field-line-v2.png";

const STAMP_THEMES = Object.freeze({
  food: { label: "광주 미식", asset: "./assets/stamps/themes/food.svg" },
  heritage: { label: "역사·전통", asset: "./assets/stamps/themes/heritage.svg" },
  culture: { label: "문화·예술", asset: "./assets/stamps/themes/culture.svg" },
  nature: { label: "자연·경관", asset: "./assets/stamps/themes/nature.svg" },
  garden: { label: "공원·정원", asset: "./assets/stamps/themes/garden.svg" },
  activity: { label: "체험·스포츠", asset: "./assets/stamps/themes/activity.svg" },
  walk: { label: "도보·산책", asset: "./assets/stamps/themes/walk.svg" },
  local: { label: "광주 로컬", asset: "./assets/stamps/themes/culture.svg" },
});

const STAMP_THEME_BY_CATEGORY = Object.freeze({
  "음식·로컬": "food",
  "역사·전통": "heritage",
  "문화·예술": "culture",
  "자연·경관": "nature",
  "공원·정원": "garden",
  "체험·스포츠": "activity",
  "도보·산책": "walk",
});

const ORIGINS = {
  songjeong_station: {
    name: "광주송정역",
    latitude: 35.1377,
    longitude: 126.7914,
  },
  bus_terminal: {
    name: "광주종합버스터미널(유스퀘어)",
    latitude: 35.1598,
    longitude: 126.8803,
  },
  champions_field: {
    name: "광주-기아 챔피언스필드",
    latitude: 35.1682,
    longitude: 126.8891,
  },
  gwangju_station: { name: "광주역", latitude: 35.1653, longitude: 126.9096 },
};

const DAY_START_MINUTES = 10 * 60;
const DEFAULT_DAILY_END_MINUTES = 24 * 60;
const MAX_TRIP_DAYS = 3;
const MIN_TRAVEL_WINDOW_MINUTES = 120;
const MEAL_DURATION_MINUTES = 60;
const MEAL_SLOTS = [
  { key: "lunch", label: "점심", targetMinutes: 12 * 60, windowStart: 11 * 60 + 30, windowEnd: 13 * 60 },
  { key: "dinner", label: "저녁", targetMinutes: 18 * 60, windowStart: 17 * 60 + 30, windowEnd: 19 * 60 },
];
const BASEBALL_GAME_DURATION_MINUTES = 210;
const STADIUM_FOOD_DURATION_MINUTES = 30;
const STADIUM_FOOD_LEAD_MINUTES = 45;
const CHAMPIONS_FIELD_GAME = {
  id: "baseball-game-champions-field",
  source: "baseball_schedule",
  sourcePlaceId: "champions-field-game",
  name: "광주-기아 챔피언스필드 야구 직관",
  region: "광주광역시 북구",
  category: "스포츠·야구",
  description: "광주-기아 챔피언스필드에서 KIA 타이거즈 경기를 관람하는 일정입니다. 경기 시간은 3시간~3시간 30분으로 확보합니다.",
  hashtags: ["#야구", "#KIA", "#직관", "#챔피언스필드"],
  vector: [0.05, 0.1, 0.05, 0.35, 0.45, 1, 0.1, 0.75],
  latitude: 35.1682,
  longitude: 126.8891,
  durationMinutes: BASEBALL_GAME_DURATION_MINUTES,
  indoor: false,
  rainOk: false,
  familyFriendly: true,
  publicTransportScore: 0.8,
  roadAddress: "광주광역시 북구 서림로 10",
  websiteUrl: "",
  imageUrl: "",
  parkingAvailable: true,
  wheelchairAccessible: true,
  petFriendly: false,
  requiresReservation: true,
  score: 2,
  displayScore: 1,
  reasons: ["스포츠·야구 매우 선호", "야구 직관 선택", "선택한 직관일 마지막 일정"],
  recommendedPlayers: [],
  activeRecommendedPlayers: [],
  isBaseballGame: true,
  endsTrip: false,
};
const WEATHER_LABELS = { sunny: "맑음", cloudy: "구름많음", rainy: "비·눈" };
const WEATHER_ICONS = { sunny: "☀️", cloudy: "☁️", rainy: "🌧️" };
const KMA_FORECAST_URL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
const KMA_MID_LAND_URL = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst";
const KMA_MID_TEMPERATURE_URL = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa";

const LOADING_PHRASES = [
  "출발지 기준 기상청 예보를 확인하고 있습니다.",
  "장소별 선호 벡터를 비교하고 있습니다.",
  "여행 시간과 이동수단에 맞지 않는 후보를 정리하고 있습니다.",
  "출발지에서 자연스럽게 이어지는 방문 순서를 계산하고 있습니다.",
  "각 장소를 추천한 이유를 여행 일정에 담고 있습니다.",
];

const PROMPT_AXIS_RULES = [
  {
    axis: 0,
    label: "자연·풍경",
    terms: ["자연", "숲", "공원", "호수", "정원", "피크닉", "풍경", "경치", "전망", "등산", "산행", "무등산"],
  },
  {
    axis: 1,
    label: "역사·문화",
    terms: ["역사", "전통", "문화유산", "근대", "민주", "인권", "한옥", "사찰", "기념관", "문화"],
  },
  {
    axis: 2,
    label: "예술·감성",
    terms: ["예술", "미술", "전시", "갤러리", "공연", "사진", "감성", "미디어아트", "비엔날레"],
  },
  {
    axis: 3,
    label: "맛집·카페",
    terms: ["맛집", "음식", "먹거리", "미식", "로컬푸드", "카페", "디저트", "시장", "떡갈비", "비빔밥"],
  },
  {
    axis: 4,
    label: "체험·활동",
    terms: ["체험", "참여", "레저", "수영", "액티비티", "활동", "놀이", "VR", "만들기"],
  },
  {
    axis: 5,
    label: "스포츠",
    terms: ["스포츠", "축구", "야구", "경기", "응원", "챔피언스필드", "체육"],
  },
  {
    axis: 6,
    label: "휴식·산책",
    terms: ["조용", "여유", "힐링", "느린", "느긋", "산책", "휴식", "쉬고", "걷고", "걷기"],
  },
  {
    axis: 7,
    label: "축제·야간",
    terms: ["축제", "행사", "페스티벌", "시즌", "야간", "야경", "불빛", "밤거리"],
  },
];

const PROMPT_META_RULES = [
  { key: "indoor", label: "실내 우선", terms: ["실내", "비 피해서", "밖에 나가지"] },
  { key: "family", label: "아이·가족 동행", terms: ["아이", "어린이", "아기", "유아", "가족"] },
  { key: "parents", label: "부모님 동행", terms: ["부모님", "어르신", "노약자"] },
  { key: "wheelchair", label: "휠체어 접근", terms: ["휠체어", "거동 불편", "계단 적게", "무장애"] },
  { key: "parking", label: "주차 편의", terms: ["주차", "주차장"] },
  { key: "pet", label: "반려동물 동행", terms: ["반려동물", "강아지", "반려견", "애견"] },
];

const state = {
  places: [],
  stadiumFoods: [],
  stadiumFoodLoadFailed: false,
  openingHoursByPlace: new Map(),
  openingHoursLoadFailed: false,
  baseballGamesByDate: new Map(),
  baseballGamesLoadFailed: false,
  baseballGamesSource: "local",
  results: [],
  route: [],
  routeDays: [],
  dayWindows: [],
  replannedDays: new Map(),
  selectedDay: 0,
  duration: 240,
  transport: "public",
  walkTimeLimitMinutes: 60,
  preference: [50, 50, 50, 50, 50, 50],
  travelPrompt: "",
  promptAnalysis: {
    raw: "",
    axisBoost: Array(AXES.length).fill(0),
    labels: [],
    matchedAxes: [],
    excludedTerms: [],
    requiredTags: [],
    namedPlaceIds: [],
  },
  savedRoutes: [],
  weatherForecast: null,
  weatherAbortController: null,
  weatherCache: new Map(),
  mealWarnings: [],
  scheduleWarnings: [],
  loading: false,
  kakaoMap: null,
  kakaoPolyline: null,
  kakaoMarkers: [],
  kakaoOverlays: [],
  mapResizeBound: false,
  previewPlaying: false,
  previewVideoStatus: "idle",
  previewVideoRequestToken: 0,
  previewVideoPollTimer: null,
  stampedIds: [],
  stampLocation: null,
  stampLocationMode: "GPS",
  stampToastTimer: null,
  stampPatternCategories: new Map(),
  reviews: [],
  rewards: [],
  baseballAttendance: false,
  baseballDayIndexes: [],
  baseballDaySelectionTouched: false,
  baseballPreviousEnd: null,
  baseballAdjustedFinalEnd: false,
};

let kakaoSdkPromise = null;

const $ = (selector, root = document) => root.querySelector(selector);
const $$ = (selector, root = document) => [...root.querySelectorAll(selector)];

function escapeHtml(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function clamp(value, min, max) {
  return Math.min(max, Math.max(min, value));
}

function wait(milliseconds) {
  return new Promise((resolve) => window.setTimeout(resolve, milliseconds));
}

function cosineSimilarity(a, b) {
  const dot = a.reduce((sum, value, index) => sum + value * b[index], 0);
  const normA = Math.sqrt(a.reduce((sum, value) => sum + value ** 2, 0));
  const normB = Math.sqrt(b.reduce((sum, value) => sum + value ** 2, 0));
  return normA && normB ? dot / (normA * normB) : 0;
}

function haversineKm(a, b) {
  const radius = 6371;
  const toRad = (degree) => (degree * Math.PI) / 180;
  const dLat = toRad(b.latitude - a.latitude);
  const dLon = toRad(b.longitude - a.longitude);
  const lat1 = toRad(a.latitude);
  const lat2 = toRad(b.latitude);
  const h =
    Math.sin(dLat / 2) ** 2 +
    Math.sin(dLon / 2) ** 2 * Math.cos(lat1) * Math.cos(lat2);
  return radius * 2 * Math.atan2(Math.sqrt(h), Math.sqrt(1 - h));
}

function emptyPromptAnalysis(raw = "") {
  return {
    raw,
    axisBoost: Array(AXES.length).fill(0),
    labels: [],
    matchedAxes: [],
    matchedTerms: [],
    excludedTerms: [],
    requiredTags: [],
    namedPlaceIds: [],
    rainy: false,
    indoor: false,
    indoorOnly: false,
    family: false,
    parents: false,
    wheelchair: false,
    parking: false,
    pet: false,
    minimizeTravel: false,
    slowPace: false,
    relaxed: false,
  };
}

function normalizePrompt(value) {
  return String(value || "")
    .normalize("NFKC")
    .replace(/\s+/g, " ")
    .trim()
    .toLowerCase();
}

function termIsExcluded(text, term) {
  const escaped = term.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const suffixNegation = new RegExp(
    `${escaped}(?:은|는|이|가|을|를|도)?\\s*(?:말고|제외|빼|싫|없이|아닌)`,
    "i",
  );
  const prefixNegation = new RegExp(
    `(?:제외할|제외하고|빼고|싫은|원치 않는|안 갈)\\s*[^,.]{0,5}${escaped}`,
    "i",
  );
  return suffixNegation.test(text) || prefixNegation.test(text);
}

function analyzeTravelPrompt(value) {
  const raw = String(value || "").trim();
  const text = normalizePrompt(raw);
  const analysis = emptyPromptAnalysis(raw);
  if (!text) return analysis;

  PROMPT_AXIS_RULES.forEach((rule) => {
    const matched = rule.terms.filter((term) => text.includes(term));
    const excluded = matched.filter((term) => termIsExcluded(text, term));
    const positive = matched.filter((term) => !excluded.includes(term));
    if (positive.length) {
      analysis.axisBoost[rule.axis] = Math.min(0.32, 0.16 + (positive.length - 1) * 0.055);
      analysis.matchedAxes.push({ axis: rule.axis, label: rule.label, terms: positive });
      analysis.matchedTerms.push(...positive);
    }
    if (excluded.length) {
      analysis.axisBoost[rule.axis] = Math.max(-0.18, analysis.axisBoost[rule.axis] - 0.14);
      analysis.excludedTerms.push(...excluded);
    }
  });

  PROMPT_META_RULES.forEach((rule) => {
    analysis[rule.key] = rule.terms.some((term) => text.includes(term) && !termIsExcluded(text, term));
  });

  analysis.rainy = /비\s*(?:가|는|오는|올|내리)|우천|장마/.test(text);
  analysis.indoorOnly =
    analysis.indoor && /실내\s*(?:만|위주|중심)|밖(?:은|에)\s*(?:싫|제외|안)/.test(text);
  analysis.minimizeTravel =
    /이동(?:은|을)?\s*(?:적게|짧게|최소)|동선(?:은|을)?\s*(?:짧게|간단)|가까운 곳|많이 걷지|걷기 힘|차로 가까/.test(text);
  analysis.slowPace =
    analysis.parents || /천천히|여유롭게|느긋하게|빡빡하지|쉬엄쉬엄|느린 여행/.test(text);

  const requestsCafe = text.includes("카페") && !termIsExcluded(text, "카페");
  if (
    requestsCafe &&
    /카페[^,.]{0,12}(?:한\s*곳|들러|넣|포함|가고|원해)|(?:한\s*곳|들러|넣|포함)[^,.]{0,12}카페/.test(text)
  ) {
    analysis.requiredTags.push("#카페");
  }

  if (analysis.rainy) analysis.labels.push("비 오는 날");
  if (analysis.indoor) analysis.labels.push("실내 우선");
  if (analysis.family) analysis.labels.push("아이·가족 동행");
  if (analysis.parents) analysis.labels.push("부모님 동행");
  if (analysis.minimizeTravel) analysis.labels.push("이동 최소화");
  if (analysis.slowPace && !analysis.parents) analysis.labels.push("여유로운 일정");
  if (analysis.wheelchair) analysis.labels.push("휠체어 접근");
  if (analysis.parking) analysis.labels.push("주차 편의");
  if (analysis.pet) analysis.labels.push("반려동물 동행");
  analysis.matchedAxes
    .sort((a, b) => analysis.axisBoost[b.axis] - analysis.axisBoost[a.axis])
    .forEach((item) => analysis.labels.push(item.label));
  if (analysis.excludedTerms.length) {
    analysis.labels.push(`${[...new Set(analysis.excludedTerms)].join("·")} 제외`);
  }
  if (analysis.requiredTags.includes("#카페")) analysis.labels.push("카페 1곳 포함");
  analysis.labels = [...new Set(analysis.labels)].slice(0, 7);
  analysis.excludedTerms = [...new Set(analysis.excludedTerms)];
  analysis.matchedTerms = [...new Set(analysis.matchedTerms)];
  return analysis;
}

function currentVector() {
  const boost = state.promptAnalysis?.axisBoost || [];
  return state.preference.map((value, index) => clamp(value / 100 + (boost[index] || 0), 0, 1));
}

function hasPreferenceSignals(vector = currentVector()) {
  return vector.some((value) => value > 0);
}

function currentConditions() {
  const selectedCompanion = $("#companion").value;
  const weatherMode = $("#weather").value;
  const automaticWeather = state.weatherForecast?.status === "ready"
    ? state.weatherForecast.condition
    : "sunny";
  const selectedWeather = weatherMode === "auto" ? automaticWeather : weatherMode;
  const sportsBaseballHighlyPreferred = state.preference[SPORTS_AXIS_INDEX] > VERY_PREFERRED_THRESHOLD;
  const baseballDayIndexes = selectedBaseballDayIndexes();
  return {
    originKey: $("#origin").value,
    origin: ORIGINS[$("#origin").value],
    travelDate: $("#travelDate").value,
    startTime: $("#startTime").value || "10:00",
    endDate: $("#endDate").value,
    endTime: $("#endTime").value || "18:00",
    selectedCompanion,
    selectedWeather,
    weatherMode,
    companion: state.promptAnalysis.family ? "family" : selectedCompanion,
    weather: state.promptAnalysis.rainy ? "rainy" : selectedWeather,
    promptRainy: state.promptAnalysis.rainy,
    promptFamily: state.promptAnalysis.family,
    sportsBaseballHighlyPreferred,
    baseballAttendance: sportsBaseballHighlyPreferred && state.baseballAttendance && baseballDayIndexes.length > 0,
    baseballDayIndexes,
    transport: state.transport,
    duration: state.duration,
  };
}

function parseClockMinutes(value) {
  const [hour, minute] = String(value || "10:00").split(":").map(Number);
  if (!Number.isFinite(hour) || !Number.isFinite(minute)) return DAY_START_MINUTES;
  return clamp(hour * 60 + minute, 0, 24 * 60 - 1);
}

function formatClockMinutes(value) {
  const normalized = ((Math.round(value) % (24 * 60)) + 24 * 60) % (24 * 60);
  return `${String(Math.floor(normalized / 60)).padStart(2, "0")}:${String(normalized % 60).padStart(2, "0")}`;
}

const ITINERARY_TIME_STEP_MINUTES = 5;

function roundUpToStep(minutes, step = ITINERARY_TIME_STEP_MINUTES) {
  return Math.ceil(minutes / step) * step;
}

function setTimeFieldValue(hiddenInput, value) {
  if (!hiddenInput) return;
  hiddenInput.value = value;
  const minutes = parseClockMinutes(value);
  const wrap = hiddenInput.closest(".time-field-wrap");
  const hourInput = wrap?.querySelector('[data-role="hour"]');
  const minuteInput = wrap?.querySelector('[data-role="minute"]');
  if (hourInput) hourInput.value = String(Math.floor(minutes / 60)).padStart(2, "0");
  if (minuteInput) minuteInput.value = String(minutes % 60).padStart(2, "0");
}

function bindTimeSegments(hiddenInput, minuteStep = 1) {
  if (!hiddenInput) return;
  const wrap = hiddenInput.closest(".time-field-wrap");
  const hourInput = wrap?.querySelector('[data-role="hour"]');
  const minuteInput = wrap?.querySelector('[data-role="minute"]');
  if (!hourInput || !minuteInput) return;

  const commit = () => {
    const hour = clamp(Number(hourInput.value) || 0, 0, 23);
    const minute = clamp(Number(minuteInput.value) || 0, 0, 59);
    hourInput.value = String(hour).padStart(2, "0");
    minuteInput.value = String(minute).padStart(2, "0");
    const combined = `${hourInput.value}:${minuteInput.value}`;
    if (hiddenInput.value !== combined) {
      hiddenInput.value = combined;
      hiddenInput.dispatchEvent(new Event("change", { bubbles: true }));
    }
  };

  const adjustSegment = (input, delta, max) => {
    const current = Number(input.value) || 0;
    input.value = String((((current + delta) % max) + max) % max).padStart(2, "0");
    commit();
  };

  [
    { input: hourInput, max: 24, step: 1 },
    { input: minuteInput, max: 60, step: minuteStep },
  ].forEach(({ input, max, step }) => {
    input.addEventListener("input", () => {
      input.value = input.value.replace(/\D/g, "").slice(0, 2);
    });
    input.addEventListener("blur", commit);
    input.addEventListener("wheel", (event) => {
      event.preventDefault();
      adjustSegment(input, event.deltaY < 0 ? step : -step, max);
    }, { passive: false });
    input.addEventListener("keydown", (event) => {
      if (event.key === "ArrowUp") {
        event.preventDefault();
        adjustSegment(input, step, max);
      } else if (event.key === "ArrowDown") {
        event.preventDefault();
        adjustSegment(input, -step, max);
      }
    });
  });
}

function setWalkTimeLimitFieldValue(minutes) {
  const hiddenInput = $("#walkTimeLimit");
  const segmentInput = $('#walkTimeLimitField [data-role="walkLimit"]');
  const clamped = clamp(Number(minutes) || WALK_TIME_LIMIT_DEFAULT, WALK_TIME_LIMIT_MIN, WALK_TIME_LIMIT_MAX);
  if (hiddenInput) hiddenInput.value = String(clamped);
  if (segmentInput) segmentInput.value = String(clamped).padStart(2, "0");
}

function bindWalkTimeLimitStepper() {
  const hiddenInput = $("#walkTimeLimit");
  const segmentInput = $('#walkTimeLimitField [data-role="walkLimit"]');
  if (!hiddenInput || !segmentInput) return;

  const commit = () => {
    const clamped = clamp(Number(segmentInput.value) || WALK_TIME_LIMIT_DEFAULT, WALK_TIME_LIMIT_MIN, WALK_TIME_LIMIT_MAX);
    segmentInput.value = String(clamped).padStart(2, "0");
    if (Number(hiddenInput.value) !== clamped) {
      hiddenInput.value = String(clamped);
      hiddenInput.dispatchEvent(new Event("change", { bubbles: true }));
    }
  };

  const adjust = (delta) => {
    const current = Number(segmentInput.value) || WALK_TIME_LIMIT_DEFAULT;
    segmentInput.value = String(clamp(current + delta, WALK_TIME_LIMIT_MIN, WALK_TIME_LIMIT_MAX));
    commit();
  };

  segmentInput.addEventListener("input", () => {
    segmentInput.value = segmentInput.value.replace(/\D/g, "").slice(0, 2);
  });
  segmentInput.addEventListener("blur", commit);
  segmentInput.addEventListener("wheel", (event) => {
    event.preventDefault();
    adjust(event.deltaY < 0 ? WALK_TIME_LIMIT_STEP : -WALK_TIME_LIMIT_STEP);
  }, { passive: false });
  segmentInput.addEventListener("keydown", (event) => {
    if (event.key === "ArrowUp") {
      event.preventDefault();
      adjust(WALK_TIME_LIMIT_STEP);
    } else if (event.key === "ArrowDown") {
      event.preventDefault();
      adjust(-WALK_TIME_LIMIT_STEP);
    }
  });
  hiddenInput.addEventListener("change", () => {
    state.walkTimeLimitMinutes = clamp(Number(hiddenInput.value) || WALK_TIME_LIMIT_DEFAULT, WALK_TIME_LIMIT_MIN, WALK_TIME_LIMIT_MAX);
  });
}

function dateOrdinal(value) {
  const [year, month, day] = String(value || "").split("-").map(Number);
  if (![year, month, day].every(Number.isFinite)) return Number.NaN;
  return Math.floor(Date.UTC(year, month - 1, day) / 86400000);
}

function baseballScheduleForDate(dateValue) {
  const game = baseballGameForDate(dateValue, { selectableOnly: true });
  if (!game) return null;
  const ordinal = dateOrdinal(dateValue);
  const dayOfWeek = Number.isFinite(ordinal)
    ? new Date(ordinal * 86400000).getUTCDay()
    : 1;
  const weekend = dayOfWeek === 0 || dayOfWeek === 6;
  const timeMatch = String(game.scheduled_start_at || "").match(/T(\d{2}):(\d{2})/);
  const gameStartMinutes = timeMatch
    ? Number(timeMatch[1]) * 60 + Number(timeMatch[2])
    : parseClockMinutes(game.start_time || "19:00");
  const gameEndMinutes = gameStartMinutes + BASEBALL_GAME_DURATION_MINUTES;
  return {
    date: dateValue,
    game,
    weekend,
    dayTypeLabel: weekend ? "주말" : "평일",
    gameStartMinutes,
    gameEndMinutes,
    stadiumFoodStartMinutes: gameStartMinutes - STADIUM_FOOD_LEAD_MINUTES,
  };
}

function conditionsForRouteDate(conditions, date) {
  if (conditions.weatherMode !== "auto") return conditions;
  const forecastDay = state.weatherForecast?.status === "ready"
    ? state.weatherForecast.days.find((day) => day.date === date && day.slots.length)
    : null;
  const selectedWeather = forecastDay?.condition || "sunny";
  return {
    ...conditions,
    selectedWeather,
    weather: conditions.promptRainy ? "rainy" : selectedWeather,
    weatherForecastSource: forecastDay?.source || "unavailable",
  };
}

function baseballGamesForDate(dateValue) {
  return state.baseballGamesByDate.get(String(dateValue)) || [];
}

function baseballGameForDate(dateValue, { selectableOnly = false } = {}) {
  const games = baseballGamesForDate(dateValue);
  if (selectableOnly) {
    return games.find((game) => ["scheduled", "in_progress"].includes(game.status)) || null;
  }
  return games.find((game) => ["scheduled", "in_progress"].includes(game.status))
    || games.find((game) => game.status === "cancelled")
    || games[0]
    || null;
}

function baseballGameOptionStatus(dateValue) {
  const games = baseballGamesForDate(dateValue);
  const selectableGame = baseballGameForDate(dateValue, { selectableOnly: true });
  if (selectableGame) {
    const schedule = baseballScheduleForDate(dateValue);
    return {
      selectable: true,
      game: selectableGame,
      label: `${selectableGame.away_team_name} vs KIA · ${formatClockMinutes(schedule.gameStartMinutes)}`,
    };
  }
  const cancelled = games.find((game) => game.status === "cancelled");
  if (cancelled) return { selectable: false, game: cancelled, label: `${cancelled.away_team_name}전 취소` };
  const postponed = games.find((game) => game.status === "postponed");
  if (postponed) return { selectable: false, game: postponed, label: `${postponed.away_team_name}전 연기` };
  const completed = games.find((game) => game.status === "completed");
  if (completed) return { selectable: false, game: completed, label: `${completed.away_team_name}전 종료` };
  return { selectable: false, game: null, label: "광주 홈경기 없음" };
}

function openingHoursForPlace(place) {
  return state.openingHoursByPlace.get(String(place?.id)) || [];
}

function openingHoursForDate(place, dateValue) {
  const ordinal = dateOrdinal(dateValue);
  if (!Number.isFinite(ordinal)) return null;
  const dayOfWeek = new Date(ordinal * 86400000).getUTCDay();
  return openingHoursForPlace(place)
    .filter((hours) => Number(hours.day_of_week) === dayOfWeek)
    .filter((hours) => !hours.valid_from || dateValue >= hours.valid_from)
    .filter((hours) => !hours.valid_until || dateValue <= hours.valid_until)
    .sort((a, b) => String(b.valid_from || "").localeCompare(String(a.valid_from || "")))[0] || null;
}

// 수영장·눈썰매장처럼 계절 한정으로 운영하는 장소를 시즌 밖 날짜에서 제외한다. 계절 필드가 없는 장소는 항상 통과한다.
function placeIsOpenInSeason(place, dateValue) {
  if (!place.seasonStartMonthDay || !place.seasonEndMonthDay) return true;
  const [, month, day] = String(dateValue).split("-").map(Number);
  if (!Number.isFinite(month) || !Number.isFinite(day)) return true;
  const [startMonth, startDay] = place.seasonStartMonthDay.split("-").map(Number);
  const [endMonth, endDay] = place.seasonEndMonthDay.split("-").map(Number);
  const monthDay = month * 100 + day;
  const start = startMonth * 100 + startDay;
  const end = endMonth * 100 + endDay;
  // 연말~연초처럼 시즌이 연도 경계를 넘는 경우(예: 12-20 ~ 02-22)를 함께 처리한다.
  return start <= end ? monthDay >= start && monthDay <= end : monthDay >= start || monthDay <= end;
}

function placeIsOpenOnDate(place, dateValue) {
  if (!placeIsOpenInSeason(place, dateValue)) return false;
  const hours = openingHoursForDate(place, dateValue);
  return !hours || hours.is_closed !== true;
}

function formatTripDate(dateValue) {
  const ordinal = dateOrdinal(dateValue);
  const [, month, day] = String(dateValue).split("-").map(Number);
  const weekday = Number.isFinite(ordinal)
    ? ["일", "월", "화", "수", "목", "금", "토"][new Date(ordinal * 86400000).getUTCDay()]
    : "";
  return `${month}월 ${day}일${weekday ? `(${weekday})` : ""}`;
}

function addClosedNamedPlaceWarnings(dateValue, dayIndex) {
  state.promptAnalysis.namedPlaceIds.forEach((placeId) => {
    const place = state.places.find((candidate) => String(candidate.id) === String(placeId));
    if (!place || placeIsOpenOnDate(place, dateValue)) return;
    const reason = !placeIsOpenInSeason(place, dateValue)
      ? "운영 기간이 아님"
      : openingHoursForDate(place, dateValue)?.notes || "휴무일";
    const warning = `Day ${dayIndex + 1} · ${formatTripDate(dateValue)} ${place.name}은 ${reason}라 일정에서 제외했습니다.`;
    if (!state.scheduleWarnings.includes(warning)) state.scheduleWarnings.push(warning);
  });
}

function baseballTripDates() {
  const startDate = $("#travelDate")?.value;
  const endDate = $("#endDate")?.value || startDate;
  const startOrdinal = dateOrdinal(startDate);
  const endOrdinal = dateOrdinal(endDate);
  if (!Number.isFinite(startOrdinal) || !Number.isFinite(endOrdinal) || endOrdinal < startOrdinal) {
    return startDate ? [startDate] : [];
  }
  const dayCount = Math.min(endOrdinal - startOrdinal + 1, MAX_TRIP_DAYS);
  return Array.from({ length: dayCount }, (_, index) => shiftDateValue(startDate, index));
}

function selectedBaseballDayIndexes({ ensureSelection = state.baseballAttendance } = {}) {
  const dates = baseballTripDates();
  if (!dates.length) {
    state.baseballDayIndexes = [];
    return [];
  }
  const checkedIndexes = $$('#baseballDayOptions input[type="checkbox"]:checked')
    .map((input) => Number(input.value))
    .filter(Number.isInteger);
  const requested = checkedIndexes.length ? checkedIndexes : state.baseballDayIndexes;
  const normalized = [...new Set((Array.isArray(requested) ? requested : [])
    .map(Number)
    .filter((index) => Number.isInteger(index)
      && index >= 0
      && index < dates.length
      && Boolean(baseballGameForDate(dates[index], { selectableOnly: true }))))]
    .sort((a, b) => a - b);
  if (ensureSelection && !normalized.length) {
    const fallbackIndex = dates
      .map((dateValue, index) => baseballGameForDate(dateValue, { selectableOnly: true }) ? index : -1)
      .filter((index) => index >= 0)
      .at(-1);
    if (Number.isInteger(fallbackIndex)) normalized.push(fallbackIndex);
  }
  state.baseballDayIndexes = normalized;
  return normalized;
}

function formatBaseballDayOption(dateValue, index) {
  const [year, month, day] = String(dateValue).split("-").map(Number);
  const ordinal = dateOrdinal(dateValue);
  const weekday = Number.isFinite(ordinal)
    ? ["일", "월", "화", "수", "목", "금", "토"][new Date(ordinal * 86400000).getUTCDay()]
    : "";
  return `Day ${index + 1} · ${year}년 ${month}월 ${day}일 (${weekday})`;
}

function populateBaseballDayOptions() {
  const options = $("#baseballDayOptions");
  if (!options) return baseballTripDates();
  const dates = baseballTripDates();
  const selectableIndexes = dates
    .map((dateValue, index) => baseballGameForDate(dateValue, { selectableOnly: true }) ? index : -1)
    .filter((index) => index >= 0);
  if (!state.baseballDaySelectionTouched && !state.baseballDayIndexes.length && selectableIndexes.length) {
    state.baseballDayIndexes = [selectableIndexes.at(-1)];
  }
  const selectedIndexes = selectedBaseballDayIndexes({ ensureSelection: true });
  options.innerHTML = dates
    .map((dateValue, index) => {
      const optionStatus = baseballGameOptionStatus(dateValue);
      return `
        <label class="baseball-day-option ${optionStatus.selectable ? "" : "unavailable"}">
          <input type="checkbox" value="${index}"
            ${selectedIndexes.includes(index) ? "checked" : ""}
            ${optionStatus.selectable ? "" : "disabled"} />
          <span>
            <b>${escapeHtml(formatBaseballDayOption(dateValue, index))}</b>
            <small>${escapeHtml(optionStatus.label)}</small>
          </span>
        </label>
      `;
    })
    .join("");
  return dates;
}

function clearBaseballDaySelection() {
  state.baseballDayIndexes = [];
  state.baseballDaySelectionTouched = false;
  const options = $("#baseballDayOptions");
  if (options) options.innerHTML = "";
}

function restoreBaseballTravelEnd() {
  if (!state.baseballPreviousEnd) return;
  $("#endDate").value = state.baseballPreviousEnd.endDate;
  setTimeFieldValue($("#endTime"), state.baseballPreviousEnd.endTime);
  state.baseballAdjustedFinalEnd = false;
}

function updateBaseballAttendanceControl({ adjustTravelWindow = false } = {}) {
  const panel = $("#baseballAttendancePanel");
  const checkbox = $("#baseballAttendance");
  const status = $("#baseballScheduleStatus");
  const dayField = $("#baseballDayField");
  if (!panel || !checkbox || !status) return;

  const eligible = state.preference[SPORTS_AXIS_INDEX] > VERY_PREFERRED_THRESHOLD;
  panel.hidden = !eligible;
  if (!eligible) {
    if (state.baseballAttendance && state.baseballPreviousEnd) {
      restoreBaseballTravelEnd();
    }
    checkbox.checked = false;
    state.baseballAttendance = false;
    clearBaseballDaySelection();
    state.baseballPreviousEnd = null;
    state.baseballAdjustedFinalEnd = false;
    syncTravelWindow();
    return;
  }

  if (!checkbox.checked) {
    state.baseballAttendance = false;
    if (dayField) dayField.hidden = true;
    clearBaseballDaySelection();
    status.hidden = false;
    status.classList.remove("warning");
    status.textContent = "직관 포함을 켜면 여행 기간에서 경기 날짜를 여러 개 고를 수 있습니다.";
    return;
  }

  state.baseballAttendance = true;
  const tripDates = populateBaseballDayOptions();
  const baseballDayIndexes = selectedBaseballDayIndexes({ ensureSelection: true });
  if (dayField) dayField.hidden = tripDates.length === 0;
  if (adjustTravelWindow) {
    if (state.baseballAdjustedFinalEnd) restoreBaseballTravelEnd();
    const finalDayIndex = tripDates.length - 1;
    if (baseballDayIndexes.includes(finalDayIndex)) {
      const finalDaySchedule = baseballScheduleForDate(tripDates[finalDayIndex]);
      if (finalDaySchedule) {
        setTimeFieldValue($("#endTime"), formatClockMinutes(finalDaySchedule.gameEndMinutes));
        state.baseballAdjustedFinalEnd = true;
      }
    }
    syncTravelWindow();
  }
  status.classList.toggle("warning", baseballDayIndexes.length === 0 || state.baseballGamesLoadFailed);
  if (state.baseballGamesLoadFailed) {
    status.hidden = false;
    status.textContent = "경기 DB를 불러오지 못했습니다. 잠시 후 다시 확인해 주세요.";
  } else if (!baseballDayIndexes.length) {
    status.hidden = false;
    status.textContent = "선택한 여행 기간에는 관람 가능한 광주 KIA 홈경기가 없습니다. 경기 없는 날·종료·취소·연기 경기는 선택할 수 없습니다.";
  } else {
    status.textContent = "";
    status.hidden = true;
  }
}

function setBaseballAttendance(active) {
  const checkbox = $("#baseballAttendance");
  if (!checkbox) return;
  if (active && !state.baseballAttendance) {
    state.baseballPreviousEnd = {
      endDate: $("#endDate").value,
      endTime: $("#endTime").value,
    };
  }
  checkbox.checked = active;
  if (!active) {
    if (state.baseballPreviousEnd) restoreBaseballTravelEnd();
    state.baseballPreviousEnd = null;
    state.baseballAttendance = false;
    clearBaseballDaySelection();
    syncTravelWindow();
    updateBaseballAttendanceControl();
    return;
  }
  updateBaseballAttendanceControl({ adjustTravelWindow: active });
}

function dateTimeMinutes(dateValue, timeValue) {
  const ordinal = dateOrdinal(dateValue);
  if (!Number.isFinite(ordinal)) return Number.NaN;
  return ordinal * 24 * 60 + parseClockMinutes(timeValue);
}

function travelDayWindows(conditions = currentConditions()) {
  const startOrdinal = dateOrdinal(conditions.travelDate);
  const endOrdinal = dateOrdinal(conditions.endDate);
  if (!Number.isFinite(startOrdinal) || !Number.isFinite(endOrdinal) || endOrdinal < startOrdinal) return [];
  const dayCount = Math.min(endOrdinal - startOrdinal + 1, MAX_TRIP_DAYS);
  const startMinutes = parseClockMinutes(conditions.startTime);
  const endMinutes = parseClockMinutes(conditions.endTime);
  return Array.from({ length: dayCount }, (_, index) => {
    const isFirst = index === 0;
    const isLast = index === dayCount - 1;
    return {
      date: shiftDateValue(conditions.travelDate, index),
      startMinutes: isFirst ? startMinutes : DAY_START_MINUTES,
      endMinutes: isLast ? endMinutes : DEFAULT_DAILY_END_MINUTES,
    };
  }).filter((window) => window.endMinutes - window.startMinutes >= 60);
}

function activeTravelMinutes(conditions) {
  return travelDayWindows(conditions).reduce(
    (sum, window) => sum + window.endMinutes - window.startMinutes,
    0,
  );
}

function syncTravelWindow({ reportValidity = false } = {}) {
  const startDateInput = $("#travelDate");
  const endDateInput = $("#endDate");
  const startTimeInput = $("#startTime");
  const endTimeInput = $("#endTime");
  const status = $("#scheduleFieldStatus");
  if (!startDateInput || !endDateInput || !startTimeInput || !endTimeInput) return false;

  endDateInput.min = startDateInput.value;
  endDateInput.max = startDateInput.value ? shiftDateValue(startDateInput.value, MAX_TRIP_DAYS - 1) : "";
  const start = dateTimeMinutes(startDateInput.value, startTimeInput.value);
  const end = dateTimeMinutes(endDateInput.value, endTimeInput.value);
  const calendarDays = dateOrdinal(endDateInput.value) - dateOrdinal(startDateInput.value) + 1;
  let message = "";
  if (!Number.isFinite(start) || !Number.isFinite(end)) {
    message = "출발일·시작 시각과 귀가일·종료 시각을 모두 입력해주세요.";
  } else if (end <= start) {
    message = "여행 종료 시각은 여행 시작 시각보다 뒤여야 합니다.";
  } else if (calendarDays > MAX_TRIP_DAYS) {
    message = `현재 루트는 최대 ${MAX_TRIP_DAYS - 1}박 ${MAX_TRIP_DAYS}일까지 만들 수 있습니다.`;
  }

  const draftConditions = {
    travelDate: startDateInput.value,
    startTime: startTimeInput.value,
    endDate: endDateInput.value,
    endTime: endTimeInput.value,
  };
  const activeMinutes = message ? 0 : activeTravelMinutes(draftConditions);
  if (!message && activeMinutes < MIN_TRAVEL_WINDOW_MINUTES) {
    message = "이동과 방문 일정을 만들려면 최소 2시간 이상 필요합니다.";
  }

  endTimeInput.setCustomValidity(message);
  status?.classList.toggle("warning", Boolean(message));
  if (message) {
    if (status) status.textContent = message;
    if (reportValidity) endTimeInput.reportValidity();
    return false;
  }

  state.duration = activeMinutes;
  state.dayWindows = travelDayWindows(draftConditions);
  const tripLabel = calendarDays > 1 ? `${calendarDays - 1}박 ${calendarDays}일` : "당일";
  if (status) {
    status.textContent = tripLabel;
  }
  return true;
}

function legacyEndDateTime(travelDate, startTime, duration) {
  const minutes = Number(duration) || 480;
  if (minutes >= 900) {
    return {
      endDate: shiftDateValue(travelDate, 1),
      endTime: formatClockMinutes(parseClockMinutes(startTime) + Math.round(minutes / 2)),
    };
  }
  const total = parseClockMinutes(startTime) + minutes;
  return {
    endDate: shiftDateValue(travelDate, Math.floor(total / (24 * 60))),
    endTime: formatClockMinutes(total),
  };
}

function shiftDateValue(value, days) {
  const [year, month, day] = String(value).split("-").map(Number);
  const shifted = new Date(Date.UTC(year, month - 1, day + days));
  return `${shifted.getUTCFullYear()}-${String(shifted.getUTCMonth() + 1).padStart(2, "0")}-${String(shifted.getUTCDate()).padStart(2, "0")}`;
}

function weatherSourceConfig() {
  const config = window.OMAEROUTE_CONFIG || {};
  const proxyUrl = config.kmaWeatherProxyUrl === false
    ? ""
    : String(config.kmaWeatherProxyUrl || "/api/weather").trim();
  const proxyBase = proxyUrl.replace(/\/$/, "");
  return {
    proxyUrl,
    midLandProxyUrl: config.kmaMidLandProxyUrl === false
      ? ""
      : String(config.kmaMidLandProxyUrl || (proxyBase ? `${proxyBase}/mid-land` : "")).trim(),
    midTemperatureProxyUrl: config.kmaMidTemperatureProxyUrl === false
      ? ""
      : String(config.kmaMidTemperatureProxyUrl || (proxyBase ? `${proxyBase}/mid-temperature` : "")).trim(),
    serviceKey: normalizeKmaServiceKey(config.kmaServiceKey),
  };
}

async function parseKmaResponse(response, emptyMessage) {
  let payload;
  try {
    payload = await response.json();
  } catch {
    throw new Error(`기상청 API가 JSON이 아닌 응답을 반환했습니다. (HTTP ${response.status})`);
  }
  if (!response.ok) {
    const portalError = payload?.OpenAPI_ServiceResponse?.cmmMsgHeader;
    const error = new Error(
      payload?.error?.message
      || portalError?.returnAuthMsg
      || portalError?.errMsg
      || `기상청 API HTTP ${response.status}`,
    );
    error.code = payload?.error?.code
      || (portalError?.returnReasonCode ? `KMA_${portalError.returnReasonCode}` : `HTTP_${response.status}`);
    throw error;
  }
  const header = payload?.response?.header;
  if (String(header?.resultCode) !== "00") {
    const error = new Error(header?.resultMsg || "기상청 예보 응답 오류");
    error.code = `KMA_${header?.resultCode || "UNKNOWN"}`;
    throw error;
  }
  const rawItems = payload?.response?.body?.items?.item;
  const items = Array.isArray(rawItems) ? rawItems : rawItems ? [rawItems] : [];
  if (!items.length) throw new Error(emptyMessage);
  return items;
}

async function requestKmaForecast(source, grid, base, signal) {
  const params = new URLSearchParams({
    pageNo: "1",
    numOfRows: "2000",
    dataType: "JSON",
    base_date: base.baseDate,
    base_time: base.baseTime,
    nx: String(grid.nx),
    ny: String(grid.ny),
  });
  let requestUrl;
  if (source.proxyUrl) {
    const url = new URL(source.proxyUrl, window.location.href);
    url.search = params.toString();
    requestUrl = url.toString();
  } else {
    params.set("serviceKey", source.serviceKey);
    requestUrl = `${KMA_FORECAST_URL}?${params}`;
  }
  const response = await fetch(requestUrl, { signal });
  return parseKmaResponse(response, "기상청 단기예보 데이터가 없습니다.");
}

async function requestKmaMidEndpoint(source, { proxyUrl, directUrl, regionId, base, signal }) {
  const params = new URLSearchParams({
    pageNo: "1",
    numOfRows: "10",
    dataType: "JSON",
  });
  let requestUrl;
  if (proxyUrl) {
    const url = new URL(proxyUrl, window.location.href);
    params.set("tm_fc", base.tmFc);
    url.search = params.toString();
    requestUrl = url.toString();
  } else {
    params.set("serviceKey", source.serviceKey);
    params.set("regId", regionId);
    params.set("tmFc", base.tmFc);
    requestUrl = `${directUrl}?${params}`;
  }
  const response = await fetch(requestUrl, { signal });
  return parseKmaResponse(response, "기상청 중기예보 데이터가 없습니다.");
}

async function requestKmaMidForecast(source, base, signal) {
  const landPromise = requestKmaMidEndpoint(source, {
    proxyUrl: source.midLandProxyUrl,
    directUrl: KMA_MID_LAND_URL,
    regionId: "11F20000",
    base,
    signal,
  });
  const temperaturePromise = requestKmaMidEndpoint(source, {
    proxyUrl: source.midTemperatureProxyUrl,
    directUrl: KMA_MID_TEMPERATURE_URL,
    regionId: "11F20501",
    base,
    signal,
  });
  const [landResult, temperatureResult] = await Promise.allSettled([landPromise, temperaturePromise]);
  if (landResult.status === "rejected") throw landResult.reason;
  if (temperatureResult.status === "rejected") {
    if (["KMA_KEY_MISSING", "KMA_20", "KMA_30", "KMA_31"].includes(temperatureResult.reason?.code)) {
      throw temperatureResult.reason;
    }
    console.warn("중기기온예보를 불러오지 못해 육상예보만 반영합니다.", temperatureResult.reason);
  }
  return {
    landItems: landResult.value,
    temperatureItems: temperatureResult.status === "fulfilled" ? temperatureResult.value : [],
  };
}

function forecastDates(conditions) {
  return travelDayWindows(conditions).map((window) => window.date);
}

function weatherSlotSummary(slot) {
  if (slot.source === "mid") {
    return `${slot.label} ${WEATHER_ICONS[slot.condition]} ${slot.weatherText} · 강수확률 ${slot.precipitationProbability}%`;
  }
  const temperature = Number.isFinite(slot.temperature)
    ? `${Math.round(slot.temperature)}℃`
    : WEATHER_LABELS[slot.condition];
  const precipitation = slot.precipitationTypeLabel
    || precipitationTypeLabel(slot.precipitationType);
  return `${slot.label} ${WEATHER_ICONS[slot.condition]} ${temperature} · 강수확률 ${slot.precipitationProbability}% · 강수형태 ${precipitation}`;
}

function renderWeatherFieldStatus() {
  const element = $("#weatherFieldStatus");
  if (!element) return;
  element.classList.remove("ready", "warning");
  const mode = $("#weather").value;
  const forecast = state.weatherForecast;
  if (mode !== "auto") {
    element.textContent = `${WEATHER_LABELS[mode]}으로 직접 설정했습니다.`;
    return;
  }
  if (forecast?.status === "loading") {
    element.textContent = "선택한 출발지의 기상청 예보를 불러오는 중입니다.";
    return;
  }
  if (forecast?.status === "ready") {
    const day = forecast.days.find((item) => item.slots.length) || forecast.days[0];
    const slots = day?.slots || [];
    const temperatureRange = day?.source === "mid"
      && Number.isFinite(day.minTemperature)
      && Number.isFinite(day.maxTemperature)
      ? ` · 최저 ${Math.round(day.minTemperature)}℃ · 최고 ${Math.round(day.maxTemperature)}℃`
      : "";
    element.textContent = `${forecast.originName} 기준 · ${slots.map(weatherSlotSummary).join(" · ")}${temperatureRange}`;
    element.classList.add(forecast.coverage === "partial" ? "warning" : "ready");
    return;
  }
  if (forecast?.status === "manual") {
    element.textContent = `${WEATHER_LABELS[forecast.condition]}으로 직접 설정했습니다.`;
    return;
  }
  if (forecast?.status === "needs_key") {
    element.textContent = ".env의 KMA_API_SERVICE_KEY를 설정하고 로컬 서버를 다시 시작해주세요.";
    element.classList.add("warning");
    return;
  }
  if (["out_of_range", "error"].includes(forecast?.status)) {
    element.textContent = `${forecast.message} 날씨를 제외한 조건으로 추천합니다.`;
    element.classList.add("warning");
    return;
  }
  element.textContent = "루트 생성 시 12시·18시 예보를 조회합니다.";
}

function renderWeatherBriefing() {
  const element = $("#weatherBriefing");
  if (!element) return;
  const forecast = state.weatherForecast;
  if (!forecast) {
    element.hidden = true;
    return;
  }
  element.hidden = false;
  if (forecast.status === "ready") {
    const selectedDate = state.dayWindows[state.selectedDay]?.date;
    const day = forecast.days.find((item) => item.date === selectedDate);
    const slots = day?.slots || [];
    if (!day || !slots.length) {
      element.innerHTML = `<strong>선택한 날짜의 기상청 예보 없음</strong><small>현재 제공되는 단기·중기예보 범위를 벗어나 날씨는 일정 추천에서 제외했습니다.</small>`;
      return;
    }
    const isMidForecast = day.source === "mid";
    const temperatureRange = isMidForecast
      && Number.isFinite(day.minTemperature)
      && Number.isFinite(day.maxTemperature)
      ? `<span class="weather-slot">최저 ${Math.round(day.minTemperature)}℃ · 최고 ${Math.round(day.maxTemperature)}℃</span>`
      : "";
    element.innerHTML = `
      <strong>${isMidForecast ? "기상청 중기예보 · 광주·전남 권역" : `기상청 단기예보 · ${escapeHtml(forecast.originName)} 출발 기준`}</strong>
      <div class="weather-slot-list">
        ${slots.map((slot) => `<span class="weather-slot">${escapeHtml(weatherSlotSummary(slot))}</span>`).join("")}
        ${temperatureRange}
      </div>
      <small>${isMidForecast ? "광주·전남 권역 기준 · 기상청 중기예보 반영" : "출발지 기준 · 기상청 5km 예보 반영"}</small>
    `;
    return;
  }
  if (forecast.status === "manual") {
    element.innerHTML = `<strong>날씨 직접 설정 · ${WEATHER_ICONS[forecast.condition]} ${WEATHER_LABELS[forecast.condition]}</strong><small>기상청 자동 대신 사용자가 선택한 날씨 조건을 추천에 반영했습니다.</small>`;
    return;
  }
  const message = forecast.status === "needs_key"
    ? "기상청 서비스키가 없어 날씨를 제외한 조건으로 추천했습니다."
    : `${forecast.message || "기상청 예보를 불러오지 못했습니다."} 날씨를 제외한 조건으로 추천했습니다.`;
  const title = forecast.status === "out_of_range" ? "기상청 예보 범위 밖 날짜" : "기상청 자동 연동 대기";
  element.innerHTML = `<strong>${title}</strong><small>${escapeHtml(message)}</small>`;
}

async function refreshWeatherForecast({ force = false } = {}) {
  const conditions = currentConditions();
  if (conditions.weatherMode !== "auto") {
    state.weatherAbortController?.abort();
    state.weatherForecast = { status: "manual", condition: conditions.weatherMode };
    renderWeatherFieldStatus();
    return state.weatherForecast;
  }

  const source = weatherSourceConfig();
  if (!source.proxyUrl && !source.serviceKey) {
    state.weatherForecast = { status: "needs_key", condition: "sunny" };
    renderWeatherFieldStatus();
    return state.weatherForecast;
  }

  const grid = latLonToKmaGrid(conditions.origin.latitude, conditions.origin.longitude);
  const base = latestKmaBase();
  const midBase = latestKmaMidBase();
  const dates = forecastDates(conditions);
  const cacheKey = `${conditions.originKey}:${conditions.travelDate}:${conditions.startTime}:${conditions.endDate}:${conditions.endTime}:${base.baseDate}:${base.baseTime}:${midBase.tmFc}`;
  if (!force && state.weatherCache.has(cacheKey)) {
    state.weatherForecast = state.weatherCache.get(cacheKey);
    renderWeatherFieldStatus();
    return state.weatherForecast;
  }

  state.weatherAbortController?.abort();
  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), 25000);
  state.weatherAbortController = controller;
  state.weatherForecast = { status: "loading", condition: "sunny" };
  renderWeatherFieldStatus();
  let shortForecast = null;
  let midForecast = null;
  let shortError = null;
  let midError = null;
  try {
    for (const candidateBase of [base, previousKmaBase(base)]) {
      try {
        const items = await requestKmaForecast(source, grid, candidateBase, controller.signal);
        shortForecast = buildWeatherForecast(items, {
          dates,
          originKey: conditions.originKey,
          originName: conditions.origin.name,
          grid,
          base: candidateBase,
          allowEmpty: true,
        });
        break;
      } catch (error) {
        if (error.name === "AbortError") throw error;
        if (["KMA_KEY_MISSING", "KMA_20", "KMA_30", "KMA_31"].includes(error.code)) throw error;
        shortError = error;
      }
    }

    const datesMissingFromShort = dates.filter((date) =>
      !shortForecast?.days?.some((day) => day.date === date && day.slots.length),
    );
    if (datesMissingFromShort.length) {
      for (const candidateBase of [midBase, previousKmaMidBase(midBase)]) {
        try {
          const result = await requestKmaMidForecast(source, candidateBase, controller.signal);
          const candidateForecast = buildMidWeatherForecast(result.landItems, result.temperatureItems, {
            dates: datesMissingFromShort,
            originKey: conditions.originKey,
            originName: conditions.origin.name,
            base: candidateBase,
          });
          if (candidateForecast.days.some((day) => day.slots.length)) {
            midForecast = candidateForecast;
            break;
          }
        } catch (error) {
          if (error.name === "AbortError") throw error;
          if (["KMA_KEY_MISSING", "KMA_20", "KMA_30", "KMA_31"].includes(error.code)) throw error;
          midError = error;
        }
      }
    }

    let forecast;
    try {
      forecast = mergeWeatherForecasts(shortForecast, midForecast, {
        dates,
        originKey: conditions.originKey,
        originName: conditions.origin.name,
        grid,
      });
    } catch (error) {
      throw midError || shortError || error;
    }
    state.weatherCache.set(cacheKey, forecast);
    state.weatherForecast = forecast;
    renderWeatherFieldStatus();
    return forecast;
  } catch (error) {
    if (error.name === "AbortError" && state.weatherAbortController !== controller) return state.weatherForecast;
    const status = error.code === "KMA_KEY_MISSING"
      ? "needs_key"
      : error.code === "FORECAST_OUT_OF_RANGE"
        ? "out_of_range"
        : "error";
    state.weatherForecast = {
      status,
      condition: "sunny",
      code: error.code || "KMA_REQUEST_FAILED",
      message: error.name === "AbortError" ? "기상청 요청 시간이 초과되었습니다." : error.message,
    };
    renderWeatherFieldStatus();
    return state.weatherForecast;
  } finally {
    window.clearTimeout(timeout);
    if (state.weatherAbortController === controller) state.weatherAbortController = null;
  }
}

function invalidateWeatherForecast({ reload = true } = {}) {
  state.weatherAbortController?.abort();
  state.weatherAbortController = null;
  state.weatherForecast = null;
  renderWeatherFieldStatus();
  const source = weatherSourceConfig();
  const canRequestWeather = Boolean(source.proxyUrl || source.serviceKey);
  if (reload && $("#weather").value === "auto" && canRequestWeather) void refreshWeatherForecast();
}

function getPreferenceLevel(value) {
  if (value <= 20) return "관심 낮음";
  if (value <= 45) return "조금 선호";
  if (value <= 75) return "보통 이상";
  return "매우 선호";
}

function topAxes(limit = 2) {
  const vector = currentVector();
  if (!hasPreferenceSignals(vector)) return [];
  return vector
    .map((value, index) => ({ value: Math.round(value * 100), ...AXES[index] }))
    .filter((axis) => axis.value > 0)
    .sort((a, b) => b.value - a.value)
    .slice(0, limit);
}

function updateRangeVisual(input) {
  input.style.setProperty("--range-progress", `${input.value}%`);
  input.closest(".slider-row").querySelector(".slider-level").textContent =
    getPreferenceLevel(Number(input.value));
}

const AXIS_COLORS = {
  sports: { light: "#f4f9ff", dark: "#3182f6" },
  nature: { light: "#f4f9ff", dark: "#3182f6" },
  culture: { light: "#f4f9ff", dark: "#3182f6" },
  art: { light: "#f4f9ff", dark: "#3182f6" },
  food: { light: "#f4f9ff", dark: "#3182f6" },
  activity: { light: "#f4f9ff", dark: "#3182f6" },
};

function renderSliders() {
  $("#preferenceSliders").innerHTML = DISPLAY_AXIS_KEYS.map(
    (axisKey) => {
      const index = AXIS_INDEX_BY_KEY[axisKey];
      const axis = AXES[index];
      const colors = AXIS_COLORS[axisKey] || { light: "#e8f5e9", dark: "#2e7d32" };
      return `
      <label class="slider-row" style="--slider-light: ${colors.light}; --slider-dark: ${colors.dark};">
        <span class="slider-meta">
          <span class="slider-name"><i>${axis.emoji}</i>${axis.label}</span>
          <span class="slider-level">${getPreferenceLevel(state.preference[index])}</span>
        </span>
        <input
          type="range"
          min="0"
          max="100"
          step="10"
          value="${state.preference[index]}"
          data-index="${index}"
          aria-label="${axis.label} 선호도"
        />
      </label>
    `;
    },
  ).join("");

  $$('#preferenceSliders input[type="range"]').forEach((input) => {
    updateRangeVisual(input);
    input.addEventListener("input", () => {
      state.preference[Number(input.dataset.index)] = Number(input.value);
      updateRangeVisual(input);
      renderAxisPreview();
      updateBaseballAttendanceControl();
    });
  });
  updateBaseballAttendanceControl();
}

function renderAxisPreview() {
  const axes = topAxes(5);
  $("#axisPreview").innerHTML = axes.length
    ? axes.map((axis) => `<span>${axis.emoji} ${axis.label} ${axis.value}</span>`).join("")
    : '<span class="axis-preview-empty">취향을 선택하면 주요 선호가 표시됩니다.</span>';
}

function promptHasSignals(analysis = state.promptAnalysis) {
  return Boolean(
    analysis?.raw &&
      (
        analysis.matchedAxes.length ||
        analysis.excludedTerms.length ||
        analysis.requiredTags.length ||
        analysis.namedPlaceIds.length ||
        analysis.rainy ||
        analysis.indoor ||
        analysis.family ||
        analysis.parents ||
        analysis.wheelchair ||
        analysis.parking ||
        analysis.pet ||
        analysis.minimizeTravel ||
        analysis.slowPace
      ),
  );
}

function renderPromptInterpretation() {
  const container = $("#promptInterpretation");
  const labels = [...state.promptAnalysis.labels];
  if (state.promptAnalysis.namedPlaceIds.length) {
    const namedPlaces = state.places
      .filter((place) => state.promptAnalysis.namedPlaceIds.includes(place.id))
      .map((place) => place.name)
      .slice(0, 2);
    labels.unshift(...namedPlaces.map((name) => `${name} 지정`));
  }
  container.innerHTML = state.travelPrompt
    ? (labels.length ? labels : ["자유 문장 반영"])
        .slice(0, 7)
        .map((label) => `<span>${escapeHtml(label)}</span>`)
        .join("")
    : '<span class="prompt-idle">요청을 적으면 반영할 키워드를 미리 보여드려요.</span>';
}

function updatePromptAnalysis() {
  const input = $("#travelPrompt");
  state.travelPrompt = input.value.trim();
  state.promptAnalysis = analyzeTravelPrompt(state.travelPrompt);
  const normalized = normalizePrompt(state.travelPrompt);
  if (normalized && state.places.length) {
    state.promptAnalysis.namedPlaceIds = state.places
      .filter((place) => normalized.includes(normalizePrompt(place.name)))
      .map((place) => place.id);
  }
  $("#promptCharacterCount").textContent = input.value.length;
  $$(".prompt-examples button").forEach((button) => {
    button.classList.toggle("active", button.dataset.promptExample === input.value);
  });
  renderPromptInterpretation();
  renderAxisPreview();
}

function placePromptText(place) {
  return normalizePrompt(
    [
      place.name,
      place.region,
      place.category,
      place.description,
      place.baseballColumn,
      ...(place.recommendedPlayers || []),
      ...(place.hashtags || []),
    ].join(" "),
  );
}

function placeHasTag(place, tag) {
  return (place.hashtags || []).some((item) => normalizePrompt(item) === normalizePrompt(tag));
}

function placeMatchesExcludedPrompt(place) {
  const text = placePromptText(place);
  return state.promptAnalysis.excludedTerms.some((term) => text.includes(normalizePrompt(term)));
}

function placePassesFilters(place, conditions, { relaxPrompt = false } = {}) {
  if (place.routeEligible === false) return false;
  if (place.stadiumFood && !conditions.baseballAttendance) return false;
  const requiresRain =
    conditions.selectedWeather === "rainy" || (conditions.promptRainy && !relaxPrompt);
  const requiresFamily =
    conditions.selectedCompanion === "family" || (conditions.promptFamily && !relaxPrompt);
  if (requiresRain && !place.indoor) return false;
  if (requiresFamily && !place.familyFriendly) return false;
  if (state.promptAnalysis.indoorOnly && !relaxPrompt && !place.indoor) return false;
  if (placeMatchesExcludedPrompt(place)) return false;
  if (conditions.transport === "public" && place.publicTransportScore < 0.48) return false;
  if (conditions.transport === "walk" && haversineKm(conditions.origin, place) > 5.5) {
    return false;
  }
  return place.durationMinutes <= Math.max(conditions.duration * 0.78, 120);
}

function contextScore(place, conditions) {
  const distance = haversineKm(conditions.origin, place);
  const transportFit =
    conditions.transport === "public"
      ? place.publicTransportScore
      : conditions.transport === "walk"
        ? clamp(1 - distance / 6.5, 0, 1)
        : clamp(1 - distance / 120, 0.45, 1);
  const weatherFit = weatherSuitabilityScore(place, conditions.weather);
  const companionFit =
    conditions.companion === "family" ? Number(place.familyFriendly) : 0.9;
  const durationFit = clamp(1 - place.durationMinutes / (conditions.duration * 1.5), 0.3, 1);
  return transportFit * 0.4 + weatherFit * 0.25 + companionFit * 0.2 + durationFit * 0.15;
}

function promptFitScore(place, conditions) {
  const analysis = state.promptAnalysis;
  if (!promptHasSignals(analysis)) return 0.5;
  const text = placePromptText(place);
  const distance = haversineKm(conditions.origin, place);
  let earned = 0;
  let possible = 0;
  const addSignal = (value, weight = 1) => {
    earned += clamp(value, 0, 1) * weight;
    possible += weight;
  };

  analysis.matchedAxes.forEach((item) => {
    addSignal(place.vector[item.axis], 1 + Math.abs(analysis.axisBoost[item.axis]));
  });
  if (analysis.rainy) addSignal(Number(place.rainOk), 1.25);
  if (analysis.indoor) addSignal(Number(place.indoor), analysis.indoorOnly ? 1.5 : 1);
  if (analysis.family) addSignal(Number(place.familyFriendly), 1.15);
  if (analysis.parents) {
    const parentFit =
      Number(placeHasTag(place, "#휠체어")) * 0.45 +
      clamp(1 - place.durationMinutes / 210, 0.2, 0.55);
    addSignal(parentFit, 1);
  }
  if (analysis.wheelchair) addSignal(Number(placeHasTag(place, "#휠체어")), 1.35);
  if (analysis.parking) addSignal(Number(placeHasTag(place, "#주차가능")), 1);
  if (analysis.pet) addSignal(Number(placeHasTag(place, "#반려동물")), 1.2);
  if (analysis.minimizeTravel) addSignal(clamp(1 - distance / 11, 0, 1), 1.45);
  if (analysis.slowPace) addSignal(clamp(1 - place.durationMinutes / 190, 0.25, 1), 0.65);
  analysis.requiredTags.forEach((tag) => addSignal(Number(placeHasTag(place, tag)), 1.8));
  if (analysis.namedPlaceIds.length) {
    addSignal(Number(analysis.namedPlaceIds.includes(place.id)), 2.2);
  }

  const directMatches = analysis.matchedTerms.filter((term) => text.includes(normalizePrompt(term)));
  if (directMatches.length) addSignal(Math.min(1, directMatches.length / 2), 0.7);
  return possible ? earned / possible : 0.5;
}

function promptReasonsForPlace(place, conditions) {
  const analysis = state.promptAnalysis;
  if (!promptHasSignals(analysis)) return [];
  const reasons = [];
  if (analysis.namedPlaceIds.includes(place.id)) reasons.push("직접 요청한 장소");
  const requiredTag = analysis.requiredTags.find((tag) => placeHasTag(place, tag));
  if (requiredTag) reasons.push(`${requiredTag.replace("#", "")} 포함 요청`);
  if (analysis.rainy && place.rainOk) reasons.push("비 오는 날 요청 반영");
  if (analysis.indoor && place.indoor) reasons.push("실내 요청 반영");
  if (analysis.family && place.familyFriendly) reasons.push("아이 동행 요청 반영");
  if (analysis.wheelchair && placeHasTag(place, "#휠체어")) reasons.push("휠체어 접근 가능");
  if (analysis.parking && placeHasTag(place, "#주차가능")) reasons.push("주차 편의 반영");
  if (analysis.pet && placeHasTag(place, "#반려동물")) reasons.push("반려동물 동행 가능");
  if (analysis.minimizeTravel && haversineKm(conditions.origin, place) <= 5) {
    reasons.push("짧은 이동 요청 반영");
  }
  const axisReason = analysis.matchedAxes
    .map((item) => ({ label: item.label, value: place.vector[item.axis] }))
    .sort((a, b) => b.value - a.value)[0];
  if (axisReason?.value >= 0.58) reasons.push(`${axisReason.label} 요청 반영`);
  return [...new Set(reasons)].slice(0, 2);
}

function matchReasons(place, vector, conditions) {
  if (conditions.baseballAttendance && place.playerRecommended) {
    const players = place.activeRecommendedPlayers?.length
      ? place.activeRecommendedPlayers
      : place.recommendedPlayers || [];
    return [players.length ? `${players.join("·")} 선수 추천` : "KIA 선수 추천"];
  }
  const preferenceReasons = hasPreferenceSignals(vector)
    ? place.vector
      .map((value, index) => ({ label: AXES[index].label, score: value * vector[index] }))
      .sort((a, b) => b.score - a.score)
      .slice(0, 2)
      .map((item) => item.label)
    : [];
  const contextReasons = [];
  if (conditions.weather === "rainy" && place.indoor) {
    contextReasons.push("비 예보·실내 우선");
  }
  if (conditions.companion === "family" && place.familyFriendly) {
    contextReasons.push("가족 동행 적합");
  }
  if (conditions.transport === "public" && place.publicTransportScore >= 0.75) {
    contextReasons.push("대중교통 편리");
  }
  if (!hasPreferenceSignals(vector) && !contextReasons.length) {
    contextReasons.push("여행 조건과 동선 적합");
  }
  return [...promptReasonsForPlace(place, conditions), ...preferenceReasons, ...contextReasons]
    .filter((item, index, items) => items.indexOf(item) === index)
    .slice(0, 3);
}

function rankPlacesLocal(conditionsOverride = null) {
  const vector = currentVector();
  const usePreferenceScore = hasPreferenceSignals(vector);
  const conditions = conditionsOverride || currentConditions();
  let candidates = state.places.filter((place) => placePassesFilters(place, conditions));
  state.promptAnalysis.relaxed = false;
  if (state.travelPrompt && candidates.length < 3) {
    candidates = state.places.filter((place) =>
      placePassesFilters(place, conditions, { relaxPrompt: true }),
    );
    state.promptAnalysis.relaxed = true;
  }
  state.promptAnalysis.requiredTags.forEach((tag) => {
    if (candidates.some((place) => placeHasTag(place, tag))) return;
    const fallback = state.places.find(
      (place) =>
        placeHasTag(place, tag) &&
        placePassesFilters(place, conditions, { relaxPrompt: true }),
    );
    if (fallback) {
      candidates.push(fallback);
      state.promptAnalysis.relaxed = true;
    }
  });
  const usePromptScore = promptHasSignals();
  return candidates
    .map((place) => {
      const preferenceScore = cosineSimilarity(vector, place.vector);
      const situationalScore = contextScore(place, conditions);
      const promptScore = promptFitScore(place, conditions);
      const baseScore = usePromptScore
        ? usePreferenceScore
          ? preferenceScore * 0.65 + situationalScore * 0.2 + promptScore * 0.15
          : situationalScore * 0.45 + promptScore * 0.55
        : usePreferenceScore
          ? preferenceScore * 0.78 + situationalScore * 0.22
          : situationalScore;
      const sportsPreferenceBoost = conditions.baseballAttendance && place.playerRecommended
        ? place.activePlayerRecommended ? 1.5 : 1.15
        : 0;
      const rainIndoorBoost = conditions.weather === "rainy" && place.indoor ? 0.14 : 0;
      return {
        ...place,
        preferenceScore,
        situationalScore,
        promptScore,
        displayScore: baseScore,
        sportsPreferenceBoost,
        rainIndoorBoost,
        score: baseScore + sportsPreferenceBoost + rainIndoorBoost,
        reasons: matchReasons(place, vector, conditions),
      };
    })
    .sort((a, b) => b.score - a.score);
}

function estimateTravelMinutes(distanceKm) {
  const speed = state.transport === "walk" ? 4.5 : state.transport === "car" ? 45 : 25;
  const buffer = state.transport === "public" ? 13 : state.transport === "car" ? 7 : 0;
  return Math.max(3, Math.round((distanceKm / speed) * 60 + buffer));
}

function hasUsableCoordinates(place) {
  return Number.isFinite(Number(place?.latitude)) && Number.isFinite(Number(place?.longitude));
}

function isMealPlace(place) {
  return place?.category === "음식·로컬";
}

function mealSlotsForDay(startMinutes, durationMinutes) {
  const endMinutes = startMinutes + durationMinutes;
  return MEAL_SLOTS.filter(
    (slot) => slot.targetMinutes >= startMinutes && slot.targetMinutes + MEAL_DURATION_MINUTES <= endMinutes,
  );
}

function routeCandidateValue(place, current) {
  const distancePenalty = state.promptAnalysis.minimizeTravel ? 0.022 : 0.006;
  const namedBonus = state.promptAnalysis.namedPlaceIds.includes(place.id) ? 0.42 : 0;
  const requiredBonus = state.promptAnalysis.requiredTags.some((tag) => placeHasTag(place, tag)) ? 0.38 : 0;
  return place.score + namedBonus + requiredBonus - haversineKm(current, place) * distancePenalty;
}

function hasReliableOperatingHours(place) {
  return place.hoursParseStatus !== "empty" && place.hoursParseStatus !== "unparsed";
}

function exceedsClosingTime(place, endMinutes) {
  if (!place.closesAt) return false;
  // 여러 영업시간대 중 첫 구간만 저장된 값이라 마감시간 신뢰도가 낮아 검사를 생략한다.
  if (place.hoursParseStatus === "multiple_ranges_took_first") return false;
  return endMinutes > parseClockMinutes(place.closesAt);
}

function hasRequiredParking(place) {
  if (state.transport !== "car") return true;
  if (isMealPlace(place) || place.stadiumFood) return true;
  return place.parkingAvailable === true;
}

function exceedsWalkTimeLimit(travelMinutes) {
  return state.transport === "walk" && travelMinutes > state.walkTimeLimitMinutes;
}

function scheduleLeg(current, clockMinutes, place, targetMinutes = null, { snap = true } = {}) {
  const distance = haversineKm(current, place);
  const travelMinutes = estimateTravelMinutes(distance);
  const arrivalMinutes = clockMinutes + travelMinutes;
  const opensAtMinutes = place.opensAt ? parseClockMinutes(place.opensAt) : null;
  const effectiveTargetMinutes = opensAtMinutes === null
    ? targetMinutes
    : Math.max(targetMinutes ?? 0, opensAtMinutes);
  const waitMinutes = effectiveTargetMinutes === null ? 0 : Math.max(0, effectiveTargetMinutes - arrivalMinutes);
  const rawStartMinutes = arrivalMinutes + waitMinutes;
  const rawEndMinutes = place.overrideEndMinutes != null
    ? Math.max(rawStartMinutes, place.overrideEndMinutes)
    : rawStartMinutes + place.durationMinutes;
  const startMinutes = snap ? roundUpToStep(rawStartMinutes) : rawStartMinutes;
  const endMinutes = snap ? roundUpToStep(rawEndMinutes) : rawEndMinutes;
  return { distance, travelMinutes, arrivalMinutes, waitMinutes, startMinutes, endMinutes };
}

function returnTravelMinutes(place, destination) {
  if (!destination) return 0;
  return estimateTravelMinutes(haversineKm(place, destination));
}

// 시간 예산까지 확인하여 후보를 선택한다. predicate는 추가 필터링 조건을 제공한다.
function chooseBestCandidate(results, current, clockMinutes, usedIds, dayEndMinutes, returnDestination = null, predicate = () => true) {
  return results
    .filter((place) => !usedIds.has(place.id) && hasUsableCoordinates(place) && predicate(place))
    .map((place) => ({ place, leg: scheduleLeg(current, clockMinutes, place) }))
    .filter(({ place, leg }) =>
      !exceedsClosingTime(place, leg.endMinutes)
      && !exceedsWalkTimeLimit(leg.travelMinutes)
      && leg.endMinutes + returnTravelMinutes(place, returnDestination) <= dayEndMinutes,
    )
    .sort((a, b) => routeCandidateValue(b.place, current) - routeCandidateValue(a.place, current))[0] || null;
}

// 후보 풀에서 식사 시간대에 맞는 최적 식당 하나를 고른다. 공통 채점/필터 로직이라 주차 우회 대체 탐색에서도 재사용한다.
function buildMealCandidate(pool, current, clockMinutes, slot, dayEndMinutes, returnDestination) {
  return pool
    .map((place) => {
      const leg = scheduleLeg(current, clockMinutes, place, slot.targetMinutes);
      const timingPenalty = Math.abs(leg.startMinutes - slot.targetMinutes) / 180;
      return { place, leg, value: routeCandidateValue(place, current) - timingPenalty };
    })
    .filter(({ place, leg }) =>
      leg.startMinutes <= slot.windowEnd
      && leg.endMinutes + returnTravelMinutes(place, returnDestination) <= dayEndMinutes
      && !exceedsClosingTime(place, leg.endMinutes)
      && !exceedsWalkTimeLimit(leg.travelMinutes),
    )
    .sort((a, b) => b.value - a.value)[0] || null;
}

function chooseMealCandidate(results, current, clockMinutes, usedIds, slot, dayEndMinutes, returnDestination = null) {
  const isCar = state.transport === "car";
  // 자동차 모드에서는 주차 불가로 확인된 식당은 애초에 후보에서 제외한다.
  const basePool = results.filter((place) =>
    !usedIds.has(place.id)
    && hasUsableCoordinates(place)
    && isMealPlace(place)
    && !place.stadiumFood
    && (!isCar || place.parkingAvailable !== false),
  );
  if (isCar) {
    // 주차 가능 식당을 우선 시도한다. 우회 거리가 과도하면 resolveMealParkingDetour가 나중에 대체한다.
    const parkingFirst = buildMealCandidate(
      basePool.filter((place) => place.parkingAvailable === true),
      current,
      clockMinutes,
      slot,
      dayEndMinutes,
      returnDestination,
    );
    if (parkingFirst) return parkingFirst;
  }
  return buildMealCandidate(basePool, current, clockMinutes, slot, dayEndMinutes, returnDestination);
}

// 주차 가능 식당이 실제로는 앞뒤 관광지에서 크게 벗어난 곳일 경우, 주차 여부 미지수인 식당으로 대체한다.
function resolveMealParkingDetour(mealPlace, prevPlace, next, prevClockMinutes, results, usedIds, dayEndMinutes, returnDestination) {
  if (state.transport !== "car" || mealPlace.parkingAvailable !== true || !prevPlace || !next) return mealPlace;
  const detourMinutes = estimateTravelMinutes(haversineKm(prevPlace, mealPlace))
    + estimateTravelMinutes(haversineKm(mealPlace, next));
  if (detourMinutes < MEAL_PARKING_DETOUR_LIMIT_MINUTES) return mealPlace;

  const slot = MEAL_SLOTS.find((candidate) => candidate.key === mealPlace.mealSlot);
  if (!slot) return mealPlace;

  const fallbackUsedIds = new Set(usedIds);
  fallbackUsedIds.delete(mealPlace.id);
  const fallbackPool = results.filter((place) =>
    !fallbackUsedIds.has(place.id)
    && hasUsableCoordinates(place)
    && isMealPlace(place)
    && !place.stadiumFood
    && place.parkingAvailable !== true
    && place.parkingAvailable !== false,
  );
  const replacement = buildMealCandidate(fallbackPool, prevPlace, prevClockMinutes, slot, dayEndMinutes, returnDestination);
  if (!replacement) return mealPlace;

  usedIds.delete(mealPlace.id);
  usedIds.add(replacement.place.id);
  return annotateMealPlace(replacement.place, slot);
}

function chooseFillerBeforeMeal(results, current, clockMinutes, usedIds, slot, dayEndMinutes, returnDestination = null) {
  return results
    .filter((place) => !usedIds.has(place.id) && hasUsableCoordinates(place) && !isMealPlace(place))
    .map((place) => {
      const leg = scheduleLeg(current, clockMinutes, place);
      const meal = chooseMealCandidate(
        results,
        place,
        leg.endMinutes,
        new Set([...usedIds, place.id]),
        slot,
        dayEndMinutes,
        returnDestination,
      );
      return { place, leg, meal, value: routeCandidateValue(place, current) };
    })
    .filter(({ place, leg, meal }) =>
      meal
      && leg.endMinutes <= slot.windowEnd
      && !exceedsClosingTime(place, leg.endMinutes)
      && !exceedsWalkTimeLimit(leg.travelMinutes),
    )
    .sort((a, b) => b.value - a.value)[0] || null;
}

function annotateMealPlace(place, slot) {
  const playerReasons = (place.reasons || []).filter((reason) => reason.endsWith("선수 추천"));
  return {
    ...place,
    mealSlot: slot.key,
    mealLabel: slot.label,
    mealTargetMinutes: slot.targetMinutes,
    reasons: (playerReasons.length
      ? playerReasons
      : [`${formatClockMinutes(slot.targetMinutes)} ${slot.label}시간 맞춤`, ...(place.reasons || [])])
      .filter((reason, index, reasons) => reasons.indexOf(reason) === index)
      .slice(0, 3),
  };
}

function buildRouteDay(results, conditions, usedIds, dayIndex, window, isFinalDay) {
  const day = [];
  const startMinutes = window.startMinutes;
  const durationMinutes = window.endMinutes - window.startMinutes;
  const dayEndMinutes = window.endMinutes;
  const maxStops = durationMinutes >= 480 ? 4 : 3;
  const mealSlots = mealSlotsForDay(startMinutes, durationMinutes);
  const returnDestination = isFinalDay ? conditions.origin : null;
  let current = conditions.origin;
  let clockMinutes = startMinutes;
  const mealParkingChecks = [];

  for (let slotIndex = 0; slotIndex < mealSlots.length; slotIndex += 1) {
    const slot = mealSlots[slotIndex];
    const remainingMealSlots = mealSlots.length - slotIndex;
    if (day.length < maxStops - remainingMealSlots) {
      const filler = chooseFillerBeforeMeal(
        results,
        current,
        clockMinutes,
        usedIds,
        slot,
        dayEndMinutes,
        returnDestination,
      );
      if (filler) {
        day.push(filler.place);
        usedIds.add(filler.place.id);
        current = filler.place;
        clockMinutes = filler.leg.endMinutes;
      }
    }

    const meal = chooseMealCandidate(
      results,
      current,
      clockMinutes,
      usedIds,
      slot,
      dayEndMinutes,
      returnDestination,
    );
    if (!meal) {
      state.mealWarnings.push(`Day ${dayIndex + 1} ${slot.label} 후보를 찾지 못했습니다.`);
      continue;
    }
    const mealPlace = annotateMealPlace(meal.place, slot);
    mealParkingChecks.push({ ref: mealPlace, prevPlace: current, prevClockMinutes: clockMinutes });
    day.push(mealPlace);
    usedIds.add(meal.place.id);
    current = mealPlace;
    clockMinutes = meal.leg.endMinutes;
  }

  // 시간계산 이동됨.
  while (day.length < maxStops) {
    const picked = chooseBestCandidate(results, current, clockMinutes, usedIds, dayEndMinutes, returnDestination, (place) => !isMealPlace(place));
    if (!picked) break;
    const { place: next, leg } = picked;
    day.push(next);
    usedIds.add(next.id);
    current = next;
    clockMinutes = leg.endMinutes;
}

  mealParkingChecks.forEach((check) => {
    const index = day.indexOf(check.ref);
    if (index === -1) return;
    const next = day[index + 1] || null;
    const resolved = resolveMealParkingDetour(
      check.ref,
      check.prevPlace,
      next,
      check.prevClockMinutes,
      results,
      usedIds,
      dayEndMinutes,
      returnDestination,
    );
    if (resolved !== check.ref) day[index] = resolved;
  });
  return day;
}

function preferenceScoreOf(place) {
  return place.displayScore ?? place.score ?? 0;
}

function subsetsOf(list) {
  return list.reduce((acc, item) => acc.concat(acc.map((set) => [...set, item])), [[]]);
}

function permutationsOf(list) {
  if (list.length <= 1) return [list];
  return list.flatMap((item, index) => {
    const rest = [...list.slice(0, index), ...list.slice(index + 1)];
    return permutationsOf(rest).map((perm) => [item, ...perm]);
  });
}

function validateFixedSchedule(startPlace, startMinutes, fixedStops) {
  let current = startPlace;
  let clockMinutes = startMinutes;
  for (const place of fixedStops) {
    const leg = scheduleLeg(current, clockMinutes, place, place.fixedStartMinutes, { snap: false });
    if (leg.startMinutes > place.fixedStartMinutes) {
      return {
        ok: false,
        place,
        lateMinutes: Math.ceil(leg.startMinutes - place.fixedStartMinutes),
      };
    }
    current = place;
    clockMinutes = leg.endMinutes;
  }
  return { ok: true };
}

function replanDayFromStop(dayIndex, stopIndex, newDepartureMinutes) {
  const day = state.routeDays[dayIndex];
  if (!day || !day[stopIndex]) return { ok: false, message: "선택한 장소를 찾지 못했습니다." };
  const window = state.dayWindows[dayIndex];
  const dayConditions = conditionsForRouteDate(currentConditions(), window.date);
  const availableResults = rankPlacesLocal(dayConditions).filter((place) => placeIsOpenOnDate(place, window.date) && hasRequiredParking(place));
  const isFinalDay = dayIndex === state.routeDays.length - 1;
  const anchorPlace = { ...day[stopIndex], overrideEndMinutes: newDepartureMinutes };
  const keptStops = [...day.slice(0, stopIndex), anchorPlace];
  const fixedRemainder = day.slice(stopIndex + 1).filter((place) => place.fixedStartMinutes != null);
  const nextFixedStop = fixedRemainder[0] || null;
  const returnDestination = nextFixedStop || (isFinalDay ? currentConditions().origin : null);
  const dayEndMinutes = nextFixedStop
    ? Math.min(window.endMinutes, nextFixedStop.fixedStartMinutes)
    : window.endMinutes;
  const fixedScheduleCheck = validateFixedSchedule(anchorPlace, newDepartureMinutes, fixedRemainder);
  if (!fixedScheduleCheck.ok) {
    return {
      ok: false,
      message: `${fixedScheduleCheck.place.name} 고정 일정에 약 ${fixedScheduleCheck.lateMinutes}분 늦습니다. 더 이른 출발 시각을 선택해주세요.`,
    };
  }
  const maxStops = window.endMinutes - window.startMinutes >= 480 ? 4 : 3;
  const otherDaysIds = state.routeDays.flatMap((otherDay, index) => (index === dayIndex ? [] : otherDay));
  const usedIds = new Set([...otherDaysIds, ...keptStops, ...fixedRemainder].map((place) => place.id));
  const consumedMealKeys = new Set(keptStops.filter((place) => place.mealSlot).map((place) => place.mealSlot));
  const pendingMealSlots = mealSlotsForDay(window.startMinutes, window.endMinutes - window.startMinutes)
    .filter((slot) => !consumedMealKeys.has(slot.key));

  let current = keptStops[keptStops.length - 1];
  let clockMinutes = newDepartureMinutes;
  const rebuilt = [];
  const mealParkingChecks = [];

  for (let slotIndex = 0; slotIndex < pendingMealSlots.length; slotIndex += 1) {
    const slot = pendingMealSlots[slotIndex];
    const remainingSlotsAfter = pendingMealSlots.length - slotIndex;
    if (keptStops.length + rebuilt.length < maxStops - remainingSlotsAfter) {
      const filler = chooseFillerBeforeMeal(
        availableResults,
        current,
        clockMinutes,
        usedIds,
        slot,
        dayEndMinutes,
        returnDestination,
      );
      if (filler) {
        rebuilt.push(filler.place);
        usedIds.add(filler.place.id);
        current = filler.place;
        clockMinutes = filler.leg.endMinutes;
      }
    }

    const meal = chooseMealCandidate(availableResults, current, clockMinutes, usedIds, slot, dayEndMinutes, returnDestination);
    if (!meal) {
      state.mealWarnings.push(`Day ${dayIndex + 1} ${slot.label} 후보를 찾지 못했습니다.`);
      continue;
    }
    const mealPlace = annotateMealPlace(meal.place, slot);
    mealParkingChecks.push({ ref: mealPlace, prevPlace: current, prevClockMinutes: clockMinutes });
    rebuilt.push(mealPlace);
    usedIds.add(meal.place.id);
    current = mealPlace;
    clockMinutes = meal.leg.endMinutes;
  }

  // 남은 칸 수만큼 순위 기준으로 우선 채택한다 (이 시점에는 체류시간을 고려하지 않음).
  const fillerCandidates = [];
  let pickCurrent = current;
  while (keptStops.length + rebuilt.length + fillerCandidates.length < maxStops) {
    const picked = chooseBestCandidate(availableResults, pickCurrent, clockMinutes, usedIds, dayEndMinutes, returnDestination, (place) => !isMealPlace(place));
    if (!picked) break;
    fillerCandidates.push(picked.place);
    usedIds.add(picked.place.id);
    pickCurrent = picked.place;
}

  // 후보 풀(최대 몇 개뿐)의 모든 부분집합 × 방문 순서를 전수 계산해서,
  // "포함된 곳 전부가 원래 duration의 절반 이상을 확보"하는 조합 중 선호도 점수 합이 가장 높은 조합을 찾는다.
  const returnMinutesFor = (lastPlace) =>
    returnTravelMinutes(lastPlace ?? current, returnDestination);
  let bestPlan = { places: [], legs: [], score: 0, totalTravel: 0 };
  subsetsOf(fillerCandidates).forEach((subset) => {
    if (!subset.length) return;
    permutationsOf(subset).forEach((order) => {
      let walker = current;
      const legs = order.map((place) => {
        const travelMinutes = estimateTravelMinutes(haversineKm(walker, place));
        walker = place;
        return travelMinutes;
      });
      const totalTravel = legs.reduce((sum, minutes) => sum + minutes, 0);
      const totalNominal = order.reduce((sum, place) => sum + place.durationMinutes, 0);
      const available = dayEndMinutes - clockMinutes - totalTravel - returnMinutesFor(order.at(-1));
      const feasible = totalNominal > 0 && available >= totalNominal * 0.5;
      if (!feasible) return;
      const score = order.reduce((sum, place) => sum + preferenceScoreOf(place), 0);
      const better = score > bestPlan.score
        || (score === bestPlan.score && order.length > bestPlan.places.length)
        || (score === bestPlan.score && order.length === bestPlan.places.length && totalTravel < bestPlan.totalTravel);
      if (better) bestPlan = { places: order, legs, score, totalTravel };
    });
  });

  const totalNominalDuration = bestPlan.places.reduce((sum, place) => sum + place.durationMinutes, 0);
  const availableForVisits = dayEndMinutes - clockMinutes
    - bestPlan.totalTravel
    - returnMinutesFor(bestPlan.places.at(-1));
  const scaleFactor = totalNominalDuration > 0 ? Math.min(1, availableForVisits / totalNominalDuration) : 1;

  bestPlan.places.forEach((place) => {
    const compressedDuration = Math.max(place.durationMinutes / 2, Math.round(place.durationMinutes * scaleFactor));
    const compressedPlace = { ...place, durationMinutes: compressedDuration };
    const leg = scheduleLeg(current, clockMinutes, compressedPlace);
    rebuilt.push(compressedPlace);
    current = compressedPlace;
    clockMinutes = leg.endMinutes;
  });

  mealParkingChecks.forEach((check) => {
    const index = rebuilt.indexOf(check.ref);
    if (index === -1) return;
    const next = rebuilt[index + 1] || fixedRemainder[0] || null;
    const resolved = resolveMealParkingDetour(
      check.ref,
      check.prevPlace,
      next,
      check.prevClockMinutes,
      availableResults,
      usedIds,
      dayEndMinutes,
      returnDestination,
    );
    if (resolved !== check.ref) rebuilt[index] = resolved;
  });

  state.routeDays[dayIndex] = [...keptStops, ...rebuilt, ...fixedRemainder];
  state.route = state.routeDays.flat();
  state.replannedDays.set(dayIndex, stopIndex);
  return { ok: true };
}

function stadiumDinnerSuitability(place) {
  const foodType = String(place.foodType || "");
  if (/한식|치킨|버거|피자/.test(foodType)) return 1;
  if (/만두|분식|타코|새우/.test(foodType)) return 0.9;
  if (/핫도그/.test(foodType)) return 0.8;
  if (/편의점/.test(foodType)) return 0.45;
  if (/디저트|아이스크림|음료/.test(foodType)) return 0.25;
  return 0.65;
}

function selectStadiumFood(results, schedule, usedIds = new Set()) {
  const selected = state.stadiumFoods
    .filter((place) =>
      place.stadiumFood
      && !usedIds.has(place.id)
      && place.venueId === "gwangju-kia-champions-field"
      && place.routeEligible !== false
      && place.availabilityStatus !== "closed"
      && !["prototype", "superseded"].includes(place.qualityStatus),
    )
    .map((place) => ({
      ...place,
      dinnerSuitability: stadiumDinnerSuitability(place),
      stadiumScore: stadiumDinnerSuitability(place) * 1.25
        + cosineSimilarity(currentVector(), place.vector) * 0.35
        + (place.menuSourceConfidence === "high_field_photo" ? 0.3 : 0)
        + (place.verificationStatus?.startsWith("official_") ? 0.12 : 0)
        + (place.sourceConfidence?.startsWith("high_brand_location") ? 0.04 : 0),
    }))
    .sort((a, b) => b.stadiumScore - a.stadiumScore)[0];
  if (!selected) return null;
  return {
    ...selected,
    description: `${selected.description} 경기 시작 전에 구매해 관람석에서 저녁으로 먹도록 배치했습니다.`,
    durationMinutes: STADIUM_FOOD_DURATION_MINUTES,
    fixedStartMinutes: schedule.stadiumFoodStartMinutes,
    purchaseStartMinutes: schedule.stadiumFoodStartMinutes,
    mealTargetMinutes: schedule.gameStartMinutes,
    mealSlot: "stadium_food",
    mealLabel: "저녁 · 야구장 먹거리",
    eatDuringGame: true,
    reasons: ["저녁 식사", "구장 내부에서 구매", "직관하며 먹기"],
  };
}

function buildBaseballRouteDay(results, conditions, usedIds, dayIndex, window, isFinalDay) {
  const schedule = baseballScheduleForDate(window.date);
  if (!schedule) {
    state.scheduleWarnings.push(`Day ${dayIndex + 1} · ${formatTripDate(window.date)} 관람 가능한 광주 홈경기가 없어 일반 여행 일정으로 구성했습니다.`);
    return buildRouteDay(results, conditions, usedIds, dayIndex, window, isFinalDay);
  }
  const day = [];
  let current = conditions.origin;
  let clockMinutes = window.startMinutes;
  const mealParkingChecks = [];
  const stadiumFood = selectStadiumFood(results, schedule, usedIds);
  const pregameEndMinutes = schedule.stadiumFoodStartMinutes;
  const lunchSlot = MEAL_SLOTS.find((slot) =>
    slot.key === "lunch"
    && slot.targetMinutes >= clockMinutes
    && slot.targetMinutes + MEAL_DURATION_MINUTES <= pregameEndMinutes,
  );

  if (lunchSlot) {
    const filler = chooseFillerBeforeMeal(
      results,
      current,
      clockMinutes,
      usedIds,
      lunchSlot,
      pregameEndMinutes,
      CHAMPIONS_FIELD_GAME,
    );
    if (filler) {
      day.push(filler.place);
      usedIds.add(filler.place.id);
      current = filler.place;
      clockMinutes = filler.leg.endMinutes;
    }

    const meal = chooseMealCandidate(
      results,
      current,
      clockMinutes,
      usedIds,
      lunchSlot,
      pregameEndMinutes,
      CHAMPIONS_FIELD_GAME,
    );
    if (meal) {
      const mealPlace = annotateMealPlace(meal.place, lunchSlot);
      mealParkingChecks.push({ ref: mealPlace, prevPlace: current, prevClockMinutes: clockMinutes });
      day.push(mealPlace);
      usedIds.add(meal.place.id);
      current = mealPlace;
      clockMinutes = meal.leg.endMinutes;
    } else {
      state.mealWarnings.push(`Day ${dayIndex + 1} 점심 후보를 찾지 못했습니다.`);
    }
  }

  while (day.length < 3) {
    const next = results
      .filter((place) =>
        !usedIds.has(place.id)
        && hasUsableCoordinates(place)
        && !isMealPlace(place)
        && !place.isBaseballGame,
      )
      .map((place) => ({ place, leg: scheduleLeg(current, clockMinutes, place) }))
      .filter(({ place, leg }) =>
        leg.endMinutes + returnTravelMinutes(place, CHAMPIONS_FIELD_GAME) <= pregameEndMinutes
        && !exceedsClosingTime(place, leg.endMinutes)
        && !exceedsWalkTimeLimit(leg.travelMinutes),
      )
      .sort((a, b) => routeCandidateValue(b.place, current) - routeCandidateValue(a.place, current))[0];
    if (!next) break;
    day.push(next.place);
    usedIds.add(next.place.id);
    current = next.place;
    clockMinutes = next.leg.endMinutes;
  }

  mealParkingChecks.forEach((check) => {
    const index = day.indexOf(check.ref);
    if (index === -1) return;
    const next = day[index + 1] || null;
    const resolved = resolveMealParkingDetour(
      check.ref,
      check.prevPlace,
      next,
      check.prevClockMinutes,
      results,
      usedIds,
      pregameEndMinutes,
      CHAMPIONS_FIELD_GAME,
    );
    if (resolved !== check.ref) day[index] = resolved;
  });

  if (stadiumFood) {
    day.push(stadiumFood);
    usedIds.add(stadiumFood.id);
  } else {
    state.mealWarnings.push(`Day ${dayIndex + 1} 야구장 저녁 후보를 찾지 못했습니다.`);
  }
  day.push({
    ...CHAMPIONS_FIELD_GAME,
    fixedStartMinutes: schedule.gameStartMinutes,
    expectedEndMinutes: schedule.gameEndMinutes,
    gameDate: window.date,
    gameDayType: schedule.dayTypeLabel,
    sourceGameId: schedule.game.source_game_id,
    opponent: schedule.game.away_team_name,
    gameStatus: schedule.game.status,
    gameTimeChangeReason: schedule.game.time_change_reason,
    endsTrip: isFinalDay,
    reasons: [
      `${schedule.game.away_team_name}전 · ${schedule.dayTypeLabel} ${formatClockMinutes(schedule.gameStartMinutes)} 시작`,
      "3시간~3시간 30분 관람",
      `Day ${dayIndex + 1} 마지막 일정`,
    ],
  });
  return day;
}

function createRoute(results) {
  const conditions = currentConditions();
  const windows = travelDayWindows(conditions);
  const usedIds = new Set();
  state.mealWarnings = [];
  state.scheduleWarnings = [];
  const builtDays = windows
    .map((window, dayIndex) => {
      addClosedNamedPlaceWarnings(window.date, dayIndex);
      const dayConditions = conditionsForRouteDate(conditions, window.date);
      const rankedResults = conditions.weatherMode === "auto"
        ? rankPlacesLocal(dayConditions)
        : results;
      const availableResults = rankedResults.filter((place) => placeIsOpenOnDate(place, window.date) && hasRequiredParking(place));
      return {
        window,
        day: conditions.baseballAttendance && conditions.baseballDayIndexes.includes(dayIndex)
          ? buildBaseballRouteDay(availableResults, dayConditions, usedIds, dayIndex, window, dayIndex === windows.length - 1)
          : buildRouteDay(availableResults, dayConditions, usedIds, dayIndex, window, dayIndex === windows.length - 1),
      };
    })
    .filter(({ day }) => day.length);
  state.dayWindows = builtDays.map(({ window }) => window);
  state.routeDays = builtDays.map(({ day }) => day);
  state.route = state.routeDays.flat();
  state.selectedDay = 0;
  state.replannedDays = new Map();
}

function buildRouteSchedule(day, dayIndex = 0) {
  const conditions = currentConditions();
  let current = conditions.origin;
  let clockMinutes = state.dayWindows[dayIndex]?.startMinutes ?? parseClockMinutes(conditions.startTime);
  return day.map((place) => {
    const leg = scheduleLeg(
      current,
      clockMinutes,
      place,
      place.fixedStartMinutes ?? place.mealTargetMinutes ?? null,
      { snap: place.fixedStartMinutes == null },
    );
    const scheduled = { place, ...leg };
    current = place;
    clockMinutes = leg.endMinutes;
    return scheduled;
  });
}

function dayMetrics(dayIndex) {
  const day = state.routeDays[dayIndex] || [];
  const conditions = currentConditions();
  const schedule = buildRouteSchedule(day, dayIndex);
  let distance = schedule.reduce((sum, stop) => sum + stop.distance, 0);
  let minutes = 0;
  const startMinutes = state.dayWindows[dayIndex]?.startMinutes ?? parseClockMinutes(conditions.startTime);
  if (schedule.length) minutes += schedule.at(-1).endMinutes - startMinutes;
  const isFinalDay = dayIndex === state.routeDays.length - 1;
  if (isFinalDay && day.length && !day.at(-1).endsTrip) {
    const returnDistance = haversineKm(day.at(-1), conditions.origin);
    distance += returnDistance;
    minutes += estimateTravelMinutes(returnDistance);
  }
  return { distance, minutes };
}

function dayRoutePoints(dayIndex) {
  const day = state.routeDays[dayIndex] || [];
  const conditions = currentConditions();
  const origin = conditions.origin;
  const isFirstDay = dayIndex === 0;
  const isFinalDay = dayIndex === state.routeDays.length - 1;
  const includesReturn = isFinalDay && day.length > 0 && !day.at(-1).endsTrip;
  const points = [];
  if (isFirstDay) points.push({ ...origin, isOrigin: true, stopNumber: null });
  day.forEach((place, index) => points.push({ ...place, isOrigin: false, stopNumber: index + 1 }));
  return { points, origin, includesReturn };
}

function updateMapMeta() {
  const metrics = dayMetrics(state.selectedDay);
  $("#mapHeading").textContent = `Day ${state.selectedDay + 1} 동선`;
  $("#mapSummary").textContent = `이동 거리 · ${metrics.distance.toFixed(1)}km`;
}

function formatDuration(minutes) {
  const hours = Math.floor(minutes / 60);
  const rest = Math.round(minutes % 60);
  if (!hours) return `${rest}분`;
  return rest ? `${hours}시간 ${rest}분` : `${hours}시간`;
}

function durationLabel() {
  const dayCount = travelDayWindows(currentConditions()).length;
  if (dayCount > 1) return `${dayCount - 1}박 ${dayCount}일`;
  if (state.duration >= 480) return "하루";
  return "반나절";
}

const MAX_PREVIEW_PHOTOS = 8;
const PREVIEW_POLL_INTERVAL_MS = 1500;
const PREVIEW_POLL_TIMEOUT_MS = 60000;
// scripts/build_route_video.ps1 의 $OpenDuration / $MoveDuration 과 반드시 동일해야 챕터 구간이 맞는다.
const PREVIEW_OPEN_DURATION = 4.083333;
const PREVIEW_MOVE_DURATION = 3.511111;

function previewSlidePlaces() {
  return state.route
    .filter((place) => Boolean(place.imageUrl))
    .slice(0, MAX_PREVIEW_PHOTOS);
}

function computePreviewChapterBounds(count) {
  if (count <= 1) return [{ start: 0, end: 1 }];
  const total = 2 * PREVIEW_OPEN_DURATION + (count - 1) * PREVIEW_MOVE_DURATION;
  const bounds = [];
  let prevBoundary = 0;
  for (let i = 0; i < count - 1; i++) {
    const mid = PREVIEW_OPEN_DURATION + i * PREVIEW_MOVE_DURATION + PREVIEW_MOVE_DURATION / 2;
    bounds.push({ start: prevBoundary / total, end: mid / total });
    prevBoundary = mid;
  }
  bounds.push({ start: prevBoundary / total, end: 1 });
  return bounds;
}

function renderPreviewChapters(places) {
  const marks = $("#previewChapterMarks");
  const tooltip = $("#previewChapterTooltip");
  marks.innerHTML = "";
  tooltip.hidden = true;
  tooltip.classList.remove("is-visible");
  if (places.length <= 1) return;

  computePreviewChapterBounds(places.length).forEach((bound, index) => {
    if (index > 0) {
      const divider = document.createElement("i");
      divider.className = "preview-chapter-divider";
      divider.style.left = `${bound.start * 100}%`;
      marks.appendChild(divider);
    }
    const hit = document.createElement("span");
    hit.className = "preview-chapter-hit";
    hit.style.left = `${bound.start * 100}%`;
    hit.style.width = `${(bound.end - bound.start) * 100}%`;
    const placeName = places[index].name || `장소 ${index + 1}`;
    hit.addEventListener("mouseenter", () => {
      tooltip.textContent = placeName;
      tooltip.style.left = `${(bound.start + bound.end) * 50}%`;
      tooltip.hidden = false;
      tooltip.classList.add("is-visible");
    });
    hit.addEventListener("mouseleave", () => {
      tooltip.classList.remove("is-visible");
      tooltip.hidden = true;
    });
    marks.appendChild(hit);
  });
}

function routeVideoProxyUrl() {
  const config = window.OMAEROUTE_CONFIG || {};
  if (config.routeVideoProxyUrl === false) return "";
  return String(config.routeVideoProxyUrl || "/api/route-video").trim();
}

function setPreviewCopy(title, description) {
  $("#previewTitle").textContent = title;
  $("#previewDescription").textContent = description;
}

function renderPreview() {
  const scene = $("#previewScene");
  const button = $("#previewPlayButton");
  scene.classList.toggle("is-playing", state.previewPlaying);
  button.hidden = state.previewVideoStatus !== "ready";
  button.textContent = state.previewPlaying ? "Ⅱ" : "▶";
  button.setAttribute("aria-label", state.previewPlaying ? "프리뷰 일시정지" : "프리뷰 재생");
}

function stopPreview() {
  const video = $("#tripPreviewVideo");
  if (video) video.pause();
  state.previewPlaying = false;
  renderPreview();
}

function startPreview() {
  const video = $("#tripPreviewVideo");
  if (!video || state.previewVideoStatus !== "ready") return;
  video.play().then(() => {
    state.previewPlaying = true;
    renderPreview();
  }).catch(() => {});
}

function togglePreview() {
  if (state.previewPlaying) stopPreview();
  else startPreview();
}

async function refreshTripPreviewVideo() {
  const token = ++state.previewVideoRequestToken;
  if (state.previewVideoPollTimer) {
    window.clearTimeout(state.previewVideoPollTimer);
    state.previewVideoPollTimer = null;
  }

  const scene = $("#previewScene");
  const video = $("#tripPreviewVideo");
  const previousUrl = video.currentSrc || video.src;
  video.pause();
  video.removeAttribute("src");
  video.load();
  if (previousUrl && previousUrl.startsWith("blob:")) {
    URL.revokeObjectURL(previousUrl);
  }
  state.previewPlaying = false;
  $("#previewProgress").style.width = "0%";

  const places = previewSlidePlaces();
  const imageUrls = places.map((place) => place.imageUrl);
  renderPreviewChapters(places);
  const proxyUrl = routeVideoProxyUrl();
  if (!imageUrls.length || !proxyUrl) {
    state.previewVideoStatus = "idle";
    scene.hidden = true;
    return;
  }

  scene.hidden = false;
  state.previewVideoStatus = "loading";
  setPreviewCopy("여행 미리보기 영상 준비 중", "잠시만 기다려주세요...");
  renderPreview();

  try {
    const postUrl = new URL(proxyUrl, window.location.href).toString();
    const submitResponse = await fetch(postUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ imageUrls }),
    });
    if (submitResponse.status !== 202) {
      throw new Error(`영상 생성 요청 실패 (HTTP ${submitResponse.status})`);
    }
    const { jobId } = await submitResponse.json();
    if (!jobId) throw new Error("작업 ID를 받지 못했습니다.");
    if (token !== state.previewVideoRequestToken) return;

    const pollUrl = new URL(proxyUrl, window.location.href);
    pollUrl.searchParams.set("id", jobId);
    const deadline = Date.now() + PREVIEW_POLL_TIMEOUT_MS;

    while (Date.now() < deadline) {
      if (token !== state.previewVideoRequestToken) return;
      const pollResponse = await fetch(pollUrl.toString());
      if (pollResponse.status === 200) {
        const blob = await pollResponse.blob();
        if (token !== state.previewVideoRequestToken) return;
        video.loop = true;
        video.src = URL.createObjectURL(blob);
        video.load();
        state.previewVideoStatus = "ready";
        setPreviewCopy("AI가 구성한 여행 미리보기", "추천 장소를 영상으로 미리 만나보세요.");
        video.addEventListener("canplay", () => {
          if (token !== state.previewVideoRequestToken) return;
          video.play().then(() => {
            state.previewPlaying = true;
            renderPreview();
          }).catch(() => {});
        }, { once: true });
        renderPreview();
        return;
      }
      if (pollResponse.status !== 202) {
        throw new Error(`영상 생성 실패 (HTTP ${pollResponse.status})`);
      }
      await new Promise((resolve) => {
        state.previewVideoPollTimer = window.setTimeout(resolve, PREVIEW_POLL_INTERVAL_MS);
      });
    }
    throw new Error("영상 생성이 시간 내에 끝나지 않았습니다.");
  } catch (error) {
    if (token !== state.previewVideoRequestToken) return;
    state.previewVideoStatus = "error";
    setPreviewCopy("여행 미리보기 영상을 만들지 못했습니다", "잠시 후 다시 시도해주세요.");
    renderPreview();
  }
}

function placeStampId(place) {
  return String(place.sourcePlaceId || place.id);
}

function loadStampIds() {
  try {
    const saved = JSON.parse(localStorage.getItem("omaeroute_stamped_place_ids") || "[]");
    state.stampedIds = Array.isArray(saved) ? saved.map(String) : [];
  } catch {
    state.stampedIds = [];
  }
}

function persistStampIds() {
  localStorage.setItem("omaeroute_stamped_place_ids", JSON.stringify(state.stampedIds));
}

function loadReviewRewards() {
  try {
    const reviews = JSON.parse(localStorage.getItem(REVIEW_STORAGE_KEY) || "[]");
    const rewards = JSON.parse(localStorage.getItem(REWARD_STORAGE_KEY) || "[]");
    state.reviews = Array.isArray(reviews) ? reviews : [];
    state.rewards = Array.isArray(rewards) ? rewards : [];
  } catch {
    state.reviews = [];
    state.rewards = [];
  }
}

function persistReviewRewards() {
  localStorage.setItem(REVIEW_STORAGE_KEY, JSON.stringify(state.reviews));
  localStorage.setItem(REWARD_STORAGE_KEY, JSON.stringify(state.rewards));
}

function reviewRouteSummary() {
  return state.routeDays.flatMap((day, dayIndex) =>
    buildRouteSchedule(day, dayIndex).map(
      (stop, stopIndex) => `${stopIndex + 1}.${stop.place.name}(${formatClockMinutes(stop.startMinutes)})`,
    ),
  ).join(" → ");
}

function currentRouteReview() {
  if (!state.route.length) return null;
  const signature = routeSignature();
  return state.reviews.find((review) => review.signature === signature) || null;
}

function currentRouteReward(review = currentRouteReview()) {
  if (!review) return null;
  return state.rewards.find((reward) => reward.reviewId === review.id) || null;
}

function formatRewardDate(value) {
  if (!value) return "";
  return new Date(value).toLocaleDateString("ko-KR", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

function updateReviewCharacterCount() {
  const textarea = $("#reviewText");
  if (!textarea) return;
  $("#reviewCharacterCount").textContent = `${textarea.value.length} / ${textarea.maxLength}`;
}

function renderReviewReward() {
  const textarea = $("#reviewText");
  const submitButton = $("#reviewSubmitButton");
  const rewardCard = $("#rewardCard");
  if (!textarea || !submitButton || !rewardCard) return;

  const review = currentRouteReview();
  const reward = currentRouteReward(review);
  const activeStampCount = state.route.filter((place) =>
    state.stampedIds.includes(placeStampId(place)),
  ).length;
  $("#reviewStampSummary").textContent = `스탬프 ${activeStampCount}개와 함께 저장`;

  if (!review) {
    textarea.disabled = false;
    textarea.value = "";
    submitButton.disabled = false;
    submitButton.textContent = "리뷰 등록하고 10% 쿠폰 받기";
    $("#reviewStatusBadge").textContent = "작성 전";
    rewardCard.hidden = true;
    updateReviewCharacterCount();
    return;
  }

  textarea.value = review.reviewText;
  textarea.disabled = true;
  submitButton.disabled = true;
  submitButton.textContent = "이 코스의 리뷰 등록 완료";
  $("#reviewStatusBadge").textContent = "등록 완료";
  updateReviewCharacterCount();

  if (!reward) {
    rewardCard.hidden = true;
    return;
  }
  $("#rewardTitle").textContent = reward.title;
  $("#rewardCode").textContent = reward.code;
  $("#rewardExpiry").textContent = `${formatRewardDate(reward.expiresAt)}까지 · 제휴 연동 전 시연용`;
  rewardCard.hidden = false;
}

function submitRouteReview() {
  if (!state.route.length) {
    showStampToast("먼저 여행 코스를 생성해주세요.", "warning");
    return;
  }
  const existingReview = currentRouteReview();
  if (existingReview) {
    showStampToast("이 코스에는 이미 리뷰를 등록했습니다.", "warning");
    renderReviewReward();
    return;
  }

  const reviewText = $("#reviewText").value.trim();
  if (!reviewText) {
    showStampToast("여행 경험을 한 글자 이상 입력해주세요.", "warning");
    $("#reviewText").focus();
    return;
  }

  const now = new Date();
  const reviewId = `review-${now.getTime()}`;
  const signature = routeSignature();
  const conditions = currentConditions();
  const stampedPlaceIds = state.route
    .filter((place) => state.stampedIds.includes(placeStampId(place)))
    .map(placeStampId);
  const review = {
    id: reviewId,
    signature,
    timestamp: now.toISOString(),
    preferenceVector: AXES.reduce((values, axis, index) => {
      values[axis.key] = state.preference[index] / 100;
      return values;
    }, {}),
    routeSummary: reviewRouteSummary(),
    route: state.route.map((place) => ({
      id: place.id,
      name: place.name,
      mealSlot: place.mealSlot || null,
    })),
    stampedPlaceIds,
    conditions: {
      originKey: conditions.originKey,
      originName: conditions.origin.name,
      travelDate: conditions.travelDate,
      startTime: conditions.startTime,
      endDate: conditions.endDate,
      endTime: conditions.endTime,
      transport: conditions.transport,
    },
    reviewText,
  };

  const expiresAt = new Date(now);
  expiresAt.setDate(expiresAt.getDate() + 30);
  const codeSuffix = `${now.getTime().toString(36)}${Math.random().toString(36).slice(2, 5)}`
    .toUpperCase()
    .slice(-8);
  const reward = {
    id: `reward-${now.getTime()}`,
    reviewId,
    signature,
    code: `OMAE-${codeSuffix}`,
    title: "광주 지역 식당 10% 할인 쿠폰",
    discountPercent: 10,
    issuedAt: now.toISOString(),
    expiresAt: expiresAt.toISOString(),
    status: "issued",
    prototype: true,
  };

  state.reviews.unshift(review);
  state.rewards.unshift(reward);
  persistReviewRewards();
  renderReviewReward();
  showStampToast("🎉 리뷰가 등록되어 시연용 10% 할인 쿠폰을 발급했습니다!", "success");
}

async function copyRewardCode() {
  const code = $("#rewardCode").textContent.trim();
  if (!code) return;
  try {
    await navigator.clipboard.writeText(code);
    showStampToast("쿠폰 코드를 복사했습니다.", "success");
  } catch {
    showStampToast(`쿠폰 코드: ${code}`, "info");
  }
}

function usesChampionsFieldStamp(place) {
  const searchableText = `${place.name || ""} ${(place.hashtags || []).join(" ")}`;
  return /챔피언스\s*필드/i.test(searchableText);
}

function championsFieldStampContent(isStamped, isInRange) {
  const stateLabel = isStamped ? "스탬프 획득" : isInRange ? "도장 찍기" : "방문";
  return `
    <span class="champions-field-stamp-art" aria-hidden="true">
      <span class="champions-field-stamp-fallback"><b>⚾</b><small>GWANGJU</small></span>
      <img
        class="champions-field-stamp-image"
        src="${CHAMPIONS_FIELD_STAMP_ASSET}"
        alt=""
        loading="lazy"
        decoding="async"
        draggable="false"
      >
    </span>
    <span class="champions-field-stamp-state">${stateLabel}</span>
  `;
}

function usesFoodThemeStamp(place) {
  return place.databaseType === "restaurant"
    || place.databaseType === "stadium_food"
    || Boolean(place.stadiumFood)
    || place.category === "음식·로컬";
}

function stampThemeForPlace(place) {
  const key = usesFoodThemeStamp(place)
    ? "food"
    : STAMP_THEME_BY_CATEGORY[place.category] || "local";
  return { key, ...STAMP_THEMES[key] };
}

function themePatternForPlace(place, themeKey) {
  if (themeKey === "food") return null;
  return state.stampPatternCategories.get(place.category) || null;
}

function themeStampContent(theme, pattern, isStamped, isInRange) {
  const stateLabel = isStamped ? "스탬프 획득" : isInRange ? "도장 찍기" : "방문";
  return `
    <span class="theme-stamp-art" aria-hidden="true">
      ${pattern ? `
        <img
          class="theme-stamp-pattern"
          src="${escapeHtml(pattern.asset)}"
          alt=""
          loading="lazy"
          decoding="async"
          draggable="false"
        >
      ` : ""}
      <img
        class="theme-stamp-template"
        src="${escapeHtml(theme.asset)}"
        alt=""
        loading="lazy"
        decoding="async"
        draggable="false"
      >
    </span>
    <span class="theme-stamp-state">${stateLabel}</span>
  `;
}

function formatStampDistance(distanceMeters) {
  if (distanceMeters === null) return "위치 확인 전";
  if (distanceMeters <= 100) return "100m 이내 · 도장 찍기 가능";
  if (distanceMeters >= 1000) return `${(distanceMeters / 1000).toFixed(1)}km 남음`;
  return `${Math.round(distanceMeters)}m 남음`;
}

function showStampToast(message, type = "info") {
  const toast = $("#stampToast");
  if (state.stampToastTimer) window.clearTimeout(state.stampToastTimer);
  toast.textContent = message;
  toast.className = `stamp-toast ${type}`;
  toast.hidden = false;
  state.stampToastTimer = window.setTimeout(() => {
    toast.hidden = true;
  }, 3500);
}

function renderStamps() {
  const select = $("#stampLocationSelect");
  const routeIds = new Set(state.route.map(placeStampId));
  if (state.stampLocationMode !== "GPS" && !routeIds.has(state.stampLocationMode)) {
    state.stampLocationMode = "GPS";
    state.stampLocation = null;
    $("#stampLocationStatus").textContent = "새 코스에서 GPS 위치를 다시 확인하세요.";
  }

  select.innerHTML = [
    '<option value="GPS">📡 GPS · 실제 내 위치 사용</option>',
    '<optgroup label="[데모] 관광지 위치로 이동">',
    ...state.route.map((place) => {
      const id = placeStampId(place);
      return `<option value="${escapeHtml(id)}">📍 ${escapeHtml(place.name)}</option>`;
    }),
    "</optgroup>",
  ].join("");
  select.value = state.stampLocationMode;

  const activeCount = state.route.filter((place) => state.stampedIds.includes(placeStampId(place))).length;
  $("#stampProgressBadge").textContent = `${activeCount} / ${state.route.length}`;
  $("#stampProgressText").textContent = `${activeCount} / ${state.route.length} 획득`;
  $("#stampProgressBar").style.width = state.route.length
    ? `${(activeCount / state.route.length) * 100}%`
    : "0%";
  const reviewStampSummary = $("#reviewStampSummary");
  if (reviewStampSummary) reviewStampSummary.textContent = `스탬프 ${activeCount}개와 함께 저장`;

  $("#stampGrid").innerHTML = state.route.map((place) => {
    const id = placeStampId(place);
    const isStamped = state.stampedIds.includes(id);
    const distanceMeters = state.stampLocation
      ? Math.round(haversineKm(state.stampLocation, place) * 1000)
      : null;
    const isInRange = distanceMeters !== null && distanceMeters <= 100;
    const isChampionsField = usesChampionsFieldStamp(place);
    const theme = isChampionsField ? null : stampThemeForPlace(place);
    const themePattern = theme ? themePatternForPlace(place, theme.key) : null;
    const sealClass = [
      isStamped ? "unlocked" : isInRange ? "in-range" : "",
      isChampionsField ? "champions-field-stamp" : "",
      theme ? `theme-stamp stamp-theme-${theme.key}` : "",
    ].filter(Boolean).join(" ");
    const sealContent = isChampionsField
      ? championsFieldStampContent(isStamped, isInRange)
      : themeStampContent(theme, themePattern, isStamped, isInRange);
    const patternTitle = themePattern
      ? ` · AI Hub 전통 문양 ${themePattern.patternType || "배경"}`
      : "";
    const stampTitle = theme ? `${theme.label} 테마 스탬프${patternTitle}` : "";
    const distanceClass = isInRange && !isStamped ? "ready" : "";
    const distanceText = isStamped ? "✓ 스탬프 획득" : formatStampDistance(distanceMeters);
    return `
      <article class="stamp-item">
        <button
          type="button"
          class="stamp-seal ${sealClass}"
          data-stamp-id="${escapeHtml(id)}"
          ${theme ? `data-stamp-theme="${escapeHtml(theme.key)}"` : ""}
          aria-label="${escapeHtml(place.name)} ${isStamped ? "스탬프 획득 완료" : "스탬프 찍기"}"
          ${stampTitle ? `title="${escapeHtml(stampTitle)}"` : ""}
          ${isStamped ? "disabled" : ""}
        >${sealContent}</button>
        <p class="stamp-place-name" title="${escapeHtml(place.name)}">${escapeHtml(place.name)}</p>
        <p class="stamp-distance ${distanceClass}">${escapeHtml(distanceText)}</p>
      </article>
    `;
  }).join("");
}

function requestStampGeolocation() {
  state.stampLocationMode = "GPS";
  $("#stampLocationSelect").value = "GPS";
  if (!navigator.geolocation) {
    $("#stampLocationStatus").textContent = "이 브라우저는 GPS를 지원하지 않습니다.";
    showStampToast("브라우저에서 위치 기능을 사용할 수 없습니다.", "warning");
    return;
  }

  $("#stampLocationStatus").textContent = "GPS 위치 수신 중…";
  navigator.geolocation.getCurrentPosition(
    (position) => {
      state.stampLocation = {
        latitude: position.coords.latitude,
        longitude: position.coords.longitude,
      };
      $("#stampLocationStatus").textContent = `GPS 수신 완료 · 오차 약 ${Math.round(position.coords.accuracy)}m`;
      renderStamps();
      showStampToast("현재 위치를 확인했습니다.", "info");
    },
    (error) => {
      const message = error.code === 1
        ? "위치 권한이 거부되었습니다. 브라우저 설정에서 위치 권한을 허용해주세요."
        : "GPS 위치를 확인하지 못했습니다. 잠시 후 다시 시도해주세요.";
      state.stampLocation = null;
      $("#stampLocationStatus").textContent = message;
      renderStamps();
      showStampToast(message, "warning");
    },
    { enableHighAccuracy: true, timeout: 8000, maximumAge: 30000 },
  );
}

function selectStampLocation(value) {
  if (value === "GPS") {
    requestStampGeolocation();
    return;
  }
  const place = state.route.find((item) => placeStampId(item) === value);
  if (!place) return;
  state.stampLocationMode = value;
  state.stampLocation = {
    latitude: place.latitude,
    longitude: place.longitude,
  };
  $("#stampLocationStatus").textContent = `데모 위치 · ${place.name}`;
  renderStamps();
  showStampToast(`데모 위치를 ${place.name}(으)로 이동했습니다.`, "info");
}

function collectStamp(id) {
  const place = state.route.find((item) => placeStampId(item) === id);
  if (!place || state.stampedIds.includes(id)) return;
  if (!state.stampLocation) {
    showStampToast("먼저 GPS 위치를 확인하거나 데모 위치를 선택해주세요.", "warning");
    return;
  }
  const distanceMeters = Math.round(haversineKm(state.stampLocation, place) * 1000);
  if (distanceMeters > 100) {
    showStampToast(`${place.name}까지 ${formatStampDistance(distanceMeters)}입니다. 100m 안에서 다시 시도해주세요.`, "warning");
    return;
  }
  state.stampedIds.push(id);
  persistStampIds();
  renderStamps();
  showStampToast(`🎉 ${place.name} 스탬프를 획득했습니다!`, "success");
}

function resetStamps() {
  state.stampedIds = [];
  localStorage.removeItem("omaeroute_stamped_place_ids");
  renderStamps();
  showStampToast("스탬프 수집 기록을 초기화했습니다.", "info");
}

function renderMap() {
  const svg = $("#routeMap");
  $("#kakaoMap").hidden = true;
  svg.hidden = false;
  $("#mapProviderStatus").textContent = "Kakao Map 연결 중";
  $("#mapProviderStatus").classList.remove("fallback");
  const { points: routePoints, origin, includesReturn } = dayRoutePoints(state.selectedDay);
  if (routePoints.length < 2) return;

  const boundsPoints = includesReturn && !routePoints[0].isOrigin ? [...routePoints, origin] : routePoints;
  const lats = boundsPoints.map((point) => point.latitude);
  const lons = boundsPoints.map((point) => point.longitude);
  let minLat = Math.min(...lats);
  let maxLat = Math.max(...lats);
  let minLon = Math.min(...lons);
  let maxLon = Math.max(...lons);
  if (maxLat - minLat < 0.02) { minLat -= 0.01; maxLat += 0.01; }
  if (maxLon - minLon < 0.02) { minLon -= 0.01; maxLon += 0.01; }

  const project = (point) => ({
    x: 90 + ((point.longitude - minLon) / (maxLon - minLon)) * 740,
    y: 56 + (1 - (point.latitude - minLat) / (maxLat - minLat)) * 250,
  });
  const projected = routePoints.map(project);
  const linePoints = includesReturn ? [...projected, project(origin)] : projected;
  const polyline = linePoints.map((point) => `${point.x},${point.y}`).join(" ");
  const grid = Array.from({ length: 13 }, (_, index) => {
    const x = -70 + index * 90;
    return `<path d="M${x} 0 L${x + 160} 390" stroke="#d1d6db" stroke-width="1" opacity=".6"/>`;
  }).join("");
  const markers = projected.map((point, index) => {
    const routePoint = routePoints[index];
    const name = routePoint.name;
    const shortName = name.length > 12 ? `${name.slice(0, 11)}…` : name;
    const color = routePoint.isOrigin ? "#1b64da" : "#3182f6";
    const labelX = clamp(point.x, 65, 855);
    const labelY = clamp(point.y + 24, 25, 350);
    return `
      <g>
        <circle cx="${point.x}" cy="${point.y}" r="17" fill="white" opacity=".96"/>
        <circle cx="${point.x}" cy="${point.y}" r="12" fill="${color}"/>
        <text x="${point.x}" y="${point.y + 3.5}" text-anchor="middle" fill="white" font-size="9" font-weight="800">${routePoint.isOrigin ? "S" : routePoint.stopNumber}</text>
        <rect x="${labelX - 57}" y="${labelY}" width="114" height="25" rx="8" fill="white" stroke="#c9e2ff"/>
        <text x="${labelX}" y="${labelY + 16}" text-anchor="middle" fill="#191f28" font-size="8.5" font-weight="700">${escapeHtml(shortName)}</text>
      </g>
    `;
  }).join("");

  svg.innerHTML = `
    <rect width="920" height="390" fill="#f4f6f8"/>
    ${grid}
    <path d="M0 285 C165 235 260 324 430 260 S670 176 920 228" fill="none" stroke="#dcecff" stroke-width="44" opacity=".82"/>
    <path d="M30 98 C230 50 350 128 520 82 S765 28 920 80" fill="none" stroke="#e5e8eb" stroke-width="22" opacity=".82"/>
    <polyline points="${polyline}" fill="none" stroke="#3182f6" stroke-width="4" stroke-dasharray="8 7" stroke-linecap="round" stroke-linejoin="round"/>
    ${markers}
  `;
}

function loadKakaoMapsSdk() {
  const key = (window.OMAEROUTE_CONFIG?.kakaoJavaScriptKey || "").trim();
  if (!key) return Promise.reject(new Error("Kakao JavaScript 키가 설정되지 않았습니다."));
  if (window.kakao?.maps) {
    return new Promise((resolve) => window.kakao.maps.load(resolve));
  }
  if (kakaoSdkPromise) return kakaoSdkPromise;

  kakaoSdkPromise = new Promise((resolve, reject) => {
    const script = document.createElement("script");
    const timeout = window.setTimeout(
      () => reject(new Error("Kakao Maps SDK 응답 시간이 초과되었습니다.")),
      9000,
    );
    script.id = "kakao-maps-sdk";
    script.async = true;
    script.src = `https://dapi.kakao.com/v2/maps/sdk.js?appkey=${encodeURIComponent(key)}&autoload=false`;
    script.onload = () => {
      window.clearTimeout(timeout);
      if (!window.kakao?.maps) {
        reject(new Error("Kakao Maps SDK를 초기화하지 못했습니다."));
        return;
      }
      window.kakao.maps.load(resolve);
    };
    script.onerror = () => {
      window.clearTimeout(timeout);
      reject(new Error("Kakao Maps SDK를 불러오지 못했습니다."));
    };
    document.head.appendChild(script);
  });
  return kakaoSdkPromise;
}

function showMapFallback(error) {
  console.warn("카카오맵 대신 SVG 지도를 표시합니다.", error);
  $("#kakaoMap").hidden = true;
  $("#routeMap").hidden = false;
  const status = $("#mapProviderStatus");
  const isMissingKey = String(error?.message || "").includes("키가 설정되지");
  status.textContent = isMissingKey ? "Kakao 키 설정 필요" : "Kakao 설정 확인 · SVG 지도";
  status.title = error?.message || "카카오맵 연결에 실패해 SVG 지도를 표시하고 있습니다.";
  status.classList.add("fallback");
}

async function renderKakaoMap() {
  if (!state.route.length || !$("#resultView").classList.contains("active")) return;
  try {
    await loadKakaoMapsSdk();
    const kakao = window.kakao;
    const mapElement = $("#kakaoMap");
    const { points: routePoints, origin, includesReturn } = dayRoutePoints(state.selectedDay);
    if (!routePoints.length) return;

    mapElement.hidden = false;
    $("#routeMap").hidden = true;
    mapElement.replaceChildren();

    const map = new kakao.maps.Map(mapElement, {
      center: new kakao.maps.LatLng(origin.latitude, origin.longitude),
      level: 8,
    });
    state.kakaoMap = map;
    state.kakaoMarkers = [];
    state.kakaoOverlays = [];

    map.addControl(new kakao.maps.MapTypeControl(), kakao.maps.ControlPosition.TOPRIGHT);
    map.addControl(new kakao.maps.ZoomControl(), kakao.maps.ControlPosition.RIGHT);

    const bounds = new kakao.maps.LatLngBounds();
    const linePath = [];

    routePoints.forEach((point) => {
      const position = new kakao.maps.LatLng(point.latitude, point.longitude);
      bounds.extend(position);
      linePath.push(position);

      const marker = new kakao.maps.Marker({ map, position, title: point.name });
      state.kakaoMarkers.push(marker);

      const infoNode = document.createElement("div");
      infoNode.style.cssText = "padding:9px 11px;min-width:145px;font-size:11px;line-height:1.5;text-align:center;font-family:'Noto Sans KR',sans-serif;";
      const infoTitle = document.createElement("strong");
      infoTitle.textContent = point.isOrigin ? `출발 · ${point.name}` : `${point.stopNumber}. ${point.name}`;
      infoNode.appendChild(infoTitle);
      if (point.region) {
        const infoMeta = document.createElement("div");
        infoMeta.style.cssText = "margin-top:3px;color:#737972;font-size:9px;";
        infoMeta.textContent = `${point.region} · ${point.category}`;
        infoNode.appendChild(infoMeta);
      }
      const infoWindow = new kakao.maps.InfoWindow({ content: infoNode, removable: true });
      kakao.maps.event.addListener(marker, "click", () => infoWindow.open(map, marker));

      const labelNode = document.createElement("div");
      labelNode.className = `kakao-route-label${point.isOrigin ? " start" : ""}`;
      labelNode.textContent = point.isOrigin ? `출발 · ${point.name}` : `${point.stopNumber}. ${point.name}`;
      const overlay = new kakao.maps.CustomOverlay({
        map,
        position,
        content: labelNode,
        yAnchor: 2.15,
        zIndex: 3,
      });
      state.kakaoOverlays.push(overlay);
    });

    if (includesReturn) {
      const returnPosition = new kakao.maps.LatLng(origin.latitude, origin.longitude);
      bounds.extend(returnPosition);
      linePath.push(returnPosition);
    }

    state.kakaoPolyline = new kakao.maps.Polyline({
      path: linePath,
      strokeWeight: 5,
      strokeColor: "#9b433c",
      strokeOpacity: 0.84,
      strokeStyle: "shortdash",
    });
    state.kakaoPolyline.setMap(map);
    map.setBounds(bounds);
    window.setTimeout(() => {
      map.relayout();
      map.setBounds(bounds);
    }, 120);

    if (!state.mapResizeBound) {
      window.addEventListener("resize", () => {
        if (state.kakaoMap && $("#resultView").classList.contains("active")) {
          state.kakaoMap.relayout();
        }
      });
      state.mapResizeBound = true;
    }

    $("#mapProviderStatus").textContent = "Kakao Map 연결됨";
    $("#mapProviderStatus").removeAttribute("title");
    $("#mapProviderStatus").classList.remove("fallback");
  } catch (error) {
    showMapFallback(error);
  }
}

function kakaoMapLink(place, nextPlace) {
  const placeName = encodeURIComponent(place.name);
  if (!nextPlace) {
    return `https://map.kakao.com/link/map/${placeName},${place.latitude},${place.longitude}`;
  }
  const nextName = encodeURIComponent(nextPlace.name);
  return `https://map.kakao.com/link/from/${placeName},${place.latitude},${place.longitude}/to/${nextName},${nextPlace.latitude},${nextPlace.longitude}`;
}

function josa(word, josaType) {
  if (!word) return "";
  const lastChar = word.charCodeAt(word.length - 1);
  const hasJongseong = (lastChar - 0xAC00) % 28 > 0;
  if (josaType === "와/과") return word + (hasJongseong ? "과" : "와");
  if (josaType === "을/를") return word + (hasJongseong ? "을" : "를");
  return word;
}

function dayTheme(day) {
  const axes = topAxes(2);
  if (!day.length) return "조건에 맞는 장소를 찾지 못했습니다.";
  const themeCopy = axes.length >= 2
    ? `${josa(axes[0].label, "와/과")} ${axes[1].label} 취향을 중심으로`
    : axes.length === 1
      ? `${axes[0].label} 취향을 중심으로`
      : "여행 조건에 맞춰";
  return `${themeCopy} ${day[0].region}에서 이어지는 일정`;
}

function renderDayTabs() {
  $("#dayTabs").innerHTML = state.routeDays
    .map((_, index) => {
      const date = state.dayWindows[index]?.date;
      const dateLabel = date ? ` · ${Number(date.slice(5, 7))}/${Number(date.slice(8, 10))}` : "";
      return `<button type="button" data-day="${index}" class="${index === state.selectedDay ? "active" : ""}">Day ${index + 1}${dateLabel}</button>`;
    })
    .join("");
}

function renderItinerary() {
  const conditions = currentConditions();
  const day = state.routeDays[state.selectedDay] || [];
  const schedule = buildRouteSchedule(day, state.selectedDay);
  const isFinalDay = state.selectedDay === state.routeDays.length - 1;
  const replanAnchorIndex = state.replannedDays.get(state.selectedDay);
  renderDayTabs();
  $("#dayTheme").textContent = dayTheme(day);
  $("#replanStopSelect").innerHTML = schedule
    .map((stop, index) => `<option value="${index}">${index + 1}. ${escapeHtml(stop.place.name)}</option>`)
    .join("");
  if (schedule.length) {
    const lastIndex = schedule.length - 1;
    $("#replanStopSelect").value = String(lastIndex);
    const now = new Date();
    const currentMinutes = now.getHours() * 60 + now.getMinutes();
    setTimeFieldValue($("#replanTimeInput"), formatClockMinutes(currentMinutes));
  }
  $("#replanStatus").hidden = true;
  const originStartCard = state.selectedDay === 0 ? `
    <article class="itinerary-stop origin-stop">
      <i class="timeline-node"></i>
      <div class="stop-card" tabindex="0">
        <div class="stop-meta">
          <span class="stop-time">◷ ${formatClockMinutes(state.dayWindows[0]?.startMinutes ?? parseClockMinutes(conditions.startTime))}</span>
          <span class="type-chip">출발지</span>
        </div>
        <h3>📍 ${escapeHtml(conditions.origin.name)}</h3>
        <p>선택하신 출발지에서 첫 일정을 시작합니다.</p>
        ${schedule.length ? `
          <div class="stop-details">
            <div class="stop-detail-actions">
              <a class="kakao-directions-link" href="${kakaoMapLink(conditions.origin, schedule[0].place)}" target="_blank" rel="noopener noreferrer">첫 장소 길찾기 ↗</a>
            </div>
          </div>
        ` : ""}
      </div>
    </article>
  ` : "";
  const lastPlace = day.at(-1);
  const returnCard = isFinalDay && lastPlace && !lastPlace.endsTrip && schedule.length ? `
    <article class="itinerary-stop origin-stop">
      <i class="timeline-node"></i>
      <div class="stop-card" tabindex="0">
        <div class="stop-meta">
          <span class="stop-time">◷ 약 ${formatClockMinutes(roundUpToStep(schedule.at(-1).endMinutes + returnTravelMinutes(lastPlace, conditions.origin)))}</span>
          <span class="type-chip">도착지</span>
        </div>
        <h3>📍 ${escapeHtml(conditions.origin.name)}</h3>
        <p>${escapeHtml(lastPlace.name)}에서 출발지로 복귀하며 여행이 마무리됩니다.</p>
        <div class="stop-details">
          <div class="stop-detail-actions">
            <a class="kakao-directions-link" href="${kakaoMapLink(lastPlace, conditions.origin)}" target="_blank" rel="noopener noreferrer">복귀 길찾기 ↗</a>
          </div>
        </div>
      </div>
    </article>
  ` : "";
  $("#itineraryTimeline").innerHTML = originStartCard + schedule.map((stop, index) => {
    const { place, travelMinutes, waitMinutes, startMinutes, endMinutes } = stop;
    const nextPlace = day[index + 1];
    const stadiumMenu = place.stadiumFood
      ? place.menuItems?.find((menu) => menu.signature) || place.menuItems?.[0]
      : null;
    const stadiumMenuPrice = Number.isFinite(stadiumMenu?.price)
      ? `${stadiumMenu.price.toLocaleString("ko-KR")}원`
      : "가격 현장 확인";
    const isFinalReturn = isFinalDay && !nextPlace && !place.endsTrip;
    const routeTarget = nextPlace || (isFinalReturn ? conditions.origin : null);
    const mapLink = kakaoMapLink(place, routeTarget);
    const originReturnMinutes = isFinalReturn ? returnTravelMinutes(place, conditions.origin) : 0;
    return `
      <article class="itinerary-stop">
        <i class="timeline-node"></i>
        <div class="stop-card" tabindex="0">
          <div class="stop-meta">
            <span class="stop-time">◷ 약 ${formatClockMinutes(startMinutes)}</span>
            ${replanAnchorIndex != null && index >= replanAnchorIndex ? `<span class="stop-time departure-time">→ 출발 약 ${formatClockMinutes(endMinutes)}</span>` : ""}
            ${place.isBaseballGame ? '<span class="meal-time-chip">⚾ 야구 직관</span>' : ""}
            ${place.mealSlot ? `<span class="meal-time-chip">🍚 ${escapeHtml(place.mealLabel)} 추천</span>` : ""}
            <span class="type-chip">${escapeHtml(place.category)}</span>
            ${place.hashtags.slice(0, 2).map((tag) => `<span class="hashtag-chip">${escapeHtml(tag)}</span>`).join("")}
          </div>
          <h3>${escapeHtml(place.name)}</h3>
          <div class="reason-callout">💡 추천 이유 · ${place.reasons.map(escapeHtml).join(" · ")}</div>
          <p class="expandable-desc">${escapeHtml(place.description)}</p>
          <div class="stop-details expandable-desc">
            ${place.isBaseballGame ? `
              <div class="baseball-game-callout">⚾ ${escapeHtml(place.gameDayType)} ${formatClockMinutes(place.fixedStartMinutes)} 경기 시작 · 약 3시간~3시간 30분 관람 · ${formatClockMinutes(place.expectedEndMinutes)} 종료</div>
            ` : ""}
            ${place.stadiumFood ? `
              <div class="stadium-food-callout">🍚 저녁 구매 · ${escapeHtml(place.branchName || "매장 위치 현장 확인")}${stadiumMenu ? ` · ${escapeHtml(stadiumMenu.name)} ${escapeHtml(stadiumMenuPrice)}` : ""} · 경기 시작 전에 사서 관람석에서 직관하며 식사</div>
            ` : ""}
            ${conditions.baseballAttendance && place.activeRecommendedPlayers?.length ? `
              <div class="player-recommendation">⚾ ${escapeHtml(place.activeRecommendedPlayers.join("·"))} 선수 추천</div>
            ` : ""}
            <div class="reason-callout detail-reason">이전 지점에서 약 ${travelMinutes}분${waitMinutes ? ` · ${place.isBaseballGame ? "경기 시작" : "식사시간"}까지 여유 ${waitMinutes}분` : ""}${isFinalReturn ? ` · ${escapeHtml(conditions.origin.name)} 복귀 약 ${originReturnMinutes}분 · ${escapeHtml(conditions.endTime)} 여행 종료 전 복귀` : ""}</div>
            <div class="stop-detail-actions">
              <a class="kakao-directions-link" href="${mapLink}" target="_blank" rel="noopener noreferrer">${nextPlace ? "다음 장소 길찾기" : isFinalReturn ? "출발지 복귀 길찾기" : "카카오맵에서 보기"} ↗</a>
            </div>
          </div>
        </div>
      </article>
    `;
  }).join("") + returnCard;
  renderWeatherBriefing();
}

function renderAlternatives() {
  const routeIds = new Set(state.route.map((place) => place.id));
  const alternatives = state.results.filter((place) => !routeIds.has(place.id)).slice(0, 3);
  $("#alternativeList").innerHTML = alternatives.length
    ? alternatives.map((place) => `
        <div class="alternative-item">
          <strong>${escapeHtml(place.name)}</strong>
          <span>${escapeHtml(place.region)} · 매칭 ${Math.round((place.displayScore ?? place.score) * 100)}%</span>
          <span>${place.reasons.map(escapeHtml).join(" · ")}</span>
        </div>
      `).join("")
    : '<p class="empty-copy">추가 추천 후보가 없습니다.</p>';
}

function geminiProxyUrl() {
  const config = window.OMAEROUTE_CONFIG || {};
  if (config.geminiProxyUrl === false) return "";
  return String(config.geminiProxyUrl || "/api/gemini").trim();
}

async function requestGemini(contents, { timeoutMs = 12000, generationConfig = null } = {}) {
  const proxyUrl = geminiProxyUrl();
  if (!proxyUrl) return null;
  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), timeoutMs);
  try {
    const url = new URL(proxyUrl, window.location.href).toString();
    const response = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(generationConfig ? { contents, generationConfig } : { contents }),
      signal: controller.signal,
    });
    if (!response.ok) return null;
    const data = await response.json();
    return data?.candidates?.[0]?.content?.parts?.[0]?.text || null;
  } catch {
    return null;
  } finally {
    window.clearTimeout(timeout);
  }
}

async function requestAiTips(prompt) {
  const rawText = await requestGemini(
    [{ role: "user", parts: [{ text: prompt }] }],
    { generationConfig: { temperature: 0.7, maxOutputTokens: 500 } },
  );
  if (!rawText) return null;
  try {
    const parsed = JSON.parse(rawText.replace(/```json|```/g, "").trim());
    if (!Array.isArray(parsed?.tips)) return null;
    return parsed.tips
      .filter((tip) => tip && typeof tip.text === "string" && tip.text.trim())
      .slice(0, 4)
      .map((tip) => ({ text: tip.text.trim(), photoSpot: Boolean(tip.photoSpot) }));
  } catch {
    return null;
  }
}

async function renderTips() {
  const tipsContainer = $("#routeTips");
  const conditions = currentConditions();
  const proxyUrl = geminiProxyUrl();
  if (proxyUrl && state.route.length) {
    tipsContainer.innerHTML = "<li>AI 컨시어지가 팁을 작성 중입니다...</li>";
    const routeNames = state.route.map((place) => place.name).join(", ");
    const transportLabel = state.transport === "public" ? "대중교통" : state.transport === "walk" ? "도보" : "자동차";
    const prompt = `다음은 사용자의 광주/전남 여행 코스입니다: ${routeNames}.
이 코스를 더 잘 즐길 수 있는 팁을 3~4가지 작성해주세요.
그중 하나는 이 코스에서 사진이 가장 잘 나올 만한 장소와 구도를 추천하는 "포토 스팟" 팁으로 만들고 photoSpot을 true로 표시하세요.
여행 조건: 출발지 ${conditions.origin.name}, 교통수단: ${transportLabel}.
다른 설명 없이 아래 JSON 형식으로만 답하세요: {"tips":[{"text":"...","photoSpot":false}]}`;
    const aiTips = await requestAiTips(prompt);
    if (aiTips?.length) {
      tipsContainer.innerHTML = aiTips
        .map((tip) => `<li${tip.photoSpot ? ' class="photo-spot-tip"' : ""}>${
          tip.photoSpot ? "<strong>📸 추천 포토 스팟:</strong> " : ""
        }${escapeHtml(tip.text)}</li>`)
        .join("");
      return;
    }
  }
  const tips = buildStaticTips(conditions);
  tipsContainer.innerHTML = tips.map((tip) => `<li>${escapeHtml(tip)}</li>`).join("");
}

function buildStaticTips(conditions) {
  const mealStops = state.route.filter((place) => place.mealSlot);
  const preferredAxes = topAxes(2);
  const tips = [
    `${conditions.origin.name}에서 첫 장소까지 ${state.transport === "public" ? "대중교통 환승 시간을 포함해" : "실제 교통 상황을 확인하며"} 출발하세요.`,
    conditions.weather === "rainy"
      ? state.promptAnalysis.relaxed && conditions.promptRainy
        ? "비 대응 장소를 우선했고, 함께 요청한 조건을 만족시키기 위해 일부 후보는 유연하게 포함했습니다. 우산과 운영 여부를 확인하세요."
        : "비 오는 날 이용 가능한 장소만 포함했습니다. 실외 이동 구간에는 우산을 준비하세요."
      : "실외 장소가 포함되어 있으니 출발 전 운영시간과 기상 상황을 한 번 더 확인하세요.",
    preferredAxes.length
      ? `추천은 ${preferredAxes.map((axis) => axis.label).join("·")} 선호를 가장 크게 반영했습니다. 장소 카드를 누르면 추천 근거를 볼 수 있습니다.`
      : "취향을 따로 선택하지 않아 이동수단·날씨·동행·체류시간 등 여행 조건을 중심으로 추천했습니다.",
  ];
  if (conditions.baseballAttendance) {
    const gameStops = state.routeDays.flatMap((day, dayIndex) =>
      day.filter((place) => place.isBaseballGame).map((place) => ({ place, dayIndex })),
    );
    const stadiumFoods = state.route.filter((place) => place.stadiumFood);
    if (gameStops.length) {
      const gameSummary = gameStops
        .map(({ place, dayIndex }) => `Day ${dayIndex + 1} ${place.gameDate} ${formatClockMinutes(place.fixedStartMinutes)}~${formatClockMinutes(place.expectedEndMinutes)}`)
        .join(" · ");
      tips.unshift(`${gameSummary} 챔피언스필드 경기를 각 날짜의 마지막 일정으로 고정했습니다.`);
    }
    if (stadiumFoods.length) {
      tips.unshift(`직관일마다 경기 전에 구장 먹거리를 구매해 관람석에서 먹도록 구성했습니다. 경기 당일 영업·재고·가격을 다시 확인하세요.`);
    }
    const playerRestaurants = mealStops.filter((place) => place.playerRecommended);
    tips.unshift(playerRestaurants.length
      ? `야구 직관을 반영해 ${playerRestaurants.map((place) => place.name).join(" · ")}의 추천 우선순위를 크게 높였습니다.`
      : "야구 직관을 선택했지만 현재 시간·동선 안에 배치 가능한 선수 추천 맛집을 찾지 못했습니다.");
  }
  if (state.mealWarnings.length) {
    tips.push(`${state.mealWarnings.join(" ")} 현재 필터에서 이용 가능한 음식점 데이터가 더 필요합니다.`);
  }
  if (state.scheduleWarnings.length) {
    tips.unshift(...state.scheduleWarnings);
  }
  if (conditions.weatherMode === "auto" && state.weatherForecast?.status !== "ready") {
    tips.push("기상청 예보를 적용하지 못해 날씨 조건은 제외했습니다. 입력 화면의 상태 안내를 확인하세요.");
  }
  const forecastTemperatures = state.weatherForecast?.status === "ready"
    ? state.weatherForecast.days.flatMap((day) => [
        ...day.slots.map((slot) => slot.temperature),
        day.minTemperature,
        day.maxTemperature,
      ]).filter(Number.isFinite)
    : [];
  if (forecastTemperatures.some((temperature) => temperature >= 30)) {
    tips.push("식사 시간 기온이 30℃ 이상으로 예상됩니다. 실내 휴식과 수분 보충 시간을 확보하세요.");
  }
  if (forecastTemperatures.some((temperature) => temperature <= 5)) {
    tips.push("식사 시간 기온이 5℃ 이하로 예상됩니다. 따뜻한 메뉴와 실내 장소를 우선 확인하세요.");
  }
  if (state.travelPrompt) {
    const interpreted = state.promptAnalysis.labels.slice(0, 3).join(" · ") || "자유 문장";
    tips.unshift(`한 줄 요청에서 ${interpreted} 조건을 읽어 장소와 동선을 다시 계산했습니다.`);
  }
  if (state.promptAnalysis.relaxed) {
    tips.push("서로 충돌하거나 후보가 적은 요청은 가능한 장소를 확보하기 위해 일부를 우선 조건으로 유연하게 적용했습니다.");
  }
  return tips;
}

function renderPromptResultSummary() {
  const summary = $("#promptResultSummary");
  if (!state.travelPrompt) {
    summary.hidden = true;
    $("#promptResultChips").innerHTML = "";
    return;
  }
  const namedLabels = state.places
    .filter((place) => state.promptAnalysis.namedPlaceIds.includes(place.id))
    .map((place) => `${place.name} 지정`);
  const labels = [
    ...namedLabels,
    ...(state.promptAnalysis.labels.length
      ? state.promptAnalysis.labels
      : ["자유 문장 반영"]),
    ...(state.promptAnalysis.relaxed ? ["일부 조건 유연 적용"] : []),
  ];
  $("#promptResultChips").innerHTML = [...new Set(labels)]
    .slice(0, 8)
    .map((label) => `<span>${escapeHtml(label)}</span>`)
    .join("");
  summary.hidden = false;
}

function renderResult() {
  const axes = topAxes(2);
  const conditions = currentConditions();
  const title = axes.length >= 2
    ? `${josa(axes[0].label, "와/과")} ${josa(axes[1].label, "을/를")} 잇는 ${durationLabel()} 여행`
    : axes.length === 1
      ? `${axes[0].label} 취향을 담은 ${durationLabel()} 여행`
      : `여행 조건에 맞춘 ${durationLabel()} 여행`;
  const travelWindowCopy = `${conditions.origin.name} · 출발일 ${conditions.travelDate} ${conditions.startTime} → 귀가일 ${conditions.endDate} ${conditions.endTime}`;
  $("#resultTitle").textContent = title;
  $("#resultDescription").textContent = conditions.baseballAttendance
    ? `${travelWindowCopy}.`
    : state.travelPrompt
      ? `${travelWindowCopy}, 슬라이더 취향과 한 줄 요청 및 출발지 복귀시간을 함께 반영한 동선입니다.`
      : axes.length
        ? `${travelWindowCopy}, 취향과 출발지 복귀시간을 반영한 동선입니다.`
        : `${travelWindowCopy}, 이동수단·날씨·동행과 출발지 복귀시간을 반영한 동선입니다.`;
  renderPromptResultSummary();
  updateMapMeta();
  renderMap();
  renderItinerary();
  renderAlternatives();
  renderTips();
  refreshTripPreviewVideo();
  renderStamps();
  renderReviewReward();
  updateSaveButton();
}

function showView(viewName, { pushState = true } = {}) {
  const wantsResult = viewName === "result" && state.route.length > 0;
  $("#formView").classList.toggle("active", !wantsResult);
  $("#resultView").classList.toggle("active", wantsResult);
  const docentWrapper = $("#aiDocentWrapper");
  if (docentWrapper) docentWrapper.hidden = !wantsResult;
  $$(".mobile-nav button").forEach((button) => {
    button.classList.toggle(
      "active",
      button.dataset.nav === (wantsResult ? "result" : "form"),
    );
  });
  if (pushState) {
    history.pushState({ view: wantsResult ? "result" : "form" }, "", wantsResult ? "#route" : "#plan");
  }
  if (wantsResult) {
    window.setTimeout(renderKakaoMap, 80);
    if (!state.stampLocation && state.stampLocationMode === "GPS") {
      window.setTimeout(requestStampGeolocation, 160);
    }
  } else {
    stopPreview();
  }
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function setLoading(active) {
  $("#loadingView").classList.toggle("active", active);
  $("#loadingView").setAttribute("aria-hidden", String(!active));
  document.body.classList.toggle("loading", active);
}

async function generateRoute() {
  if (state.loading) return;
  if (!syncTravelWindow({ reportValidity: true })) return;
  updatePromptAnalysis();
  state.loading = true;
  setLoading(true);
  const activeLoadingPhrases = state.travelPrompt
      ? [
        `${state.promptAnalysis.labels.slice(0, 2).join(" · ") || "한 줄 여행"} 요청을 이해했어요.`,
        "선택한 출발지의 12시·18시 기상청 예보를 확인하고 있습니다.",
        "문장의 취향 키워드를 8가지 여행 취향 점수에 더하고 있습니다.",
        state.promptAnalysis.minimizeTravel
          ? "이동 부담을 줄이도록 가까운 장소 사이의 동선을 계산하고 있습니다."
          : "요청과 잘 맞는 장소를 이동 흐름에 맞춰 연결하고 있습니다.",
        "각 장소에 요청이 반영된 이유를 정리하고 있습니다.",
      ]
    : LOADING_PHRASES;
  let phraseIndex = 0;
  $("#loadingPhrase").textContent = activeLoadingPhrases[0];
  const phraseTimer = window.setInterval(() => {
    phraseIndex = (phraseIndex + 1) % activeLoadingPhrases.length;
    $("#loadingPhrase").textContent = activeLoadingPhrases[phraseIndex];
  }, 650);

  try {
    const startedAt = performance.now();
    await refreshWeatherForecast();
    state.results = rankPlacesLocal();
    createRoute(state.results);
    renderResult();
    await wait(Math.max(1050 - (performance.now() - startedAt), 250));
    showView("result");
  } finally {
    window.clearInterval(phraseTimer);
    setLoading(false);
    state.loading = false;
  }
}

function loadSavedRoutes() {
  try {
    state.savedRoutes = JSON.parse(localStorage.getItem("omaeroute_saved_routes") || "[]");
  } catch {
    state.savedRoutes = [];
  }
  renderSavedRoutes();
}

function localDateValue(date = new Date()) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

function setupTravelWindow() {
  const startDateInput = $("#travelDate");
  const endDateInput = $("#endDate");
  const today = localDateValue();
  startDateInput.min = today;
  if (!startDateInput.value) startDateInput.value = today;
  if (!endDateInput.value) endDateInput.value = startDateInput.value;
  syncTravelWindow();
}

function routeSignature(route = state.route) {
  const baseballKey = state.baseballAttendance
    ? `baseball-days-${selectedBaseballDayIndexes().join("-")}`
    : "baseball-off";
  return `${route.map((place) => `${place.id}:${place.mealSlot || "visit"}`).join("-")}@${$("#travelDate").value}:${$("#startTime").value}-${$("#endDate").value}:${$("#endTime").value}:${baseballKey}`;
}

function preferenceByKey(preference = state.preference) {
  return Object.fromEntries(AXES.map((axis, index) => [axis.key, Number(preference[index]) || 0]));
}

function normalizeSavedPreference(saved) {
  if (saved?.preferenceByKey && typeof saved.preferenceByKey === "object") {
    return AXES.map((axis) => Number(saved.preferenceByKey[axis.key]) || 0);
  }
  if (Array.isArray(saved?.preference) && Array.isArray(saved.preferenceOrder)) {
    const keyedPreference = Object.fromEntries(
      saved.preferenceOrder.map((axisKey, index) => [axisKey, saved.preference[index]]),
    );
    return AXES.map((axis) => Number(keyedPreference[axis.key]) || 0);
  }
  if (Array.isArray(saved?.preference)) {
    return AXES.map((_, index) => Number(saved.preference[index]) || 0);
  }
  return Array(AXES.length).fill(0);
}

function saveCurrentRoute() {
  if (!state.route.length) return;
  const signature = routeSignature();
  const existing = state.savedRoutes.find((item) => item.signature === signature);
  if (existing) {
    state.savedRoutes = state.savedRoutes.filter((item) => item.signature !== signature);
  } else {
    state.savedRoutes.unshift({
      id: Date.now(),
      signature,
      title: $("#resultTitle").textContent,
      routeIds: state.route.map((place) => place.id),
      routeDays: state.routeDays.map((day) => day.map((place) => ({
        id: place.id,
        mealSlot: place.mealSlot || null,
        mealLabel: place.mealLabel || null,
        mealTargetMinutes: place.mealTargetMinutes ?? null,
        fixedStartMinutes: place.fixedStartMinutes ?? null,
        expectedEndMinutes: place.expectedEndMinutes ?? null,
        isBaseballGame: Boolean(place.isBaseballGame),
        stadiumFood: Boolean(place.stadiumFood),
        endsTrip: Boolean(place.endsTrip),
        gameDate: place.gameDate || null,
        gameDayType: place.gameDayType || null,
        sourceGameId: place.sourceGameId || null,
        opponent: place.opponent || null,
        gameStatus: place.gameStatus || null,
        gameTimeChangeReason: place.gameTimeChangeReason || null,
      }))),
      originKey: currentConditions().originKey,
      travelDate: $("#travelDate").value,
      startTime: $("#startTime").value,
      endDate: $("#endDate").value,
      endTime: $("#endTime").value,
      duration: state.duration,
      transport: state.transport,
      walkTimeLimitMinutes: state.walkTimeLimitMinutes,
      preference: [...state.preference],
      preferenceOrder: AXES.map((axis) => axis.key),
      preferenceByKey: preferenceByKey(),
      prompt: state.travelPrompt,
      companion: $("#companion").value,
      weather: $("#weather").value,
      baseballAttendance: state.baseballAttendance,
      baseballDayIndexes: [...state.baseballDayIndexes],
      baseballDayIndex: state.baseballDayIndexes[0] ?? null,
      weatherForecast: state.weatherForecast?.status === "ready" ? state.weatherForecast : null,
      createdAt: new Date().toISOString(),
    });
  }
  localStorage.setItem("omaeroute_saved_routes", JSON.stringify(state.savedRoutes));
  renderSavedRoutes();
  updateSaveButton();
}

function updateSaveButton() {
  const saved = state.savedRoutes.some((item) => item.signature === routeSignature());
  $("#saveButton").classList.toggle("saved", saved);
  $("#saveButton").textContent = saved ? "♥ 저장됨" : "♡ 루트 저장";
}

function renderSavedRoutes() {
  const markup = state.savedRoutes.length
    ? state.savedRoutes.slice(0, 8).map((item) => {
        const routeCount = Array.isArray(item.routeIds)
          ? item.routeIds.length
          : Array.isArray(item.routeDays)
            ? item.routeDays.flat().length
            : 0;
        const originName = ORIGINS[item.originKey]?.name || "광주 여행";
        const savedDate = item.travelDate
          ? new Date(`${item.travelDate}T00:00:00`).toLocaleDateString("ko-KR", {
              year: "numeric",
              month: "short",
              day: "numeric",
            })
          : new Date(item.createdAt).toLocaleDateString("ko-KR");
        const travelTime = item.startTime
          ? `${item.startTime}${item.endTime ? `–${item.endTime}` : ""}`
          : "시간 정보 없음";
        return `
          <button type="button" class="saved-route-item" data-saved-id="${item.id}" aria-label="${escapeHtml(item.title)} 다시 보기">
            <span class="saved-route-item-top">
              <strong>${escapeHtml(item.title)}</strong>
              <i aria-hidden="true">→</i>
            </span>
            <span class="saved-route-meta">${savedDate} · ${travelTime}</span>
            <span class="saved-route-foot"><em>${escapeHtml(originName)} 출발</em><b>${routeCount}곳</b></span>
          </button>
        `;
      }).join("")
    : '<div class="empty-copy saved-empty"><span aria-hidden="true">♡</span><strong>아직 저장된 루트가 없어요</strong><p>추천 일정을 만든 뒤 ‘루트 저장’을 눌러보세요.</p></div>';
  $("#savedCount").textContent = state.savedRoutes.length;
  $("#savedRoutes").innerHTML = markup;
  $("#drawerSavedRoutes").innerHTML = markup;
  $("#drawerSavedCount").textContent = `${state.savedRoutes.length}개`;
  const navCount = $("#savedNavCount");
  navCount.textContent = state.savedRoutes.length > 99 ? "99+" : String(state.savedRoutes.length);
  navCount.hidden = state.savedRoutes.length === 0;
}

function restoreSavedRoute(id) {
  const saved = state.savedRoutes.find((item) => item.id === id);
  if (!saved || (!state.places.length && !state.stadiumFoods.length)) return;
  $("#origin").value = saved.originKey;
  const restoredTravelDate = saved.travelDate || localDateValue();
  const restoredStartTime = saved.startTime || "10:00";
  const legacyEnd = legacyEndDateTime(restoredTravelDate, restoredStartTime, saved.duration);
  $("#travelDate").value = restoredTravelDate;
  setTimeFieldValue($("#startTime"), restoredStartTime);
  $("#endDate").value = saved.endDate || legacyEnd.endDate;
  setTimeFieldValue($("#endTime"), saved.endTime || legacyEnd.endTime);
  syncTravelWindow();
  state.transport = saved.transport;
  state.walkTimeLimitMinutes = clamp(Number(saved.walkTimeLimitMinutes) || WALK_TIME_LIMIT_DEFAULT, WALK_TIME_LIMIT_MIN, WALK_TIME_LIMIT_MAX);
  setWalkTimeLimitFieldValue(state.walkTimeLimitMinutes);
  state.preference = normalizeSavedPreference(saved);
  state.baseballAttendance = Boolean(saved.baseballAttendance);
  const savedBaseballDayIndexes = Array.isArray(saved.baseballDayIndexes)
    ? saved.baseballDayIndexes.map(Number).filter(Number.isInteger)
    : [];
  const savedBaseballDayIndex = Number(saved.baseballDayIndex);
  const legacyBaseballDayIndexes = Array.isArray(saved.routeDays)
    ? saved.routeDays
      .map((day, index) => day.some((stop) => stop.isBaseballGame) ? index : -1)
      .filter((index) => index >= 0)
    : [];
  state.baseballDayIndexes = savedBaseballDayIndexes.length
    ? savedBaseballDayIndexes
    : Number.isInteger(savedBaseballDayIndex)
      ? [savedBaseballDayIndex]
      : legacyBaseballDayIndexes;
  state.baseballDaySelectionTouched = state.baseballAttendance && state.baseballDayIndexes.length > 0;
  state.baseballPreviousEnd = null;
  state.baseballAdjustedFinalEnd = false;
  $("#baseballAttendance").checked = state.baseballAttendance;
  $("#travelPrompt").value = saved.prompt || "";
  if (saved.companion) $("#companion").value = saved.companion;
  if (saved.weather) $("#weather").value = saved.weather;
  state.weatherForecast = saved.weatherForecast || null;
  $$('.choice-group[data-group="transport"] button').forEach((button) => {
    button.classList.toggle("active", button.dataset.value === state.transport);
  });
  $("#walkTimeLimitField").hidden = state.transport !== "walk";
  $$('.choice-group[data-group="companion"] button').forEach((button) => {
    button.classList.toggle("active", button.dataset.value === $("#companion").value);
  });
  renderSliders();
  updateBaseballAttendanceControl();
  updatePromptAnalysis();
  state.dayWindows = travelDayWindows(currentConditions());
  state.results = rankPlacesLocal();
  const restoreStop = (savedStop) => {
    const basePlace = savedStop.isBaseballGame
      ? CHAMPIONS_FIELD_GAME
      : state.results.find((candidate) => candidate.id === savedStop.id)
        || state.places.find((candidate) => candidate.id === savedStop.id)
        || state.stadiumFoods.find((candidate) => candidate.id === savedStop.id);
    if (!basePlace) return null;
    const place = {
      ...basePlace,
      fixedStartMinutes: savedStop.fixedStartMinutes ?? basePlace.fixedStartMinutes,
      expectedEndMinutes: savedStop.expectedEndMinutes ?? basePlace.expectedEndMinutes,
      isBaseballGame: Boolean(savedStop.isBaseballGame || basePlace.isBaseballGame),
      stadiumFood: Boolean(savedStop.stadiumFood || basePlace.stadiumFood),
      endsTrip: Boolean(savedStop.endsTrip || basePlace.endsTrip),
      gameDate: savedStop.gameDate || basePlace.gameDate,
      gameDayType: savedStop.gameDayType || basePlace.gameDayType,
      sourceGameId: savedStop.sourceGameId || basePlace.sourceGameId,
      opponent: savedStop.opponent || basePlace.opponent,
      gameStatus: savedStop.gameStatus || basePlace.gameStatus,
      gameTimeChangeReason: savedStop.gameTimeChangeReason || basePlace.gameTimeChangeReason,
    };
    if (!savedStop.mealSlot) return place;
    if (savedStop.mealSlot === "stadium_food") {
      return {
        ...place,
        mealSlot: "stadium_food",
        mealLabel: savedStop.mealLabel || "저녁 · 야구장 먹거리",
        mealTargetMinutes: savedStop.mealTargetMinutes,
        fixedStartMinutes: savedStop.fixedStartMinutes,
        purchaseStartMinutes: savedStop.fixedStartMinutes,
        eatDuringGame: true,
        reasons: ["저녁 식사", "구장 내부에서 구매", "직관하며 먹기"],
      };
    }
    const slot = MEAL_SLOTS.find((candidate) => candidate.key === savedStop.mealSlot);
    return slot ? annotateMealPlace(place, { ...slot, targetMinutes: savedStop.mealTargetMinutes ?? slot.targetMinutes }) : place;
  };
  if (Array.isArray(saved.routeDays) && saved.routeDays.length) {
    state.routeDays = saved.routeDays.map((day) => day.map(restoreStop).filter(Boolean));
    state.route = state.routeDays.flat();
  } else {
    state.route = saved.routeIds.map((placeId) =>
      state.results.find((place) => place.id === placeId)
      || state.stadiumFoods.find((place) => place.id === placeId)
      || (placeId === CHAMPIONS_FIELD_GAME.id ? CHAMPIONS_FIELD_GAME : null),
    ).filter(Boolean);
    const dayCount = Math.max(1, state.dayWindows.length);
    const chunkSize = Math.ceil(state.route.length / dayCount);
    state.routeDays = Array.from({ length: dayCount }, (_, index) =>
      state.route.slice(index * chunkSize, (index + 1) * chunkSize),
    ).filter((day) => day.length);
    state.dayWindows = state.dayWindows.slice(0, state.routeDays.length);
  }
  state.mealWarnings = [];
  state.scheduleWarnings = [];
  state.selectedDay = 0;
  renderResult();
  closeDrawer();
  showView("result");
}

function openDrawer() {
  renderSavedRoutes();
  const drawer = $("#savedDrawer");
  const activeNav = $(".mobile-nav button.active");
  drawer.dataset.previousNav = activeNav?.dataset.nav || (state.route.length && $("#resultView").classList.contains("active") ? "result" : "form");
  $("#savedDrawer").classList.add("open");
  $("#savedDrawer").setAttribute("aria-hidden", "false");
  document.body.classList.add("drawer-open");
  $$(".mobile-nav button").forEach((button) => {
    button.classList.toggle("active", button.dataset.nav === "profile");
  });
  window.setTimeout(() => $("#closeDrawerButton").focus({ preventScroll: true }), 40);
}

function closeDrawer() {
  const drawer = $("#savedDrawer");
  const previousNav = drawer.dataset.previousNav || (state.route.length && $("#resultView").classList.contains("active") ? "result" : "form");
  drawer.classList.remove("open");
  drawer.setAttribute("aria-hidden", "true");
  document.body.classList.remove("drawer-open");
  $$(".mobile-nav button").forEach((button) => {
    button.classList.toggle("active", button.dataset.nav === previousNav);
  });
}

function bindEvents() {
  $("#startButton").addEventListener("click", () => {
    const splashView = $("#splashView");
    splashView.classList.add("dismissed");
    splashView.setAttribute("aria-hidden", "true");
    document.body.classList.remove("splash-open");
    window.setTimeout(() => $("#origin").focus({ preventScroll: true }), 380);
  });

  $$(".choice-group").forEach((group) => {
    group.addEventListener("click", (event) => {
      const button = event.target.closest("button[data-value]");
      if (!button) return;
      $$("button", group).forEach((item) => item.classList.remove("active"));
      button.classList.add("active");
      if (group.dataset.group === "transport") {
        state.transport = button.dataset.value;
        $("#walkTimeLimitField").hidden = state.transport !== "walk";
      }
      if (group.dataset.group === "companion") $("#companion").value = button.dataset.value;
    });
  });

  $("#origin").addEventListener("change", () => invalidateWeatherForecast({ reload: false }));
  bindTimeSegments($("#startTime"), 1);
  bindTimeSegments($("#endTime"), 1);
  bindTimeSegments($("#replanTimeInput"), 1);
  bindWalkTimeLimitStepper();
  [$("#travelDate"), $("#startTime"), $("#endDate"), $("#endTime")].forEach((input) => {
    input.addEventListener("change", () => {
      if (input === $("#travelDate") && (!$("#endDate").value || $("#endDate").value < input.value)) {
        $("#endDate").value = input.value;
      }
      if (state.baseballAttendance && state.baseballPreviousEnd) {
        if (input === $("#travelDate")) state.baseballPreviousEnd.endDate = $("#endDate").value;
        if (input === $("#endDate")) state.baseballPreviousEnd.endDate = input.value;
        if (input === $("#endTime")) state.baseballPreviousEnd.endTime = input.value;
      }
      syncTravelWindow();
      if (state.baseballAttendance) {
        updateBaseballAttendanceControl({ adjustTravelWindow: true });
      } else {
        updateBaseballAttendanceControl();
      }
      invalidateWeatherForecast({ reload: false });
    });
  });
  $("#baseballAttendance").addEventListener("change", (event) => {
    setBaseballAttendance(event.currentTarget.checked);
    invalidateWeatherForecast({ reload: false });
  });
  $("#baseballDayOptions").addEventListener("change", () => {
    const selectedIndexes = $$('#baseballDayOptions input[type="checkbox"]:checked')
      .map((input) => Number(input.value))
      .filter(Number.isInteger);
    state.baseballDayIndexes = selectedIndexes;
    state.baseballDaySelectionTouched = true;
    updateBaseballAttendanceControl({ adjustTravelWindow: state.baseballAttendance });
  });
  $("#weather").addEventListener("change", () => {
    if ($("#weather").value === "auto") invalidateWeatherForecast({ reload: false });
    else void refreshWeatherForecast();
  });

  $("#travelPrompt").addEventListener("input", updatePromptAnalysis);
  $("#travelPrompt").addEventListener("keydown", (event) => {
    if ((event.ctrlKey || event.metaKey) && event.key === "Enter") {
      event.preventDefault();
      $("#travelForm").requestSubmit();
    }
  });
  $$(".prompt-examples button").forEach((button) => {
    button.addEventListener("click", () => {
      $("#travelPrompt").value = button.dataset.promptExample;
      updatePromptAnalysis();
      $("#travelPrompt").focus();
    });
  });

  $("#travelForm").addEventListener("submit", async (event) => {
    event.preventDefault();
    await generateRoute();
  });
  $("#backButton").addEventListener("click", () => showView("form"));
  $("#bottomBackButton").addEventListener("click", () => showView("form"));
  $("#brandButton").addEventListener("click", () => showView("form"));
  $("#saveButton").addEventListener("click", saveCurrentRoute);
  $("#printButton").addEventListener("click", () => window.print());
  $("#previewPlayButton").addEventListener("click", togglePreview);
  $("#tripPreviewVideo").addEventListener("timeupdate", (event) => {
    const video = event.target;
    if (!video.duration) return;
    $("#previewProgress").style.width = `${Math.min(100, (video.currentTime / video.duration) * 100)}%`;
  });
  $("#tripPreviewVideo").addEventListener("pause", () => {
    state.previewPlaying = false;
    renderPreview();
  });
  $("#tripPreviewVideo").addEventListener("play", () => {
    state.previewPlaying = true;
    renderPreview();
  });
  $("#previewProgressTrack").addEventListener("click", (event) => {
    const video = $("#tripPreviewVideo");
    if (!video || !Number.isFinite(video.duration) || video.duration <= 0) return;
    const rect = event.currentTarget.getBoundingClientRect();
    const fraction = Math.min(1, Math.max(0, (event.clientX - rect.left) / rect.width));
    video.pause();
    video.currentTime = fraction * video.duration;
    $("#previewProgress").style.width = `${fraction * 100}%`;
  });
  $("#stampLocationSelect").addEventListener("change", (event) => {
    selectStampLocation(event.target.value);
  });
  $("#stampGpsButton").addEventListener("click", requestStampGeolocation);
  $("#stampResetButton").addEventListener("click", resetStamps);
  $("#stampGrid").addEventListener("click", (event) => {
    const button = event.target.closest("button[data-stamp-id]");
    if (button) collectStamp(button.dataset.stampId);
  });
  $("#reviewText").addEventListener("input", updateReviewCharacterCount);
  $("#reviewSubmitButton").addEventListener("click", submitRouteReview);
  $("#rewardCopyButton").addEventListener("click", copyRewardCode);

  $("#dayTabs").addEventListener("click", (event) => {
    const button = event.target.closest("button[data-day]");
    if (!button) return;
    state.selectedDay = Number(button.dataset.day);
    renderItinerary();
    updateMapMeta();
    renderMap();
    renderKakaoMap();
  });
  $("#itineraryTimeline").addEventListener("click", (event) => {
    const card = event.target.closest(".stop-card");
    if (card) card.classList.toggle("expanded");
  });
  $("#itineraryTimeline").addEventListener("keydown", (event) => {
    if ((event.key === "Enter" || event.key === " ") && event.target.matches(".stop-card")) {
      event.preventDefault();
      event.target.classList.toggle("expanded");
    }
  });
  $("#replanButton").addEventListener("click", () => {
    const stopIndex = Number($("#replanStopSelect").value);
    const timeValue = $("#replanTimeInput").value;
    const statusEl = $("#replanStatus");
    if (!Number.isInteger(stopIndex) || !timeValue) {
      statusEl.textContent = "장소와 새 출발 시각을 모두 선택해주세요.";
      statusEl.classList.add("warning");
      statusEl.hidden = false;
      return;
    }
    const replanResult = replanDayFromStop(state.selectedDay, stopIndex, parseClockMinutes(timeValue));
    if (!replanResult?.ok) {
      statusEl.textContent = replanResult?.message || "일정을 다시 계산하지 못했습니다.";
      statusEl.classList.add("warning");
      statusEl.hidden = false;
      return;
    }
    renderResult();
    const refreshedStatus = $("#replanStatus");
    refreshedStatus.textContent = "남은 일정을 다시 계산했습니다.";
    refreshedStatus.classList.remove("warning");
    refreshedStatus.hidden = false;
  });

  $("#menuButton").addEventListener("click", openDrawer);
  $("#profileButton").addEventListener("click", openDrawer);
  $("#toolbarSavedRoutesButton").addEventListener("click", openDrawer);
  $("#closeDrawerButton").addEventListener("click", closeDrawer);
  $(".drawer-backdrop").addEventListener("click", closeDrawer);
  $("#newRouteButton").addEventListener("click", () => {
    closeDrawer();
    showView("form");
  });
  [$("#savedRoutes"), $("#drawerSavedRoutes")].forEach((container) => {
    container.addEventListener("click", (event) => {
      const item = event.target.closest("[data-saved-id]");
      if (item) restoreSavedRoute(Number(item.dataset.savedId));
    });
  });

  $$(".mobile-nav button").forEach((button) => {
    button.addEventListener("click", () => {
      if (button.dataset.nav === "form") showView("form");
      if (button.dataset.nav === "result") showView("result");
      if (button.dataset.nav === "stamp") {
        if (state.route.length) {
          showView("result");
          window.setTimeout(() => {
            $("#stampSection").scrollIntoView({ behavior: "smooth" });
            $$(".mobile-nav button").forEach((item) => {
              item.classList.toggle("active", item.dataset.nav === "stamp");
            });
          }, 100);
        } else {
          showView("form");
        }
      }
      if (button.dataset.nav === "profile") openDrawer();
    });
  });

  window.addEventListener("popstate", (event) => {
    showView(event.state?.view === "result" ? "result" : "form", { pushState: false });
  });
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && $("#savedDrawer").classList.contains("open")) closeDrawer();
  });
  document.addEventListener("visibilitychange", () => {
    if (document.hidden && state.previewPlaying) stopPreview();
  });

  // AI 도슨트 버튼 및 패널 로직
  const docentBtn = $("#aiDocentButton");
  const docentPanel = $("#aiDocentPanel");
  const docentClose = $("#aiDocentCloseButton");
  const docentRefresh = $("#aiDocentRefreshButton");
  const docentChat = $("#aiDocentChat");
  const docentInput = $("#aiDocentInput");
  const docentSend = $("#aiDocentSendButton");

  function addDocentMessage(text, isUser = false) {
    const msg = document.createElement("div");
    msg.className = isUser ? "ai-msg user-msg" : "ai-msg docent-msg";
    msg.textContent = text;
    docentChat.appendChild(msg);
    docentChat.scrollTop = docentChat.scrollHeight;
  }

  function findNearestPlace() {
    if (!state.route || state.route.length === 0) return null;
    let currentLoc = state.stampLocation;
    if (!currentLoc && state.kakaoMap) {
      const center = state.kakaoMap.getCenter();
      currentLoc = { latitude: center.getLat(), longitude: center.getLng() };
    }
    if (!currentLoc && currentConditions().origin) {
      currentLoc = currentConditions().origin;
    }

    if (!currentLoc) return state.route[0];

    let nearest = state.route[0];
    let minDist = haversineKm(currentLoc, nearest);
    
    for (let i = 1; i < state.route.length; i++) {
      const dist = haversineKm(currentLoc, state.route[i]);
      if (dist < minDist) {
        minDist = dist;
        nearest = state.route[i];
      }
    }
    return nearest;
  }

  if (docentBtn && docentPanel) {
    let docentChatHistory = [];

    function initDocentChat() {
      docentChat.innerHTML = "";
      const nearest = findNearestPlace();
      let initialMessage = "";
      if (nearest) {
        initialMessage = `지금 계신 곳과 가장 가까운 여행지는 [${nearest.name}]입니다!\n\n${nearest.description}\n\n이곳에 대해 더 궁금한 점이 있으신가요?`;
        docentChatHistory = [
          { role: "user", parts: [{ text: `[System: 당신은 '오매루트'의 AI 도슨트입니다. 친절하고 유익한 여행 가이드 역할을 수행하세요.]\n\n현재 사용자는 ${nearest.name} 근처에 있습니다. 장소 설명: ${nearest.description}` }] },
          { role: "model", parts: [{ text: initialMessage }] }
        ];
      } else {
        initialMessage = `안녕하세요! 오매루트 AI 도슨트입니다. 어떤 장소가 궁금하신가요?`;
        docentChatHistory = [
          { role: "user", parts: [{ text: `[System: 당신은 '오매루트'의 AI 도슨트입니다. 친절하고 유익한 여행 가이드 역할을 수행하세요.]\n\n안녕하세요.` }] },
          { role: "model", parts: [{ text: initialMessage }] }
        ];
      }
      addDocentMessage(initialMessage);
    }

    docentBtn.addEventListener("click", () => {
      docentPanel.hidden = false;
      docentBtn.hidden = true;
      if (docentChat.children.length === 0) {
        initDocentChat();
      }
    });

    if (docentRefresh) {
      docentRefresh.addEventListener("click", () => {
        initDocentChat();
      });
    }
    docentClose.addEventListener("click", () => {
      docentPanel.hidden = true;
      docentBtn.hidden = false;
    });
    docentSend.addEventListener("click", async () => {
      const text = docentInput.value.trim();
      if (!text) return;
      addDocentMessage(text, true);
      docentInput.value = "";

      if (!geminiProxyUrl()) {
        addDocentMessage("AI 도슨트가 설정되지 않았습니다. 서버의 GEMINI_API_KEY를 확인해주세요.");
        return;
      }

      const typingMsg = document.createElement("div");
      typingMsg.className = "ai-msg docent-msg typing";
      typingMsg.textContent = "AI가 답변을 작성 중입니다...";
      docentChat.appendChild(typingMsg);
      docentChat.scrollTop = docentChat.scrollHeight;

      docentChatHistory.push({ role: "user", parts: [{ text }] });

      try {
        const replyText = await requestGemini(docentChatHistory, { timeoutMs: 20000 })
          || "답변을 생성할 수 없습니다.";

        docentChat.removeChild(typingMsg);
        addDocentMessage(replyText);
        docentChatHistory.push({ role: "model", parts: [{ text: replyText }] });

      } catch (error) {
        console.error("AI Docent Error:", error);
        if (docentChat.contains(typingMsg)) {
          docentChat.removeChild(typingMsg);
        }
        addDocentMessage("오류가 발생했습니다. 잠시 후 다시 시도해주세요. (콘솔 로그를 확인해주세요)");
        docentChatHistory.pop(); // Remove the user message to try again
      }
    });
    docentInput.addEventListener("keydown", (e) => {
      if (e.key === "Enter") docentSend.click();
    });
  }
}

async function loadBaseballGames() {
  try {
    const response = await fetch("./data/baseball_games.json");
    if (!response.ok) throw new Error(`야구 경기 데이터 오류: ${response.status}`);
    return { rows: await response.json(), failed: false, source: "local" };
  } catch (error) {
    console.warn(error);
    return { rows: [], failed: true, source: "failed" };
  }
}

async function loadStampPatterns() {
  try {
    const response = await fetch("./data/local-stamps/stamp-patterns.json", { cache: "no-store" });
    if (!response.ok) throw new Error(`전통 문양 스탬프 데이터 오류: ${response.status}`);
    const payload = await response.json();
    return {
      places: payload?.places && typeof payload.places === "object" ? payload.places : {},
      categories: payload?.categories && typeof payload.categories === "object" ? payload.categories : {},
    };
  } catch (error) {
    console.info("로컬 전통 문양 스탬프를 사용하지 않습니다.", error);
    return { places: {}, categories: {} };
  }
}

async function loadPlaces() {
  const stadiumFoodRequest = fetch("./data/stadium_foods.json")
    .then(async (response) => {
      if (!response.ok) throw new Error(`야구장 먹거리 데이터 오류: ${response.status}`);
      return { foods: await response.json(), failed: false };
    })
    .catch((error) => {
      console.warn(error);
      return { foods: [], failed: true };
    });
  const openingHoursRequest = fetch("./data/place_opening_hours.json")
    .then(async (response) => {
      if (!response.ok) throw new Error(`운영시간 데이터 오류: ${response.status}`);
      return { rows: await response.json(), failed: false };
    })
    .catch((error) => {
      console.warn(error);
      return { rows: [], failed: true };
    });
  const [placeResponse, restaurantResponse, stadiumFoodResult, openingHoursResult, baseballGamesResult, stampPatternResult] = await Promise.all([
    fetch("./data/places.json"),
    fetch("./data/restaurants.json"),
    stadiumFoodRequest,
    openingHoursRequest,
    loadBaseballGames(),
    loadStampPatterns(),
  ]);
  if (!placeResponse.ok) throw new Error(`관광지 데이터 오류: ${placeResponse.status}`);
  if (!restaurantResponse.ok) throw new Error(`음식점 데이터 오류: ${restaurantResponse.status}`);
  const [places, restaurants] = await Promise.all([placeResponse.json(), restaurantResponse.json()]);
  state.places = [...places, ...restaurants];
  state.stadiumFoods = Array.isArray(stadiumFoodResult.foods) ? stadiumFoodResult.foods : [];
  state.stadiumFoodLoadFailed = stadiumFoodResult.failed;
  state.openingHoursByPlace = new Map();
  (Array.isArray(openingHoursResult.rows) ? openingHoursResult.rows : []).forEach((hours) => {
    const placeKey = `${hours.source}:${hours.source_place_id}`;
    const rows = state.openingHoursByPlace.get(placeKey) || [];
    rows.push(hours);
    state.openingHoursByPlace.set(placeKey, rows);
  });
  state.openingHoursLoadFailed = openingHoursResult.failed;
  state.baseballGamesByDate = new Map();
  (Array.isArray(baseballGamesResult.rows) ? baseballGamesResult.rows : []).forEach((game) => {
    const rows = state.baseballGamesByDate.get(game.game_date) || [];
    rows.push(game);
    rows.sort((a, b) => String(a.scheduled_start_at).localeCompare(String(b.scheduled_start_at)));
    state.baseballGamesByDate.set(game.game_date, rows);
  });
  state.baseballGamesLoadFailed = baseballGamesResult.failed;
  state.baseballGamesSource = baseballGamesResult.source;
  state.stampPatternCategories = new Map(Object.entries(stampPatternResult.categories));
  renderSavedRoutes();
  updateBaseballAttendanceControl();
  const playerRestaurantCount = restaurants.filter((place) => place.playerRecommended).length;
  const openingHoursPlaceCount = state.openingHoursByPlace.size;
  const baseballGameCount = [...state.baseballGamesByDate.values()].flat().length;
  $("#dataStatus").textContent = `관광지 ${places.length}곳 · 음식점 ${restaurants.length}곳 · 운영정보 ${openingHoursPlaceCount}곳 · KIA 광주 홈경기 ${baseballGameCount}건 · 구장 먹거리 ${state.stadiumFoods.length}곳 · 선수 추천 ${playerRestaurantCount}곳${state.stadiumFoodLoadFailed ? " · 구장 DB 확인 필요" : ""}${state.openingHoursLoadFailed ? " · 운영시간 DB 확인 필요" : ""}${state.baseballGamesLoadFailed ? " · 경기 DB 확인 필요" : ""}`;
}

async function init() {
  const resultSidebar = $("#resultView .result-sidebar");
  const resultMapPane = $("#resultView .result-map-pane");
  const resultSidebarScroll = $("#resultView .result-sidebar-scroll");
  if (resultSidebar && resultMapPane && resultSidebarScroll && resultMapPane.parentElement !== resultSidebar) {
    resultSidebar.insertBefore(resultMapPane, resultSidebarScroll);
  }
  setupTravelWindow();
  renderSliders();
  renderAxisPreview();
  loadSavedRoutes();
  loadStampIds();
  loadReviewRewards();
  bindEvents();
  renderWeatherFieldStatus();
  try {
    await loadPlaces();
    const demoRoute = new URLSearchParams(window.location.search).get("demo") === "route";
    if (demoRoute) {
      await generateRoute();
    } else {
      void refreshWeatherForecast();
    }
  } catch (error) {
    console.error(error);
    $("#dataStatus").textContent = "장소 데이터 연결 실패";
    $("#recommendButton").disabled = true;
  }
  if (!state.route.length) {
    history.replaceState({ view: "form" }, "", "#plan");
  }
}

init();
