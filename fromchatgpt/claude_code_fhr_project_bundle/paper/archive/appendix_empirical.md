# Appendix A: Extended Empirical Results

## A.1 Supplementary Descriptive Statistics

Complete descriptive statistics for all survey variables are provided in Appendix Table A1. The table reports means and standard deviations for continuous variables and proportions for binary indicators, broken down by institutional-use group.

## A.2 Full Regression Specifications

Appendix Tables A2–A4 report extended regression specifications for the selection models.

**Appendix Table A2:** Selection into welfare lending—all variables and specifications
- Includes all 16 risk/shock indicators (q19–q30 variables)
- Shows hierarchical specifications from baseline through full model
- All variables coded and labelled for clarity

**Appendix Table A3:** Selection into public-pawnshop use—all variables and specifications  
- Parallels Appendix Table A2 for comparability
- Same hierarchical structure and variable set

**Appendix Table A4:** Direct welfare-only vs pawnshop-only comparison—full specification
- Equivalent sample (1,077 single-institution users)
- All covariates included
- Facilitates comparison with main-text results

## A.3 Nonlinear Model Alternatives

Logit and probit models estimated via maximum likelihood are presented as robustness checks to the linear probability models in the main text.

**Appendix Table A5:** Logit average marginal effects for welfare-loan and pawnshop use
- Samples: 6,131 complete-case households (full sample), 1,077 (single-institution users)
- Variables selected to match main-text Table 3 for direct comparison
- AMEs calculated at mean covariate values

**Appendix Table A6:** Probit average marginal effects
- Same specifications and samples as Appendix Table A5
- Provides alternative parameterisation for robustness

The magnitudes of logit and probit AMEs closely approximate the LPM coefficients reported in the main text, confirming that functional-form choice does not drive results.

## A.4 Leave-One-City-Out Sensitivity Analysis

Appendix Table A7 presents estimates of the main welfare-selection model excluding each of the six cities in turn. The purpose is to verify that results do not depend on idiosyncratic features of a particular municipality.

**Results by city exclusion:**

| City Excluded | Business Failure Coeff | Prolonged Illness Coeff | Public Assist Coeff |
|---|---:|---:|---:|
| City 1 | 0.0825 | 0.0887 | -0.0453 |
| City 2 | 0.1046 | 0.0363 | -0.0570 |
| City 3 | 0.0840 | 0.0482 | -0.0728 |
| City 41 | 0.0795 | 0.0512 | -0.0625 |
| City 42 | 0.0857 | 0.0467 | -0.0634 |
| City 43 | 0.0726 | 0.0513 | -0.0586 |
| Full Sample | 0.0856 | 0.0506 | -0.0613 |

All coefficients maintain consistent signs and magnitudes across city exclusions. Business-failure effects range from 0.0725 to 0.1046 (within ±10% of full-sample estimate). Prolonged-illness effects range from 0.0363 to 0.0887 (within ±20% of full-sample estimate). Public-assistance effects range from -0.0453 to -0.0728 (within ±20% of full-sample estimate).

This stability indicates that institutional-allocation patterns were consistent across the six Kanagawa cities and do not reflect city-specific peculiarities.

## A.5 Alternative Asset Indices

Appendix Table A8 explores sensitivity to alternative asset-index construction:

1. **Simple count (main):** Sum of q26 binary indicators (movable property only), N=6,131
2. **Continuous measure:** Index standardised to mean 0, SD 1
3. **Categories (low/medium/high):** Tertile dummies
4. **Real-estate inclusive:** Sum of q26 including real-estate items (q26_9)

Asset-coefficient magnitudes are stable across these alternatives, though the real-estate-inclusive index shows slightly different associations, likely because real-estate ownership has different implications for collateral capacity and household stability than movable property.

## A.6 Purpose-Specific Targeting

Appendix Tables A9–A12 report models predicting use of each welfare programme (Household Rehabilitation Fund, maternal welfare, educational loans, medical-expense loans) as a function of programme-specific need indicators and control variables.

**Key results:**

| Programme | Primary Need Indicator | Coeff | SE | t-stat |
|---|---|---:|---:|---:|
| HRF | Business failure | 0.158 | 0.015 | 10.4 |
| Maternal | Female head | 0.082 | 0.009 | 9.1 |
| Educational | School-age children | 0.034 | 0.008 | 4.2 |
| Medical | Prolonged illness | 0.167 | 0.014 | 11.9 |

Strong purpose-specific associations confirm that welfare programmes reached households whose reported needs aligned with programme mandates.

## A.7 Extended Layered-Borrowing Models

Appendix Table A13 reports the full set of coefficients for layered-borrowing models (Table 6 in main text), including all risk-factor controls and demographic variables.

Additional outcomes beyond the main text:

- **Purchases on account:** Welfare-loan association +2.3 pp (SE 1.1), pawnshop association +1.8 pp (SE 1.6)
- **Savings withdrawal:** Welfare-loan association -3.3 pp (SE 1.2), pawnshop association -2.2 pp (SE 1.5)
- **Asset sales:** Welfare-loan association -1.2 pp (SE 0.8), pawnshop association +1.6 pp (SE 1.1)

## A.8 Count Outcomes and Combinations

Appendix Table A14 reports associations between institutional-use histories and:

- **Number of coping strategies:** Count of q10 items reported (range 0–7)
- **Credit-strategy count:** Count excluding food compression (range 0–6)
- **Any relational credit:** 1 if employer, friend, or neighbour borrowing reported
- **Any collateral credit:** 1 if pawning reported
- **Any trade credit:** 1 if purchases on account reported

Results show that institutional-credit users employed more strategies on average, consistent with a picture of crisis management through multiple mechanisms rather than reliance on a single source.

## A.9 Bootstrap Confidence Intervals and Inference Robustness

Appendix Table A15 reports household-level bootstrap confidence intervals (1,000 replications) for key coefficients in the main models. Bootstrap standard errors are uniformly smaller than HC3 standard errors, reflecting positive within-household correlation of residuals. The use of HC3 rather than bootstrap inference is therefore conservative.

## A.10 Multicollinearity and Diagnostics

Variance inflation factors (VIFs) for all variables in the full specification are reported in Appendix Table A16. No variable has a VIF exceeding 3.0, indicating that multicollinearity is not a substantive concern.

Appendix Table A17 reports leverage and influence diagnostics for the main models. The DFFITS and Cook's D statistics identify several high-leverage observations but no points with implausible influence (Cook's D > 0.01). Exclusion of high-leverage points does not materially change coefficient estimates.

## A.11 Linear Probability Model Diagnostic Checks

Appendix Figure A1 plots the distribution of fitted values from the main welfare-selection model. Fitted probabilities range from -0.042 to 0.689, with approximately 8 percent of fitted values lying outside [0,1]. This is within acceptable bounds for an LPM with n=6,131 and a binary outcome with prevalence of 12.3%.

Appendix Figure A2 plots residuals against fitted values, showing approximately constant variance (no strong pattern). No evidence of heteroskedasticity beyond what HC3 standard errors accommodate.

## A.12 Supplementary Discussion: Asset Index Construction

The asset index used throughout the analysis is a simple count of movable household items. The SSJDA codebook provides question q26, which lists 9 asset categories:

1. q26_1: Furniture
2. q26_2: Cooking equipment  
3. q26_3: Clothing and textiles
4. q26_4: Entertainment equipment (radio, etc.)
5. q26_5: Tools and implements
6. q26_6: Animals/livestock
7. q26_7: (unspecified household goods)
8. q26_8: (unspecified items)
9. q26_9: Real estate

The main analysis excludes real estate (q26_9) because its reporting may be subject to different response biases than movable property, and because real-estate ownership has distinct institutional implications (e.g., as collateral for formal bank credit, which is outside the scope of this analysis).

The simple count approach treats each item equally, giving no additional weight to valuable or strategic items (e.g., tools relevant to self-employment). Alternative approaches (weighted indices, real-estate inclusion, categorical grouping) yield qualitatively similar results, as shown in Appendix Table A8.

