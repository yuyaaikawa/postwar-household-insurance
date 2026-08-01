# CLAUDE.md

## Project

Develop a publishable English-language financial-history paper on welfare credit, public pawnshops, and low-income household finance in postwar Japan, using the 1961 SSJDA 1331 Kanagawa Borderline-Stratum Survey.

The intended journal is *Financial History Review*. The paper should connect household-level evidence to the history of financial intermediation, social policy, and the postwar welfare state.

## Non-negotiable source rule for Chapter 2

Use `paper/chapter2_institutional_background_fhr.md` as the current authoritative draft of Chapter 2.

- Preserve its four-subsection structure, Figure 1, Table 1, core argument, citations, references, and verification notes.
- Do not rewrite Chapter 2 from scratch.
- You may correct or improve it only after checking the cited primary or scholarly source.
- Record every substantive change in `docs/chapter2_change_log.md`, with the original wording, revised wording, and evidentiary reason.
- If internet access is unavailable, do not alter a source-dependent factual statement merely from memory.

## Language and style

- All prose, code comments, tables, figures, file names, and documentation must be in English.
- Write in a clear academic style suitable for an interdisciplinary economic-history audience.
- Distinguish facts, empirical associations, interpretation, and speculation.
- Avoid causal language unless a defensible identification strategy exists.
- Do not call a partial association an effect, impact, treatment effect, or consequence.
- Prefer precise terms such as “is associated with,” “is consistent with,” and “suggests.”
- Explain institutional terminology for readers unfamiliar with Japanese welfare history.
- Use Japanese names and institutional terms consistently, supplying romanised Japanese only where useful.

## Data and reproducibility

Primary raw data:
- `data/raw/ssjda1331.dta`
- `data/raw/ssjda1331.csv`
- `data/raw/ssjda1331_labels.txt`
- `data/raw/ssjda1331_readme.docx`

Never modify files in `data/raw/`.

Read the readme and label file before constructing variables. Audit every special code for nonresponse and not-applicable values rather than assuming that all 9/99/999 values mean the same thing.

The q04 variables record histories of public-program use. They do not report dates, amounts, applications, rejection, repayment, arrears, or default. The q10 variables report methods used when living expenses are insufficient; verify the questionnaire wording before describing them as contemporaneous behaviour. Do not infer that q10 necessarily occurred after q04.

The survey is not a random sample of all Kanagawa households. It contains households visible to welfare administration and also includes surviving questionnaires that did not necessarily satisfy the historical final borderline-stratum tabulation rule. Do not present sample means as population estimates.

## Existing code

Files in `code/legacy/` document earlier exploratory work. They are not authoritative and may contain coding or interpretive errors.

- Reproduce all results independently from the raw data.
- Compare new results with the legacy files.
- Retain useful parts only after validation.
- Never copy a reported coefficient into the paper without regenerating it.

## Core historical questions

1. **Selection across institutions:** Which households were connected to welfare loans, and which used public pawnshops? Did the two institutions serve observably different groups?
2. **Substitution versus layered borrowing:** Were welfare credit and pawnbroking substitutes, or were welfare loans layered on top of employer credit, neighbourhood borrowing, purchases on account, and pawning?
3. **Purpose-specific targeting:** Did individual welfare funds reach households with needs corresponding to their stated institutional purposes?
4. **Historical continuity and change:** Did welfare-state credit replace older household finance, or add a new lending technology to a plural and layered credit system?

## Central interpretation to test, not assume

Welfare loans and public pawnshops were two different technologies of public credit. Welfare lending relied on administrative information, designated uses, guidance, and an expected path to rehabilitation. Pawnbroking relied mainly on pledged goods and rapid small-scale liquidity. This interpretation must be tested against the data and qualified where the data do not support it.

## Required analytical cautions

- Public-assistance history may reflect eligibility, timing, institutional boundaries, or selection. It does not prove that welfare loans prevented public assistance.
- Household assets may proxy material capacity, household type, or items available for pawning. They may also have been reduced by past distress or pawning. Treat coefficients cautiously.
- “Low living ability” may reflect respondent reporting or administrative assessment. Verify the source wording and do not treat it automatically as a formal credit score.
- Historical welfare-loan use and q10 coping strategies have uncertain time ordering. Use “overlap,” “co-use,” or “association,” not “continued after receiving a loan,” unless the source establishes chronology.
- With only six cities, city-clustered standard errors are not reliable as a default. Use city fixed effects and HC3 standard errors; report alternative inference transparently.
- The small “both welfare loan and public pawnshop” group limits multinomial modelling. Treat such models as supplementary.

## Expected project structure

Create and maintain:

- `docs/data_audit.md`
- `docs/variable_dictionary.md`
- `docs/analysis_decisions.md`
- `docs/chapter2_change_log.md`
- `code/00_setup_and_cleaning.do`
- `code/01_descriptives.do`
- `code/02_selection_models.do`
- `code/03_layered_borrowing.do`
- `code/04_targeting_models.do`
- `code/05_robustness.do`
- `code/06_tables_figures.do`
- Python equivalents under `code/python/` if Stata is unavailable
- `output/tables/`
- `output/figures/`
- `output/logs/`
- `paper/chapter3_data.md`
- `paper/chapter4_empirical_framework.md`
- `paper/chapter5_results.md`
- `paper/appendix_empirical.md`
- `paper/full_working_draft.md`
- `REPRODUCTION.md`

## Workflow discipline

1. Audit before estimating.
2. Reproduce before improving.
3. Save machine-readable estimates and sample counts.
4. Keep a complete log.
5. Use scripts, not manual spreadsheet edits, to generate final tables and figures.
6. Make no silent changes to definitions or samples.
7. At the end of each phase, write a short memo stating what was verified, what changed, and what remains uncertain.
