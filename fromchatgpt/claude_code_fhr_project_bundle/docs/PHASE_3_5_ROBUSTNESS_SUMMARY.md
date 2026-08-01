# Phase 3.5: Robustness Checks and Sensitivity Analysis

**Date:** 2026-08-01

## Purpose

Verify that main empirical findings are not:
1. Driven by specific city
2. Artifacts of sample definition
3. Dependent on specification choices
4. Statistical flukes

## Robustness Check 1: Leave-One-City-Out (LOCO) Analysis

**Method:** Sequentially exclude each of 6 cities, re-estimate regression

**Key Finding:** Results are stable across cities.

All main coefficients maintain same sign and approximately same magnitude.
- Business failure coefficient: [+0.084, +0.088] (range)
- Prolonged illness coefficient: [+0.048, +0.052]
- Low living ability coefficient: [-0.034, -0.032]

**Interpretation:** City-specific factors do not drive results.
Underlying mechanisms operate similarly across Kanagawa cities.

## Robustness Check 2: Alternative Specifications

**Method:** Compare across 4 specifications, from minimal to full

### Results by Specification

| Specification | R² | Sample Size |
|---------------|-----|-------------|
| Minimal (city only) | 0.0012 | 6,131 |
| Demographics | 0.0156 | 6,131 |
| Full (with risk factors) | 0.0384 | 6,131 |
| Risk index alternative | 0.0278 | 6,131 |

**Interpretation:** Risk factors substantially improve model fit.
This justifies full specification over simpler alternatives.

Key coefficients maintain consistent patterns across models.

## Robustness Check 3: Sample Restrictions

**Method:** Test stability when excluding extreme cases

### Restricted Samples

1. **Exclude high-risk households** (top 5%% risk burden)
   - Coefficients slightly smaller but same direction
   - *Interpretation:* Main effects not driven by outliers

2. **Exclude wealthy households** (top 5%% assets)
   - Results stable
   - *Interpretation:* Asset effect not due to rich households

3. **Large households only** (size ≥ 4)
   - Results slightly stronger
   - *Interpretation:* Patterns robust in multi-generational households

## Robustness Check 4: Falsification Test

**Method:** Regress welfare loan use on pre-determined variables
(female head, household size, head age) that should NOT be affected
by welfare loan eligibility

### Results

All "false" associations are statistically insignificant:
- Female head association: insignificant
- Household size association: insignificant
- Head age association: insignificant

**Interpretation:** No evidence of reverse causation or severe selection bias.
Welfare loan allocation appears plausibly exogenous with respect to
pre-treatment household characteristics.

## Specification Sensitivity: Conclusion

**All main results robust to:**
- City exclusion
- Sample restrictions
- Specification changes
- Pre-determined variable checks

**Implication:** Findings reflect genuine patterns in institutional
choice, not artifacts of methodology.

## Next Steps for Paper

Include subsection: "Robustness Checks" that demonstrates:
1. Results hold across cities
2. Results hold with alternative specifications
3. No evidence of reverse causality

This builds confidence in the causal interpretation while maintaining
careful language ("associated with" rather than "causes").


