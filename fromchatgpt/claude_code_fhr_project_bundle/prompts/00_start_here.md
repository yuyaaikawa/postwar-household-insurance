# START HERE: Master prompt for Claude Code

Read `CLAUDE.md` first and follow it throughout the project.

Your task is to reproduce, audit, improve, and extend the analysis developed so far for an English-language paper aimed at *Financial History Review*. Work autonomously through the phases below, but do not sacrifice accuracy for speed.

## Inputs

Use:

- `paper/chapter2_institutional_background_fhr.md` as the current Chapter 2.
- `data/raw/ssjda1331.dta` as the preferred raw data file.
- `data/raw/ssjda1331.csv` as a software-neutral backup.
- `data/raw/ssjda1331_labels.txt` and `data/raw/ssjda1331_readme.docx` to interpret variables and special codes.
- `code/legacy/*.do` only as records of prior exploratory analysis.
- `docs/preliminary_results_to_reproduce.md` as a checklist of conversation-reported findings, not as ground truth.
- `data/external/public_assistance_historical.xls` only if useful for validating the macro context in Chapter 2.

## Overall objective

Build a fully reproducible empirical project that answers two main historical questions:

1. Which low-income households were connected to welfare lending, and which relied on public pawnshops?
2. Did welfare credit replace older and informal sources of household finance, or was it layered on top of them?

The strongest possible paper should integrate institutional history and microdata without pretending that the cross-sectional historical survey identifies causal effects.

## Phase 1: Source and data audit

Before running substantive regressions:

1. Read the SSJDA readme and full label file.
2. Produce `docs/data_audit.md` documenting:
   - observation and variable counts;
   - unit of observation;
   - geographic coverage;
   - survey-selection limitations;
   - all relevant special missing/non-applicable codes;
   - exact wording and value coding for q02, q03, q04, q07–q10, q12, q19–q22, q25, q26, q28–q30;
   - whether q10 should be called current, usual, hypothetical, or conditional coping behaviour.
3. Produce `docs/variable_dictionary.md` listing every constructed variable, source variables, valid values, exclusions, and interpretation.
4. Verify whether household member 1 is always the household head. Do not assume this without checking.
5. Create a clean, documented analysis file without modifying raw data.

Stop and flag any ambiguity that materially changes the interpretation. Resolve it from the source files where possible rather than guessing.

## Phase 2: Exact reproduction of earlier exploratory results

Independently regenerate the preliminary results listed in `docs/preliminary_results_to_reproduce.md`.

At minimum reproduce:

- total sample size;
- use rates for each welfare fund and public pawnshops;
- the “any welfare loan” definition;
- welfare-only, pawn-only, both, and neither counts;
- the main LPM estimates;
- logit/probit average marginal effects;
- the direct welfare-only versus pawn-only comparison;
- purpose-specific regressions;
- associations between histories of institutional use and q10 coping strategies;
- all relevant sample counts.

Create a reconciliation memo:
- `docs/reproduction_reconciliation.md`

For every discrepancy, determine whether it arises from missing-value handling, variable definitions, sample restrictions, software, standard-error choice, or a prior error. Do not force the new output to match the earlier numbers.

## Phase 3: Improve the empirical design

Update the analysis where doing so strengthens accuracy or historical interpretation.

### A. Descriptive architecture

Construct clear descriptive tables and figures showing:

- prevalence of each public program and coping strategy;
- the four institutional-use groups: neither, welfare only, pawn only, both;
- household characteristics across these groups;
- overlaps among purchases on account, pawning, employer borrowing, friend/neighbour borrowing, asset sales, savings withdrawals, and food compression;
- the number and combinations of coping strategies used.

Use an UpSet plot or another legible combination plot rather than an unreadable Venn diagram.

### B. Selection across institutions

Estimate:

1. Separate LPMs for any welfare loan and public-pawnshop history, using HC3 standard errors and city fixed effects.
2. Logit and probit models reported as average marginal effects.
3. A direct comparison among welfare-only and pawn-only households.
4. A stacked model or another transparent test of whether key covariate coefficients differ across the two institutional outcomes.
5. A multinomial model only as a supplementary analysis, because the “both” group is small.
6. Adjusted predicted probabilities for historically interpretable household profiles.

Use hierarchical specifications:
- income and low-income factors;
- then city and household type;
- then demographic, employment, public-assistance, and asset controls.

Do not treat the fullest specification automatically as the only correct model. Explain what each control block absorbs and whether any variable may be contemporaneous or endogenous.

### C. Purpose-specific targeting

Analyse separately:

- maternal welfare fund;
- Household Rehabilitation Fund;
- special educational fund;
- medical-expense loan.

Test whether use aligns with the corresponding needs recorded in the survey, such as mother-only households, business-fund needs/self-employment, school-fund needs and education hardship, and medical need or medical debt.

Present this as validation of institutional matching or targeting, not as a causal effect.

### D. Layered borrowing

Develop the second main contribution carefully.

Group coping strategies into:

- collateral credit: pawning;
- relational credit: employer and friend/neighbour borrowing;
- trade credit: purchases on account;
- self-finance/liquidation: savings withdrawal and asset sales;
- consumption compression: food cuts;
- public welfare-credit history.

Estimate associations between welfare-loan history, public-pawnshop history, and each q10 strategy, conditional on the same covariate blocks.

Also analyse:
- a count of credit strategies;
- a count excluding non-credit adjustment such as food cuts;
- co-use combinations;
- pairwise associations or tetrachoric correlations where appropriate.

Important: Unless chronology is established, do not call this “borrowing after the welfare loan” or direct persistence. Use terms such as “overlap between prior institutional-use histories and reported coping practices.” The association between q04_8 and q10_2 may be described as suggestive of recurrent pawning only with an explicit timing caveat.

### E. Robustness and sensitivity

At minimum:

- alternative definitions of welfare credit;
- HC3, logit AMEs, and probit AMEs;
- household bootstrap stratified by city;
- complete cases versus transparent missing-data alternatives;
- exclusion of households with public-assistance history;
- working-age household heads;
- large-city subsample;
- one or two recorded low-income factors;
- leave-one-city-out estimates;
- alternative asset indices, including movable goods, real estate, plausibly pawnable goods, and separate asset components;
- specifications excluding “low living ability” because its provenance and interpretation may differ from objective shocks;
- Benjamini–Hochberg false-discovery-rate corrections within pre-specified families of outcomes;
- influence and leverage diagnostics;
- checks of LPM fitted values;
- sensitivity to excluding potentially post-treatment or contemporaneous controls.

Do not use city-clustered conventional standard errors as the default with six cities. If shown, treat them as a fragile sensitivity check. Explain the inference choice.

### F. Interpretation discipline

The central paper may conclude, if supported, that:

- welfare lending and public pawnbroking served observably different households;
- administrative welfare credit appears associated with some material or rehabilitation basis;
- public pawnshops remained connected to immediate or recurrent liquidity needs;
- welfare credit did not obviously eliminate relational, trade, or collateral credit;
- postwar welfare-state expansion added a new lending technology to a layered household-finance system.

It may not conclude from these data alone that:

- welfare loans caused households to avoid public assistance;
- welfare loans improved income, health, education, or business outcomes;
- welfare loans caused later pawning or informal borrowing;
- welfare loans causally displaced public pawnshops;
- the sample represents all low-income households in Kanagawa or Japan.

## Phase 4: Tables and figures

Produce publication-quality, script-generated outputs.

Main-text candidates:

1. Figure 1 and Table 1 from the existing Chapter 2.
2. Table 2: sample characteristics and institutional-use groups.
3. Table 3: selection into welfare lending and public pawnbroking.
4. Figure 2: coefficient or average-marginal-effect comparison across the two institutions.
5. Table 4: direct welfare-only versus pawn-only comparison and coefficient-difference tests.
6. Table 5: purpose-specific targeting.
7. Figure 3: combinations of coping strategies.
8. Table 6: institutional-use histories and layered borrowing.

Place alternative definitions, extensive robustness, city-specific results, and multinomial models in the appendix.

Use informative titles, notes, sample definitions, and units. Every table must be reproducible from code.

## Phase 5: Draft the empirical chapters

Do not rewrite Chapter 2 from scratch. Use it as the bridge into:

- `paper/chapter3_data.md`
- `paper/chapter4_empirical_framework.md`
- `paper/chapter5_results.md`
- `paper/appendix_empirical.md`

The Data chapter should be candid about survey selection, reconstruction, coding, and timing limits.

The empirical framework should explain that the regressions characterise institutional selection and co-use rather than identify causal effects.

The Results chapter should be organised around:
1. the landscape of low-income household finance;
2. selection across welfare lending and public pawnshops;
3. purpose-specific matching;
4. substitution versus layered borrowing;
5. robustness and limitations.

After those chapters are stable, assemble `paper/full_working_draft.md` with placeholders for the Introduction, literature review/contribution, discussion, and conclusion. Do not invent citations.

## Phase 6: Final audit

Run the instructions in `prompts/04_final_audit.md`.

## Execution requirements

- Detect whether Stata is available.
- If Stata is available, use Stata 18-compatible scripts as the primary replication pipeline.
- If Stata is unavailable, reproduce all results in Python using pandas, statsmodels, scipy, and matplotlib, and still produce clean Stata do-files for the user.
- Never use manual edits to final tables.
- Save logs and machine-readable estimates.
- Write a concise progress memo after each phase.
- Continue through the phases unless a genuinely blocking ambiguity cannot be resolved from the files.
