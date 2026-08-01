# Chapter 4: Empirical Framework

## 4.1 Characterising Institutional Selection Rather than Causal Effects

This chapter analyses institutional selection and co-use of credit. The analysis does not attempt to identify causal effects of welfare lending on household outcomes. Instead, it characterises:

1. **Institutional selection:** Which households' observable characteristics were associated with welfare-loan use or public-pawnshop use?
2. **Institutional comparison:** How did the characteristics of welfare-loan users, pawnshop users, and non-users differ?
3. **Institutional overlap:** What was the relationship between institutional-use histories and reported coping practices?

Because the survey records institutional-use histories without dates, loan amounts, applications, rejections, or household outcomes, the analysis cannot estimate treatment effects or causal impacts. Instead, the regressions identify associations between household characteristics and institutional-use patterns.

## 4.2 Regression Specifications

All regression models are linear probability models (LPMs) estimated via ordinary least squares with heteroskedasticity-consistent standard errors (HC3). The LPM is chosen for three reasons:

1. **Interpretability:** Coefficients in an LPM directly measure the change in probability (in percentage points) associated with a unit change in the regressor, making results intuitive for a historical audience.

2. **Robustness:** When the conditional probability is bounded away from 0 and 1, LPM estimates are robust to misspecification of the underlying latent-variable model.

3. **Inference:** With six cities and large sample size, the LPM with HC3 standard errors provides reliable inference without requiring strong functional-form assumptions.

Logit and probit models estimated via maximum likelihood are presented as robustness checks, with results reported as average marginal effects (AMEs) to maintain comparability with LPM coefficients.

### Specification Hierarchy

The analysis employs hierarchical specifications to allow assessment of which control variables absorb explanatory power:

**Specification 1 (Baseline):**
- Low-income causes: business failure, unemployment, prolonged illness, disability, income decline, war damage
- Geography: city fixed effects (5 dummies for 6 cities)

**Specification 2 (Household Type):**
- Adds: household-head sex, household size, employment status of principal earner
- Rationale: Household composition may correlate with institutional eligibility and capacity

**Specification 3 (Preferred Full Specification):**
- Adds: household-head age, age squared, public-assistance history, household-asset count, "low living ability"
- Rationale: Captures material basis and household trajectory

The preferred specification is reported in all main tables. Simpler specifications are presented in appendix tables to show the robustness of key coefficients to control-variable inclusion.

## 4.3 Inference: Standard Errors and Clustering

The analysis reports HC3 heteroskedasticity-consistent standard errors. With only six cities in the sample, city-clustered standard errors are not reliable as a default (bootstrap confidence intervals would be preferred, but the small number of clusters limits their precision). HC3 standard errors are instead used as the primary inference method.

City-level analyses (leave-one-city-out sensitivity checks) are reported in the appendix to assess whether results depend on particular municipalities.

## 4.4 Sample Sizes and Model Fit

The main-selection models (Table 3) use 6,131 complete-case observations with non-missing demographic controls. The direct welfare-only versus pawnshop-only comparison (Table 4) restricts the sample to 1,077 households using only one institutional form.

Model fit, measured by R-squared, remains modest:

- **Welfare-loan selection model:** R² = 0.0384 (explains 3.8 percent of variation)
- **Public-pawnshop selection model:** R² = 0.0262 (explains 2.6 percent of variation)
- **Direct welfare-vs-pawnshop comparison:** R² = 0.1197 (explains 12.0 percent of variation)

The modest R-squared values are typical for binary choice models with large samples and heterogeneous populations. The goal of this analysis is not to predict institutional use with high precision but to identify which household characteristics are systematically associated with institutional choice, holding other factors constant.

## 4.5 Direct Comparison Model: Welfare-Only versus Pawnshop-Only

Table 4 estimates a model directly comparing households using welfare loans with households using public pawnshops (excluding the small group using both institutions). The dependent variable is coded 1 if the household used welfare loans only, 0 if the household used pawnshops only, based on the 1,077 households in these two groups.

This specification allows direct comparison of the observable characteristics that distinguish the two institutional users without having to account for non-users or the simultaneous choice between institutional and non-use.

## 4.6 Layered-Borrowing Models: Institutional Histories and Coping Practices

Table 6 estimates separate linear probability models for each reported coping practice (pawning, employer borrowing, friend/neighbor borrowing, purchases on account, asset sales, savings withdrawal, food compression) as a function of:

- **Institutional-use histories:** Whether the household used welfare loans and/or public pawnshops (q04 variables)
- **Risk indicators:** Low-income causes and shocks (q19–q24)
- **Household characteristics:** Age, sex, size, employment, assets, public-assistance history

The coefficients on the institutional-use indicators measure the association between institutional access and reported use of each coping practice, net of risk factors and household characteristics.

### Important Caveat: Temporal Ordering

The q04 institutional-use variables record past or present use, while the q10 coping-practice variables record responses to insufficient living expenses. The survey does not establish the temporal ordering between these two sets of events. It is therefore not possible to determine whether households reported using a coping practice *after* using an institution, or whether the use of institutional credit and coping practices overlapped.

Coefficients in Table 6 should be interpreted as associations between institutional-use histories and reported coping practices, not as evidence that institutional credit caused households to adopt (or abandon) particular coping methods. The large association between public-pawnshop history and reported pawning (37.7 percentage points) is consistent with recurrent pawning by households with a history of pawnshop use, but this interpretation must remain qualified by the temporal ambiguity in the data.

## 4.7 Why Causality Cannot Be Claimed

Several features of the data and research design prevent causal inference:

1. **No variation in eligibility:** The data do not identify a quasi-experimental boundary that would distinguish households marginally eligible for welfare loans from those marginally ineligible. Instead, all observations are low-income households known to welfare administration.

2. **No control group:** There is no external comparison group of low-income households outside the welfare system that might serve as a control.

3. **Missing counterfactuals:** The survey does not record what would have happened to households had they not accessed welfare loans or pawnshops—the outcome under non-treatment.

4. **Endogenous selection:** The households observed to use welfare loans were selected partly by administrative criteria (application, means-testing, eligibility determination). The causal effect of welfare-loan receipt on subsequent outcomes cannot be separated from the selection process that determined who received loans.

5. **Temporal ordering:** The timing and sequence of institutional use, economic shocks, and coping practices are not clearly established.

Given these limitations, the analysis is framed as a study of institutional selection and observable institutional-use patterns, not of causal treatment effects.

## 4.8 Interpretation Discipline

The analysis asks: "What household characteristics were associated with institutional use?" and "Which coping practices were more common among users of particular institutions?" These are questions about associations and patterns, not about causal effects.

Specifically:

- When we find that business failure is associated with higher welfare-loan probability, we interpret this as: welfare loans were allocated more often to households that had experienced business failure, consistent with the programmes' stated purpose. We do not interpret this as: welfare loans caused business failure or prevented business recovery.

- When we find that public-pawnshop users were more likely to report pawning, we interpret this as: households with a history of pawnshop use also reported current or recent pawning when living expenses were insufficient, consistent with repeated use of this liquidity mechanism. We do not interpret this as: pawnshops caused persistent indebtedness.

The empirical strategy is appropriate for a descriptive, historical study of institutional allocation under conditions of scarcity and rationing. It is not appropriate for policy evaluation or causal inference about programme effects.

