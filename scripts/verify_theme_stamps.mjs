import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const baseUrl = process.env.OMAE_ROUTE_URL || "http://127.0.0.1:4173";
const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const page = await browser.newPage({ viewport: { width: 1440, height: 1050 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));
  await page.addInitScript(() => localStorage.removeItem("omaeroute_stamped_place_ids"));
  await page.goto(`${baseUrl}/?demo=route`, { waitUntil: "networkidle" });
  await page.click("#startButton");
  await page.waitForSelector("#resultView.active", { timeout: 20000 });
  await page.waitForSelector(".stamp-seal.theme-stamp", { timeout: 10000 });

  const before = await page.evaluate(() => {
    const allButtons = [...document.querySelectorAll(".stamp-seal")];
    const themeButtons = allButtons.filter((button) => button.classList.contains("theme-stamp"));
    const foodButtons = themeButtons.filter((button) => button.dataset.stampTheme === "food");
    const themes = Object.fromEntries([...new Set(themeButtons.map((button) => button.dataset.stampTheme))]
      .map((theme) => [theme, themeButtons.filter((button) => button.dataset.stampTheme === theme).length]));
    return {
      stampCount: allButtons.length,
      themeCount: themeButtons.length,
      themes,
      invalidClassCount: allButtons.filter((button) =>
        button.classList.contains("restaurant-brand-stamp")
        || button.classList.contains("traditional-pattern-stamp")).length,
      nonThemeCount: allButtons.filter((button) =>
        !button.classList.contains("theme-stamp")
        && !button.classList.contains("champions-field-stamp")).length,
      foodCount: foodButtons.length,
      foodAssets: [...new Set(foodButtons.map((button) =>
        button.querySelector(".theme-stamp-template")?.getAttribute("src")))],
      templateImagesLoaded: themeButtons.every((button) => {
        const image = button.querySelector(".theme-stamp-template");
        return Boolean(image?.complete && image.naturalWidth > 0);
      }),
      firstFoodId: foodButtons[0]?.dataset.stampId || "",
      firstFoodTitle: foodButtons[0]?.title || "",
      themeTitlesValid: themeButtons.every((button) => button.title.includes("테마 스탬프")),
      patternCount: themeButtons.filter((button) => button.querySelector(".theme-stamp-pattern")).length,
    };
  });

  if (!before.themeCount || before.nonThemeCount) {
    throw new Error(`챔피언스필드 외 장소가 테마 스탬프로 통일되지 않았습니다: ${JSON.stringify(before)}`);
  }
  if (before.invalidClassCount) throw new Error("기존 음식점 상표·장소별 문양 스탬프 클래스가 남아 있습니다.");
  if (!before.foodCount) throw new Error("추천 일정에 광주 미식 스탬프가 없습니다.");
  if (before.foodAssets.length !== 1 || before.foodAssets[0] !== "./assets/stamps/themes/food.svg") {
    throw new Error(`음식 스탬프 SVG가 통일되지 않았습니다: ${before.foodAssets.join(", ")}`);
  }
  if (!before.templateImagesLoaded) throw new Error("테마 스탬프 SVG 중 로드되지 않은 파일이 있습니다.");
  if (!before.firstFoodTitle.includes("광주 미식 테마 스탬프") || !before.themeTitlesValid) {
    throw new Error(`테마 스탬프 안내가 올바르지 않습니다: ${before.firstFoodTitle}`);
  }

  await page.selectOption("#stampLocationSelect", before.firstFoodId);
  const foodStamp = page.locator(`.stamp-seal[data-stamp-id="${before.firstFoodId}"]`);
  await foodStamp.click();
  await page.waitForFunction((stampId) =>
    document.querySelector(`.stamp-seal[data-stamp-id="${CSS.escape(stampId)}"]`)?.classList.contains("unlocked"),
  before.firstFoodId);

  const after = await foodStamp.evaluate((button) => ({
    unlocked: button.classList.contains("unlocked"),
    disabled: button.disabled,
    theme: button.dataset.stampTheme,
    state: button.querySelector(".theme-stamp-state")?.textContent.trim(),
    artFilter: getComputedStyle(button.querySelector(".theme-stamp-art")).filter,
    artOpacity: getComputedStyle(button.querySelector(".theme-stamp-art")).opacity,
  }));

  if (!after.unlocked || !after.disabled || after.state !== "스탬프 획득") {
    throw new Error(`테마 스탬프 획득 상태가 잘못됐습니다: ${JSON.stringify(after)}`);
  }
  if (after.artFilter !== "none" || after.artOpacity !== "1") {
    throw new Error(`획득한 테마 스탬프가 선명하지 않습니다: ${JSON.stringify(after)}`);
  }
  if (browserErrors.length) throw new Error(`브라우저 오류: ${browserErrors.join(" | ")}`);

  await page.locator("#stampGrid").screenshot({ path: "outputs/ui_theme_stamps.png" });
  console.log(JSON.stringify({ baseUrl, before, after }, null, 2));
} finally {
  await browser.close();
}
