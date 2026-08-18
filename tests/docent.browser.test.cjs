const test = require("node:test");
const assert = require("node:assert/strict");
const { spawn } = require("node:child_process");
const fs = require("node:fs");
const http = require("node:http");
const net = require("node:net");
const path = require("node:path");
const { chromium } = require("playwright");

const root = path.resolve(__dirname, "..");
const browserExecutable = [
  process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE,
  "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
  "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
].filter(Boolean).find((candidate) => fs.existsSync(candidate));

async function getFreePort() {
  const server = net.createServer();
  await new Promise((resolve, reject) => {
    server.once("error", reject);
    server.listen(0, "127.0.0.1", resolve);
  });
  const { port } = server.address();
  await new Promise((resolve) => server.close(resolve));
  return port;
}

async function waitForServer(port) {
  for (let attempt = 0; attempt < 60; attempt += 1) {
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
  throw new Error(`테스트 서버(${port})가 시작되지 않았습니다.`);
}

function startAppServer(port, envFile) {
  return spawn("powershell", [
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", path.join(root, "start_server.ps1"),
    "-NoBrowser",
    "-Port", String(port),
    "-EnvFile", envFile,
  ], {
    cwd: root,
    windowsHide: true,
    stdio: "ignore",
    env: {
      ...process.env,
      AI_PROVIDER: "",
      GEMINI_API_KEY: "",
      GEMINI_MODEL: "",
      GEMINI_INTERACTIONS_URL: "",
      OPENAI_API_KEY: "",
      OPENAI_MODEL: "",
      OPENAI_RESPONSES_URL: "",
      KMA_API_SERVICE_KEY: "",
      KMA_SERVICE_KEY: "",
    },
  });
}

test("AI docent defaults to Gemini and can switch to OpenAI", async () => {
  const requests = [];
  const mockAi = http.createServer((request, response) => {
    let body = "";
    request.setEncoding("utf8");
    request.on("data", (chunk) => { body += chunk; });
    request.on("end", () => {
      const payload = JSON.parse(body);
      const provider = request.headers["x-goog-api-key"] ? "gemini" : "openai";
      requests.push({ provider, headers: request.headers, payload });
      if (String(payload.input).includes("요청 제한")) {
        response.writeHead(429, { "Content-Type": "application/json" });
        response.end(JSON.stringify({ error: { message: "rate limited" } }));
        return;
      }

      response.writeHead(200, { "Content-Type": "application/json" });
      if (provider === "gemini") {
        response.end(JSON.stringify({
          id: "int_docent_test",
          model: "gemini-3.6-flash-test",
          status: "completed",
          steps: [{
            type: "model_output",
            status: "done",
            content: [{
              type: "text",
              text: "첫 장소는 현재 일정에 포함된 광주 여행지입니다. 저장된 장소 설명을 기준으로 차분히 둘러보세요.",
            }],
          }],
        }));
        return;
      }

      response.end(JSON.stringify({
        id: "resp_docent_test",
        model: "gpt-5.4-mini-test",
        output: [{
          type: "message",
          role: "assistant",
          content: [{
            type: "output_text",
            text: "OpenAI 제공자 전환도 정상적으로 동작합니다.",
          }],
        }],
      }));
    });
  });

  const envPath = path.join(root, "tmp", "docent-browser-test.env");
  const openAiEnvPath = path.join(root, "tmp", "docent-openai-test.env");
  const noKeyEnvPath = path.join(root, "tmp", "docent-no-key-test.env");
  await new Promise((resolve) => mockAi.listen(0, "127.0.0.1", resolve));
  const upstreamPort = mockAi.address().port;
  const appPort = await getFreePort();
  const openAiPort = await getFreePort();
  const noKeyPort = await getFreePort();
  const baseUrl = `http://localhost:${appPort}`;
  fs.mkdirSync(path.dirname(envPath), { recursive: true });
  fs.writeFileSync(envPath, [
    "AI_PROVIDER=gemini",
    "GEMINI_API_KEY=test-gemini-key",
    "GEMINI_MODEL=gemini-3.6-flash-test",
    `GEMINI_INTERACTIONS_URL=http://127.0.0.1:${upstreamPort}/v1beta/interactions`,
    "KMA_API_SERVICE_KEY=",
    "",
  ].join("\n"), "utf8");
  fs.writeFileSync(openAiEnvPath, [
    "AI_PROVIDER=openai",
    "OPENAI_API_KEY=test-openai-key",
    "OPENAI_MODEL=gpt-5.4-mini-test",
    `OPENAI_RESPONSES_URL=http://127.0.0.1:${upstreamPort}/v1/responses`,
    "KMA_API_SERVICE_KEY=",
    "",
  ].join("\n"), "utf8");
  fs.writeFileSync(noKeyEnvPath, [
    "AI_PROVIDER=gemini",
    "GEMINI_API_KEY=",
    "KMA_API_SERVICE_KEY=",
    "",
  ].join("\n"), "utf8");

  const appServer = startAppServer(appPort, envPath);
  let openAiServer;
  let noKeyServer;
  let browser;
  try {
    await waitForServer(appPort);
    openAiServer = startAppServer(openAiPort, openAiEnvPath);
    noKeyServer = startAppServer(noKeyPort, noKeyEnvPath);
    await Promise.all([waitForServer(openAiPort), waitForServer(noKeyPort)]);

    assert.ok(browserExecutable, "Edge 또는 Chrome 실행 파일이 필요합니다.");
    browser = await chromium.launch({ headless: true, executablePath: browserExecutable });
    const page = await browser.newPage();
    await page.goto(baseUrl, { waitUntil: "domcontentloaded" });
    await page.locator("#startButton").click();
    await page.waitForFunction(() => document.querySelector("#dataStatus")?.textContent.includes("관광지"));
    await page.locator("#recommendButton").click();
    await page.locator("#resultView.active").waitFor({ timeout: 12000 });

    await page.locator("#aiDocentButton").click();
    assert.match(await page.locator("#aiDocentChat").textContent(), /가장 가까운 여행지/);
    await page.locator("#aiDocentInput").fill("첫 번째 장소의 특징을 알려줘");
    await page.locator("#aiDocentSendButton").click();
    await page.waitForFunction(
      () => document.querySelector("#aiDocentChat")?.textContent.includes("저장된 장소 설명을 기준으로"),
      null,
      { timeout: 8000 },
    );
    assert.match(await page.locator("#aiDocentStatus").textContent(), /Gemini · gemini-3\.6-flash-test/);

    assert.equal(requests.length, 1);
    assert.equal(requests[0].provider, "gemini");
    assert.equal(requests[0].headers["x-goog-api-key"], "test-gemini-key");
    assert.equal(requests[0].headers.authorization, undefined);
    assert.equal(requests[0].payload.model, "gemini-3.6-flash-test");
    assert.equal(requests[0].payload.store, false);
    assert.equal(requests[0].payload.generation_config.max_output_tokens, 500);
    assert.match(requests[0].payload.system_instruction, /확인되지 않은 운영시간/);
    assert.match(requests[0].payload.input, /route_days/);
    assert.match(requests[0].payload.input, /첫 번째 장소의 특징/);

    await page.locator("#aiDocentInput").fill("요청 제한 테스트");
    await page.locator("#aiDocentSendButton").click();
    await page.waitForFunction(
      () => document.querySelector("#aiDocentChat")?.textContent.includes("요청이 잠시 몰렸습니다"),
      null,
      { timeout: 8000 },
    );
    assert.match(await page.locator("#aiDocentStatus").textContent(), /연결을 확인/);

    const invalidResponse = await fetch(`${baseUrl}/api/docent`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message: "" }),
    });
    assert.equal(invalidResponse.status, 400);
    assert.equal((await invalidResponse.json()).error.code, "DOCENT_INVALID_MESSAGE");

    const openAiResponse = await fetch(`http://localhost:${openAiPort}/api/docent`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        message: "OpenAI 전환 확인",
        context: { route_days: [] },
        history: [],
      }),
    });
    assert.equal(openAiResponse.status, 200);
    const openAiBody = await openAiResponse.json();
    assert.equal(openAiBody.provider, "OpenAI");
    assert.equal(openAiBody.model, "gpt-5.4-mini-test");
    assert.equal(openAiBody.answer, "OpenAI 제공자 전환도 정상적으로 동작합니다.");

    const openAiRequest = requests.find((item) => item.provider === "openai");
    assert.ok(openAiRequest);
    assert.equal(openAiRequest.headers.authorization, "Bearer test-openai-key");
    assert.equal(openAiRequest.headers["x-goog-api-key"], undefined);
    assert.equal(openAiRequest.payload.model, "gpt-5.4-mini-test");
    assert.equal(openAiRequest.payload.store, false);
    assert.match(openAiRequest.payload.instructions, /확인되지 않은 운영시간/);
    assert.match(openAiRequest.payload.input, /OpenAI 전환 확인/);

    const noKeyResponse = await fetch(`http://localhost:${noKeyPort}/api/docent`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message: "안녕" }),
    });
    assert.equal(noKeyResponse.status, 503);
    assert.equal((await noKeyResponse.json()).error.code, "AI_KEY_MISSING");
  } finally {
    if (browser) await browser.close();
    appServer.kill();
    if (openAiServer) openAiServer.kill();
    if (noKeyServer) noKeyServer.kill();
    await new Promise((resolve) => mockAi.close(resolve));
    fs.rmSync(envPath, { force: true });
    fs.rmSync(openAiEnvPath, { force: true });
    fs.rmSync(noKeyEnvPath, { force: true });
  }
});
