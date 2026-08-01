# Prompt 04: Final reproducibility and factual audit

Conduct a hostile-reviewer audit of the entire project.

## Empirical audit

- Run the complete pipeline from a clean session.
- Confirm that raw data are never modified.
- Confirm every table and figure is script-generated.
- Verify all sample counts, means, coefficients, standard errors, p-values, confidence intervals, and multiple-testing adjustments.
- Check that table notes match the actual specification.
- Check variable coding against the label file and readme.
- Search for accidental treatment of 9/99/999/888 values as substantive data.
- Check that the same analysis sample is used when coefficients are compared.
- Verify that “both” group size is sufficient for every model that uses it.
- Check logit/probit convergence, separation, influence, and LPM fitted values.
- Confirm that no result relies on an undocumented manual step.

## Interpretive audit

Search the draft for:
- “effect,” “impact,” “caused,” “led to,” “after,” “continued,” “prevented,” and similar causal or temporal language;
- claims that the sample represents Kanagawa or Japan;
- claims that assets unambiguously measure wealth or collateral;
- claims that q02_21 is a formal creditworthiness score;
- claims that welfare credit replaced or failed to replace pawnshops causally.

Revise or qualify every unsupported statement.

## Historical and citation audit

- Preserve the supplied Chapter 2 unless a source-verified correction is needed.
- Open every cited source that can be accessed and verify that it supports the associated statement.
- Confirm dates, institutional names, units, table numbers, and translated quotations.
- Keep direct quotations short and supply the original Japanese in a note when useful.
- Mark any citation that could not be verified.
- Ensure every bibliography entry is cited and every citation appears in the bibliography.

## Deliverables

- `docs/final_audit_report.md`
- `docs/unresolved_issues.md`
- updated clean code and manuscript
- `REPRODUCTION.md` containing exact commands and software versions
- a final list of the five strongest claims and the five claims the paper must not make
