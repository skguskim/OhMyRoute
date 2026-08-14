import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

async function runScenario(date, expected) {
  const page = await browser.newPage({ viewport: { width: 1440, height: 1000 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));

  await page.goto("http://127.0.0.1:4173", { waitUntil: "networkidle" });
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
  await page.click("#startButton");
  await page.evaluate(() => {
    const weather = document.querySelector("#weather");
    weather.value = "sunny";
    weather.dispatchEvent(new Event("change", { bubbles: true }));
  });

  await page.fill("#travelDate", date);
  await page.dispatchEvent("#travelDate", "change");
  await page.fill("#endDate", date);
  await page.dispatchEvent("#endDate", "change");
  await page.evaluate(() => {
    const slider = document.querySelector('#preferenceSliders input[data-index="5"]');
    slider.value = "90";
    slider.dispatchEvent(new Event("input", { bubbles: true }));
  });
  await page.waitForSelector("#baseballAttendancePanel:not([hidden])");
  await page.click(".baseball-attendance-toggle");

  const formState = await page.evaluate(() => ({
    sportsLevel: document.querySelector('#preferenceSliders input[data-index="5"]')
      ?.closest(".slider-row")
      ?.querySelector(".slider-level")
      ?.textContent.trim(),
    status: document.querySelector("#baseballScheduleStatus")?.textContent.trim(),
    endTime: document.querySelector("#endTime")?.value,
  }));
  if (expected.dayType === "평일") {
    await page.locator("#baseballAttendancePanel").screenshot({ path: "outputs/ui_baseball_option.png" });
  }

  await page.click("#recommendButton");
  try {
    await page.waitForSelector("#resultView.active", { timeout: 15000 });
  } catch (error) {
    const debugState = await page.evaluate(() => ({
      loading: document.querySelector("#loadingView")?.className,
      formVisible: document.querySelector("#formView")?.className,
      endTimeValidity: document.querySelector("#endTime")?.validationMessage,
      scheduleStatus: document.querySelector("#scheduleFieldStatus")?.textContent.trim(),
    }));
    throw new Error(`${date}: result did not open; ${JSON.stringify({ debugState, browserErrors })}; ${error.message}`);
  }

  const result = await page.evaluate(() => {
    const stops = [...document.querySelectorAll(".itinerary-stop")].map((stop) => ({
      time: stop.querySelector(".stop-time")?.textContent.trim(),
      name: stop.querySelector("h3")?.textContent.trim(),
      mealChips: [...stop.querySelectorAll(".meal-time-chip")].map((chip) => chip.textContent.trim()),
      game: stop.querySelector(".baseball-game-callout")?.textContent.trim() || "",
      stadiumFood: stop.querySelector(".stadium-food-callout")?.textContent.trim() || "",
    }));
    return {
      description: document.querySelector("#resultDescription")?.textContent.trim(),
      stops,
      lastStop: stops.at(-1),
      tips: [...document.querySelectorAll("#routeTips li")].map((item) => item.textContent.trim()),
    };
  });
  if (expected.dayType === "평일") {
    await page.screenshot({ path: "outputs/ui_baseball_route_weekday.png", fullPage: false });
  }

  const stadiumFoodStop = result.stops.find((stop) => stop.stadiumFood);
  const gameStop = result.stops.find((stop) => stop.game);
  const scenario = { date, formState, stadiumFoodStop, gameStop, ...result, browserErrors };

  if (formState.sportsLevel !== "매우 선호") throw new Error(`${date}: sports level did not reach very preferred`);
  if (!formState.status.includes(expected.dayType)) throw new Error(`${date}: weekday/weekend label mismatch`);
  if (!formState.status.includes(expected.gameStart)) throw new Error(`${date}: game start missing from form status`);
  if (formState.endTime !== expected.gameEnd) throw new Error(`${date}: end time was not fixed to game end`);
  if (!stadiumFoodStop?.time.includes(expected.foodStart)) throw new Error(`${date}: stadium food purchase time mismatch`);
  if (!stadiumFoodStop.mealChips.some((chip) => chip.includes("저녁 · 야구장 먹거리"))) throw new Error(`${date}: stadium dinner label missing`);
  if (!stadiumFoodStop.stadiumFood.includes("관람석에서 직관하며 식사")) throw new Error(`${date}: eat-during-game flow missing`);
  if (stadiumFoodStop.stadiumFood.includes("가격 현장 확인")) throw new Error(`${date}: a verified dinner menu should be preferred`);
  if (result.stops.filter((stop) => stop.mealChips.some((chip) => chip.includes("저녁"))).length !== 1) throw new Error(`${date}: dinner must come only from stadium food DB`);
  if (!gameStop?.time.includes(expected.gameStart)) throw new Error(`${date}: game start time mismatch`);
  if (!gameStop.game.includes(expected.gameEnd)) throw new Error(`${date}: expected game end is missing`);
  if (result.lastStop?.name !== "광주-기아 챔피언스필드 야구 직관") throw new Error(`${date}: baseball game is not the final stop`);
  if (!result.description.includes("구장 먹거리 DB에서 저녁을 골라")) throw new Error(`${date}: stadium dinner route description missing`);
  if (browserErrors.length) throw new Error(`${date}: browser errors: ${browserErrors.join(" | ")}`);

  await page.close();
  return scenario;
}

async function runMultiDayScenario() {
  const page = await browser.newPage({ viewport: { width: 1440, height: 1100 } });
  const browserErrors = [];
  page.on("pageerror", (error) => browserErrors.push(error.message));

  await page.goto("http://127.0.0.1:4173", { waitUntil: "networkidle" });
  await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("구장 먹거리 13곳"));
  await page.click("#startButton");
  await page.evaluate(() => {
    const weather = document.querySelector("#weather");
    weather.value = "sunny";
    weather.dispatchEvent(new Event("change", { bubbles: true }));
  });
  await page.fill("#travelDate", "2026-08-17");
  await page.dispatchEvent("#travelDate", "change");
  await page.fill("#endDate", "2026-08-19");
  await page.dispatchEvent("#endDate", "change");
  await page.evaluate(() => {
    const slider = document.querySelector('#preferenceSliders input[data-index="5"]');
    slider.value = "90";
    slider.dispatchEvent(new Event("input", { bubbles: true }));
  });
  await page.waitForSelector("#baseballAttendancePanel:not([hidden])");

  const beforeToggle = await page.evaluate(() => ({
    dayFieldHidden: document.querySelector("#baseballDayField")?.hidden,
    optionCount: document.querySelectorAll("#baseballDayOptions input").length,
  }));
  if (!beforeToggle.dayFieldHidden || beforeToggle.optionCount !== 0) {
    throw new Error(`date buttons must be absent before attendance is enabled: ${JSON.stringify(beforeToggle)}`);
  }

  await page.click(".baseball-attendance-toggle");
  await page.locator('.baseball-day-option:has(input[value="0"])').click();
  const firstSelection = await page.evaluate(() => ({
    dayFieldHidden: document.querySelector("#baseballDayField")?.hidden,
    selected: [...document.querySelectorAll("#baseballDayOptions input:checked")].map((input) => input.value),
  }));
  if (firstSelection.dayFieldHidden || firstSelection.selected.join(",") !== "0,2") {
    throw new Error(`multiple date selection failed: ${JSON.stringify(firstSelection)}`);
  }

  await page.click(".baseball-attendance-toggle");
  const afterToggleOff = await page.evaluate(() => ({
    dayFieldHidden: document.querySelector("#baseballDayField")?.hidden,
    optionCount: document.querySelectorAll("#baseballDayOptions input").length,
  }));
  if (!afterToggleOff.dayFieldHidden || afterToggleOff.optionCount !== 0) {
    throw new Error(`date buttons must be cleared after attendance is disabled: ${JSON.stringify(afterToggleOff)}`);
  }

  await page.click(".baseball-attendance-toggle");
  await page.locator('.baseball-day-option:has(input[value="0"])').click();
  const activeSelection = await page.evaluate(() => ({
    selected: [...document.querySelectorAll("#baseballDayOptions input:checked")].map((input) => input.value),
    endTime: document.querySelector("#endTime")?.value,
    status: document.querySelector("#baseballScheduleStatus")?.textContent.trim(),
  }));
  if (activeSelection.selected.join(",") !== "0,2") throw new Error("selected dates were not restored for route creation");
  if (activeSelection.endTime !== "22:00") throw new Error(`final game end was not applied: ${activeSelection.endTime}`);
  await page.locator("#baseballAttendancePanel").screenshot({ path: "outputs/ui_baseball_multi_day_option.png" });

  await page.click("#recommendButton");
  await page.waitForSelector("#resultView.active", { timeout: 20000 });
  const dayResults = [];
  for (const dayIndex of [0, 1, 2]) {
    await page.click(`#dayTabs button[data-day="${dayIndex}"]`);
    dayResults.push(await page.evaluate(() => ({
      gameCount: document.querySelectorAll(".baseball-game-callout").length,
      stadiumFoodCount: document.querySelectorAll(".stadium-food-callout").length,
    })));
  }
  const tips = await page.locator("#routeTips").textContent();
  if (dayResults[0].gameCount !== 1 || dayResults[0].stadiumFoodCount !== 1) throw new Error("Day 1 baseball route is missing");
  if (dayResults[1].gameCount !== 0 || dayResults[1].stadiumFoodCount !== 0) throw new Error("unselected Day 2 contains a baseball route");
  if (dayResults[2].gameCount !== 1 || dayResults[2].stadiumFoodCount !== 1) throw new Error("Day 3 baseball route is missing");
  if (!tips.includes("Day 1") || !tips.includes("Day 3")) throw new Error("multi-day baseball summary is missing");
  if (browserErrors.length) throw new Error(`browser errors: ${browserErrors.join(" | ")}`);

  await page.close();
  return { beforeToggle, firstSelection, afterToggleOff, activeSelection, dayResults };
}

try {
  const weekday = await runScenario("2026-08-17", {
    dayType: "평일",
    foodStart: "17:45",
    gameStart: "18:30",
    gameEnd: "22:00",
  });
  const weekend = await runScenario("2026-08-22", {
    dayType: "주말",
    foodStart: "17:15",
    gameStart: "18:00",
    gameEnd: "21:30",
  });
  const multiDay = await runMultiDayScenario();
  console.log(JSON.stringify({ weekday, weekend, multiDay }, null, 2));
} finally {
  await browser.close();
}
