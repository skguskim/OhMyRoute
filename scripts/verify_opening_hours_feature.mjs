import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const BASE_URL = process.env.OMAEROUTE_OPENING_HOURS_VERIFY_URL || "http://127.0.0.1:4173";
const TARGET_PLACE = "광주광산문화원";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

async function runScenario(label, startDate, endDate) {
  const page = await browser.newPage({ viewport: { width: 1280, height: 900 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));

  await page.route("https://**/*", (route) => route.abort());
  await page.goto(BASE_URL, { waitUntil: "domcontentloaded" });
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("운영정보 2곳"));
  await page.click("#startButton");
  await page.evaluate(() => {
    const weather = document.querySelector("#weather");
    weather.value = "sunny";
    weather.dispatchEvent(new Event("change", { bubbles: true }));
  });
  await page.fill("#travelDate", startDate);
  await page.dispatchEvent("#travelDate", "change");
  await page.fill("#endDate", endDate);
  await page.dispatchEvent("#endDate", "change");
  await page.evaluate((targetPlace) => {
    const prompt = document.querySelector("#travelPrompt");
    prompt.value = `${targetPlace} 꼭 포함`;
    prompt.dispatchEvent(new Event("input", { bubbles: true }));
  }, TARGET_PLACE);

  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 15000 });
  const tabCount = await page.locator("#dayTabs button").count();
  const days = [];
  for (let dayIndex = 0; dayIndex < tabCount; dayIndex += 1) {
    await page.click(`#dayTabs button[data-day="${dayIndex}"]`);
    const names = await page.locator("#itineraryTimeline h3").allTextContents();
    days.push({
      day: dayIndex + 1,
      names,
      hasTarget: names.some((name) => name.includes(TARGET_PLACE)),
    });
  }
  const tips = await page.locator("#routeTips li").allTextContents();
  await page.close();
  return {
    label,
    startDate,
    endDate,
    days,
    tips,
    hasTarget: days.some((day) => day.hasTarget),
    browserErrors,
  };
}

try {
  const thuFri = await runScenario("목·금", "2026-08-20", "2026-08-21");
  const weekend = await runScenario("토·일", "2026-08-22", "2026-08-23");

  if (!thuFri.hasTarget) throw new Error("목·금 일정에서 평일 운영 장소가 누락됐습니다.");
  if (weekend.hasTarget) throw new Error("토·일 휴무 장소가 주말 일정에 포함됐습니다.");
  if (!weekend.tips.some((tip) => tip.includes(TARGET_PLACE) && tip.includes("휴무"))) {
    throw new Error("직접 요청한 휴무 장소의 제외 안내가 없습니다.");
  }
  const browserErrors = [...thuFri.browserErrors, ...weekend.browserErrors];
  if (browserErrors.length) throw new Error(`브라우저 오류: ${browserErrors.join(" | ")}`);

  console.log(JSON.stringify({ target: TARGET_PLACE, thuFri, weekend }, null, 2));
} finally {
  await browser.close();
}
