# Reproduction Instructions

**Project:** Institutional Choice in Postwar Japan: Welfare Loans vs. Public Pawnshops, 1961  
**Author:** Autonomous Analysis (Phases 1–4)  
**Date:** August 2, 2026  
**Target Journal:** Financial History Review

## Quick Start

All analysis scripts are in `code/` directory. To reproduce the complete pipeline:

```bash
cd C:\Users\yuyaa\git\postwar_household_insurance\postwar_household_insurance\fromchatgpt\claude_code_fhr_project_bundle

# Run all phases in sequence
Rscript code/00_setup_paths.R
Rscript code/01_data_audit.R
Rscript code/02_data_cleaning.R
Rscript code/03_reproduce_results.R
Rscript code/04_descriptive_tables.R
Rscript code/05_logit_probit_ame.R
Rscript code/06_purpose_targeting.R
Rscript code/07_layered_borrowing.R
Rscript code/08_robustness_checks.R

# Generate publication-quality output
python3 code/python/phase4_publication_tables.py
```

Output files:
- Tables: `output/tables/*.csv`
- Figures: `output/figures/*.pdf` and `.png`
- Manuscript: `paper/FULL_WORKING_DRAFT.md`
- Documentation: `docs/*.md`

## Data Location

Raw data (read-only):
```
C:\Users\yuyaa\git\postwar_household_insurance\postwar_household_insurance\data\raw\
```

Files:
- `ssjda1331.csv` or `ssjda1331.dta`
- `ssjda1331_labels.txt`
- `ssjda1331_readme.docx`

**DO NOT MODIFY RAW DATA FILES.**

## Software Requirements

### R (Primary)
R 3.6+ with packages:
- tidyverse, fixest, modelsummary, ggplot2, knitr

Install: `install.packages(c("tidyverse", "fixest", "modelsummary", "ggplot2", "knitr"))`

### Python (Backup)
Python 3.7+ with:
- pandas, numpy, statsmodels, matplotlib, scipy

Install: `pip install pandas numpy statsmodels matplotlib scipy`

## Key Results for Verification

After running all scripts, check:

**Descriptive Statistics:**
- Total sample: 6,152 households
- Complete cases: 6,131
- Welfare loan users: 759 (12.3%)
- Pawnshop users: 378 (6.1%)
- Both: 30 (0.5%)

**Main Coefficients:**
- Business failure → welfare: +0.0856 (SE 0.0067)
- Prolonged illness → welfare: +0.0506 (SE 0.0057)
- Public assistance → welfare: -0.0613 (SE 0.0082)
- Pawnshop history → pawning: +0.377 (SE 0.022)

**Model Fit:**
- Welfare selection R²: 0.0384
- Pawnshop selection R²: 0.0262
- Direct welfare-vs-pawnshop R²: 0.1197

## Documentation

See `docs/` directory:
- `data_audit.md` — Variable definitions
- `variable_dictionary.md` — Complete codebook
- `analysis_decisions.md` — Methodology
- `main_text_appendix_decisions.md` — Table placement rationale
- `final_audit_report.md` — Complete audit findings

## Manuscript Files

- `paper/chapter2_institutional_background_fhr.md` — Institutional history (authoritative)
- `paper/chapter3_data.md` — Data chapter
- `paper/chapter4_empirical_framework.md` — Empirical strategy
- `paper/chapter5_results.md` — Results with tables
- `paper/appendix_empirical.md` — Extended appendix
- `paper/FULL_WORKING_DRAFT.md` — Complete working draft
- `paper/references.bib` — BibTeX references

## LaTeX Compilation

```bash
cd paper
pdflatex draft.tex
bibtex draft.aux
pdflatex draft.tex
pdflatex draft.tex
```

## Questions?

Consult:
- `docs/data_audit.md` for data questions
- `code/` scripts for implementation details
- `paper/` chapters for interpretation
- `docs/final_audit_report.md` for audit findings

---
End of Reproduction Instructions
Generated: August 2, 2026
