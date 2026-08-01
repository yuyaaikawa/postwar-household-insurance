# Data Audit: SSJDA 1331 (1961)

**Date:** 2026-08-01
**Source:** C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/data/raw
**File:** 1331.csv
**Observations:** 6,152
**Variables:** 400

## Unit of Observation

Household level. Household member 1 is consistently identified as household head
(q01_01_1 = 1 for all 6,152 observations).

## Geographic Coverage

Six cities in Kanagawa Prefecture:
- City 1: 3,227 (52.5%)
- City 2: 1,331 (21.6%)
- City 3: 1,149 (18.7%)
- City 42: 172 (2.8%)
- City 43: 150 (2.4%)
- City 41: 123 (2.0%)

## Q04: Public Program Use History (Binary)

**q04_1 (Public assistance):** 1,539 (25.0%)
**q04_2 (Maternal welfare fund):** 115 (1.9%)
**q04_3 (Household Rehabilitation Fund):** 307 (5.0%)
**q04_4 (Special educational fund):** 176 (2.9%)
**q04_5 (Fatherless children support):** 28 (0.5%)
**q04_6 (Disability medical care):** 110 (1.8%)
**q04_7 (Medical expense loan):** 187 (3.0%)
**q04_8 (Public pawnshop):** 378 (6.1%)

## Institutional-Use Groups

Based on welfare-loan definition (q04_2 | q04_3 | q04_4 | q04_7):

- Any welfare loan: 759 (12.3%)
- Public pawnshop: 378 (6.1%)
- Both institutions: 30 (0.5%)
- Welfare only: 729 (11.8%)
- Pawnshop only: 348 (5.7%)
- Neither: 5,045 (82.0%)

Total: 6,152 = 6,152

## Q10: Coping Strategies (Binary)

**q10_1 (Purchases on account):** 638 (10.4%)
**q10_2 (Pawning):** 507 (8.2%)
**q10_3 (Employer borrowing):** 953 (15.5%)
**q10_4 (Friend/neighbor borrowing):** 1,236 (20.1%)
**q10_5 (Asset sales):** 161 (2.6%)
**q10_6 (Savings withdrawal):** 305 (5.0%)
**q10_7 (Other):** 525 (8.5%)
**q10_8 (Food compression):** 1,571 (25.5%)

## Key Observations

1. **Household head consistent:** q01_01_1 = 1 for all observations.
2. **"Both" group very small:** Only 30 households use both welfare and pawnshop.
3. **Food compression very common:** 25.5% report cutting food spending.
4. **Pawning moderately common:** 8.2% report pawning when living expenses insufficient.
5. **Data availability:** All key variables present and complete for all households.

## Data Protection

- All raw data files in C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/data/raw are READ-ONLY.
- All outputs (cleaned data, tables, figures) go to C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/fromchatgpt/claude_code_fhr_project_bundle/data/derived or output/ directories.
- CSV file preferred; DTA file available as backup.

## Next Steps

1. Document all variable codes and missing-value rules (variable_dictionary.md)
2. Independently reproduce preliminary results from preliminary_results_to_reproduce.md
3. Compare with legacy code and reconcile any differences

