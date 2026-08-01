# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an empirical economics paper project focused on postwar household insurance. The project follows a standard research workflow: data cleaning, exploratory analysis, regression analysis, and paper writing.

## Project Structure

```
postwar_household_insurance/
├── data/
│   ├── raw/              # Original data (never modified)
│   ├── clean/            # Processed data ready for analysis
│   └── analysis/         # Output datasets from analysis
├── code/                 # Analysis scripts (R and/or Python)
├── tables/               # Regression tables and summary statistics
├── figures/              # Plots and visualizations
├── paper/                # Manuscript in LaTeX or Rmarkdown
└── CLAUDE.md             # This file
```

## Key Development Practices

### Data Handling
- **Never modify raw data files.** All data transformations happen in separate scripts that output to `data/clean/` or `data/analysis/`.
- Document all data sources and processing steps clearly.
- Include data dictionaries or codebooks describing variables.

### Analysis Workflow
- Use R as the primary tool for data cleaning, analysis, and visualization.
- Use Python only for specific tasks (web scraping, PDF processing) if needed.
- Each analysis script should be self-contained and reproducible.
- Use version control for all analysis code.

### Causal Inference & Specification
- Always clearly state identifying assumptions in code comments.
- Be careful about:
  - Endogeneity and reverse causality
  - Sample definitions and selection bias
  - Choice of fixed effects and control variables
  - Standard error specifications (clustering, bootstrap, etc.)
- Document the rationale for each specification choice.

### Robustness Checks
When suggesting robustness checks, explain what concern or alternative interpretation each check addresses:
- Alternative specifications (different controls, functional forms)
- Alternative samples (exclude outliers, subgroup analysis)
- Different estimators (OLS vs. IV, etc.)
- Placebo tests and falsification exercises

### Paper Writing
- Use LaTeX for the final manuscript or Rmarkdown for dynamic documents.
- Structure: Introduction → Literature Review → Data → Empirical Strategy → Results → Robustness → Conclusion.
- Use `/econ-write` skill when writing, editing, or revising the manuscript or any section.

## Common Commands

### R Workflow
```r
# Install required packages
install.packages(c("tidyverse", "fixest", "modelsummary", "ggplot2", "lfe"))

# Run analysis script
source("code/01_data_cleaning.R")
source("code/02_analysis.R")

# Render paper (if using Rmarkdown)
rmarkdown::render("paper/manuscript.Rmd")
```

### File Naming Conventions
- Analysis scripts: `01_data_cleaning.R`, `02_analysis.R`, `03_robustness_checks.R`
- Output files: descriptive names with date if versioning is needed

## Regression Analysis Guidance

When specifying regressions:
- Use `fixest::feols()` for fixed effects models (more efficient than `felm()` or `lm()` with dummies).
- Use `modelsummary::modelsummary()` to create publication-quality regression tables.
- Always report: sample size, R², adjusted R², and degrees of freedom.
- Justify clustering choices when reporting clustered standard errors.
- Consider multiple hypothesis testing corrections if running many tests.

## Exploratory Data Analysis

- Start with descriptive statistics and data quality checks.
- Create visualizations early to identify patterns, outliers, and data issues.
- Document data anomalies and how they're handled.

## Writing Standards

- Use clear, precise, professional academic tone.
- Avoid overstating causal claims—distinguish between correlation and causation.
- When reporting results, emphasize magnitude and statistical significance appropriately.
- For tables and figures: include informative titles and notes explaining specifications.

## Integration with Global Guidelines

This project follows the general development guidelines in your global CLAUDE.md for applied economics research. Key points:
- R is the default tool for analysis.
- LaTeX for papers and equations.
- Distinguish clearly between facts, assumptions, and speculation.
- Use `/econ-write` skill for all paper writing and editing.
