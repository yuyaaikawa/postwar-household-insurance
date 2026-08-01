# Preliminary results to reproduce independently

These figures were reported during exploratory conversation and may contain coding, sample, or interpretive errors. They are **not ground truth**. Reproduce them from the raw files and document every discrepancy.

## Descriptive benchmarks

- Total observations: 6,152 households.
- Any welfare loan, provisionally defined as any use history of:
  - maternal welfare fund (`q04_2`);
  - Household Rehabilitation Fund (`q04_3`);
  - special educational fund (`q04_4`);
  - medical-expense loan (`q04_7`).
- Approximate reported prevalence:
  - any welfare loan: 12.3%;
  - public pawnshop history (`q04_8`): 6.1%;
  - welfare only: 729;
  - pawn only: 348;
  - both: 30.
- Earlier complete-case regressions used approximately 5,893–5,894 observations.

## Reported full-specification LPM associations

All are approximate percentage-point coefficients and must be regenerated.

### Any welfare loan

- business failure: +8.6 pp;
- prolonged illness: +5.2 pp;
- household member with a disability: +4.7 pp;
- “low living ability”: −3.3 pp;
- public-assistance history: −6.2 pp;
- one additional household asset: +0.68 pp.

### Public pawnshop history

- business failure: +6.6 pp;
- weak/sickly household economic head: +4.5 pp;
- unemployment of the main earner: +3.5 pp;
- war damage: +2.9 pp;
- “low living ability”: +2.9 pp;
- decline in labour income: +2.7 pp;
- prolonged illness: +2.5 pp;
- one additional household asset: −0.72 pp.

## Reported direct welfare-only versus pawn-only comparison

Among households using only one of the two institutional types, the probability of being in welfare lending rather than public pawnbroking was reportedly associated with:

- “low living ability”: −14.5 pp;
- weak/sickly household economic head: −11.4 pp;
- public-assistance history: −15.6 pp;
- one additional household asset: +3.84 pp.

## Reported purpose-specific patterns

Approximate earlier findings included:

- maternal welfare fund strongly associated with mother-only household status;
- Household Rehabilitation Fund associated with business failure, current self-employment, and reported need for business funds;
- special educational fund associated with school-fund needs and inability to purchase school materials;
- medical-expense loans associated with prolonged illness, long-term treatment, and medical need.

All definitions and sample restrictions must be rechecked.

## Reported overlap with coping practices

Earlier exploratory LPMs reportedly found:

| Coping-practice outcome | Welfare-loan history | Public-pawnshop history |
|---|---:|---:|
| Pawning | +5.5 pp | +38.3 pp |
| Employer borrowing | +0.7 pp | +9.0 pp |
| Friend/neighbour borrowing | +6.7 pp | +10.5 pp |
| Asset sales | −1.2 pp | +1.4 pp |
| Savings withdrawal | −3.2 pp | −2.0 pp |
| Food cuts | −2.4 pp | −0.5 pp |

These must not be described as behaviour occurring after a loan unless the survey documentation establishes temporal order. The q04 variables are use histories; the precise timing and interpretation of q10 must be audited.

## Reported robustness claims to verify

Earlier exploratory work claimed that:

- main findings were similar in logit and probit average marginal effects;
- business failure, prolonged illness, public-assistance history, and “low living ability” were among the more robust welfare-loan correlates;
- business failure, weak household head, unemployment, war damage, and “low living ability” were among the more robust pawnshop correlates;
- multiple-testing adjustment weakened some secondary results;
- results survived several sample restrictions and leave-one-city-out checks;
- asset results were sensitive to the exact asset definition.

Reproduce these claims rather than assuming them.
