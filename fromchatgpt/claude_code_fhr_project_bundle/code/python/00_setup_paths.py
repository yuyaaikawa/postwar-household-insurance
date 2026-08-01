"""
Setup and path configuration for SSJDA 1331 analysis.
All data paths are strictly read-only. All outputs go to derived/ directories.

Usage:
  from setup_paths import SSJDA_CSV_FILE, DATA_DERIVED, ...
  or: exec(open("setup_paths.py").read())
"""

import os
from pathlib import Path

# Project root (this is the bundle directory)
PROJECT_ROOT = Path(__file__).parent.parent.parent

# Read-only authoritative source-data directory
AUTHORITATIVE_DATA_DIR = Path(r"C:\Users\yuyaa\git\postwar_household_insurance\postwar_household_insurance\data\raw")

# Specific data files within the source directory
SSJDA_EXTRACT_DIR = AUTHORITATIVE_DATA_DIR / "神奈川県における民生基礎調査（ボーダー・ライン層調査）1961" / "1331"
SSJDA_DTA_FILE = SSJDA_EXTRACT_DIR / "1331.dta"
SSJDA_CSV_FILE = SSJDA_EXTRACT_DIR / "1331.csv"
SSJDA_LABELS_FILE = SSJDA_EXTRACT_DIR / "1331label.txt"
SSJDA_README_FILE = SSJDA_EXTRACT_DIR / "1331readme.docx"

# Project output directories
DATA_DERIVED = PROJECT_ROOT / "data" / "derived"
OUTPUT_TABLES = PROJECT_ROOT / "output" / "tables"
OUTPUT_FIGURES = PROJECT_ROOT / "output" / "figures"
OUTPUT_LOGS = PROJECT_ROOT / "output" / "logs"
DOCS = PROJECT_ROOT / "docs"

# Create derived directories if they don't exist
for d in [DATA_DERIVED, OUTPUT_TABLES, OUTPUT_FIGURES, OUTPUT_LOGS, DOCS]:
    d.mkdir(parents=True, exist_ok=True)

if __name__ == "__main__":
    print("=" * 70)
    print("PATH CONFIGURATION")
    print("=" * 70)
    print(f"Project root: {PROJECT_ROOT}")
    print(f"Read-only data dir: {AUTHORITATIVE_DATA_DIR}")
    print(f"SSJDA CSV file exists: {SSJDA_CSV_FILE.exists()}")
    print(f"SSJDA labels exists: {SSJDA_LABELS_FILE.exists()}")
    print(f"\nOutput directories created.")

    # Verify that source files exist
    if not SSJDA_CSV_FILE.exists():
        raise FileNotFoundError(f"SSJDA CSV file not found: {SSJDA_CSV_FILE}")
    if not SSJDA_LABELS_FILE.exists():
        raise FileNotFoundError(f"SSJDA labels file not found: {SSJDA_LABELS_FILE}")

    print("All paths configured and verified.")
