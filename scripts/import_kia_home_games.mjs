import fs from "node:fs";
import path from "node:path";

const args = process.argv.slice(2);
const sourceFiles = args.filter((arg) => !arg.startsWith("--"));
const syncedAtArg = args.find((arg) => arg.startsWith("--synced-at="));
const syncedAt = syncedAtArg?.slice("--synced-at=".length) || new Date().toISOString();
const projectRoot = path.resolve(import.meta.dirname, "..");
const jsonOutput = path.join(projectRoot, "data", "baseball_games.json");
const regularSeasonStart = "20260328";

if (!sourceFiles.length) {
  console.error("사용법: node scripts/import_kia_home_games.mjs <KIA 월별 API JSON...> [--synced-at=ISO]");
  process.exit(1);
}

function formatGameDate(value) {
  const text = String(value || "");
  if (!/^\d{8}$/.test(text)) throw new Error(`잘못된 경기 날짜: ${value}`);
  return `${text.slice(0, 4)}-${text.slice(4, 6)}-${text.slice(6, 8)}`;
}

function gameStatus(row) {
  if (row.outcome === "취" || Number(row.status) === 4) return "cancelled";
  if (String(row.endFlag) === "1" || Number(row.status) === 3) return "completed";
  return "scheduled";
}

function timeChangeReason(gameDate) {
  return gameDate >= "2026-08-11" && gameDate <= "2026-09-06"
    ? "폭염 대응 KBO 경기 시간 조정(광주 19시 시작)"
    : null;
}

const rows = sourceFiles
  .flatMap((file) => {
    const absolutePath = path.resolve(projectRoot, file);
    const payload = JSON.parse(fs.readFileSync(absolutePath, "utf8"));
    if (Number(payload?.status) !== 0 || !Array.isArray(payload?.data?.list)) {
      throw new Error(`KIA 일정 API 응답 형식이 올바르지 않습니다: ${file}`);
    }
    return payload.data.list;
  })
  .filter((row) => row.homeKey === "HT" && row.stadiumKey === "KC")
  .filter((row) => String(row.displayDate) >= regularSeasonStart)
  .map((row) => {
    const gameDate = formatGameDate(row.displayDate);
    const status = gameStatus(row);
    return {
      source: "kia_tigers_official",
      source_game_id: row.gmkey,
      league: "KBO",
      season: 2026,
      game_date: gameDate,
      scheduled_start_at: `${gameDate}T${row.gtime}:00+09:00`,
      original_scheduled_start_at: null,
      venue_code: "KC",
      venue_name: "광주-기아 챔피언스필드",
      home_team_code: "HT",
      home_team_name: "KIA",
      away_team_code: row.visitKey,
      away_team_name: row.visit,
      status,
      result: status === "completed" ? row.outcome || null : null,
      home_score: Number.isFinite(Number(row.homeScore)) && row.homeScore !== null ? Number(row.homeScore) : null,
      away_score: Number.isFinite(Number(row.visitScore)) && row.visitScore !== null ? Number(row.visitScore) : null,
      time_change_reason: timeChangeReason(gameDate),
      status_note: status === "cancelled" ? "KIA 공식 일정에서 취소로 확인" : null,
      source_url: `https://tigers.co.kr/game/schedule/major/${gameDate.replaceAll("-", "").slice(0, 6)}`,
      source_updated_at: syncedAt,
    };
  })
  .sort((a, b) => a.scheduled_start_at.localeCompare(b.scheduled_start_at));

const duplicateIds = rows
  .map((row) => row.source_game_id)
  .filter((id, index, values) => values.indexOf(id) !== index);
if (duplicateIds.length) throw new Error(`중복 경기 ID: ${[...new Set(duplicateIds)].join(", ")}`);

fs.writeFileSync(jsonOutput, `${JSON.stringify(rows, null, 2)}\n`, "utf8");

const counts = Object.groupBy(rows, (row) => row.status);
console.log(`광주 KIA 홈경기 ${rows.length}건 생성: ${jsonOutput}`);
console.log(Object.fromEntries(Object.entries(counts).map(([status, games]) => [status, games.length])));
