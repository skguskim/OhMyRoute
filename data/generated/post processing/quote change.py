import csv
import pandas as pd
from pathlib import Path
ROOT_DIR = Path(".").resolve()
GENERATED_DIR = ROOT_DIR / "OhMyRoute" / "data" / "generated"

# PREFIX = "gwangju_official"
PREFIX = "tourapi"

op_info_df = pd.read_csv(GENERATED_DIR / f"{PREFIX}_operating_info_review.csv", encoding='utf-8')
place_profiles_df = pd.read_csv(GENERATED_DIR / f"{PREFIX}_place_profiles.csv", encoding='utf-8')
places_df = pd.read_csv(GENERATED_DIR / f"{PREFIX}_places.csv", encoding='utf-8')

op_info_df.to_csv(GENERATED_DIR / f"{PREFIX}_operating_info_review.csv", index=False, quoting=csv.QUOTE_ALL, encoding='utf-8')
place_profiles_df.to_csv(GENERATED_DIR / f"{PREFIX}_place_profiles.csv", index=False, quoting=csv.QUOTE_ALL, encoding='utf-8')
places_df.to_csv(GENERATED_DIR / f"{PREFIX}_places.csv", index=False, quoting=csv.QUOTE_ALL, encoding='utf-8')
