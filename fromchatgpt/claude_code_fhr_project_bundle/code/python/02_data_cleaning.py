#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Data cleaning and variable construction for SSJDA 1331 analysis.
Constructs all variables needed for reproducible analysis.
Output saved to data/derived/ for use in subsequent analysis.
"""

import pandas as pd
import numpy as np
from pathlib import Path

# Setup paths
PROJECT_ROOT = Path(__file__).parent.parent.parent
AUTHORITATIVE_DATA_DIR = Path(r"C:\Users\yuyaa\git\postwar_household_insurance\postwar_household_insurance\data\raw")
SSJDA_EXTRACT_DIR = AUTHORITATIVE_DATA_DIR / "神奈川県における民生基礎調査（ボーダー・ライン層調査）1961" / "1331"
SSJDA_CSV_FILE = SSJDA_EXTRACT_DIR / "1331.csv"
DATA_DERIVED = PROJECT_ROOT / "data" / "derived"
DATA_DERIVED.mkdir(parents=True, exist_ok=True)

print("=" * 80)
print("DATA CLEANING AND VARIABLE CONSTRUCTION")
print("=" * 80)

# Load raw data
print("\n1. Loading raw data...")
df = pd.read_csv(SSJDA_CSV_FILE)
print(f"   Loaded: {len(df):,} observations")

# Keep original for reference
df_orig = df.copy()

# ============================================================================
# INSTITUTIONAL VARIABLES
# ============================================================================

print("\n2. Constructing institutional variables...")

# Public program use (binary)
df['any_welfare_loan'] = ((df['q04_2'] == 1) | (df['q04_3'] == 1) |
                          (df['q04_4'] == 1) | (df['q04_7'] == 1)).astype(int)
df['public_pawnshop'] = (df['q04_8'] == 1).astype(int)

# Institutional groups
df['both_institutions'] = ((df['any_welfare_loan'] == 1) &
                           (df['public_pawnshop'] == 1)).astype(int)
df['welfare_only'] = ((df['any_welfare_loan'] == 1) &
                      (df['public_pawnshop'] == 0)).astype(int)
df['pawnshop_only'] = ((df['any_welfare_loan'] == 0) &
                       (df['public_pawnshop'] == 1)).astype(int)
df['neither_institution'] = ((df['any_welfare_loan'] == 0) &
                             (df['public_pawnshop'] == 0)).astype(int)

# Public assistance (for control variables)
df['public_assistance'] = (df['q04_1'] == 1).astype(int)

print("   Welfare loan: {:,}".format(df['any_welfare_loan'].sum()))
print("   Pawnshop: {:,}".format(df['public_pawnshop'].sum()))
print("   Both: {:,}".format(df['both_institutions'].sum()))
print("   Welfare only: {:,}".format(df['welfare_only'].sum()))
print("   Pawnshop only: {:,}".format(df['pawnshop_only'].sum()))
print("   Neither: {:,}".format(df['neither_institution'].sum()))

# ============================================================================
# COPING STRATEGIES (Q10 VARIABLES)
# ============================================================================

print("\n3. Constructing coping strategy variables...")

coping_vars = {
    'coping_account': 'q10_1',          # Purchases on account
    'coping_pawn': 'q10_2',             # Pawning
    'coping_employer': 'q10_3',         # Employer borrowing
    'coping_friend': 'q10_4',           # Friend/neighbor borrowing
    'coping_asset_sale': 'q10_5',       # Asset sales
    'coping_savings': 'q10_6',          # Savings withdrawal
    'coping_other': 'q10_7',            # Other
    'coping_food': 'q10_8'              # Food compression
}

for new_var, orig_var in coping_vars.items():
    df[new_var] = (df[orig_var] == 1).astype(int)

# Count of coping strategies
df['n_coping_strategies'] = df[[v for v in coping_vars.keys()]].sum(axis=1)
df['any_coping'] = (df['n_coping_strategies'] > 0).astype(int)

# Borrowing indicators (trade credit, relational, collateral)
df['any_borrowing'] = ((df['q10_1'] == 1) | (df['q10_2'] == 1) |
                       (df['q10_3'] == 1) | (df['q10_4'] == 1)).astype(int)

print("   Coping strategy variables created")
print("   Mean number of strategies: {:.2f}".format(df['n_coping_strategies'].mean()))

# ============================================================================
# HOUSEHOLD DEMOGRAPHICS
# ============================================================================

print("\n4. Constructing demographic variables...")

# Head age (from q01_01_3, with 99 = missing)
df['head_age'] = df['q01_01_3'].where(df['q01_01_3'] < 99, np.nan)
df['head_age_sq'] = df['head_age'] ** 2

# Female head (1=female, 0=male)
df['female_head'] = (df['q01_01_2'] == 2).astype(int)
# Set to NaN if not properly coded
df.loc[~df['q01_01_2'].isin([1, 2]), 'female_head'] = np.nan

# Household size (from q12_1, with 99 = missing)
df['household_size'] = df['q12_1'].where(df['q12_1'] < 99, np.nan)

# Workers in household (from q12_4, with 9 = missing)
df['n_workers'] = df['q12_4'].where(df['q12_4'] < 9, np.nan)

# Unemployed in household (from q12_6, with 9 = missing)
df['n_unemployed'] = df['q12_6'].where(df['q12_6'] < 9, np.nan)

print("   Head age - mean: {:.1f}".format(df['head_age'].mean()))
print("   Female head: {:.1%}".format(df['female_head'].mean()))
print("   Household size - mean: {:.1f}".format(df['household_size'].mean()))
print("   Workers - mean: {:.1f}".format(df['n_workers'].mean()))

# ============================================================================
# HOUSEHOLD ASSETS (Q26 VARIABLES)
# ============================================================================

print("\n5. Constructing asset variables...")

# Asset ownership (0 = not owned, 1 = owned, 9 = missing/unknown)
asset_items = ['q26_{}'.format(i) for i in range(1, 10)]
asset_labels = [
    'dresser', 'sewing_machine', 'radio', 'television',
    'watch', 'dining_table', 'electric_washer', 'study_desk', 'real_estate'
]

# Clean assets (set 9 = NaN)
for var in asset_items:
    df[var] = df[var].where(df[var] != 9, np.nan)

# Asset count (only owned=1, exclude real estate first)
df['asset_count'] = df[[f'q26_{i}' for i in range(1, 9)]].sum(axis=1)
df['asset_count_with_realestate'] = df[asset_items].sum(axis=1)

print("   Asset count (8 movables) - mean: {:.2f}".format(df['asset_count'].mean()))
print("   Asset count (including real estate) - mean: {:.2f}".format(df['asset_count_with_realestate'].mean()))

# ============================================================================
# HOUSEHOLD ECONOMIC CHARACTERISTICS (Q02 VARIABLES)
# ============================================================================

print("\n6. Constructing low-income-cause variables...")

# Q02 variables: risk factors for low income (0=no, 1=yes, 99=missing)
# We use the coding structure from the preliminary analysis

risk_factors = {
    'war_damage': 'q02_01',
    'disaster': 'q02_02',
    'head_death': 'q02_03',
    'unemployment': 'q02_04',
    'business_failure': 'q02_05',
    'family_conflict': 'q02_06',
    'income_decline': 'q02_07',
    'asset_loss': 'q02_08',
    'illness_onset': 'q02_09',
    'prolonged_illness': 'q02_10',
    'aging_work_decline': 'q02_11',
    'low_living_ability': 'q02_21',
    'weak_household_head': 'q02_22',
    'household_discord': 'q02_23',
    'disabled_household_member': 'q02_24',
    'longterm_patient': 'q02_25'
}

for new_var, orig_var in risk_factors.items():
    # Convert to binary, set 99 (missing/unknown) to NaN
    df[new_var] = df[orig_var].where(df[orig_var] != 99, np.nan)

print("   Low-income-cause variables created: {}".format(len(risk_factors)))

# ============================================================================
# HOUSEHOLD INCOME AND CONSUMPTION
# ============================================================================

print("\n7. Constructing income and consumption variables...")

# Income level (q07): categorical, 1-16 (higher = more income)
# Keep as is; will use as categorical in models

# Income change (q08): 1=increased, 2=no change, 3=decreased, 9=missing
df['income_decreased'] = (df['q08'] == 3).astype(int)
df.loc[df['q08'] == 9, 'income_decreased'] = np.nan

# Rent arrears (q19): amount in yen, 88888 or >1000 = missing/not applicable
df['rent_arrears_amount'] = df['q19'].where((df['q19'] < 1000) & (df['q19'] != 88888), np.nan)
df['has_rent_arrears'] = (df['rent_arrears_amount'] > 0).astype(int)

print("   Income decreased: {:.1%}".format(df['income_decreased'].mean()))
print("   Has rent arrears: {:.1%}".format(df['has_rent_arrears'].mean()))

# ============================================================================
# HOUSEHOLD TYPE
# ============================================================================

print("\n8. Household type and employment...")

# Household type (q03): keep as is for now
df['household_type'] = df['q03']

print("   Household types: {}".format(df['household_type'].nunique()))

# ============================================================================
# SAVE ANALYSIS DATASET
# ============================================================================

print("\n9. Saving analysis dataset...")

# Select key variables for analysis
key_columns = ['ID', 'city', 'household_type'] + \
              list(coping_vars.keys()) + \
              ['any_coping', 'n_coping_strategies', 'any_borrowing'] + \
              ['any_welfare_loan', 'public_pawnshop', 'public_assistance'] + \
              ['both_institutions', 'welfare_only', 'pawnshop_only', 'neither_institution'] + \
              ['head_age', 'head_age_sq', 'female_head', 'household_size',
               'n_workers', 'n_unemployed'] + \
              ['asset_count', 'asset_count_with_realestate'] + \
              list(risk_factors.keys()) + \
              ['income_decreased', 'has_rent_arrears', 'rent_arrears_amount'] + \
              ['q04_1', 'q04_2', 'q04_3', 'q04_4', 'q04_5', 'q04_6', 'q04_7', 'q04_8',  # Original Q04
               'q07', 'q08', 'q10_1', 'q10_2', 'q10_3', 'q10_4', 'q10_5', 'q10_6', 'q10_7', 'q10_8']  # Original Q10

# Create analysis dataset
df_analysis = df[key_columns].copy()

# Save to CSV
output_file = DATA_DERIVED / "ssjda1331_analysis.csv"
df_analysis.to_csv(output_file, index=False)

print(f"   Saved to: {output_file}")
print(f"   Dimensions: {df_analysis.shape}")

# ============================================================================
# DATA QUALITY SUMMARY
# ============================================================================

print("\n10. Data quality summary...")

print("\n   Missing values (key institutional variables):")
print(f"     any_welfare_loan: {df_analysis['any_welfare_loan'].isna().sum()}")
print(f"     public_pawnshop: {df_analysis['public_pawnshop'].isna().sum()}")

print("\n   Missing values (key demographic variables):")
print(f"     head_age: {df_analysis['head_age'].isna().sum()}")
print(f"     female_head: {df_analysis['female_head'].isna().sum()}")
print(f"     n_workers: {df_analysis['n_workers'].isna().sum()}")

print("\n   Coping variables complete: YES (all binary for full sample)")

print("\n" + "=" * 80)
print("DATA CLEANING COMPLETE")
print("=" * 80)
print(f"Output file: {output_file}")
print(f"Ready for regression analysis.")
