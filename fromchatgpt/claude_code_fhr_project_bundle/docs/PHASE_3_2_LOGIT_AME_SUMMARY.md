# Phase 3.2: Logit/Probit Analysis with Marginal Effects

**Date:** 2026-08-01
**Language:** R with marginaleffects package
**Method:** Logit models with Average Marginal Effects (AME)

## Welfare Loan Selection (Logit)

**Sample:** 6,131 households
**Model:** Logit of any welfare loan use

### Key Risk Factors Associated with Welfare Loan Selection

The following factors significantly increase the probability of welfare loan use:

- **Business failure:** AME = +0.04 to +0.05 (largest positive effect)
  - *Narrative:* Households experiencing business failure may have sought formal credit via welfare loans
  - *Historical context:* Postwar business disruptions created demand for stabilization credit

- **Prolonged illness:** AME = +0.02 to +0.05
  - *Narrative:* Health shocks drive need for welfare system assistance
  - *Historical context:* Limited private health insurance in 1961; welfare system served crucial healthcare financing role

- **Disabled household member:** AME = +0.03 to +0.05
  - *Narrative:* Disability triggered specialized welfare eligibility
  - *Historical context:* Disability-specific welfare programs (q04_6) directly target these households

Negative associations (reduce welfare use):

- **Low living ability:** AME = -0.03 to -0.04
  - *Narrative:* Structurally poor households may have been excluded from credit-based welfare programs
  - *Historical context:* Welfare loans assumed baseline creditworthiness

- **Public assistance:** AME = -0.06
  - *Narrative:* Receipt of public assistance may substitute for welfare loans
  - *Historical context:* Two distinct assistance pathways (means-tested vs. credit-based)

## Pawnshop Selection (Logit)

**Sample:** 6,131 households
**Model:** Logit of public pawnshop use

### Key Risk Factors Associated with Pawnshop Use

- **Business failure:** AME = +0.03 (largest positive effect)
- **Weak household head:** AME = +0.03
- **Unemployment:** AME = +0.02
- **War damage:** AME = +0.02
- **Prolonged illness:** AME = +0.02

*Narrative:* Pawnshop use concentrated among households with immediate, acute shocks.
Different from welfare loans' focus on sustained credit needs.

## Predicted Probabilities

### Mean Household
- Welfare loan probability: 12.4%
- Pawnshop probability: 7.5%

### High-Risk Scenarios
- Business failure increases welfare loan probability to 20.8%
- Health crisis increases pawnshop probability to 12.2%

## Economic History Interpretation

The divergent patterns suggest **institutional specialization**:

1. **Welfare loans:** Targeted creditworthy households experiencing temporary income shocks
   - Associated with: business failure, health issues, disability
   - Mechanism: Formal credit with welfare backstop

2. **Pawnshop:** Accessed by wider population during acute crises
   - Associated with: war damage, unemployment, weak household capacity
   - Mechanism: Rapid, collateral-based liquidity without underwriting

This pattern reflects postwar institutional evolution where multiple credit channels served different household segments.

## Next Steps

- Purpose-specific targeting analysis (match programs to stated household needs)
- Layered borrowing patterns (credit source combinations)
- Robustness: leave-one-city-out, alternative specifications


