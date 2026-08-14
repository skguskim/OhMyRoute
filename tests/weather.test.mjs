import test from "node:test";
import assert from "node:assert/strict";
import {
  WeatherForecastError,
  buildWeatherForecast,
  forecastCondition,
  latestKmaBase,
  latLonToKmaGrid,
  precipitationTypeLabel,
  selectForecastSlot,
  weatherSuitabilityScore,
} from "../weather.mjs";

function itemsFor(date, time, values) {
  return Object.entries(values).map(([category, fcstValue]) => ({
    fcstDate: date.replaceAll("-", ""),
    fcstTime: time,
    category,
    fcstValue,
  }));
}

test("광주송정역 좌표를 기상청 격자로 변환한다", () => {
  assert.deepEqual(latLonToKmaGrid(35.1377, 126.7914), { nx: 57, ny: 74 });
});

test("15분 발표 지연을 고려해 최신 발표시각을 선택한다", () => {
  assert.deepEqual(latestKmaBase(new Date("2026-08-14T02:20:00.000Z")), {
    baseDate: "20260814",
    baseTime: "1100",
  });
});

test("12시 슬롯의 기온·강수확률·강수형태를 정확히 파싱한다", () => {
  const slot = selectForecastSlot(itemsFor("2026-08-15", "1200", {
    TMP: "29",
    POP: "70",
    PTY: "4",
    SKY: "4",
    PCP: "1.0mm",
  }), "2026-08-15", "1200", "12시");
  assert.equal(slot.temperature, 29);
  assert.equal(slot.precipitationProbability, 70);
  assert.equal(slot.precipitationTypeLabel, "소나기");
  assert.equal(slot.condition, "rainy");
});

test("강수형태가 없어도 강수확률 60% 이상이면 비 예보로 처리한다", () => {
  assert.equal(forecastCondition({ PTY: 0, POP: 60, SKY: 3 }), "rainy");
  assert.equal(precipitationTypeLabel(2), "비/눈");
});

test("12시와 18시 전체 예보의 범위를 기록한다", () => {
  const items = [
    ...itemsFor("2026-08-15", "1200", { TMP: 28, POP: 20, PTY: 0, SKY: 3 }),
    ...itemsFor("2026-08-15", "1800", { TMP: 25, POP: 70, PTY: 1, SKY: 4 }),
  ];
  const forecast = buildWeatherForecast(items, {
    dates: ["2026-08-15"],
    originKey: "songjeong_station",
    originName: "광주송정역",
    grid: { nx: 57, ny: 74 },
    base: { baseDate: "20260814", baseTime: "1100" },
  });
  assert.equal(forecast.coverage, "full");
  assert.equal(forecast.condition, "rainy");
  assert.deepEqual(forecast.availableRange, { from: "2026-08-15", to: "2026-08-15" });
});

test("일부 12시·18시 데이터가 없으면 부분 범위로 표시한다", () => {
  const forecast = buildWeatherForecast(
    itemsFor("2026-08-15", "1200", { TMP: 28, POP: 10, PTY: 0, SKY: 1 }),
    {
      dates: ["2026-08-15"],
      originKey: "songjeong_station",
      originName: "광주송정역",
      grid: { nx: 57, ny: 74 },
      base: { baseDate: "20260814", baseTime: "1100" },
    },
  );
  assert.equal(forecast.coverage, "partial");
  assert.deepEqual(forecast.missingSlots, [{ date: "2026-08-15", time: "1800" }]);
});

test("단기예보 범위 밖 날짜는 명시적 오류를 낸다", () => {
  assert.throws(
    () => buildWeatherForecast(
      itemsFor("2026-08-15", "1200", { TMP: 28, POP: 10, PTY: 0, SKY: 1 }),
      {
        dates: ["2026-09-01"],
        originKey: "songjeong_station",
        originName: "광주송정역",
        grid: { nx: 57, ny: 74 },
        base: { baseDate: "20260814", baseTime: "1100" },
      },
    ),
    (error) => error instanceof WeatherForecastError && error.code === "FORECAST_OUT_OF_RANGE",
  );
});

test("비 예보에서는 실내 관광지가 실외 우천 가능 장소보다 우선한다", () => {
  const indoor = weatherSuitabilityScore({ rainOk: true, indoor: true }, "rainy");
  const outdoor = weatherSuitabilityScore({ rainOk: true, indoor: false }, "rainy");
  assert.ok(indoor > outdoor);
  assert.equal(weatherSuitabilityScore({ rainOk: false, indoor: true }, "rainy"), 0);
});
