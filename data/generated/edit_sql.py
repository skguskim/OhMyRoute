import csv
from pathlib import Path
import csv
import re

def filter_sql_by_csv(csv_path, sql_path, output_sql_path):
    # 1. CSV 파일에서 유지할 기준 키(source, source_place_id) 세트 생성
    # csv.DictReader가 첫 줄의 헤더와 쌍따옴표("")를 자동으로 처리합니다.
    valid_keys = set()
    with open(csv_path, mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if row.get('source') and row.get('source_place_id'):
                valid_keys.add((row['source'], row['source_place_id']))

    # 2. SQL 구문에서 식별자를 추출하기 위한 정규표현식
    # places 테이블 매칭용: values ('gwangju_tour', 'nature.cs:2', ...
    places_pattern = re.compile(r"values\s*\(\s*'([^']+)'\s*,\s*'([^']+)'", re.IGNORECASE)
    
    # place_profiles 테이블 매칭용: where p.source = 'gwangju_tour' and p.source_place_id = 'nature.cs:2'
    profiles_pattern = re.compile(r"where\s+p\.source\s*=\s*'([^']+)'\s*and\s+p\.source_place_id\s*=\s*'([^']+)'", re.IGNORECASE)

    # 3. SQL 파일 읽기 및 세미콜론(;) 기준 분리
    with open(sql_path, mode='r', encoding='utf-8') as f:
        sql_content = f.read()

    # 4. [수정됨] URL 내부의 '&amp;' 분리 방지를 위해 정규표현식으로 문장 분리
    # 세미콜론(;) 뒤에 줄바꿈이 오는 경우에만 분리하도록 처리합니다.
    sql_statements = re.split(r';\s*\n+', sql_content)
    filtered_statements = []

    # 4. 각 쿼리문을 검사하여 CSV에 없는 항목 필터링
    for stmt in sql_statements:
        if not stmt.strip():
            continue
            
        stmt_with_semi = stmt.strip() + ';'
        
        # 패턴 매칭 시도
        match = places_pattern.search(stmt)
        if not match:
            match = profiles_pattern.search(stmt)
            
        if match:
            source = match.group(1)
            source_place_id = match.group(2)
            
            # 추출된 식별자가 CSV 셋(Set)에 존재하는 경우에만 유지
            if (source, source_place_id) in valid_keys:
                filtered_statements.append(stmt_with_semi)
        else:
            # 패턴이 없는 기타 구문(예: begin;)은 그대로 유지
            filtered_statements.append(stmt_with_semi)

    # 5. 필터링된 결과를 새로운 SQL 파일로 저장
    with open(output_sql_path, mode='w', encoding='utf-8') as f:
        f.write('\n\n'.join(filtered_statements))

ROOT_DIR = Path(".").resolve()
CSV_PATH = ROOT_DIR / "OhMyRoute" / "data" / "generated" / "gwangju_official_places.csv"
SQL_PATH = ROOT_DIR / "OhMyRoute" / "data" / "generated" / "gwangju_official_seed.sql"

filter_sql_by_csv(CSV_PATH, SQL_PATH, SQL_PATH)  # 기존 SQL 파일을 덮어쓰도록 설정
