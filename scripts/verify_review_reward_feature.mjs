import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const context = await browser.newContext({
    geolocation: { latitude: 35.1653, longitude: 126.9096 },
    permissions: ["geolocation"],
  });
  const page = await context.newPage();
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));

  await page.goto("http://127.0.0.1:4173", { waitUntil: "networkidle" });
  await page.evaluate(() => {
    localStorage.removeItem("omaeroute_reviews");
    localStorage.removeItem("omaeroute_rewards");
  });
  await page.reload({ waitUntil: "networkidle" });
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
  await page.click("#startButton");

  await page.fill("#endTime", "20:00");
  await page.dispatchEvent("#endTime", "change");
  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 15000 });

  const initialRewardHidden = await page.locator("#rewardCard").getAttribute("hidden");
  await page.fill("#reviewText", "동선이 자연스럽고 선수 추천 맛집 표시가 유용했어요.");
  await page.click("#reviewSubmitButton");
  await page.waitForSelector("#rewardCard:not([hidden])");

  const result = await page.evaluate(() => {
    const reviews = JSON.parse(localStorage.getItem("omaeroute_reviews") || "[]");
    const rewards = JSON.parse(localStorage.getItem("omaeroute_rewards") || "[]");
    return {
      reviewStatus: document.querySelector("#reviewStatusBadge")?.textContent.trim(),
      submitDisabled: document.querySelector("#reviewSubmitButton")?.disabled,
      submitLabel: document.querySelector("#reviewSubmitButton")?.textContent.trim(),
      rewardCode: document.querySelector("#rewardCode")?.textContent.trim(),
      rewardExpiry: document.querySelector("#rewardExpiry")?.textContent.trim(),
      reviewCount: reviews.length,
      rewardCount: rewards.length,
      savedReview: reviews[0],
      savedReward: rewards[0],
    };
  });

  await page.reload({ waitUntil: "networkidle" });
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
  await page.click("#startButton");
  await page.fill("#endTime", "20:00");
  await page.dispatchEvent("#endTime", "change");
  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 15000 });
  result.persistedAfterReload = await page.evaluate(() => ({
    reviewStatus: document.querySelector("#reviewStatusBadge")?.textContent.trim(),
    submitDisabled: document.querySelector("#reviewSubmitButton")?.disabled,
    rewardCode: document.querySelector("#rewardCode")?.textContent.trim(),
    reviewCount: JSON.parse(localStorage.getItem("omaeroute_reviews") || "[]").length,
    rewardCount: JSON.parse(localStorage.getItem("omaeroute_rewards") || "[]").length,
  }));

  result.initialRewardHidden = initialRewardHidden !== null;
  result.browserErrors = browserErrors;
  console.log(JSON.stringify(result, null, 2));

  if (!result.initialRewardHidden) throw new Error("Reward must be hidden before review submission");
  if (result.reviewStatus !== "등록 완료") throw new Error("Review completion status is missing");
  if (!result.submitDisabled) throw new Error("Duplicate review submission is not blocked");
  if (!/^OMAE-[A-Z0-9]{8}$/.test(result.rewardCode)) throw new Error("Reward code format is invalid");
  if (result.reviewCount !== 1 || result.rewardCount !== 1) throw new Error("Review/reward was not saved exactly once");
  if (!result.savedReview?.routeSummary || !result.savedReview?.preferenceVector) {
    throw new Error("Review is missing route or preference context");
  }
  if (result.savedReward?.discountPercent !== 10 || !result.savedReward?.prototype) {
    throw new Error("Reward metadata is invalid");
  }
  if (result.persistedAfterReload.reviewStatus !== "등록 완료"
    || !result.persistedAfterReload.submitDisabled
    || result.persistedAfterReload.rewardCode !== result.rewardCode
    || result.persistedAfterReload.reviewCount !== 1
    || result.persistedAfterReload.rewardCount !== 1) {
    throw new Error("Review/reward did not persist or duplicate prevention failed after reload");
  }
  if (browserErrors.length) throw new Error(`Browser errors: ${browserErrors.join(" | ")}`);
} finally {
  await browser.close();
}
