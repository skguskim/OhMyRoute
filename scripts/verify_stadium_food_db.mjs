import { readFile } from "node:fs/promises";

const root = new URL("../", import.meta.url);
const [places, restaurants, stadiumFoods] = await Promise.all([
  readFile(new URL("data/places.json", root), "utf8").then(JSON.parse),
  readFile(new URL("data/restaurants.json", root), "utf8").then(JSON.parse),
  readFile(new URL("data/stadium_foods.json", root), "utf8").then(JSON.parse),
]);

const errors = [];
const allIds = [...places, ...restaurants, ...stadiumFoods].map((item) => item.id);
const duplicateIds = allIds.filter((id, index) => allIds.indexOf(id) !== index);
if (duplicateIds.length) errors.push(`전역 ID 중복: ${[...new Set(duplicateIds)].join(", ")}`);
if (restaurants.some((item) => item.stadiumFood)) errors.push("restaurants.json에 stadiumFood 항목이 남아 있습니다.");

const sourcePlaceIds = new Set();
for (const [index, item] of stadiumFoods.entries()) {
  const label = `stadium_foods[${index}] ${item.name || "이름 없음"}`;
  if (!item.id) errors.push(`${label}: id 누락`);
  if (item.venueId !== "gwangju-kia-champions-field") errors.push(`${label}: venueId 오류`);
  if (!item.stadiumFood) errors.push(`${label}: stadiumFood=true 누락`);
  if (item.databaseType !== "stadium_food") errors.push(`${label}: databaseType 오류`);
  if (!item.sourcePlaceId || sourcePlaceIds.has(item.sourcePlaceId)) errors.push(`${label}: sourcePlaceId 누락 또는 중복`);
  sourcePlaceIds.add(item.sourcePlaceId);
  if (!Array.isArray(item.vector) || item.vector.length !== 8 || item.vector.some((value) => value < 0 || value > 1)) {
    errors.push(`${label}: 8축 벡터 오류`);
  }
  if (!Number.isFinite(item.latitude) || !Number.isFinite(item.longitude)) errors.push(`${label}: 좌표 누락`);
  if (item.coordinatePrecision !== "venue_centroid") errors.push(`${label}: 좌표 정밀도 표시 오류`);
  if (!Array.isArray(item.stallLocations) || !item.stallLocations.length) errors.push(`${label}: 판매 위치 누락`);
  if (!Array.isArray(item.menuItems) || !item.menuItems.length) errors.push(`${label}: 메뉴 후보 누락`);
  if (!item.recommendationSourceUrl || !item.lastVerifiedAt || !item.qualityStatus) errors.push(`${label}: 출처·검수 필드 누락`);
  if (item.verificationStatus?.startsWith("official_") && !item.recommendationSourceUrl.includes("tigers.co.kr")) {
    errors.push(`${label}: 공식 위치 검증 URL 오류`);
  }
  if (item.verificationStatus?.startsWith("official_") && item.qualityStatus !== "verified") {
    errors.push(`${label}: 공식 브랜드·위치 검증 상태 오류`);
  }
  for (const menu of item.menuItems || []) {
    if (menu.price !== null && (!Number.isFinite(menu.price) || menu.price <= 0 || !menu.priceVerifiedAt || !item.menuSourceUrl)) {
      errors.push(`${label}: 가격이 있는 메뉴의 관측일·출처 오류`);
    }
  }
  if (item.availabilityStatus === "closed" && item.routeEligible !== false) errors.push(`${label}: 폐점 상태인데 추천 가능`);
}

if (errors.length) {
  console.error(errors.map((error) => `- ${error}`).join("\n"));
  process.exitCode = 1;
} else {
  const officiallyLocated = stadiumFoods.filter((item) => item.verificationStatus?.startsWith("official_")).length;
  const fieldPriced = stadiumFoods.filter((item) => item.menuItems.some((menu) => menu.price !== null)).length;
  console.log(`PASS: 일반 음식점 ${restaurants.length}곳과 야구장 먹거리 ${stadiumFoods.length}곳이 분리되어 있습니다.`);
  console.log(`PASS: 구장 먹거리 ${officiallyLocated}곳의 브랜드와 판매 구역을 KIA 2026 공식 안내도에서 확인했습니다.`);
  console.log(`PASS: ${fieldPriced}곳은 2026 현장 메뉴판의 관측 가격과 출처를 포함합니다.`);
  console.log("NOTICE: 메뉴·가격·경기일 영업 여부는 경기 당일 재확인이 필요합니다.");
}
