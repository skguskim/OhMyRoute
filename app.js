const AXES = [
  { key: "nature", label: "자연·풍경", emoji: "🌿" },
  { key: "culture", label: "문화·역사", emoji: "🏛" },
  { key: "art", label: "예술·전시", emoji: "🎨" },
  { key: "food", label: "음식·로컬", emoji: "🍚" },
  { key: "activity", label: "체험·활동", emoji: "🥾" },
  { key: "sports", label: "스포츠·야구", emoji: "⚾" },
  { key: "healing", label: "휴식·산책", emoji: "🌳" },
  { key: "festival", label: "축제·야간", emoji: "✨" },
];
const SPORTS_AXIS_INDEX = AXES.findIndex((axis) => axis.key === "sports");
const VERY_PREFERRED_THRESHOLD = 75;
const REVIEW_STORAGE_KEY = "omaeroute_reviews";
const REWARD_STORAGE_KEY = "omaeroute_rewards";

const ORIGINS = {
  gwangju_station: { name: "광주역", latitude: 35.1653, longitude: 126.9096 },
  bus_terminal: {
    name: "광주종합버스터미널",
    latitude: 35.1598,
    longitude: 126.8803,
  },
  champions_field: {
    name: "광주-기아 챔피언스필드",
    latitude: 35.1682,
    longitude: 126.8891,
  },
  songjeong_station: {
    name: "광주송정역",
    latitude: 35.1377,
    longitude: 126.7914,
  },
};

const DAY_START_MINUTES = 10 * 60;
const DEFAULT_DAILY_END_MINUTES = 20 * 60;
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
  reasons: ["스포츠·야구 매우 선호", "야구 직관 선택", "여행 마지막 일정"],
  recommendedPlayers: [],
  activeRecommendedPlayers: [],
  isBaseballGame: true,
  endsTrip: true,
};
const WEATHER_LABELS = { sunny: "맑음", cloudy: "구름많음", rainy: "비·눈" };
const WEATHER_ICONS = { sunny: "☀️", cloudy: "☁️", rainy: "🌧️" };
const KMA_FORECAST_URL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
const KMA_BASE_HOURS = [2, 5, 8, 11, 14, 17, 20, 23];

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
  results: [],
  route: [],
  routeDays: [],
  dayWindows: [],
  selectedDay: 0,
  duration: 240,
  transport: "public",
  preference: [72, 56, 66, 54, 48, 35, 76, 43],
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
  loading: false,
  kakaoMap: null,
  kakaoPolyline: null,
  kakaoMarkers: [],
  kakaoOverlays: [],
  mapResizeBound: false,
  previewIndex: 0,
  previewPlaying: false,
  previewTimer: null,
  stampedIds: [],
  stampLocation: null,
  stampLocationMode: "GPS",
  stampToastTimer: null,
  reviews: [],
  rewards: [],
  baseballAttendance: false,
  baseballPreviousEnd: null,
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

function currentConditions() {
  const selectedCompanion = $("#companion").value;
  const weatherMode = $("#weather").value;
  const automaticWeather = state.weatherForecast?.status === "ready"
    ? state.weatherForecast.condition
    : "sunny";
  const selectedWeather = weatherMode === "auto" ? automaticWeather : weatherMode;
  const sportsBaseballHighlyPreferred = state.preference[SPORTS_AXIS_INDEX] > VERY_PREFERRED_THRESHOLD;
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
    baseballAttendance: sportsBaseballHighlyPreferred && state.baseballAttendance,
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

function dateOrdinal(value) {
  const [year, month, day] = String(value || "").split("-").map(Number);
  if (![year, month, day].every(Number.isFinite)) return Number.NaN;
  return Math.floor(Date.UTC(year, month - 1, day) / 86400000);
}

function baseballScheduleForDate(dateValue) {
  const ordinal = dateOrdinal(dateValue);
  const dayOfWeek = Number.isFinite(ordinal)
    ? new Date(ordinal * 86400000).getUTCDay()
    : 1;
  const weekend = dayOfWeek === 0 || dayOfWeek === 6;
  const gameStartMinutes = weekend ? 18 * 60 : 18 * 60 + 30;
  const gameEndMinutes = gameStartMinutes + BASEBALL_GAME_DURATION_MINUTES;
  return {
    date: dateValue,
    weekend,
    dayTypeLabel: weekend ? "주말" : "평일",
    gameStartMinutes,
    gameEndMinutes,
    stadiumFoodStartMinutes: gameStartMinutes - STADIUM_FOOD_LEAD_MINUTES,
  };
}

function updateBaseballAttendanceControl({ adjustTravelWindow = false } = {}) {
  const panel = $("#baseballAttendancePanel");
  const checkbox = $("#baseballAttendance");
  const status = $("#baseballScheduleStatus");
  if (!panel || !checkbox || !status) return;

  const eligible = state.preference[SPORTS_AXIS_INDEX] > VERY_PREFERRED_THRESHOLD;
  panel.hidden = !eligible;
  if (!eligible) {
    if (state.baseballAttendance && state.baseballPreviousEnd) {
      $("#endDate").value = state.baseballPreviousEnd.endDate;
      $("#endTime").value = state.baseballPreviousEnd.endTime;
    }
    checkbox.checked = false;
    state.baseballAttendance = false;
    state.baseballPreviousEnd = null;
    syncTravelWindow();
    return;
  }

  const gameDate = $("#endDate").value || $("#travelDate").value;
  const schedule = baseballScheduleForDate(gameDate);
  if (!checkbox.checked) {
    state.baseballAttendance = false;
    status.textContent = `${schedule.dayTypeLabel} ${formatClockMinutes(schedule.gameStartMinutes)} 경기 · 직관을 선택하면 구장 먹거리와 경기 시간을 고정합니다.`;
    return;
  }

  state.baseballAttendance = true;
  if (adjustTravelWindow) {
    $("#endDate").value = gameDate;
    $("#endTime").value = formatClockMinutes(schedule.gameEndMinutes);
    syncTravelWindow();
  }
  status.textContent = `${schedule.dayTypeLabel} ${formatClockMinutes(schedule.gameStartMinutes)} 경기 · ${formatClockMinutes(schedule.stadiumFoodStartMinutes)} 구장 먹거리 · ${formatClockMinutes(schedule.gameEndMinutes)} 종료`;
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
  if (!active && state.baseballPreviousEnd) {
    $("#endDate").value = state.baseballPreviousEnd.endDate;
    $("#endTime").value = state.baseballPreviousEnd.endTime;
    state.baseballPreviousEnd = null;
    state.baseballAttendance = false;
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
    status.textContent = `${tripLabel} · 실제 일정 가능 ${formatDuration(activeMinutes)} · ${startTimeInput.value} 시작 → ${endTimeInput.value} 종료`;
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

function koreaDateParts(date = new Date()) {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Seoul",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    hourCycle: "h23",
  }).formatToParts(date);
  return Object.fromEntries(parts.map((part) => [part.type, part.value]));
}

function latestKmaBase(date = new Date()) {
  const buffered = new Date(date.getTime() - 15 * 60 * 1000);
  const parts = koreaDateParts(buffered);
  const hour = Number(parts.hour);
  let baseHour = [...KMA_BASE_HOURS].reverse().find((candidate) => candidate <= hour);
  let baseDate = `${parts.year}-${parts.month}-${parts.day}`;
  if (baseHour === undefined) {
    baseHour = 23;
    baseDate = shiftDateValue(baseDate, -1);
  }
  return {
    baseDate: baseDate.replaceAll("-", ""),
    baseTime: `${String(baseHour).padStart(2, "0")}00`,
  };
}

function previousKmaBase({ baseDate, baseTime }) {
  const baseHour = Number(baseTime.slice(0, 2));
  const index = KMA_BASE_HOURS.indexOf(baseHour);
  if (index > 0) {
    return { baseDate, baseTime: `${String(KMA_BASE_HOURS[index - 1]).padStart(2, "0")}00` };
  }
  const dateValue = `${baseDate.slice(0, 4)}-${baseDate.slice(4, 6)}-${baseDate.slice(6, 8)}`;
  return { baseDate: shiftDateValue(dateValue, -1).replaceAll("-", ""), baseTime: "2300" };
}

function latLonToKmaGrid(latitude, longitude) {
  const earthRadius = 6371.00877;
  const gridSpacing = 5.0;
  const firstStandardParallel = 30.0;
  const secondStandardParallel = 60.0;
  const originLongitude = 126.0;
  const originLatitude = 38.0;
  const originX = 43;
  const originY = 136;
  const degreesToRadians = Math.PI / 180;
  const re = earthRadius / gridSpacing;
  const slat1 = firstStandardParallel * degreesToRadians;
  const slat2 = secondStandardParallel * degreesToRadians;
  const olon = originLongitude * degreesToRadians;
  const olat = originLatitude * degreesToRadians;
  let sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
  sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
  let sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
  sf = (Math.cos(slat1) * sf ** sn) / sn;
  let ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
  ro = (re * sf) / ro ** sn;
  let ra = Math.tan(Math.PI * 0.25 + latitude * degreesToRadians * 0.5);
  ra = (re * sf) / ra ** sn;
  let theta = longitude * degreesToRadians - olon;
  if (theta > Math.PI) theta -= 2 * Math.PI;
  if (theta < -Math.PI) theta += 2 * Math.PI;
  theta *= sn;
  return {
    nx: Math.floor(ra * Math.sin(theta) + originX + 0.5),
    ny: Math.floor(ro - ra * Math.cos(theta) + originY + 0.5),
  };
}

function normalizeKmaServiceKey(value) {
  const key = String(value || "").trim();
  if (!key.includes("%")) return key;
  try {
    return decodeURIComponent(key);
  } catch {
    return key;
  }
}

async function requestKmaForecast(serviceKey, grid, base, signal) {
  const params = new URLSearchParams({
    serviceKey,
    pageNo: "1",
    numOfRows: "2000",
    dataType: "JSON",
    base_date: base.baseDate,
    base_time: base.baseTime,
    nx: String(grid.nx),
    ny: String(grid.ny),
  });
  const response = await fetch(`${KMA_FORECAST_URL}?${params}`, { signal });
  if (!response.ok) throw new Error(`기상청 API HTTP ${response.status}`);
  const payload = await response.json();
  const header = payload?.response?.header;
  if (String(header?.resultCode) !== "00") {
    throw new Error(header?.resultMsg || "기상청 예보 응답 오류");
  }
  const items = payload?.response?.body?.items?.item;
  if (!Array.isArray(items) || !items.length) throw new Error("기상청 예보 데이터가 없습니다.");
  return items;
}

function forecastCondition(values) {
  const precipitationType = Number(values.PTY || 0);
  const precipitationProbability = Number(values.POP || 0);
  if (precipitationType > 0 || precipitationProbability >= 60) return "rainy";
  if ([3, 4].includes(Number(values.SKY))) return "cloudy";
  return "sunny";
}

function selectForecastSlot(items, dateValue, targetMinutes, label) {
  const forecastDate = dateValue.replaceAll("-", "");
  const dayItems = items.filter((item) => String(item.fcstDate) === forecastDate);
  const times = [...new Set(dayItems.map((item) => String(item.fcstTime).padStart(4, "0")))];
  const selectedTime = times
    .map((time) => ({
      time,
      minutes: Number(time.slice(0, 2)) * 60 + Number(time.slice(2, 4)),
    }))
    .sort((a, b) => Math.abs(a.minutes - targetMinutes) - Math.abs(b.minutes - targetMinutes))[0];
  if (!selectedTime || Math.abs(selectedTime.minutes - targetMinutes) > 180) return null;
  const values = Object.fromEntries(
    dayItems
      .filter((item) => String(item.fcstTime).padStart(4, "0") === selectedTime.time)
      .map((item) => [item.category, item.fcstValue]),
  );
  const condition = forecastCondition(values);
  return {
    label,
    time: selectedTime.time,
    condition,
    sky: Number(values.SKY || 0),
    precipitationType: Number(values.PTY || 0),
    precipitationProbability: Number(values.POP || 0),
    precipitation: values.PCP || "강수없음",
    temperature: Number(values.TMP),
    humidity: Number(values.REH),
    windSpeed: Number(values.WSD),
  };
}

function forecastDates(conditions) {
  return travelDayWindows(conditions).map((window) => window.date);
}

function buildWeatherForecast(items, conditions, grid, base) {
  const days = forecastDates(conditions).map((date, index) => ({
    date,
    dayIndex: index,
    slots: [
      selectForecastSlot(items, date, 12 * 60, "12시 점심"),
      selectForecastSlot(items, date, 18 * 60, "18시 저녁"),
    ].filter(Boolean),
  }));
  const slots = days.flatMap((day) => day.slots);
  if (!slots.length) throw new Error("선택한 날짜가 기상청 단기예보 범위 밖입니다.");
  const condition = slots.some((slot) => slot.condition === "rainy")
    ? "rainy"
    : slots.some((slot) => slot.condition === "cloudy")
      ? "cloudy"
      : "sunny";
  return {
    status: "ready",
    condition,
    originKey: conditions.originKey,
    originName: conditions.origin.name,
    grid,
    base,
    days,
    fetchedAt: new Date().toISOString(),
  };
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
    const slots = forecast.days[0]?.slots || [];
    element.textContent = `${forecast.originName} 기준 · ${slots.map((slot) => `${slot.label} ${WEATHER_ICONS[slot.condition]} ${Number.isFinite(slot.temperature) ? `${Math.round(slot.temperature)}℃` : WEATHER_LABELS[slot.condition]}`).join(" · ")}`;
    element.classList.add("ready");
    return;
  }
  if (forecast?.status === "manual") {
    element.textContent = `${WEATHER_LABELS[forecast.condition]}으로 직접 설정했습니다.`;
    return;
  }
  if (forecast?.status === "needs_key") {
    element.textContent = "config.js에 기상청 서비스키를 넣으면 출발지 기준으로 자동 반영됩니다.";
    element.classList.add("warning");
    return;
  }
  if (forecast?.status === "error") {
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
    const day = forecast.days.find((item) => item.date === selectedDate) || forecast.days[0];
    const slots = day?.slots || [];
    element.innerHTML = `
      <strong>기상청 단기예보 · ${escapeHtml(forecast.originName)} 출발 기준</strong>
      <div class="weather-slot-list">
        ${slots.map((slot) => `<span class="weather-slot">${WEATHER_ICONS[slot.condition]} ${escapeHtml(slot.label)} · ${Number.isFinite(slot.temperature) ? `${Math.round(slot.temperature)}℃` : WEATHER_LABELS[slot.condition]} · 강수 ${slot.precipitationProbability}%</span>`).join("")}
      </div>
      <small>${escapeHtml(day.date)} · 출발장소가 포함된 기상청 5km 격자 ${forecast.grid.nx}/${forecast.grid.ny} 기준</small>
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
  element.innerHTML = `<strong>기상청 자동 연동 대기</strong><small>${escapeHtml(message)}</small>`;
}

async function refreshWeatherForecast({ force = false } = {}) {
  const conditions = currentConditions();
  if (conditions.weatherMode !== "auto") {
    state.weatherAbortController?.abort();
    state.weatherForecast = { status: "manual", condition: conditions.weatherMode };
    renderWeatherFieldStatus();
    return state.weatherForecast;
  }

  const config = window.OMAEROUTE_CONFIG || {};
  const serviceKey = normalizeKmaServiceKey(config.kmaServiceKey);
  if (!serviceKey) {
    state.weatherForecast = { status: "needs_key", condition: "sunny" };
    renderWeatherFieldStatus();
    return state.weatherForecast;
  }

  const grid = latLonToKmaGrid(conditions.origin.latitude, conditions.origin.longitude);
  const base = latestKmaBase();
  const cacheKey = `${conditions.originKey}:${conditions.travelDate}:${conditions.startTime}:${conditions.endDate}:${conditions.endTime}:${base.baseDate}:${base.baseTime}`;
  if (!force && state.weatherCache.has(cacheKey)) {
    state.weatherForecast = state.weatherCache.get(cacheKey);
    renderWeatherFieldStatus();
    return state.weatherForecast;
  }

  state.weatherAbortController?.abort();
  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), 10000);
  state.weatherAbortController = controller;
  state.weatherForecast = { status: "loading", condition: "sunny" };
  renderWeatherFieldStatus();
  let lastError;
  try {
    for (const candidateBase of [base, previousKmaBase(base)]) {
      try {
        const items = await requestKmaForecast(serviceKey, grid, candidateBase, controller.signal);
        const forecast = buildWeatherForecast(items, conditions, grid, candidateBase);
        state.weatherCache.set(cacheKey, forecast);
        state.weatherForecast = forecast;
        renderWeatherFieldStatus();
        return forecast;
      } catch (error) {
        if (error.name === "AbortError") throw error;
        lastError = error;
      }
    }
    throw lastError || new Error("기상청 예보를 불러오지 못했습니다.");
  } catch (error) {
    if (error.name === "AbortError" && state.weatherAbortController !== controller) return state.weatherForecast;
    state.weatherForecast = {
      status: "error",
      condition: "sunny",
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
  const hasKey = Boolean(normalizeKmaServiceKey(window.OMAEROUTE_CONFIG?.kmaServiceKey));
  if (reload && $("#weather").value === "auto" && hasKey) void refreshWeatherForecast();
}

function getPreferenceLevel(value) {
  if (value <= 20) return "관심 낮음";
  if (value <= 45) return "조금 선호";
  if (value <= 75) return "보통 이상";
  return "매우 선호";
}

function topAxes(limit = 2) {
  return currentVector()
    .map((value, index) => ({ value: Math.round(value * 100), ...AXES[index] }))
    .sort((a, b) => b.value - a.value)
    .slice(0, limit);
}

function updateRangeVisual(input) {
  input.style.setProperty("--range-progress", `${input.value}%`);
  input.closest(".slider-row").querySelector(".slider-level").textContent =
    getPreferenceLevel(Number(input.value));
}

function renderSliders() {
  $("#preferenceSliders").innerHTML = AXES.map(
    (axis, index) => `
      <label class="slider-row">
        <span class="slider-meta">
          <span class="slider-name"><i>${axis.emoji}</i>${axis.label}</span>
          <span class="slider-level">${getPreferenceLevel(state.preference[index])}</span>
        </span>
        <input
          type="range"
          min="0"
          max="100"
          step="1"
          value="${state.preference[index]}"
          data-index="${index}"
          aria-label="${axis.label} 선호도"
        />
      </label>
    `,
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
  $("#axisPreview").innerHTML = topAxes(5)
    .map((axis) => `<span>${axis.emoji} ${axis.label} ${axis.value}</span>`)
    .join("");
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
  if (requiresRain && !place.rainOk) return false;
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
  const weatherFit = conditions.weather === "rainy" ? Number(place.rainOk) : 0.92;
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
  if (conditions.sportsBaseballHighlyPreferred && place.playerRecommended) {
    const players = place.activeRecommendedPlayers?.length
      ? place.activeRecommendedPlayers
      : place.recommendedPlayers || [];
    return [players.length ? `${players.join("·")} 선수 추천` : "KIA 선수 추천"];
  }
  const preferenceReasons = place.vector
    .map((value, index) => ({ label: AXES[index].label, score: value * vector[index] }))
    .sort((a, b) => b.score - a.score)
    .slice(0, 2)
    .map((item) => item.label);
  const contextReasons = [];
  if (conditions.weather === "rainy" && place.rainOk) contextReasons.push("비 오는 날 가능");
  if (conditions.companion === "family" && place.familyFriendly) {
    contextReasons.push("가족 동행 적합");
  }
  if (conditions.transport === "public" && place.publicTransportScore >= 0.75) {
    contextReasons.push("대중교통 편리");
  }
  return [...promptReasonsForPlace(place, conditions), ...preferenceReasons, ...contextReasons]
    .filter((item, index, items) => items.indexOf(item) === index)
    .slice(0, 3);
}

function rankPlacesLocal() {
  const vector = currentVector();
  const conditions = currentConditions();
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
        ? preferenceScore * 0.65 + situationalScore * 0.2 + promptScore * 0.15
        : preferenceScore * 0.78 + situationalScore * 0.22;
      const sportsPreferenceBoost = conditions.sportsBaseballHighlyPreferred && place.playerRecommended
        ? place.activePlayerRecommended ? 1.5 : 1.15
        : 0;
      return {
        ...place,
        preferenceScore,
        situationalScore,
        promptScore,
        displayScore: baseScore,
        sportsPreferenceBoost,
        score: baseScore + sportsPreferenceBoost,
        reasons: matchReasons(place, vector, conditions),
      };
    })
    .sort((a, b) => b.score - a.score);
}

function parseVector(value) {
  if (Array.isArray(value)) return value.map(Number);
  if (typeof value === "string") {
    return value.replaceAll("[", "").replaceAll("]", "").split(",").map(Number);
  }
  return currentVector();
}

async function rankPlacesSupabase() {
  const config = window.OMAEROUTE_CONFIG || {};
  const conditions = currentConditions();
  const response = await fetch(`${config.supabaseUrl}/rest/v1/rpc/recommend_places`, {
    method: "POST",
    headers: {
      apikey: config.anonKey,
      Authorization: `Bearer ${config.anonKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      query_vector: `[${currentVector().join(",")}]`,
      match_count: 30,
      filter_rain_ok: conditions.weather === "rainy",
      filter_family_friendly: conditions.companion === "family",
      min_public_transport_score: conditions.transport === "public" ? 0.48 : 0,
    }),
  });
  if (!response.ok) throw new Error(`Supabase RPC 오류: ${response.status}`);

  return (await response.json()).map((row) => {
    const place = {
      id: Number(row.place_id),
      name: row.place_name,
      region: row.region,
      category: row.category,
      description: row.description,
      hashtags: row.hashtags || [],
      vector: parseVector(row.preference_vector),
      latitude: row.latitude,
      longitude: row.longitude,
      durationMinutes: row.duration_minutes,
      indoor: row.indoor,
      rainOk: row.rain_ok,
      familyFriendly: row.family_friendly,
      publicTransportScore: row.public_transport_score,
      score: Number(row.similarity),
    };
    return { ...place, reasons: matchReasons(place, currentVector(), conditions) };
  });
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

function scheduleLeg(current, clockMinutes, place, targetMinutes = null) {
  const distance = haversineKm(current, place);
  const travelMinutes = estimateTravelMinutes(distance);
  const arrivalMinutes = clockMinutes + travelMinutes;
  const waitMinutes = targetMinutes === null ? 0 : Math.max(0, targetMinutes - arrivalMinutes);
  const startMinutes = arrivalMinutes + waitMinutes;
  const endMinutes = startMinutes + place.durationMinutes;
  return { distance, travelMinutes, arrivalMinutes, waitMinutes, startMinutes, endMinutes };
}

function returnTravelMinutes(place, destination) {
  if (!destination) return 0;
  return estimateTravelMinutes(haversineKm(place, destination));
}

function chooseBestCandidate(results, current, usedIds, predicate = () => true) {
  return results
    .filter((place) => !usedIds.has(place.id) && hasUsableCoordinates(place) && predicate(place))
    .sort((a, b) => routeCandidateValue(b, current) - routeCandidateValue(a, current))[0] || null;
}

function chooseMealCandidate(results, current, clockMinutes, usedIds, slot, dayEndMinutes, returnDestination = null) {
  return results
    .filter((place) =>
      !usedIds.has(place.id)
      && hasUsableCoordinates(place)
      && isMealPlace(place)
      && !place.stadiumFood,
    )
    .map((place) => {
      const leg = scheduleLeg(current, clockMinutes, place, slot.targetMinutes);
      const timingPenalty = Math.abs(leg.startMinutes - slot.targetMinutes) / 180;
      return { place, leg, value: routeCandidateValue(place, current) - timingPenalty };
    })
    .filter(({ place, leg }) =>
      leg.startMinutes <= slot.windowEnd
      && leg.endMinutes + returnTravelMinutes(place, returnDestination) <= dayEndMinutes,
    )
    .sort((a, b) => b.value - a.value)[0] || null;
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
    .filter(({ leg, meal }) => meal && leg.endMinutes <= slot.windowEnd)
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
    day.push(mealPlace);
    usedIds.add(meal.place.id);
    current = mealPlace;
    clockMinutes = meal.leg.endMinutes;
  }

  while (day.length < maxStops) {
    let next = chooseBestCandidate(results, current, usedIds, (place) => !isMealPlace(place));
    if (!next) next = chooseBestCandidate(results, current, usedIds);
    if (!next) break;
    const leg = scheduleLeg(current, clockMinutes, next);
    if (leg.endMinutes + returnTravelMinutes(next, returnDestination) > dayEndMinutes) break;
    day.push(next);
    usedIds.add(next.id);
    current = next;
    clockMinutes = leg.endMinutes;
  }
  return day;
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

function selectStadiumFood(results, schedule) {
  const selected = state.stadiumFoods
    .filter((place) =>
      place.stadiumFood
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

function buildBaseballRouteDay(results, conditions, usedIds, dayIndex, window) {
  const schedule = baseballScheduleForDate(window.date);
  const day = [];
  let current = conditions.origin;
  let clockMinutes = window.startMinutes;
  const stadiumFood = selectStadiumFood(results, schedule);
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
        leg.endMinutes + returnTravelMinutes(place, CHAMPIONS_FIELD_GAME) <= pregameEndMinutes,
      )
      .sort((a, b) => routeCandidateValue(b.place, current) - routeCandidateValue(a.place, current))[0];
    if (!next) break;
    day.push(next.place);
    usedIds.add(next.place.id);
    current = next.place;
    clockMinutes = next.leg.endMinutes;
  }

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
    reasons: [
      `${schedule.dayTypeLabel} ${formatClockMinutes(schedule.gameStartMinutes)} 경기 시작`,
      "3시간~3시간 30분 관람",
      "여행 마지막 일정",
    ],
  });
  return day;
}

function createRoute(results) {
  const conditions = currentConditions();
  const windows = travelDayWindows(conditions);
  const usedIds = new Set();
  state.mealWarnings = [];
  const builtDays = windows
    .map((window, dayIndex) => ({
      window,
      day: conditions.baseballAttendance && dayIndex === windows.length - 1
        ? buildBaseballRouteDay(results, conditions, usedIds, dayIndex, window)
        : buildRouteDay(results, conditions, usedIds, dayIndex, window, dayIndex === windows.length - 1),
    }))
    .filter(({ day }) => day.length);
  state.dayWindows = builtDays.map(({ window }) => window);
  state.routeDays = builtDays.map(({ day }) => day);
  state.route = state.routeDays.flat();
  state.selectedDay = 0;
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
    );
    const scheduled = { place, ...leg };
    current = place;
    clockMinutes = leg.endMinutes;
    return scheduled;
  });
}

function routeMetrics(routeDays = state.routeDays) {
  let distance = 0;
  let minutes = 0;
  const conditions = currentConditions();
  routeDays.forEach((day, dayIndex) => {
    const schedule = buildRouteSchedule(day, dayIndex);
    const startMinutes = state.dayWindows[dayIndex]?.startMinutes ?? parseClockMinutes(conditions.startTime);
    distance += schedule.reduce((sum, stop) => sum + stop.distance, 0);
    if (schedule.length) minutes += schedule.at(-1).endMinutes - startMinutes;
    if (dayIndex === routeDays.length - 1 && day.length && !day.at(-1).endsTrip) {
      const returnDistance = haversineKm(day.at(-1), conditions.origin);
      distance += returnDistance;
      minutes += estimateTravelMinutes(returnDistance);
    }
  });
  return { distance, minutes };
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

function previewSlides() {
  return state.route.map((place) => ({
    title: place.name,
    description: place.description,
    imageUrl: place.imageUrl || "",
  }));
}

function renderPreview() {
  const slides = previewSlides();
  if (!slides.length) return;
  state.previewIndex %= slides.length;
  const slide = slides[state.previewIndex];
  const scene = $("#previewScene");
  const image = $("#previewImage");
  const button = $("#previewPlayButton");
  const progress = $("#previewProgress");

  scene.classList.toggle("is-playing", state.previewPlaying);
  scene.classList.toggle("image-missing", !slide.imageUrl);
  image.src = slide.imageUrl;
  image.alt = `${slide.title} 여행 프리뷰`;
  $("#previewTitle").textContent = slide.title;
  $("#previewDescription").textContent = slide.description;
  button.textContent = state.previewPlaying ? "Ⅱ" : "▶";
  button.setAttribute("aria-label", state.previewPlaying ? "프리뷰 일시정지" : "프리뷰 재생");
  $("#previewDots").innerHTML = slides
    .map((_, index) => `<i class="${index === state.previewIndex ? "active" : ""}"></i>`)
    .join("");

  progress.classList.remove("running");
  void progress.offsetWidth;
  if (state.previewPlaying) progress.classList.add("running");
}

function stopPreview({ reset = false } = {}) {
  if (state.previewTimer) {
    window.clearInterval(state.previewTimer);
    state.previewTimer = null;
  }
  state.previewPlaying = false;
  if (reset) state.previewIndex = 0;
  if (state.route.length) renderPreview();
}

function startPreview() {
  const slides = previewSlides();
  if (!slides.length) return;
  if (state.previewTimer) window.clearInterval(state.previewTimer);
  state.previewPlaying = true;
  renderPreview();
  state.previewTimer = window.setInterval(() => {
    state.previewIndex = (state.previewIndex + 1) % slides.length;
    renderPreview();
  }, 3500);
}

function togglePreview() {
  if (state.previewPlaying) stopPreview();
  else startPreview();
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

function stampIcon(place) {
  const category = `${place.category} ${place.hashtags.join(" ")}`;
  if (/음식|시장|맛집|카페|로컬/.test(category)) return "🍚";
  if (/스포츠|체험|액티비티|야구/.test(category)) return "🏆";
  if (/자연|경관|산|숲|공원|정원/.test(category)) return "🌿";
  if (/전시|문화|예술|박물관/.test(category)) return "🏛";
  return "✦";
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
    const sealClass = isStamped ? "unlocked" : isInRange ? "in-range" : "";
    const sealContent = isStamped
      ? `<span>광주·전남</span><b>${escapeHtml(place.name)}</b><span>완료</span>`
      : `<span class="stamp-icon">${stampIcon(place)}</span><span>${isInRange ? "도장 찍기" : "방문"}</span>`;
    const distanceClass = isInRange && !isStamped ? "ready" : "";
    const distanceText = isStamped ? "✓ 스탬프 획득" : formatStampDistance(distanceMeters);
    return `
      <article class="stamp-item">
        <button
          type="button"
          class="stamp-seal ${sealClass}"
          data-stamp-id="${escapeHtml(id)}"
          aria-label="${escapeHtml(place.name)} ${isStamped ? "스탬프 획득 완료" : "스탬프 찍기"}"
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
  const origin = currentConditions().origin;
  const points = [origin, ...state.route];
  if (points.length < 2) return;

  const lats = points.map((point) => point.latitude);
  const lons = points.map((point) => point.longitude);
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
  const projected = points.map(project);
  const polyline = [...projected, projected[0]].map((point) => `${point.x},${point.y}`).join(" ");
  const grid = Array.from({ length: 13 }, (_, index) => {
    const x = -70 + index * 90;
    return `<path d="M${x} 0 L${x + 160} 390" stroke="#d1d6db" stroke-width="1" opacity=".6"/>`;
  }).join("");
  const markers = projected.map((point, index) => {
    const name = index === 0 ? origin.name : state.route[index - 1].name;
    const shortName = name.length > 12 ? `${name.slice(0, 11)}…` : name;
    const color = index === 0 ? "#1b64da" : "#3182f6";
    const labelX = clamp(point.x, 65, 855);
    const labelY = clamp(point.y + 24, 25, 350);
    return `
      <g>
        <circle cx="${point.x}" cy="${point.y}" r="17" fill="white" opacity=".96"/>
        <circle cx="${point.x}" cy="${point.y}" r="12" fill="${color}"/>
        <text x="${point.x}" y="${point.y + 3.5}" text-anchor="middle" fill="white" font-size="9" font-weight="800">${index === 0 ? "S" : index}</text>
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
    const origin = currentConditions().origin;
    const routePoints = [
      { ...origin, order: 0, label: "출발" },
      ...state.route.map((place, index) => ({ ...place, order: index + 1, label: `${index + 1}` })),
    ];

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
      infoTitle.textContent = point.order === 0 ? `출발 · ${point.name}` : `${point.order}. ${point.name}`;
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
      labelNode.className = `kakao-route-label${point.order === 0 ? " start" : ""}`;
      labelNode.textContent = point.order === 0 ? `출발 · ${point.name}` : `${point.order}. ${point.name}`;
      const overlay = new kakao.maps.CustomOverlay({
        map,
        position,
        content: labelNode,
        yAnchor: 2.15,
        zIndex: 3,
      });
      state.kakaoOverlays.push(overlay);
    });

    linePath.push(new kakao.maps.LatLng(origin.latitude, origin.longitude));

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

function dayTheme(day) {
  const axes = topAxes(2);
  if (!day.length) return "조건에 맞는 장소를 찾지 못했습니다.";
  const mealLabels = day.filter((place) => place.mealSlot).map((place) => `${formatClockMinutes(place.mealTargetMinutes)} ${place.mealLabel}`);
  return `${axes[0].label}와 ${axes[1].label} 취향을 중심으로 ${day[0].region}에서 이어지는 일정${mealLabels.length ? ` · ${mealLabels.join("·")} 포함` : ""}`;
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
  renderDayTabs();
  $("#dayTheme").textContent = dayTheme(day);
  $("#itineraryTimeline").innerHTML = schedule.map((stop, index) => {
    const { place, travelMinutes, waitMinutes, startMinutes } = stop;
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
            ${place.isBaseballGame ? '<span class="meal-time-chip">⚾ 야구 직관</span>' : ""}
            ${place.mealSlot ? `<span class="meal-time-chip">🍚 ${escapeHtml(place.mealLabel)} 추천</span>` : ""}
            <span class="type-chip">${escapeHtml(place.category)}</span>
            ${place.hashtags.slice(0, 2).map((tag) => `<span class="hashtag-chip">${escapeHtml(tag)}</span>`).join("")}
          </div>
          <h3>${escapeHtml(place.name)}</h3>
          <p>${escapeHtml(place.description)}</p>
          <div class="stop-details">
            ${place.isBaseballGame ? `
              <div class="baseball-game-callout">⚾ ${escapeHtml(place.gameDayType)} ${formatClockMinutes(place.fixedStartMinutes)} 경기 시작 · 약 3시간~3시간 30분 관람 · ${formatClockMinutes(place.expectedEndMinutes)} 종료</div>
            ` : ""}
            ${place.stadiumFood ? `
              <div class="stadium-food-callout">🍚 저녁 구매 · ${escapeHtml(place.branchName || "매장 위치 현장 확인")}${stadiumMenu ? ` · ${escapeHtml(stadiumMenu.name)} ${escapeHtml(stadiumMenuPrice)}` : ""} · 경기 시작 전에 사서 관람석에서 직관하며 식사</div>
            ` : ""}
            ${conditions.sportsBaseballHighlyPreferred && place.activeRecommendedPlayers?.length ? `
              <div class="player-recommendation">⚾ ${escapeHtml(place.activeRecommendedPlayers.join("·"))} 선수 추천</div>
            ` : ""}
            <div class="reason-callout">추천 이유 · ${place.reasons.map(escapeHtml).join(" · ")} · 이전 지점에서 약 ${travelMinutes}분${waitMinutes ? ` · ${place.isBaseballGame ? "경기 시작" : "식사시간"}까지 여유 ${waitMinutes}분` : ""}${isFinalReturn ? ` · ${escapeHtml(conditions.origin.name)} 복귀 약 ${originReturnMinutes}분 · ${escapeHtml(conditions.endTime)} 여행 종료 전 복귀` : ""}</div>
            <div class="stop-detail-actions">
              <a class="kakao-directions-link" href="${mapLink}" target="_blank" rel="noopener noreferrer">${nextPlace ? "다음 장소 길찾기" : isFinalReturn ? "출발지 복귀 길찾기" : "카카오맵에서 보기"} ↗</a>
            </div>
          </div>
        </div>
      </article>
    `;
  }).join("");
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

function renderTips() {
  const conditions = currentConditions();
  const mealStops = state.route.filter((place) => place.mealSlot);
  const tips = [
    `${conditions.origin.name}에서 첫 장소까지 ${state.transport === "public" ? "대중교통 환승 시간을 포함해" : "실제 교통 상황을 확인하며"} 출발하세요.`,
    conditions.weather === "rainy"
      ? state.promptAnalysis.relaxed && conditions.promptRainy
        ? "비 대응 장소를 우선했고, 함께 요청한 조건을 만족시키기 위해 일부 후보는 유연하게 포함했습니다. 우산과 운영 여부를 확인하세요."
        : "비 오는 날 이용 가능한 장소만 포함했습니다. 실외 이동 구간에는 우산을 준비하세요."
      : "실외 장소가 포함되어 있으니 출발 전 운영시간과 기상 상황을 한 번 더 확인하세요.",
    `추천은 ${topAxes(2).map((axis) => axis.label).join("·")} 선호를 가장 크게 반영했습니다. 장소 카드를 누르면 추천 근거를 볼 수 있습니다.`,
  ];
  if (mealStops.length) {
    tips.unshift(`${mealStops.map((place) => `${formatClockMinutes(place.mealTargetMinutes)} ${place.mealLabel}`).join(" · ")} 시간에 맞춰 음식점을 동선에 포함했습니다.`);
  }
  if (conditions.baseballAttendance) {
    const gameStop = state.route.find((place) => place.isBaseballGame);
    const stadiumFood = state.route.find((place) => place.stadiumFood);
    if (gameStop) {
      tips.unshift(`${gameStop.gameDayType} ${formatClockMinutes(gameStop.fixedStartMinutes)} 챔피언스필드 경기를 마지막 일정으로 고정했고 ${formatClockMinutes(gameStop.expectedEndMinutes)} 종료로 계산했습니다.`);
    }
    if (stadiumFood) {
      const dinnerMenu = stadiumFood.menuItems?.find((menu) => menu.signature) || stadiumFood.menuItems?.[0];
      tips.unshift(`${formatClockMinutes(stadiumFood.fixedStartMinutes)} ${stadiumFood.name}에서 ${dinnerMenu?.name || "저녁 메뉴"} 구매 후, 경기 시작부터 관람석에서 먹는 일정입니다. 경기 당일 영업·재고·가격을 다시 확인하세요.`);
    }
  }
  if (conditions.sportsBaseballHighlyPreferred) {
    const playerRestaurants = mealStops.filter((place) => place.playerRecommended);
    tips.unshift(playerRestaurants.length
      ? `스포츠·야구 매우 선호를 반영해 ${playerRestaurants.map((place) => place.name).join(" · ")}의 추천 우선순위를 크게 높였습니다.`
      : "스포츠·야구를 매우 선호하지만 현재 시간·동선 안에 배치 가능한 선수 추천 맛집을 찾지 못했습니다.");
  }
  if (state.mealWarnings.length) {
    tips.push(`${state.mealWarnings.join(" ")} 현재 필터에서 이용 가능한 음식점 데이터가 더 필요합니다.`);
  }
  if (conditions.weatherMode === "auto" && state.weatherForecast?.status !== "ready") {
    tips.push("기상청 예보를 적용하지 못해 날씨 조건은 제외했습니다. 입력 화면의 상태 안내를 확인하세요.");
  }
  const forecastTemperatures = state.weatherForecast?.status === "ready"
    ? state.weatherForecast.days.flatMap((day) => day.slots).map((slot) => slot.temperature).filter(Number.isFinite)
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
  $("#routeTips").innerHTML = tips.map((tip) => `<li>${escapeHtml(tip)}</li>`).join("");
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
  const metrics = routeMetrics();
  const title = `${axes[0].label}와 ${axes[1].label}을 잇는 ${durationLabel()} 여행`;
  const travelWindowCopy = `${conditions.origin.name} · 출발일 ${conditions.travelDate} ${conditions.startTime} → 귀가일 ${conditions.endDate} ${conditions.endTime}`;
  $("#resultTitle").textContent = title;
  $("#resultDescription").textContent = conditions.baseballAttendance
    ? `${travelWindowCopy}, 구장 먹거리 DB에서 저녁을 골라 경기 전에 구매하고 직관하며 먹도록 구성한 동선입니다.`
    : state.travelPrompt
      ? `${travelWindowCopy}, 슬라이더 취향과 한 줄 요청 및 출발지 복귀시간을 함께 반영한 동선입니다.`
      : conditions.sportsBaseballHighlyPreferred
        ? `${travelWindowCopy}, 스포츠·야구 취향과 KIA 선수 추천 맛집 및 복귀시간을 우선 반영한 동선입니다.`
        : `${travelWindowCopy}, 취향과 출발지 복귀시간을 반영한 동선입니다.`;
  renderPromptResultSummary();
  $("#mapSummary").textContent = `${conditions.origin.name} 왕복 · ${metrics.distance.toFixed(1)}km`;
  renderMap();
  renderItinerary();
  renderAlternatives();
  renderTips();
  stopPreview({ reset: true });
  renderStamps();
  renderReviewReward();
  updateSaveButton();
}

function showView(viewName, { pushState = true } = {}) {
  const wantsResult = viewName === "result" && state.route.length > 0;
  $("#formView").classList.toggle("active", !wantsResult);
  $("#resultView").classList.toggle("active", wantsResult);
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
    const config = window.OMAEROUTE_CONFIG || {};
    await refreshWeatherForecast();
    try {
      state.results = config.useSupabase ? await rankPlacesSupabase() : rankPlacesLocal();
    } catch (error) {
      console.warn("Supabase 추천 실패, 로컬 데이터로 전환합니다.", error);
      state.results = rankPlacesLocal();
    }
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
  return `${route.map((place) => `${place.id}:${place.mealSlot || "visit"}`).join("-")}@${$("#travelDate").value}:${$("#startTime").value}-${$("#endDate").value}:${$("#endTime").value}`;
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
      }))),
      originKey: currentConditions().originKey,
      travelDate: $("#travelDate").value,
      startTime: $("#startTime").value,
      endDate: $("#endDate").value,
      endTime: $("#endTime").value,
      duration: state.duration,
      transport: state.transport,
      preference: [...state.preference],
      prompt: state.travelPrompt,
      companion: $("#companion").value,
      weather: $("#weather").value,
      baseballAttendance: state.baseballAttendance,
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
  $("#startTime").value = restoredStartTime;
  $("#endDate").value = saved.endDate || legacyEnd.endDate;
  $("#endTime").value = saved.endTime || legacyEnd.endTime;
  syncTravelWindow();
  state.transport = saved.transport;
  state.preference = [...saved.preference];
  state.baseballAttendance = Boolean(saved.baseballAttendance);
  $("#baseballAttendance").checked = state.baseballAttendance;
  $("#travelPrompt").value = saved.prompt || "";
  if (saved.companion) $("#companion").value = saved.companion;
  if (saved.weather) $("#weather").value = saved.weather;
  state.weatherForecast = saved.weatherForecast || null;
  $$('.choice-group[data-group="transport"] button').forEach((button) => {
    button.classList.toggle("active", button.dataset.value === state.transport);
  });
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
      if (group.dataset.group === "transport") state.transport = button.dataset.value;
      if (group.dataset.group === "companion") $("#companion").value = button.dataset.value;
    });
  });

  $("#origin").addEventListener("change", () => invalidateWeatherForecast({ reload: false }));
  [$("#travelDate"), $("#startTime"), $("#endDate"), $("#endTime")].forEach((input) => {
    input.addEventListener("change", () => {
      if (input === $("#travelDate") && (!$("#endDate").value || $("#endDate").value < input.value)) {
        $("#endDate").value = input.value;
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
  $("#previewImage").addEventListener("load", () => {
    $("#previewScene").classList.remove("image-missing");
  });
  $("#previewImage").addEventListener("error", () => {
    $("#previewScene").classList.add("image-missing");
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
  const [placeResponse, restaurantResponse, stadiumFoodResult] = await Promise.all([
    fetch("./data/places.json"),
    fetch("./data/restaurants.json"),
    stadiumFoodRequest,
  ]);
  if (!placeResponse.ok) throw new Error(`관광지 데이터 오류: ${placeResponse.status}`);
  if (!restaurantResponse.ok) throw new Error(`음식점 데이터 오류: ${restaurantResponse.status}`);
  const [places, restaurants] = await Promise.all([placeResponse.json(), restaurantResponse.json()]);
  state.places = [...places, ...restaurants];
  state.stadiumFoods = Array.isArray(stadiumFoodResult.foods) ? stadiumFoodResult.foods : [];
  state.stadiumFoodLoadFailed = stadiumFoodResult.failed;
  renderSavedRoutes();
  const config = window.OMAEROUTE_CONFIG || {};
  const playerRestaurantCount = restaurants.filter((place) => place.playerRecommended).length;
  $("#dataStatus").textContent = config.useSupabase
    ? "Supabase pgvector 연결"
    : `관광지 ${places.length}곳 · 음식점 ${restaurants.length}곳 · 구장 먹거리 ${state.stadiumFoods.length}곳 · 선수 추천 ${playerRestaurantCount}곳${state.stadiumFoodLoadFailed ? " · 구장 DB 확인 필요" : ""}`;
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
