import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});
const page = await browser.newPage();
const browserErrors = [];
page.on("pageerror", (error) => browserErrors.push(error.message));

await page.goto("http://127.0.0.1:4173", { waitUntil: "networkidle" });
await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
await page.click("#startButton");
await page.evaluate(() => {
  const sportsSlider = document.querySelector('#preferenceSliders input[data-index="5"]');
  sportsSlider.value = "90";
  sportsSlider.dispatchEvent(new Event("input", { bubbles: true }));
});
await page.fill("#endTime", "20:00");
await page.dispatchEvent("#endTime", "change");
await page.click("#recommendButton");
await page.waitForSelector("#resultView.active", { timeout: 15000 });

const result = await page.evaluate(() => ({
  dataStatus: document.querySelector("#dataStatus")?.textContent,
  sportsPreferenceLevel: document.querySelector('#preferenceSliders input[data-index="5"]')
    ?.closest(".slider-row")
    ?.querySelector(".slider-level")
    ?.textContent,
  description: document.querySelector("#resultDescription")?.textContent,
  scheduleStatus: document.querySelector("#scheduleFieldStatus")?.textContent.trim(),
  returnLink: [...document.querySelectorAll(".kakao-directions-link")].at(-1)?.textContent.trim(),
  meals: [...document.querySelectorAll(".itinerary-stop")]
    .filter((stop) => stop.querySelector(".meal-time-chip"))
    .map((stop) => ({
      time: stop.querySelector(".stop-time")?.textContent.trim(),
      meal: stop.querySelector(".meal-time-chip")?.textContent.trim(),
      name: stop.querySelector("h3")?.textContent.trim(),
      playerRecommendation: stop.querySelector(".player-recommendation")?.textContent.trim() || "",
      reason: stop.querySelector(".reason-callout")?.textContent.trim(),
    })),
  tips: [...document.querySelectorAll("#routeTips li")].map((item) => item.textContent.trim()),
}));
result.browserErrors = browserErrors;

await page.click("#backButton");
await page.evaluate(() => {
  const sportsSlider = document.querySelector('#preferenceSliders input[data-index="5"]');
  sportsSlider.value = "75";
  sportsSlider.dispatchEvent(new Event("input", { bubbles: true }));
});
await page.click("#recommendButton");
await page.waitForSelector("#resultView.active", { timeout: 15000 });
const thresholdResult = await page.evaluate(() => ({
  sportsPreferenceLevel: document.querySelector('#preferenceSliders input[data-index="5"]')
    ?.closest(".slider-row")
    ?.querySelector(".slider-level")
    ?.textContent,
  description: document.querySelector("#resultDescription")?.textContent,
  playerRecommendationLabels: [...document.querySelectorAll(".player-recommendation")]
    .map((label) => label.textContent.trim()),
  tips: [...document.querySelectorAll("#routeTips li")].map((item) => item.textContent.trim()),
}));

result.thresholdCheck = thresholdResult;

console.log(JSON.stringify(result, null, 2));
if (result.meals.length !== 2) throw new Error(`Expected lunch and dinner, got ${result.meals.length}`);
if (!result.scheduleStatus.includes("실제 일정 가능 10시간")) throw new Error("The arrival/departure window was not applied");
if (!result.returnLink.includes("출발지 복귀 길찾기")) throw new Error("The final return route is missing");
if (result.sportsPreferenceLevel !== "매우 선호") throw new Error("Sports preference is not in the very-preferred range");
if (!result.meals.every((meal) => /⚾ .+ 선수 추천$/.test(meal.playerRecommendation))) {
  throw new Error("A baseball-fan meal is missing the active-player recommendation label");
}
if (!result.meals.every((meal) => /추천 이유 · .+ 선수 추천 · 이전 지점/.test(meal.reason))) {
  throw new Error("Player recommendation reasons still include generic category labels");
}
if (result.meals.some((meal) => meal.reason.includes("시간 맞춤") || meal.reason.includes("스포츠·야구") || meal.reason.includes("음식·로컬"))) {
  throw new Error("Player recommendation reasons are not reduced to the player name");
}
if (thresholdResult.sportsPreferenceLevel === "매우 선호") throw new Error("75 must remain below the very-preferred range");
if (thresholdResult.description.includes("KIA 선수 추천 맛집을 우선")) {
  throw new Error("The player-restaurant boost was applied below the very-preferred threshold");
}
if (thresholdResult.tips.some((tip) => tip.includes("스포츠·야구 매우 선호를 반영"))) {
  throw new Error("The player-restaurant tip was shown below the very-preferred threshold");
}
if (thresholdResult.playerRecommendationLabels.length) {
  throw new Error("Player recommendation labels must be hidden below the very-preferred threshold");
}
if (browserErrors.length) throw new Error(`Browser errors: ${browserErrors.join(" | ")}`);

await browser.close();
