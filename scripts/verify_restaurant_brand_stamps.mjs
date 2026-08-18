import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const page = await browser.newPage({ viewport: { width: 1440, height: 1000 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));
  await page.addInitScript(() => localStorage.removeItem("omaeroute_stamped_place_ids"));
  await page.goto("http://127.0.0.1:4173/?demo=route", { waitUntil: "networkidle" });
  await page.click("#startButton");
  await page.waitForSelector("#resultView.active", { timeout: 20000 });
  await page.waitForSelector(".stamp-seal.restaurant-brand-stamp", { timeout: 10000 });

  const before = await page.evaluate(() => {
    const button = document.querySelector(".stamp-seal.restaurant-brand-stamp");
    const item = button?.closest(".stamp-item");
    const art = button?.querySelector(".restaurant-brand-stamp-art");
    return {
      id: button?.dataset.stampId || "",
      placeName: item?.querySelector(".stamp-place-name")?.textContent.trim() || "",
      wordmark: button?.querySelector(".restaurant-brand-stamp-wordmark b")?.textContent.trim() || "",
      title: button?.title || "",
      filter: art ? getComputedStyle(art).filter : "",
      opacity: art ? getComputedStyle(art).opacity : "",
      isTraditionalPattern: button?.classList.contains("traditional-pattern-stamp") || false,
    };
  });

  if (!before.id || !before.wordmark) throw new Error("음식점 이름 기반 스탬프가 렌더링되지 않았습니다.");
  if (before.isTraditionalPattern) throw new Error("음식점에 전통 문양 스탬프가 함께 적용됐습니다.");
  if (!before.title.includes("음식점 이름 기반 스탬프")) throw new Error(`음식점 스탬프 출처 안내가 없습니다: ${before.title}`);
  if (!before.filter.includes("grayscale")) throw new Error(`획득 전 음식점 스탬프가 흑백이 아닙니다: ${before.filter}`);

  await page.selectOption("#stampLocationSelect", before.id);
  const button = page.locator(`.stamp-seal[data-stamp-id="${before.id}"]`);
  await button.click();
  await page.waitForFunction((stampId) => {
    return document.querySelector(`.stamp-seal[data-stamp-id="${CSS.escape(stampId)}"]`)?.classList.contains("unlocked");
  }, before.id);

  const after = await page.evaluate((stampId) => {
    const unlocked = document.querySelector(`.stamp-seal[data-stamp-id="${CSS.escape(stampId)}"]`);
    const art = unlocked?.querySelector(".restaurant-brand-stamp-art");
    return {
      unlocked: unlocked?.classList.contains("unlocked") || false,
      disabled: unlocked?.disabled || false,
      state: unlocked?.querySelector(".restaurant-brand-stamp-state")?.textContent.trim() || "",
      filter: art ? getComputedStyle(art).filter : "",
      opacity: art ? getComputedStyle(art).opacity : "",
    };
  }, before.id);

  if (!after.unlocked || !after.disabled || after.state !== "스탬프 획득") {
    throw new Error(`음식점 스탬프 획득 상태가 잘못됐습니다: ${JSON.stringify(after)}`);
  }
  if (after.filter !== "none" || after.opacity !== "1") {
    throw new Error(`획득 후 음식점 상표가 선명하지 않습니다: ${JSON.stringify(after)}`);
  }
  if (browserErrors.length) throw new Error(`브라우저 오류: ${browserErrors.join(" | ")}`);

  await page.screenshot({ path: "outputs/ui_restaurant_brand_stamps.png", fullPage: true });
  console.log(JSON.stringify({ before, after }, null, 2));
} finally {
  await browser.close();
}
