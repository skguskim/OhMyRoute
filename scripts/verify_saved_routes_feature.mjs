import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const context = await browser.newContext({
    viewport: { width: 390, height: 844 },
    deviceScaleFactor: 1,
    geolocation: { latitude: 35.1653, longitude: 126.9096 },
    permissions: ["geolocation"],
  });
  const page = await context.newPage();
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));

  await page.goto("http://127.0.0.1:4173", { waitUntil: "networkidle" });
  await page.evaluate(() => localStorage.removeItem("omaeroute_saved_routes"));
  await page.reload({ waitUntil: "networkidle" });
  await page.click("#startButton");
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));

  const homeNavigation = await page.evaluate(() => {
    const nav = document.querySelector(".mobile-nav");
    return {
      visible: nav.getClientRects().length > 0 && getComputedStyle(nav).display !== "none",
      labels: [...nav.querySelectorAll("button")].map((button) => button.getAttribute("aria-label")),
    };
  });
  if (!homeNavigation.visible || homeNavigation.labels.join("|") !== "탐색|일정|스탬프|내 정보와 저장된 루트") {
    throw new Error(`Home navigation mismatch: ${JSON.stringify(homeNavigation)}`);
  }

  await page.fill("#endTime", "20:00");
  await page.dispatchEvent("#endTime", "change");
  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 15000 });
  const savedTitle = await page.textContent("#resultTitle");
  await page.click("#saveButton");
  await page.waitForFunction(() => document.querySelector("#saveButton")?.textContent.includes("저장됨"));

  await page.click("#menuButton");
  await page.waitForSelector("#savedDrawer.open");
  await page.waitForTimeout(350);
  const library = await page.evaluate(() => ({
    count: document.querySelector("#drawerSavedCount")?.textContent.trim(),
    items: document.querySelectorAll("#drawerSavedRoutes [data-saved-id]").length,
    navCount: document.querySelector("#savedNavCount")?.textContent.trim(),
    profileActive: document.querySelector('.mobile-nav button[data-nav="profile"]')?.classList.contains("active"),
  }));
  if (library.count !== "1개" || library.items !== 1 || library.navCount !== "1" || !library.profileActive) {
    throw new Error(`Saved route library mismatch: ${JSON.stringify(library)}`);
  }
  await page.screenshot({ path: "outputs/ui_saved_routes_mobile.png", fullPage: false });

  await page.click("#drawerSavedRoutes [data-saved-id]");
  await page.waitForFunction(() => !document.querySelector("#savedDrawer")?.classList.contains("open"));
  await page.waitForSelector("#resultView.active");
  const restoredTitle = await page.textContent("#resultTitle");
  if (restoredTitle !== savedTitle) {
    throw new Error(`Saved route restore mismatch: ${JSON.stringify({ savedTitle, restoredTitle })}`);
  }

  await page.setViewportSize({ width: 1200, height: 850 });
  const resultDesktopEntryVisible = await page.locator("#toolbarSavedRoutesButton").isVisible();
  if (!resultDesktopEntryVisible) throw new Error("Desktop result saved-list button is hidden");
  await page.click("#backButton");
  await page.waitForSelector("#formView.active");
  const homeDesktopEntryVisible = await page.locator("#menuButton").isVisible();
  if (!homeDesktopEntryVisible) throw new Error("Desktop home hamburger button is hidden");
  await page.click("#menuButton");
  await page.waitForSelector("#savedDrawer.open");
  await page.click("#closeDrawerButton");

  if (browserErrors.length) throw new Error(`Browser errors: ${JSON.stringify(browserErrors)}`);
  console.log("Saved routes check:", {
    homeNavigation,
    library,
    restoredTitle,
    resultDesktopEntryVisible,
    homeDesktopEntryVisible,
  });
} finally {
  await browser.close();
}
