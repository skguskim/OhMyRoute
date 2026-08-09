import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const context = await browser.newContext({
    viewport: { width: 1440, height: 1000 },
    deviceScaleFactor: 1,
    geolocation: { latitude: 35.1653, longitude: 126.9096 },
    permissions: ["geolocation"],
  });
  const page = await context.newPage();
  await page.goto("http://127.0.0.1:4173", { waitUntil: "networkidle" });
  await page.waitForSelector("#splashView:not(.dismissed)");
  await page.screenshot({ path: "outputs/ui_splash_desktop.png", fullPage: false });
  await page.click("#startButton");
  await page.waitForSelector("#splashView.dismissed");
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
  const typography = await page.evaluate(() => {
    const selectors = [
      "body",
      "#formTitle",
      ".card-heading h2",
      "#origin",
      "#recommendButton",
    ];

    return Object.fromEntries(
      selectors.map((selector) => [
        selector,
        getComputedStyle(document.querySelector(selector)).fontFamily,
      ]),
    );
  });

  const mismatchedTypography = Object.entries(typography).filter(
    ([, fontFamily]) => !fontFamily.includes("Pretendard"),
  );

  if (mismatchedTypography.length > 0) {
    throw new Error(`Pretendard typography mismatch: ${JSON.stringify(mismatchedTypography)}`);
  }

  console.log("Typography check:", typography);
  await page.screenshot({ path: "outputs/ui_input_desktop.png", fullPage: true });

  const formLayout = await page.evaluate(() => {
    const isVisible = (selector) => {
      const element = document.querySelector(selector);
      return Boolean(
        element &&
        element.getClientRects().length > 0 &&
        getComputedStyle(element).visibility !== "hidden"
      );
    };
    const button = document.querySelector("#recommendButton");
    return {
      headerVisible: isVisible(".app-header"),
      promptVisible: isVisible(".prompt-card"),
      engineVisible: isVisible(".engine-card"),
      buttonDisplay: getComputedStyle(button).display,
      buttonHeight: Math.round(button.getBoundingClientRect().height),
    };
  });

  if (
    !formLayout.headerVisible ||
    formLayout.promptVisible ||
    formLayout.engineVisible ||
    formLayout.buttonDisplay !== "flex" ||
    formLayout.buttonHeight !== 68
  ) {
    throw new Error(`Reference form layout mismatch: ${JSON.stringify(formLayout)}`);
  }
  console.log("Reference form layout check:", formLayout);

  await page.setViewportSize({ width: 390, height: 844 });
  await page.waitForTimeout(300);
  await page.screenshot({ path: "outputs/ui_input_mobile.png", fullPage: true });
  await page.setViewportSize({ width: 1440, height: 1000 });
  await page.waitForTimeout(300);

  await page.fill("#endTime", "20:00");
  await page.dispatchEvent("#endTime", "change");
  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 15000 });
  await page.waitForTimeout(1200);
  const desktopMapSeparation = await page.evaluate(() => {
    const preview = document.querySelector("#previewScene").getBoundingClientRect();
    const mapCard = document.querySelector(".result-map-pane > .map-card").getBoundingClientRect();
    const mapFrame = document.querySelector(".result-map-pane .map-frame").getBoundingClientRect();
    return {
      previewBottom: Math.round(preview.bottom),
      mapTop: Math.round(mapCard.top),
      mapFrameHeight: Math.round(mapFrame.height),
    };
  });
  if (desktopMapSeparation.previewBottom > desktopMapSeparation.mapTop || desktopMapSeparation.mapFrameHeight < 280) {
    throw new Error(`Desktop preview/map overlap: ${JSON.stringify(desktopMapSeparation)}`);
  }
  console.log("Desktop preview/map separation:", desktopMapSeparation);
  await page.screenshot({ path: "outputs/ui_result_desktop.png", fullPage: false });

  await page.setViewportSize({ width: 390, height: 844 });
  await page.waitForTimeout(500);
  const mobileResultLayout = await page.evaluate(() => ({
    summaryBottom: Math.round(document.querySelector(".result-hero-card").getBoundingClientRect().bottom),
    mapTop: Math.round(document.querySelector(".result-map-pane").getBoundingClientRect().top),
    itineraryTop: Math.round(document.querySelector(".itinerary-card").getBoundingClientRect().top),
    previewBottom: Math.round(document.querySelector("#previewScene").getBoundingClientRect().bottom),
    mapCardTop: Math.round(document.querySelector(".result-map-pane > .map-card").getBoundingClientRect().top),
    mapFrameHeight: Math.round(document.querySelector(".result-map-pane .map-frame").getBoundingClientRect().height),
    resultStatsExists: Boolean(document.querySelector("#resultStats")),
  }));
  if (
    mobileResultLayout.mapTop < mobileResultLayout.summaryBottom ||
    mobileResultLayout.mapTop >= mobileResultLayout.itineraryTop ||
    mobileResultLayout.previewBottom > mobileResultLayout.mapCardTop ||
    mobileResultLayout.mapFrameHeight < 320 ||
    mobileResultLayout.resultStatsExists
  ) {
    throw new Error(`Mobile result order mismatch: ${JSON.stringify(mobileResultLayout)}`);
  }
  console.log("Mobile result order check:", mobileResultLayout);
  await page.screenshot({ path: "outputs/ui_result_mobile.png", fullPage: true });
} finally {
  await browser.close();
}
