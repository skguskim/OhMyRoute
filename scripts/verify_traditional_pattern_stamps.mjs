import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const page = await browser.newPage({ viewport: { width: 1440, height: 1000 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));
  await page.addInitScript(() => {
    localStorage.removeItem("omaeroute_stamped_place_ids");
  });
  await page.goto("http://127.0.0.1:4173/?demo=route", { waitUntil: "networkidle" });
  await page.click("#startButton");
  await page.waitForSelector("#resultView.active", { timeout: 20000 });
  await page.waitForSelector(".stamp-seal.traditional-pattern-stamp", { timeout: 10000 });

  const before = await page.evaluate(() => {
    const buttons = [...document.querySelectorAll(".stamp-seal.traditional-pattern-stamp")];
    const first = buttons[0];
    const image = first?.querySelector(".traditional-pattern-stamp-image");
    return {
      stampCount: document.querySelectorAll(".stamp-item").length,
      traditionalCount: buttons.length,
      firstId: first?.dataset.stampId || "",
      title: first?.getAttribute("title") || "",
      imageLoaded: Boolean(image?.complete && image.naturalWidth > 0),
      imageWidth: image?.naturalWidth || 0,
      filter: image ? getComputedStyle(image).filter : "",
      opacity: image ? getComputedStyle(image).opacity : "",
    };
  });

  if (!before.traditionalCount) throw new Error("전통 문양 스탬프가 렌더링되지 않았습니다.");
  if (!before.imageLoaded) throw new Error("전통 문양 이미지가 로드되지 않았습니다.");
  if (!before.title.includes("AI Hub 전통 문양")) throw new Error("전통 문양 출처 툴팁이 없습니다.");
  if (!before.filter.includes("grayscale")) throw new Error(`잠금 상태 흑백 필터가 없습니다: ${before.filter}`);

  await page.selectOption("#stampLocationSelect", before.firstId);
  const firstButton = page.locator(`.stamp-seal[data-stamp-id="${before.firstId}"]`);
  await firstButton.click();
  await page.waitForFunction((stampId) => {
    return document.querySelector(`.stamp-seal[data-stamp-id="${CSS.escape(stampId)}"]`)?.classList.contains("unlocked");
  }, before.firstId);

  const after = await page.evaluate((stampId) => {
    const button = [...document.querySelectorAll(".stamp-seal")]
      .find((item) => item.dataset.stampId === stampId);
    const image = button?.querySelector(".traditional-pattern-stamp-image");
    return {
      unlocked: button?.classList.contains("unlocked") || false,
      disabled: button?.disabled || false,
      state: button?.querySelector(".traditional-pattern-stamp-state")?.textContent.trim() || "",
      filter: image ? getComputedStyle(image).filter : "",
      progress: document.querySelector("#stampProgressText")?.textContent.trim() || "",
    };
  }, before.firstId);

  if (!after.unlocked || !after.disabled) throw new Error("문양 스탬프 획득 상태가 적용되지 않았습니다.");
  if (after.state !== "스탬프 획득") throw new Error(`획득 문구가 다릅니다: ${after.state}`);
  if (after.filter.includes("grayscale(1)")) throw new Error(`획득 후에도 흑백 상태입니다: ${after.filter}`);
  if (!after.progress.startsWith("1 /")) throw new Error(`스탬프 진행률이 갱신되지 않았습니다: ${after.progress}`);
  if (browserErrors.length) throw new Error(`브라우저 오류: ${browserErrors.join(" | ")}`);

  await page.screenshot({ path: "outputs/ui_traditional_pattern_stamps.png", fullPage: true });
  console.log(JSON.stringify({ before, after }, null, 2));
} finally {
  await browser.close();
}
