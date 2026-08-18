import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parents[3]
DATA_DIR = BASE_DIR / "data" / "generated"
# tourapi, gwangju_official 중 선택
PREFIX = "gwangju_official"

CSV_LIST = ["places", "place_profiles", "operating_info_review"]

def remove_non_overlapping_rows(file_a_path: str | Path, file_b_path: str | Path, output_path: str | Path) -> None:
    """두 CSV 파일을 비교하여 source_place_id가 겹치지 않는 행을 제거하고 저장합니다."""
    path_a = Path(file_a_path)
    path_b = Path(file_b_path)
    out_path = Path(output_path)

    df_a = pd.read_csv(path_a, dtype=str)
    df_b = pd.read_csv(path_b, dtype=str)

    if "source_place_id" not in df_a.columns or "source_place_id" not in df_b.columns:
        raise KeyError("두 CSV 파일 모두 'source_place_id' 컬럼이 존재해야 합니다.")

    # [수정] ID 형태 유지를 위해 문자열 변환 후 앞뒤 공백 완전 제거
    df_a["source_place_id"] = df_a["source_place_id"].astype(str).str.strip()
    df_b["source_place_id"] = df_b["source_place_id"].astype(str).str.strip()

    # 교집합 및 누락 데이터 디버깅을 위해 Set 구조로 추출
    set_a = set(df_a["source_place_id"])
    set_b = set(df_b["source_place_id"])
    common_ids = set_a.intersection(set_b)
    
    # 기존 데이터(A)에는 있지만 새 데이터(B)에는 없는 ID 확인
    missing_ids = set_a - set_b

    # file_b(새 데이터) 기준으로 교집합에 포함된 데이터만 남김
    filtered_df = df_b[df_b["source_place_id"].isin(common_ids)]

    # 결과 저장
    out_path.parent.mkdir(parents=True, exist_ok=True)
    filtered_df.to_csv(out_path, index=False, encoding="utf-8-sig")
    
    # [수정] 원인 파악을 위한 상세 출력문
    print(f"\n--- [{path_a.name} & {path_b.name} 비교] ---")
    print(f"기존 데이터 고유 ID 개수: {len(set_a)}개 (전체 {len(df_a)}줄)")
    print(f"새 데이터 고유 ID 개수: {len(set_b)}개 (전체 {len(df_b)}줄)")
    print(f"교집합 ID 개수: {len(common_ids)}개")
    print(f"=> 최종 저장된 데이터: {len(filtered_df)}줄")
    
    if missing_ids:
        print(f"\n[경고] 기존 데이터 60개 중 새 데이터에서 찾을 수 없는 ID가 {len(missing_ids)}개 있습니다.")
        print(f"누락된 ID 목록: {list(missing_ids)}")

if __name__ == "__main__":
    for csv_name in CSV_LIST:
        file_1 = DATA_DIR / "intact csv files" / f"e_{PREFIX}_{csv_name}.csv"     # e_ 가 붙은건 이전에 전처리 해둔 csv
        file_2 = DATA_DIR / f"{PREFIX}_{csv_name}.csv"       # 새로 생성된 csv
        print(f"[file_1 탐색 위치] {file_1.resolve()} -> 존재 여부: {file_1.exists()}")
        print(f"[file_2 탐색 위치] {file_2.resolve()} -> 존재 여부: {file_2.exists()}")
        
        if file_1.exists() and file_2.exists():
            remove_non_overlapping_rows(file_1, file_2, file_2)
        else:
            print(f"\n파일을 찾을 수 없어 건너뜁니다: {csv_name}")
