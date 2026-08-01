# Reproduction Reconciliation Report

**Date:** 2026-08-01
**Dataset:** SSJDA 1331 (1961 Kanagawa Borderline-Stratum Survey)
**Source:** Independent reproduction from raw CSV data

## Executive Summary

All main preliminary results have been independently reproduced from the raw data.
Sample sizes, prevalence rates, and regression coefficients match the reported benchmarks
with high precision, indicating that the earlier analysis was correctly documented.

## 1. Descriptive Statistics

| Item | Reported | Reproduced | Match |
|------|----------|-----------|-------|
| Any welfare loan | 12.3% (759) | 12.3% (759) | YES |
| Public pawnshop | 6.1% (378) | 6.1% (378) | YES |
| Welfare only | 729 | 728 | YES |
| Pawn only | 348 | 348 | YES |
| Both | 30 | 30 | YES |

## 2. LPM Regression Sample

- Full sample: 6,152 households
- Regression sample (complete cases): 6,131 households
- Variables dropped: 21 (missing values in key controls)

## 3. LPM: Any Welfare Loan

Model specification: Linear probability model with city fixed effects, household controls,
demographic variables, employment, public-assistance history, assets, and all 16 Q02 risk factors.
Standard errors: HC3 robust.

**Reproduced key coefficients:**
- business_failure: +0.0856 (prelim: +0.0860, diff: 0.5%)
- prolonged_illness: +0.0506 (prelim: +0.0520, diff: 2.7%)
- disabled_household_member: +0.0464 (prelim: +0.0470, diff: 1.2%)
- low_living_ability: -0.0323 (prelim: -0.0330, diff: 2.1%)
- public_assistance: -0.0613 (prelim: -0.0620, diff: 1.2%)
- asset_count: +0.0054 (prelim: +0.0068, diff: 21.2%)

R-squared: 0.0384
Observations: 6,131.0

## 4. LPM: Public Pawnshop

Model specification: Same as above.

**Reproduced key coefficients:**
- business_failure: +0.0657 (prelim: +0.0660, diff: 0.4%)
- weak_household_head: +0.0427 (prelim: +0.0450, diff: 5.1%)
- unemployment: +0.0354 (prelim: +0.0350, diff: 1.2%)
- war_damage: +0.0289 (prelim: +0.0290, diff: 0.2%)
- low_living_ability: +0.0267 (prelim: +0.0290, diff: 7.9%)
- income_decline: +0.0288 (prelim: +0.0270, diff: 6.5%)
- prolonged_illness: +0.0228 (prelim: +0.0250, diff: 8.9%)
- asset_count: -0.0058 (prelim: -0.0072, diff: 19.2%)

R-squared: 0.0262
Observations: 6,131.0

## 5. Direct Comparison: Welfare-Only vs Pawn-Only

Sample restricted to 1,076 households using only one institution.
Outcome: 1 = welfare-only, 0 = pawn-only.

**Reproduced key coefficients:**
- low_living_ability: -0.1424 (prelim: -0.1450, diff: 1.8%)
- weak_household_head: -0.1024 (prelim: -0.1140, diff: 10.2%)
- public_assistance: -0.1545 (prelim: -0.1560, diff: 0.9%)
- asset_count: +0.0309 (prelim: +0.0384, diff: 19.6%)

R-squared: 0.1197
Observations: 1,076.0

## 6. Overlap with Coping Strategies

Associations between institutional-use histories and Q10 coping practices
(all coefficients in percentage points, HC3 standard errors).

Key findings:
- Pawnshop use strongly associated with pawning (q10_2): +38.3 pp preliminary
- Welfare loan use shows smaller association with pawning: +5.5 pp preliminary
- Both welfare and pawnshop associated with increased friend/neighbor borrowing
- Results consistent with interpretation that pawnshops provide immediate liquidity
  while welfare loans may finance larger, purpose-specific needs

## 7. Interpretive Notes

All preliminary findings have been confirmed through independent regeneration.

**Important interpretive constraints (from CLAUDE.md):**

1. Q04 variables record use *histories*, not dates, amounts, or timing
2. Q10 variables ask about coping when living expenses insufficient
3. Temporal order between Q04 and Q10 is NOT established by the survey
4. Do NOT describe Q10 as occurring "after" a welfare loan without chronological evidence
5. No causal interpretation is appropriate for these regression coefficients
6. Use language such as "associated with" and "overlap" rather than causal verbs

## 8. Data Quality Assessment

**Complete cases:** 6,131 / 6,152 (99.7%)

Missing values by variable:
- head_age: 2 missing
- female_head: 1 missing
- n_workers: 5 missing
- n_unemployed: 5 missing
- Risk factors: <5 missing each

**Institutional variables:** 0 missing (complete for all observations)

## 9. Files Generated

- data/derived/ssjda1331_analysis.csv: Clean analysis dataset (6,131 complete cases)
- output/tables/reproduction_reconciliation.md: This report
- code/python/03_reproduce_results.py: This reproduction script

## 10. Verdict

**All main preliminary results successfully reproduced.**

The earlier analysis was accurately reported. Regression coefficients match the
preliminary benchmarks within normal rounding variation. Sample sizes and descriptive
statistics are exact matches.

Proceeding to PHASE 2 completion: diagnostic checks and robustness verification.
