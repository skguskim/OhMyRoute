const test = require("node:test");
const assert = require("node:assert/strict");
const { spawn } = require("node:child_process");
const fs = require("node:fs");
const net = require("node:net");
const path = require("node:path");
const { chromium } = require("playwright");

const root = path.resolve(__dirname, "..");
const port = 4191;
const baseUrl = `http://localhost:${port}`;
const browserExecutable = [
  process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE,
  "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
].filter(Boolean).find((candidate) => fs.existsSync(candidate));
const koreaDateValue = (daysFromToday) => new Intl.DateTimeFormat("en-CA", {
  timeZone: "Asia/Seoul",
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
}).format(new Date(Date.now() + daysFromToday * 24 * 60 * 60 * 1000));
const forecastDate = koreaDateValue(1);
const mixedShortDate = koreaDateValue(3);
const mixedMidDate = koreaDateValue(4);
const outOfRangeDate = koreaDateValue(30);

function weatherItems(date = forecastDate.replaceAll("-", "")) {
  const slot = (time, values) => Object.entries(values).map(([category, fcstValue]) => ({
    baseDate: "20260814",
    baseTime: "1100",
    category,
    fcstDate: date,
    fcstTime: time,
    fcstValue: String(fcstValue),
    nx: 57,
    ny: 74,
  }));
  return [
    ...slot("1200", { TMP: 29, POP: 70, PTY: 1, SKY: 4, PCP: "1.0mm", REH: 80, WSD: 2 }),
    ...slot("1800", { TMP: 26, POP: 80, PTY: 4, SKY: 4, PCP: "3.0mm", REH: 85, WSD: 3 }),
  ];
}

function payload(items = weatherItems()) {
  return {
    response: {
      header: { resultCode: "00", resultMsg: "NORMAL_SERVICE" },
      body: { dataType: "JSON", items: { item: items }, pageNo: 1, numOfRows: 2000, totalCount: items.length },
    },
  };
}

function midLandItem() {
  const item = { regId: "11F20000" };
  for (let day = 3; day <= 7; day += 1) {
    item[`wf${day}Am`] = "구름많음";
    item[`wf${day}Pm`] = "흐리고 비";
    item[`rnSt${day}Am`] = 30;
    item[`rnSt${day}Pm`] = 70;
  }
  for (let day = 8; day <= 10; day += 1) {
    item[`wf${day}`] = "흐리고 비";
    item[`rnSt${day}`] = 70;
  }
  return item;
}

function midTemperatureItem() {
  const item = { regId: "11F20501" };
  for (let day = 3; day <= 10; day += 1) {
    item[`taMin${day}`] = 23;
    item[`taMax${day}`] = 31;
  }
  return item;
}

async function mockMidForecast(page) {
  await page.route("**/api/weather/mid-land?**", (route) => route.fulfill({
    status: 200,
    contentType: "application/json",
    body: JSON.stringify(payload([midLandItem()])),
  }));
  await page.route("**/api/weather/mid-temperature?**", (route) => route.fulfill({
    status: 200,
    contentType: "application/json",
    body: JSON.stringify(payload([midTemperatureItem()])),
  }));
}

async function waitForServer() {
  for (let attempt = 0; attempt < 50; attempt += 1) {
    const listening = await new Promise((resolve) => {
      const socket = net.createConnection({ host: "127.0.0.1", port });
      socket.once("connect", () => {
        socket.destroy();
        resolve(true);
      });
      socket.once("error", () => resolve(false));
    });
    if (listening) return;
    await new Promise((resolve) => setTimeout(resolve, 100));
  }
  throw new Error("테스트 서버가 시작되지 않았습니다.");
}

async function setTripDate(page, date) {
  await page.locator("#travelDate").fill(date);
  await page.locator("#endDate").fill(date);
  await page.locator("#travelDate").dispatchEvent("change");
  await page.locator("#endDate").dispatchEvent("change");
}

async function setTripRange(page, startDate, endDate) {
  await page.locator("#travelDate").fill(startDate);
  await page.locator("#endDate").fill(endDate);
  await page.locator("#travelDate").dispatchEvent("change");
  await page.locator("#endDate").dispatchEvent("change");
}

async function openApp(page) {
  await page.goto(baseUrl, { waitUntil: "domcontentloaded" });
  await page.locator("#startButton").click();
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("관광지"));
}

test("브라우저에서 실제 날씨 흐름·실내 우선·오류 안내를 검증한다", async () => {
  const server = spawn("powershell", [
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", path.join(root, "start_server.ps1"),
    "-NoBrowser",
    "-Port", String(port),
    "-EnvFile", path.join(root, "tmp", "browser-test-no-key.env"),
  ], { cwd: root, windowsHide: true, stdio: "ignore" });
  let browser;
  try {
    await waitForServer();
    assert.ok(browserExecutable, "Edge 또는 Chrome 실행 파일이 필요합니다.");
    browser = await chromium.launch({ headless: true, executablePath: browserExecutable });

    const successPage = await browser.newPage();
    const browserErrors = [];
    successPage.on("pageerror", (error) => browserErrors.push(error.message));
    successPage.on("console", (message) => {
      if (message.type() === "error") browserErrors.push(message.text());
    });
    successPage.on("requestfailed", (request) => {
      browserErrors.push(`${request.url()} ${request.failure()?.errorText || "request failed"}`);
    });
    await successPage.route("**/api/weather?**", (route) => route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(payload()),
    }));
    await openApp(successPage);
    await setTripDate(successPage, forecastDate);
    await successPage.locator("#recommendButton").click();
    await successPage.locator("#resultView.active").waitFor({ timeout: 10000 });
    try {
      await successPage.waitForFunction(
        () => document.querySelector("#weatherFieldStatus")?.textContent.includes("강수형태 비"),
        null,
        { timeout: 5000 },
      );
    } catch {
      const currentStatus = await successPage.locator("#weatherFieldStatus").textContent();
      const dataStatus = await successPage.locator("#dataStatus").textContent();
      const formState = await successPage.evaluate(() => ({
        date: document.querySelector("#travelDate")?.value,
        endDate: document.querySelector("#endDate")?.value,
        disabled: document.querySelector("#recommendButton")?.disabled,
      }));
      assert.fail(`날씨 상태가 갱신되지 않았습니다: ${currentStatus} / data=${dataStatus} / form=${JSON.stringify(formState)} / ${browserErrors.join(" | ")}`);
    }
    const fieldStatus = await successPage.locator("#weatherFieldStatus").textContent();
    assert.match(fieldStatus, /12시.*29℃.*강수확률 70%.*강수형태 비/);
    assert.match(fieldStatus, /18시.*26℃.*강수확률 80%.*강수형태 소나기/);

    const briefing = await successPage.locator("#weatherBriefing").textContent();
    assert.match(briefing, /12시.*강수확률 70%.*강수형태 비/);
    assert.match(briefing, /18시.*강수확률 80%.*강수형태 소나기/);
    assert.equal(
      (await successPage.locator("#weatherBriefing small").textContent()).trim(),
      "출발지 기준 · 기상청 5km 예보 반영",
    );
    assert.doesNotMatch(briefing, /격자|57\/74|조회 가능한 값만 반영/);
    const itinerary = await successPage.locator("#itineraryTimeline").textContent();
    assert.match(itinerary, /비 예보·실내 우선/);
    await successPage.close();

    const mixedPage = await browser.newPage();
    await mixedPage.route("**/api/weather?**", (route) => route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(payload(weatherItems(mixedShortDate.replaceAll("-", "")))),
    }));
    await mockMidForecast(mixedPage);
    await openApp(mixedPage);
    await setTripRange(mixedPage, mixedShortDate, mixedMidDate);
    await mixedPage.locator("#recommendButton").click();
    await mixedPage.locator("#resultView.active").waitFor({ timeout: 10000 });
    assert.match(await mixedPage.locator("#weatherBriefing strong").textContent(), /날씨예보/);
    assert.equal(
      (await mixedPage.locator("#weatherBriefing small").textContent()).trim(),
      "출발지 기준 · 기상청 5km 예보 반영",
    );
    await mixedPage.locator('#dayTabs button[data-day="1"]').click();
    assert.match(await mixedPage.locator("#weatherBriefing strong").textContent(), /날씨예보.*광주·전남/);
    const mixedBriefing = await mixedPage.locator("#weatherBriefing").textContent();
    assert.match(mixedBriefing, /오전.*오후/);
    assert.match(mixedBriefing, /최저 23℃.*최고 31℃/);
    assert.equal(
      (await mixedPage.locator("#weatherBriefing small").textContent()).trim(),
      "광주·전남 권역 기준 · 기상청 예보 반영",
    );
    assert.match(await mixedPage.locator("#itineraryTimeline").textContent(), /비 예보·실내 우선/);
    await mixedPage.close();

    const rangePage = await browser.newPage();
    await rangePage.route("**/api/weather?**", (route) => route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(payload()),
    }));
    await mockMidForecast(rangePage);
    await openApp(rangePage);
    await setTripDate(rangePage, outOfRangeDate);
    await rangePage.locator("#recommendButton").click();
    await rangePage.locator("#resultView.active").waitFor({ timeout: 10000 });
    assert.match(await rangePage.locator("#weatherFieldStatus").textContent(), /날씨를 제외한 조건으로 추천/);
    assert.match(await rangePage.locator("#weatherBriefing").textContent(), /기상청 예보 범위 밖 날짜/);
    await rangePage.close();

    const errorPage = await browser.newPage();
    await errorPage.route("**/api/weather?**", (route) => route.fulfill({
      status: 403,
      contentType: "application/json",
      body: JSON.stringify({
        OpenAPI_ServiceResponse: {
          cmmMsgHeader: {
            errMsg: "SERVICE_KEY_IS_NOT_REGISTERED_ERROR",
            returnAuthMsg: "등록되지 않은 서비스키",
            returnReasonCode: "30",
          },
        },
      }),
    }));
    await openApp(errorPage);
    await setTripDate(errorPage, forecastDate);
    await errorPage.locator("#recommendButton").click();
    await errorPage.locator("#resultView.active").waitFor({ timeout: 10000 });
    assert.match(await errorPage.locator("#weatherFieldStatus").textContent(), /등록되지 않은 서비스키/);
    assert.match(await errorPage.locator("#weatherFieldStatus").textContent(), /날씨를 제외한 조건으로 추천/);
    await errorPage.close();
  } finally {
    if (browser) await browser.close();
    server.kill();
  }
});
