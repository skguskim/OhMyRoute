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

  await page.goto(baseUrl, { waitUntil: "networkidle" });
  await page.evaluate(() => localStorage.removeItem("omaeroute_stamped_place_ids"));
  await page.reload({ waitUntil: "networkidle" });
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
  await page.click("#startButton");
  await page.evaluate(() => {
    const weather = document.querySelector("#weather");
    weather.value = "sunny";
    weather.dispatchEvent(new Event("change", { bubbles: true }));
  });
  await page.fill("#travelDate", "2026-08-25");
  await page.dispatchEvent("#travelDate", "change");
  await page.fill("#endDate", "2026-08-25");
  await page.dispatchEvent("#endDate", "change");
  await page.evaluate(() => {
    const slider = document.querySelector('#preferenceSliders input[data-index="5"]');
    slider.value = "90";
    slider.dispatchEvent(new Event("input", { bubbles: true }));
  });
  await page.waitForSelector("#baseballAttendancePanel:not([hidden])");
  await page.click(".baseball-attendance-toggle");
  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 20000 });

  const specialStamp = page.locator(".stamp-item:has(.champions-field-stamp)").last();
  if ((await specialStamp.count()) === 0) {
    const debugState = await page.evaluate(() => ({
      itineraryNames: [...document.querySelectorAll(".itinerary-stop h3")].map((item) => item.textContent.trim()),
      stampNames: [...document.querySelectorAll(".stamp-place-name")].map((item) => item.textContent.trim()),
      attendanceChecked: document.querySelector("#baseballAttendance")?.checked,
      attendanceStatus: document.querySelector("#baseballScheduleStatus")?.textContent.trim(),
    }));
    throw new Error(`챔피언스필드가 테스트 일정에 포함되지 않았습니다: ${JSON.stringify(debugState)}`);
  }
  await specialStamp.scrollIntoViewIfNeeded();
  await specialStamp.locator(".champions-field-stamp-image").waitFor();
  await page.waitForFunction(() => {
    const images = [...document.querySelectorAll(".champions-field-stamp-image")];
    return images.length > 0 && images.every((image) => image.complete && image.naturalWidth > 0);
  });

  const before = await specialStamp.evaluate((item) => {
    const button = item.querySelector("button[data-stamp-id]");
    const image = item.querySelector(".champions-field-stamp-image");
    return {
      id: button.dataset.stampId,
      classes: button.className,
      disabled: button.disabled,
      imageWidth: image.naturalWidth,
      imageHeight: image.naturalHeight,
      imageOpacity: getComputedStyle(image).opacity,
      imageFilter: getComputedStyle(image).filter,
      status: item.querySelector(".champions-field-stamp-state")?.textContent.trim(),
      placeName: item.querySelector(".stamp-place-name")?.textContent.trim(),
    };
  });
  await specialStamp.screenshot({ path: "outputs/ui_champions_field_stamp_before.png" });

  await page.selectOption("#stampLocationSelect", before.id);
  const readyStamp = page.locator(`button[data-stamp-id="${before.id}"]`);
  await readyStamp.waitFor();
  if (!(await readyStamp.evaluate((button) => button.classList.contains("in-range")))) {
    throw new Error("챔피언스필드 데모 위치를 선택해도 스탬프가 활성화되지 않았습니다.");
  }
  await readyStamp.click();

  const afterStamp = page.locator(`button[data-stamp-id="${before.id}"]`);
  await afterStamp.waitFor();
  const after = await afterStamp.evaluate((button) => {
    const image = button.querySelector(".champions-field-stamp-image");
    return {
      classes: button.className,
      disabled: button.disabled,
      imageOpacity: getComputedStyle(image).opacity,
      imageFilter: getComputedStyle(image).filter,
      status: button.querySelector(".champions-field-stamp-state")?.textContent.trim(),
    };
  });
  await afterStamp.locator("xpath=..").screenshot({ path: "outputs/ui_champions_field_stamp_after.png" });

  if (before.imageWidth < 900 || before.imageHeight < 600) {
    throw new Error(`첨부 이미지 크기가 다릅니다: ${before.imageWidth}x${before.imageHeight}`);
  }
  if (before.disabled || before.status !== "방문") {
    throw new Error(`획득 전 상태가 잘못되었습니다: ${JSON.stringify(before)}`);
  }
  if (!after.classes.includes("unlocked") || !after.disabled || after.status !== "스탬프 획득") {
    throw new Error(`획득 후 상태가 잘못되었습니다: ${JSON.stringify(after)}`);
  }
  if (after.imageOpacity !== "1" || after.imageFilter !== "none") {
    throw new Error(`획득 후 로고 표시가 선명하지 않습니다: ${JSON.stringify(after)}`);
  }
  if (browserErrors.length) {
    throw new Error(`브라우저 오류: ${browserErrors.join(" | ")}`);
  }

  console.log(JSON.stringify({ baseUrl, before, after }, null, 2));
} finally {
  await browser.close();
}
