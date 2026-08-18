import importlib.util
import json
import tempfile
import unittest
import zipfile
from pathlib import Path


SCRIPT_PATH = Path(__file__).resolve().parents[1] / "scripts" / "prepare_stamp_dataset.py"
SPEC = importlib.util.spec_from_file_location("prepare_stamp_dataset", SCRIPT_PATH)
MODULE = importlib.util.module_from_spec(SPEC)
assert SPEC and SPEC.loader
SPEC.loader.exec_module(MODULE)


class PrepareStampDatasetTest(unittest.TestCase):
    def test_collects_deduplicates_and_balances_records_without_copying_images(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            source_dir = Path(temp_dir) / "aihub"
            label_dir = source_dir / "labels"
            image_dir = source_dir / "images"
            label_dir.mkdir(parents=True)
            image_dir.mkdir(parents=True)

            (image_dir / "SM_KC_0001_S1.jpg").write_bytes(b"fixture")
            record = {
                "images": {
                    "pattern_file_name": "SM_KC_0001_S1",
                    "pattern_type": "식물문",
                    "pattern_type_detail_kor": "연꽃문",
                    "pattern_symbol": "청정, 고결함",
                    "relic_name_kor": "연꽃무늬수막새",
                    "relic_no": "PS000414",
                    "era": "삼국",
                    "material": "토제",
                    "source": "국립중앙박물관",
                },
                "caption_kor": {
                    "normal_kor": "연꽃문이 있는 전통 수막새",
                    "keyword_kor": "연꽃문양, 청정",
                },
            }
            (label_dir / "sample.json").write_text(
                json.dumps({"records": [record, record]}, ensure_ascii=False),
                encoding="utf-8",
            )

            records, stats = MODULE.collect_records(source_dir)
            self.assertEqual(len(records), 1)
            self.assertEqual(stats["duplicate_records"], 1)
            self.assertEqual(records[0]["pattern_type"], "식물문")
            self.assertEqual(Path(records[0]["image_path"]).name, "SM_KC_0001_S1.jpg")

            selected = MODULE.balanced_sample(records, per_type=1, seed=7)
            output_path = Path(temp_dir) / "output" / "manifest.jsonl"
            MODULE.write_manifest(
                output_path,
                selected,
                records,
                stats,
                source_dir,
                per_type=1,
                seed=7,
            )

            self.assertTrue(output_path.exists())
            self.assertTrue(output_path.with_suffix(".summary.json").exists())
            self.assertEqual((source_dir / "images" / "SM_KC_0001_S1.jpg").read_bytes(), b"fixture")

    def test_reads_validation_zips_and_joins_vertical_metadata(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            image_dir = root / "Validation" / "01.원천데이터"
            label_dir = root / "Validation" / "02.라벨링데이터"
            metadata_dir = root / "Other" / "메타데이터"
            image_dir.mkdir(parents=True)
            label_dir.mkdir(parents=True)
            (metadata_dir / "BH" / "KC").mkdir(parents=True)

            image_zip = image_dir / "VS_문양이미지데이터_BH_KC.zip"
            with zipfile.ZipFile(image_zip, "w") as archive:
                archive.writestr("/KC_BH_0001_S1.jpg", b"fixture")

            label_zip = label_dir / "VL_문양라벨링데이터_BH_KC.zip"
            with zipfile.ZipFile(label_zip, "w") as archive:
                archive.writestr(
                    "/KC_BH_0001_S1.json",
                    json.dumps({
                        "caption_kor": {
                            "description_kor": "태극과 구름이 함께 새겨진 문양",
                            "symbolism_kor": "화합과 장수",
                            "keyword_kor": "태극문, 구름문",
                        },
                    }, ensure_ascii=False),
                )

            (metadata_dir / "BH" / "KC" / "KC_BH_0001_M1.csv").write_text(
                "pattern_file_name,KC_BH_0001_S1\n"
                "relic_name_kor,관리명부 현판\n"
                "relic_no,PS020460\n"
                "pattern_type,복합문\n"
                "pattern_symbol,안정과 화합\n"
                "pattern_usage,건축물\n"
                "era,조선\n",
                encoding="utf-8",
            )

            records, stats = MODULE.collect_records(
                images_dir=image_dir,
                labels_dir=label_dir,
                metadata_dir=metadata_dir,
            )

            self.assertEqual(len(records), 1)
            self.assertEqual(records[0]["pattern_type"], "복합문")
            self.assertEqual(records[0]["relic_name"], "관리명부 현판")
            self.assertEqual(records[0]["image_zip_path"], str(image_zip.resolve()))
            self.assertEqual(records[0]["image_entry"], "/KC_BH_0001_S1.jpg")
            self.assertEqual(records[0]["label_zip_path"], str(label_zip.resolve()))
            self.assertEqual(records[0]["symbolism"], "화합과 장수")
            self.assertEqual(stats["missing_pattern_image"], 0)


if __name__ == "__main__":
    unittest.main()
