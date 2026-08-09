import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const videoUrl = "file:///C:/Users/nahyun/Downloads/%EB%B9%84%EB%94%94%EC%98%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.mp4";
const captureTimes = [0, 2, 5, 8, 12, 16, 20, 24, 28, 32];

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
  args: ["--allow-file-access-from-files"],
});

try {
  const page = await browser.newPage({ viewport: { width: 1600, height: 1000 } });
  await page.goto(videoUrl, { waitUntil: "load" });
  await page.evaluate(() => {
    const video = document.querySelector("video");
    video.id = "reference";
    video.muted = true;
  });

  await page.waitForFunction(() => {
    const video = document.querySelector("#reference");
    return video?.readyState >= 1 && Number.isFinite(video.duration);
  });

  const metadata = await page.evaluate(() => {
    const video = document.querySelector("#reference");
    return {
      duration: video.duration,
      width: video.videoWidth,
      height: video.videoHeight,
    };
  });
  console.log("Video metadata:", metadata);

  for (const requestedTime of captureTimes) {
    const time = Math.min(requestedTime, Math.max(0, metadata.duration - 0.05));
    await page.evaluate((nextTime) => {
      const video = document.querySelector("#reference");
      video.currentTime = nextTime;
      return new Promise((resolve) => {
        video.addEventListener("seeked", resolve, { once: true });
      });
    }, time);
    await page.locator("#reference").screenshot({
      path: `outputs/reference_video_${String(requestedTime).padStart(2, "0")}s.png`,
    });
  }
} finally {
  await browser.close();
}
