import { chromium } from "file:///C:/Users/nahyun/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright/index.mjs";

const queries = process.argv.slice(2);
if (!queries.length) {
  throw new Error("조회할 음식점 이름을 하나 이상 입력하세요.");
}

const browser = await chromium.launch({
  headless: true,
  executablePath: "C:/Program Files/Google/Chrome/Application/chrome.exe",
});

try {
  const page = await browser.newPage();
  await page.goto("http://localhost:4173", { waitUntil: "domcontentloaded" });

  const results = await page.evaluate(async (restaurantQueries) => {
    const key = window.OMAEROUTE_CONFIG?.kakaoJavaScriptKey?.trim();
    if (!key) throw new Error("Kakao JavaScript 키가 설정되지 않았습니다.");

    await new Promise((resolve, reject) => {
      const script = document.createElement("script");
      script.src = `https://dapi.kakao.com/v2/maps/sdk.js?appkey=${encodeURIComponent(key)}&autoload=false&libraries=services`;
      script.onload = resolve;
      script.onerror = () => reject(new Error("Kakao Maps SDK를 불러오지 못했습니다."));
      document.head.appendChild(script);
    });
    await new Promise((resolve) => window.kakao.maps.load(resolve));

    const places = new window.kakao.maps.services.Places();
    const search = (query) => new Promise((resolve, reject) => {
      places.keywordSearch(query, (items, status) => {
        if (status === window.kakao.maps.services.Status.OK) resolve(items);
        else if (status === window.kakao.maps.services.Status.ZERO_RESULT) resolve([]);
        else reject(new Error(`${query} 장소검색 실패: ${status}`));
      });
    });

    const output = {};
    for (const query of restaurantQueries) {
      const items = await search(query);
      output[query] = items.map((item) => ({
        id: item.id,
        name: item.place_name,
        category: item.category_name,
        phone: item.phone,
        roadAddress: item.road_address_name,
        lotAddress: item.address_name,
        latitude: Number(item.y),
        longitude: Number(item.x),
        placeUrl: item.place_url,
        distance: item.distance,
      }));
    }
    return output;
  }, queries);

  console.log(JSON.stringify(results, null, 2));
} finally {
  await browser.close();
}
