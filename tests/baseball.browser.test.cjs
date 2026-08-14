const test = require("node:test");
const assert = require("node:assert/strict");
const { spawn } = require("node:child_process");
const fs = require("node:fs");
const net = require("node:net");
const path = require("node:path");
const { chromium } = require("playwright");

const root = path.resolve(__dirname, "..");
const port = 4192;
const baseUrl = `http://localhost:${port}`;
const browserExecutable = [
  process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE,
  "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
].filter(Boolean).find((candidate) => fs.existsSync(candidate));

async function waitForServer() {
  for (let attempt = 0; attempt < 50; attempt += 1) {
    const listening = await new Promise((resolve) => {
      const socket = net.createConnection({ host: "127.0.0.1", port });
      socket.once("connect", () => {
        socket.destroy();
        resolve(true);
      });
      socket.once("error", () => resolve(false));
    });
    if (listening) return;
    await new Promise((resolve) => setTimeout(resolve, 100));
  }
  throw new Error("테스트 서버가 시작되지 않았습니다.");
}

async function openBaseballForm(page, startDate, endDate) {
  await page.goto(baseUrl, { waitUntil: "domcontentloaded" });
  await page.locator("#startButton").click();
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("KIA 광주 홈경기 69건"));
  const sportsSlider = page.locator('#preferenceSliders input[data-index="5"]');
  await sportsSlider.fill("100");
  await sportsSlider.dispatchEvent("input");
  await page.locator("#baseballAttendancePanel").waitFor({ state: "visible" });
  await page.evaluate(({ startDateValue, endDateValue }) => {
    const start = document.querySelector("#travelDate");
    const end = document.querySelector("#endDate");
    start.value = startDateValue;
    end.value = endDateValue;
    start.dispatchEvent(new Event("change", { bubbles: true }));
    end.value = endDateValue;
    end.dispatchEvent(new Event("change", { bubbles: true }));
  }, { startDateValue: startDate, endDateValue: endDate });
  await page.locator('label[for="baseballAttendance"]').click();
}

test("실제 KIA 광주 홈경기만 선택하고 취소·경기 없음·폭염 변경 시간을 표시한다", async () => {
  const server = spawn("powershell", [
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", path.join(root, "start_server.ps1"),
    "-NoBrowser",
    "-Port", String(port),
    "-EnvFile", path.join(root, "tmp", "browser-test-no-key.env"),
  ], { cwd: root, windowsHide: true, stdio: "ignore" });
  let browser;
  try {
    await waitForServer();
    assert.ok(browserExecutable, "Edge 또는 Chrome 실행 파일이 필요합니다.");
    browser = await chromium.launch({ headless: true, executablePath: browserExecutable });

    const homeSeriesPage = await browser.newPage();
    await openBaseballForm(homeSeriesPage, "2026-08-14", "2026-08-16");
    assert.equal(await homeSeriesPage.locator("#baseballDayOptions input:not(:disabled)").count(), 3);
    assert.equal(await homeSeriesPage.locator("#baseballDayOptions input:disabled").count(), 0);
    assert.match(await homeSeriesPage.locator("#baseballDayOptions").textContent(), /두산 vs KIA · 19:00/);
    const homeGameInputs = homeSeriesPage.locator("#baseballDayOptions input");
    for (let index = 0; index < await homeGameInputs.count(); index += 1) {
      await homeGameInputs.nth(index).check({ force: true });
    }
    assert.equal(await homeSeriesPage.locator("#baseballDayOptions input:checked").count(), 3);
    const homeStatus = await homeSeriesPage.locator("#baseballScheduleStatus").textContent();
    assert.match(homeStatus, /8월 14일.*두산 vs KIA.*19:00 경기/);
    assert.match(homeStatus, /8월 16일.*폭염 대응 시간 변경 반영/);
    assert.equal(await homeSeriesPage.locator("#endTime").inputValue(), "22:30");
    await homeSeriesPage.close();

    const awaySeriesPage = await browser.newPage();
    await openBaseballForm(awaySeriesPage, "2026-08-18", "2026-08-20");
    assert.equal(await awaySeriesPage.locator("#baseballDayOptions input:not(:disabled)").count(), 0);
    assert.equal(await awaySeriesPage.locator("#baseballDayOptions input:disabled").count(), 3);
    assert.match(await awaySeriesPage.locator("#baseballDayOptions").textContent(), /광주 홈경기 없음/);
    assert.match(await awaySeriesPage.locator("#baseballScheduleStatus").textContent(), /관람 가능한 광주 KIA 홈경기가 없습니다/);
    await awaySeriesPage.close();

    const cancelledPage = await browser.newPage();
    await openBaseballForm(cancelledPage, "2026-08-04", "2026-08-06");
    assert.equal(await cancelledPage.locator("#baseballDayOptions input:not(:disabled)").count(), 0);
    assert.equal(await cancelledPage.locator("#baseballDayOptions input:disabled").count(), 3);
    assert.match(await cancelledPage.locator("#baseballDayOptions").textContent(), /KT전 취소/);
    await cancelledPage.close();

    const septemberPage = await browser.newPage();
    await openBaseballForm(septemberPage, "2026-09-04", "2026-09-06");
    assert.equal(await septemberPage.locator("#baseballDayOptions input:not(:disabled)").count(), 3);
    assert.match(await septemberPage.locator("#baseballDayOptions").textContent(), /KT vs KIA · 19:00/);
    await septemberPage.close();
  } finally {
    if (browser) await browser.close();
    server.kill();
  }
});
