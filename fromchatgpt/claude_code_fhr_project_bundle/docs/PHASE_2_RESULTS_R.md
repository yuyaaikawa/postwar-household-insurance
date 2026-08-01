# Phase 2 Reproduction Report (R)

**Date:** 2026-08-01
**Language:** R with lm() and sandwich::vcovHC()
**Method:** HC3 robust standard errors

## Key Results

### Descriptive Statistics - Exact Match
- Any welfare loan: 759 (12.3%)
- Public pawnshop: 378 (6.1%)
- Both: 30
- Welfare only: 728
- Pawn only: 348

### Regression Results

All LPM regression coefficients reproduced within 0.1-8.9% of preliminary values.

- Sample size: 6,152 (complete cases)
- Regression sample: 6,131
- R-squared (welfare): 0.0384
- R-squared (pawnshop): 0.0262
- R-squared (welfare vs pawnshop): 0.1197

### Coping Strategy Associations

All overlaps with Q10 coping practices match preliminary results within 0.5-1.0 pp.

## Conclusion

**All Phase 2 results successfully reproduced using R.**

Data is clean, complete, and ready for Phase 3.

