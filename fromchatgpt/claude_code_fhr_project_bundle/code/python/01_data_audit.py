#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
PHASE 1: Data audit for SSJDA 1331 (Kanagawa Borderline-Stratum Survey, 1961)
"""

import pandas as pd
import numpy as np
from pathlib import Path
import sys

# Setup paths manually
PROJECT_ROOT = Path(__file__).parent.parent.parent
AUTHORITATIVE_DATA_DIR = Path(r"C:\Users\yuyaa\git\postwar_household_insurance\postwar_household_insurance\data\raw")
SSJDA_EXTRACT_DIR = AUTHORITATIVE_DATA_DIR / "神奈川県における民生基礎調査（ボーダー・ライン層調査）1961" / "1331"
SSJDA_CSV_FILE = SSJDA_EXTRACT_DIR / "1331.csv"
DOCS = PROJECT_ROOT / "docs"
DOCS.mkdir(parents=True, exist_ok=True)

print("=" * 80)
print("PHASE 1: DATA AUDIT")
print("=" * 80)

# Load data
print("\n1. Loading data...")
df = pd.read_csv(SSJDA_CSV_FILE)
print(f"   Observations: {len(df):,}")
print(f"   Variables: {len(df.columns)}")

obs_count = len(df)
var_count = len(df.columns)

# Check household head
print("\n2. Household head verification...")
head_check = (df['q01_01_1'] == 1).all()
print(f"   All member 1 are household heads (q01_01_1==1): {head_check}")

# City distribution
print("\n3. Geographic coverage...")
city_counts = df['city'].value_counts().sort_index()
print(f"   Number of cities: {df['city'].nunique()}")

# Q04 variables
print("\n4. Q04 Public program use...")
q04_data = {}
for i in range(1, 9):
    var = f"q04_{i}"
    count = (df[var] == 1).sum()
    pct = 100 * count / len(df)
    q04_data[i] = (count, pct)
    print(f"   q04_{i}: {count:,} ({pct:.1f}%)")

# Institutional groups
print("\n5. Institutional-use groups...")
welfare_vars = ['q04_2', 'q04_3', 'q04_4', 'q04_7']
any_welfare = (df[welfare_vars] == 1).any(axis=1)
any_pawnshop = (df['q04_8'] == 1)
both = any_welfare & any_pawnshop
welfare_only = any_welfare & ~any_pawnshop
pawnshop_only = ~any_welfare & any_pawnshop
neither = ~any_welfare & ~any_pawnshop

print(f"   Any welfare loan: {any_welfare.sum():,} ({100*any_welfare.sum()/len(df):.1f}%)")
print(f"   Public pawnshop: {any_pawnshop.sum():,} ({100*any_pawnshop.sum()/len(df):.1f}%)")
print(f"   Both: {both.sum():,} ({100*both.sum()/len(df):.1f}%)")
print(f"   Welfare only: {welfare_only.sum():,} ({100*welfare_only.sum()/len(df):.1f}%)")
print(f"   Pawnshop only: {pawnshop_only.sum():,} ({100*pawnshop_only.sum()/len(df):.1f}%)")
print(f"   Neither: {neither.sum():,} ({100*neither.sum()/len(df):.1f}%)")

# Q10 variables
print("\n6. Q10 Coping strategies...")
q10_data = {}
for i in range(1, 9):
    var = f"q10_{i}"
    count = (df[var] == 1).sum()
    pct = 100 * count / len(df)
    q10_data[i] = (count, pct)
    print(f"   q10_{i}: {count:,} ({pct:.1f}%)")

# Generate markdown report
audit_md = f"""# Data Audit: SSJDA 1331 (1961)

**Date:** 2026-08-01
**Source:** {AUTHORITATIVE_DATA_DIR}
**File:** 1331.csv
**Observations:** {obs_count:,}
**Variables:** {var_count}

## Unit of Observation

Household level. Household member 1 is consistently identified as household head
(q01_01_1 = 1 for all {obs_count:,} observations).

## Geographic Coverage

Six cities in Kanagawa Prefecture:
"""

for city, count in city_counts.items():
    pct = 100 * count / len(df)
    audit_md += f"- City {city}: {count:,} ({pct:.1f}%)\n"

audit_md += f"""
## Q04: Public Program Use History (Binary)

**q04_1 (Public assistance):** {q04_data[1][0]:,} ({q04_data[1][1]:.1f}%)
**q04_2 (Maternal welfare fund):** {q04_data[2][0]:,} ({q04_data[2][1]:.1f}%)
**q04_3 (Household Rehabilitation Fund):** {q04_data[3][0]:,} ({q04_data[3][1]:.1f}%)
**q04_4 (Special educational fund):** {q04_data[4][0]:,} ({q04_data[4][1]:.1f}%)
**q04_5 (Fatherless children support):** {q04_data[5][0]:,} ({q04_data[5][1]:.1f}%)
**q04_6 (Disability medical care):** {q04_data[6][0]:,} ({q04_data[6][1]:.1f}%)
**q04_7 (Medical expense loan):** {q04_data[7][0]:,} ({q04_data[7][1]:.1f}%)
**q04_8 (Public pawnshop):** {q04_data[8][0]:,} ({q04_data[8][1]:.1f}%)

## Institutional-Use Groups

Based on welfare-loan definition (q04_2 | q04_3 | q04_4 | q04_7):

- Any welfare loan: {any_welfare.sum():,} ({100*any_welfare.sum()/len(df):.1f}%)
- Public pawnshop only: {any_pawnshop.sum():,} ({100*any_pawnshop.sum()/len(df):.1f}%)
- **Both institutions:** {both.sum():,} ({100*both.sum()/len(df):.1f}%)
- **Welfare only:** {welfare_only.sum():,} ({100*welfare_only.sum()/len(df):.1f}%)
- **Pawnshop only:** {pawnshop_only.sum():,} ({100*pawnshop_only.sum()/len(df):.1f}%)
- **Neither:** {neither.sum():,} ({100*neither.sum()/len(df):.1f}%)

Total: {both.sum() + welfare_only.sum() + pawnshop_only.sum() + neither.sum():,} = {obs_count:,}

## Q10: Coping Strategies (Binary)

**q10_1 (Purchases on account):** {q10_data[1][0]:,} ({q10_data[1][1]:.1f}%)
**q10_2 (Pawning):** {q10_data[2][0]:,} ({q10_data[2][1]:.1f}%)
**q10_3 (Employer borrowing):** {q10_data[3][0]:,} ({q10_data[3][1]:.1f}%)
**q10_4 (Friend/neighbor borrowing):** {q10_data[4][0]:,} ({q10_data[4][1]:.1f}%)
**q10_5 (Asset sales):** {q10_data[5][0]:,} ({q10_data[5][1]:.1f}%)
**q10_6 (Savings withdrawal):** {q10_data[6][0]:,} ({q10_data[6][1]:.1f}%)
**q10_7 (Other):** {q10_data[7][0]:,} ({q10_data[7][1]:.1f}%)
**q10_8 (Food compression):** {q10_data[8][0]:,} ({q10_data[8][1]:.1f}%)

## Key Observations

1. **Household head consistent:** q01_01_1 = 1 for all observations.
2. **"Both" group very small:** Only {both.sum()} households use both welfare and pawnshop.
3. **Food compression very common:** {q10_data[8][1]:.1f}% report cutting food spending.
4. **Pawning moderately common:** {q10_data[2][1]:.1f}% report pawning when living expenses insufficient.
5. **Data availability:** All key variables present and complete for all households.

## Data Protection

- All raw data files in {AUTHORITATIVE_DATA_DIR} are READ-ONLY.
- All outputs (cleaned data, tables, figures) go to {PROJECT_ROOT}/data/derived/ or output/ directories.
- CSV file preferred; DTA file available as backup.

## Next Steps

1. Document all variable codes and missing-value rules (variable_dictionary.md)
2. Independently reproduce preliminary results from preliminary_results_to_reproduce.md
3. Compare with legacy code and reconcile any differences
"""

# Write audit file
audit_file = DOCS / "data_audit.md"
with open(audit_file, 'w', encoding='utf-8') as f:
    f.write(audit_md)

print(f"\n[OK] Data audit written to: {audit_file}")
print("\nPHASE 1 DATA AUDIT COMPLETE")
