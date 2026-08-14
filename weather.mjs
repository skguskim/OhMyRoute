export const KMA_BASE_HOURS = [2, 5, 8, 11, 14, 17, 20, 23];

const PRECIPITATION_TYPE_LABELS = {
  0: "강수없음",
  1: "비",
  2: "비/눈",
  3: "눈",
  4: "소나기",
  5: "빗방울",
  6: "빗방울/눈날림",
  7: "눈날림",
};

export class WeatherForecastError extends Error {
  constructor(code, message, details = {}) {
    super(message);
    this.name = "WeatherForecastError";
    this.code = code;
    this.details = details;
  }
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

export function latestKmaBase(date = new Date()) {
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

export function previousKmaBase({ baseDate, baseTime }) {
  const baseHour = Number(baseTime.slice(0, 2));
  const index = KMA_BASE_HOURS.indexOf(baseHour);
  if (index > 0) {
    return { baseDate, baseTime: `${String(KMA_BASE_HOURS[index - 1]).padStart(2, "0")}00` };
  }
  const dateValue = `${baseDate.slice(0, 4)}-${baseDate.slice(4, 6)}-${baseDate.slice(6, 8)}`;
  return { baseDate: shiftDateValue(dateValue, -1).replaceAll("-", ""), baseTime: "2300" };
}

export function latLonToKmaGrid(latitude, longitude) {
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

export function normalizeKmaServiceKey(value) {
  const key = String(value || "").trim();
  if (!key.includes("%")) return key;
  try {
    return decodeURIComponent(key);
  } catch {
    return key;
  }
}

export function precipitationTypeLabel(value) {
  const code = Number(value || 0);
  return PRECIPITATION_TYPE_LABELS[code] || `강수형태 ${code}`;
}

export function forecastCondition(values) {
  const precipitationType = Number(values.PTY || 0);
  const precipitationProbability = Number(values.POP || 0);
  if (precipitationType > 0 || precipitationProbability >= 60) return "rainy";
  if ([3, 4].includes(Number(values.SKY))) return "cloudy";
  return "sunny";
}

export function selectForecastSlot(items, dateValue, targetTime, label) {
  const forecastDate = dateValue.replaceAll("-", "");
  const normalizedTargetTime = String(targetTime).padStart(4, "0");
  const values = Object.fromEntries(
    items
      .filter((item) =>
        String(item.fcstDate) === forecastDate
        && String(item.fcstTime).padStart(4, "0") === normalizedTargetTime,
      )
      .map((item) => [item.category, item.fcstValue]),
  );
  if (!("TMP" in values) || !("POP" in values) || !("PTY" in values)) return null;
  const precipitationType = Number(values.PTY || 0);
  return {
    label,
    time: normalizedTargetTime,
    condition: forecastCondition(values),
    sky: Number(values.SKY || 0),
    precipitationType,
    precipitationTypeLabel: precipitationTypeLabel(precipitationType),
    precipitationProbability: Number(values.POP || 0),
    precipitation: values.PCP || "강수없음",
    temperature: Number(values.TMP),
    humidity: Number(values.REH),
    windSpeed: Number(values.WSD),
  };
}

export function buildWeatherForecast(items, {
  dates,
  originKey,
  originName,
  grid,
  base,
  fetchedAt = new Date().toISOString(),
}) {
  const requestedSlots = [
    { time: "1200", label: "12시" },
    { time: "1800", label: "18시" },
  ];
  const days = dates.map((date, dayIndex) => ({
    date,
    dayIndex,
    slots: requestedSlots
      .map(({ time, label }) => selectForecastSlot(items, date, time, label))
      .filter(Boolean),
  }));
  const slots = days.flatMap((day) => day.slots);
  const availableDates = [...new Set(items.map((item) => String(item.fcstDate)))]
    .sort()
    .map((date) => `${date.slice(0, 4)}-${date.slice(4, 6)}-${date.slice(6, 8)}`);
  const availableRange = availableDates.length
    ? { from: availableDates[0], to: availableDates.at(-1) }
    : null;
  if (!slots.length) {
    const rangeText = availableRange
      ? `현재 조회 가능한 기간은 ${availableRange.from}~${availableRange.to}입니다.`
      : "현재 조회 가능한 단기예보가 없습니다.";
    throw new WeatherForecastError(
      "FORECAST_OUT_OF_RANGE",
      `선택한 날짜가 기상청 단기예보 범위 밖입니다. ${rangeText}`,
      { dates, availableRange },
    );
  }
  const missingSlots = days.flatMap((day) => requestedSlots
    .filter(({ time }) => !day.slots.some((slot) => slot.time === time))
    .map(({ time }) => ({ date: day.date, time })));
  const condition = slots.some((slot) => slot.condition === "rainy")
    ? "rainy"
    : slots.some((slot) => slot.condition === "cloudy")
      ? "cloudy"
      : "sunny";
  return {
    status: "ready",
    condition,
    coverage: missingSlots.length ? "partial" : "full",
    missingSlots,
    availableRange,
    originKey,
    originName,
    grid,
    base,
    days,
    fetchedAt,
  };
}

export function weatherSuitabilityScore(place, condition) {
  if (condition !== "rainy") return 0.92;
  if (!place?.rainOk) return 0;
  return place.indoor ? 1 : 0.72;
}
