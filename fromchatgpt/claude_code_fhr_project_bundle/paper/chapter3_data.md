# Chapter 3: Data and Sample Construction

## 3.1 The Kanagawa Survey of the Borderline Poor

The analysis draws on the 1961 *Kanagawa Survey of the Borderline Poor* (*Kanagawa-ken Henkai Kakei Chosa*), a restored historical survey covering 6,152 low-income households in six Kanagawa prefecture cities. The survey was conducted by Kanagawa Prefecture welfare administration in 1961 to identify and characterise the population of households that fell just above the threshold for public assistance but remained economically vulnerable.

The survey records a comprehensive array of household characteristics, sources of income, employment status, types of economic shocks experienced, histories of public-programme use, and self-reported coping methods when household income proved insufficient. These features make it possible to compare welfare-loan users and public-pawnshop users within the same low-income population and to observe the mix of credit and coping strategies they employed.

## 3.2 Sample Selection and Geographic Coverage

The survey covers six Kanagawa cities (城市1, 城市2, 城市3, 城市41, 城市42, 城市43).¹ The sample is not a random sample of all low-income households in Kanagawa Prefecture or Japan. Rather, it represents households known to or contacted by welfare administration during the survey period. The inclusion criteria appear to have been based partly on income level, partly on visibility to welfare agencies, and partly on survival of questionnaires to the time of archival.

The sample should not be treated as representative of all low-income households even within Kanagawa. Rather, it represents the population of low-income households that came to the attention of welfare administration in 1961.

## 3.3 Unit of Observation and Sample Size

The unit of observation is the household. The dataset contains 6,152 complete records. All regressions are conducted on 6,131 households with non-missing values for the core demographic controls (household head age, household size, household head sex, city of residence, and employment status of the principal earner).

Table 2 displays the cross-tabulation of households by institutional-use history: 5,045 households (82.0 percent) used neither welfare loans nor public pawnshops; 729 (11.8 percent) used welfare loans only; 348 (5.7 percent) used public pawnshops only; and 30 (0.5 percent) used both institutions.

## 3.4 Key Variables

### Institutional-Use Histories (q04 variables)

The survey records histories of use of public programmes and pawnshops. These are binary indicators corresponding to whether the household ever used each programme:

- **q04_any_welfare:** 1 if the household ever used any welfare loan (maternal welfare fund, Household Rehabilitation Fund, special educational fund, or medical-expense loan)
- **q04_pawnshop:** 1 if the household ever used public pawnshops
- **q04_public_assistance:** 1 if the household had a history of receiving public assistance

These variables record institutional-use histories, not dates, amounts, or reasons for rejection. The temporal ordering between q04 events and q10 events (see below) is not observed and cannot be inferred from the questionnaire.

### Reported Coping Practices (q10 variables)

When household members were asked what they did when living expenses were insufficient, they reported the following strategies:

- **q10_pawning:** Pawning or selling goods
- **q10_employer_borrowing:** Borrowing from an employer
- **q10_friend_neighbor_borrowing:** Borrowing from friends or neighbours
- **q10_purchases_on_account:** Making purchases on account (credit from shops or merchants)
- **q10_asset_sales:** Selling household assets
- **q10_savings_withdrawal:** Drawing down household savings
- **q10_food_compression:** Reducing expenditure on food

These variables are binary indicators of whether households reported using each strategy "when living expenses were insufficient." The survey does not specify whether these practices are current, usual, hypothetical, or conditional on a specific shortage. The exact wording of the question q10 appears in the questionnaire; in the absence of further temporal markers, these should be interpreted as reported coping practices rather than as a strictly defined time-bound behaviour.

### Risk Indicators and Economic Shocks (q19-q30 variables)

The survey lists several household economic difficulties in q02 and records reasons for low income in q19–q22:

- **q19_business_failure:** The household experienced business failure or loss of self-employment
- **q20_unemployment:** The principal wage-earner was unemployed
- **q21_prolonged_illness:** The household was affected by prolonged illness
- **q22_income_decline:** The household experienced a decline in labour income or earnings
- **q23_disability:** A household member had a disability
- **q24_war_damage:** The household experienced residual war-related economic loss

The survey also records subjective assessment variables:

- **q30_low_living_ability:** The household was rated as having "low living ability" (*chi-taku-ryoku*) by the survey administrator—a term encompassing financial management capacity, economic stability, and prospects for rehabilitation.

### Household Characteristics and Material Basis

The survey records demographic information on the household head:

- **q02_head_age:** Age of the household head
- **q03_female_head:** Binary indicator of female household head
- **q07_household_size:** Number of household members
- **q08_employment:** Employment status of the principal wage-earner

The survey records household economic position through:

- **q25_asset_count:** A count of household assets—items owned by the household, coded as the simple sum of binary indicators for movable property including furniture, tools, and household goods, excluding real estate and vehicles.

## 3.5 Missing Data and Sample Restrictions

The full sample contains 6,152 observations. Missing values arise in:

1. **Demographic controls:** 21 observations have missing values for household-head age, household size, or female-head status, reducing the regression sample to 6,131.
2. **Risk factors:** The q19–q24 variables have negligible missing values (< 1 percent).
3. **Institutional-use indicators:** q04 variables are binary with no missing values for the subsample used.
4. **Coping strategies:** q10 variables contain missing values for approximately 2–5 percent of observations per variable, depending on the outcome.

For the main selection models (Table 3), analysis proceeds on the 6,131 complete-case households with full demographic control data. For layered-borrowing models (Table 6), each outcome uses the maximum-available sample with non-missing values for that outcome.

## 3.6 Historical Context and Representativeness

The 1961 survey was conducted during the Japanese high-growth period (1956–1973). GDP grew at approximately 10 percent annually. Despite rapid aggregate growth, a substantial segment of the population remained economically vulnerable. The 1958 Ministry of Health and Welfare White Paper estimated that 12.7 percent of Japanese households fell into the "low-consumption-level" category. The survey sample of borderline-stratum households represents those positioned just above absolute public-assistance eligibility but facing recurrent economic distress.

The non-random character of the sample must be remembered in interpretation. Estimates of the prevalence of welfare-loan use, pawnshop use, and coping strategies in this sample should not be generalised to the universe of all low-income households in Kanagawa Prefecture or Japan. Rather, they characterise the subset of low-income households known to welfare administration.

### Data Quality and Restoration

The data were restored to digital form by the Social Science Japan Data Archive (SSJDA) from surviving paper questionnaires. The restoration process involved key-entry verification and consistency checking. Variable labels and value codes were reconstructed from the original questionnaire. The dataset has been deposited in the SSJDA archive and is available to approved researchers under standard data-sharing protocols.

---

**Table 2** presents descriptive statistics for the full sample and for each institutional-use group, displaying the household heterogeneity that motivates the regression analysis. The next chapter explains the empirical strategy used to characterise institutional selection.

