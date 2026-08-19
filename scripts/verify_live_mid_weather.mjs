import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const baseUrl = process.env.OMAE_ROUTE_URL || "http://127.0.0.1:4194";
const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

const tripDate = new Intl.DateTimeFormat("en-CA", {
  timeZone: "Asia/Seoul",
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
}).format(new Date(Date.now() + 6 * 24 * 60 * 60 * 1000));

try {
  const page = await browser.newPage({ viewport: { width: 1440, height: 1050 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));
  await page.goto(baseUrl, { waitUntil: "networkidle" });
  await page.click("#startButton");
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("관광지"));
  await page.fill("#travelDate", tripDate);
  await page.dispatchEvent("#travelDate", "change");
  await page.fill("#endDate", tripDate);
  await page.dispatchEvent("#endDate", "change");
  await page.evaluate(() => {
    const weather = document.querySelector("#weather");
    weather.value = "auto";
    weather.dispatchEvent(new Event("change", { bubbles: true }));
  });
  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 40000 });
  await page.waitForFunction(() => document.querySelector("#weatherBriefing strong")?.textContent.includes("중기예보"), null, {
    timeout: 30000,
  });

  const result = await page.evaluate(() => ({
    title: document.querySelector("#weatherBriefing strong")?.textContent.trim() || "",
    summary: document.querySelector("#weatherBriefing")?.textContent.replace(/\s+/g, " ").trim() || "",
    source: document.querySelector("#weatherBriefing small")?.textContent.trim() || "",
    routeReasons: [...document.querySelectorAll(".reason-chip")].map((item) => item.textContent.trim()),
  }));
  if (!result.title.includes("기상청 중기예보")) throw new Error(`중기예보 제목이 없습니다: ${result.title}`);
  if (!result.summary.includes("오전") || !result.summary.includes("오후")) {
    throw new Error(`중기예보 오전·오후 데이터가 없습니다: ${result.summary}`);
  }
  if (!result.summary.includes("최저") || !result.summary.includes("최고")) {
    throw new Error(`중기기온 데이터가 없습니다: ${result.summary}`);
  }
  if (result.source !== "광주·전남 권역 기준 · 기상청 중기예보 반영") {
    throw new Error(`중기예보 출처 문구가 다릅니다: ${result.source}`);
  }
  if (browserErrors.length) throw new Error(`브라우저 오류: ${browserErrors.join(" | ")}`);

  await page.screenshot({ path: "outputs/ui_mid_weather_live.png", fullPage: false });
  console.log(JSON.stringify({ baseUrl, tripDate, result }, null, 2));
} finally {
  await browser.close();
}
