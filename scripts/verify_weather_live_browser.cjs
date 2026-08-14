const fs = require("node:fs");
const { chromium } = require("playwright");

const baseUrl = process.env.OMAEROUTE_WEATHER_VERIFY_URL || "http://localhost:4173";
const travelDate = process.env.OMAEROUTE_WEATHER_VERIFY_DATE;
const verifyKakao = process.env.OMAEROUTE_VERIFY_KAKAO === "true";
const browserExecutable = [
  process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE,
  "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
].filter(Boolean).find((candidate) => fs.existsSync(candidate));

async function main() {
  if (!travelDate) throw new Error("OMAEROUTE_WEATHER_VERIFY_DATE를 YYYY-MM-DD로 설정해주세요.");
  if (!browserExecutable) throw new Error("Edge 또는 Chrome 실행 파일을 찾지 못했습니다.");
  const browser = await chromium.launch({ headless: true, executablePath: browserExecutable });
  try {
    const page = await browser.newPage();
    const pageErrors = [];
    page.on("pageerror", (error) => pageErrors.push(error.message));
    await page.goto(baseUrl, { waitUntil: "domcontentloaded" });
    await page.locator("#startButton").click();
    await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("관광지"));
    await page.locator("#travelDate").fill(travelDate);
    await page.locator("#endDate").fill(travelDate);
    await page.locator("#travelDate").dispatchEvent("change");
    await page.locator("#endDate").dispatchEvent("change");
    await page.locator("#recommendButton").click();
    await page.locator("#resultView.active").waitFor({ timeout: 15000 });
    if (verifyKakao) {
      await page.waitForFunction(
        () => document.querySelector("#mapProviderStatus")?.textContent.includes("연결됨"),
        null,
        { timeout: 15000 },
      );
    }

    const compactText = async (selector) => (await page.locator(selector).textContent())
      .replace(/\s+/g, " ")
      .trim();
    const fieldStatus = await compactText("#weatherFieldStatus");
    const briefing = await compactText("#weatherBriefing");
    const itinerary = await compactText("#itineraryTimeline");
    const stopNames = await page.locator("#itineraryTimeline .itinerary-stop:not(.origin-stop) h3").allTextContents();
    const kakaoState = await page.evaluate(() => ({
      sdkLoaded: Boolean(window.kakao?.maps),
      status: document.querySelector("#mapProviderStatus")?.textContent.trim(),
      mapHidden: document.querySelector("#kakaoMap")?.hidden,
      fallbackHidden: document.querySelector("#routeMap")?.hidden,
      labels: document.querySelectorAll("#kakaoMap .kakao-route-label").length,
      mapChildren: document.querySelector("#kakaoMap")?.childElementCount || 0,
    }));

    if (!fieldStatus.includes("12시") || !fieldStatus.includes("18시")) {
      throw new Error(`12시·18시 실제 예보가 표시되지 않았습니다: ${fieldStatus}`);
    }
    if (fieldStatus.includes("강수형태 비") && !itinerary.includes("비 예보·실내 우선")) {
      throw new Error("비 예보인데 실내 우선 추천 근거가 일정에 없습니다.");
    }
    if (verifyKakao && (
      !kakaoState.sdkLoaded
      || kakaoState.status !== "Kakao Map 연결됨"
      || kakaoState.mapHidden
      || !kakaoState.fallbackHidden
      || kakaoState.labels < 1
      || kakaoState.mapChildren < 1
    )) {
      throw new Error(`Kakao Map 렌더링 상태가 올바르지 않습니다: ${JSON.stringify(kakaoState)}`);
    }

    console.log(`fieldStatus=${fieldStatus}`);
    console.log(`briefing=${briefing}`);
    console.log(`indoorPriority=${itinerary.includes("비 예보·실내 우선")}`);
    console.log(`stops=${stopNames.map((name) => name.trim()).join(" | ")}`);
    console.log(`kakao=${JSON.stringify(kakaoState)}`);
    if (pageErrors.length) console.log(`pageErrors=${pageErrors.join(" | ")}`);
  } finally {
    await browser.close();
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
