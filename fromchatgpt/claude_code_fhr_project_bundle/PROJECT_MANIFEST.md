# Project manifest

## Purpose

This bundle is designed to be placed in a Claude Code project directory. It contains the current Chapter 2, the SSJDA 1331 microdata and documentation, earlier exploratory Stata scripts, and a complete set of prompts for reproducing and upgrading the analysis.

## Start

1. Unzip the bundle.
2. Open a terminal in the bundle root.
3. Start Claude Code.
4. Paste:  
   `Read CLAUDE.md and prompts/00_start_here.md, then execute the project phase by phase.`
5. For a staged workflow, use the numbered prompts in `prompts/`.

## File map

### Authoritative current manuscript input

- `paper/chapter2_institutional_background_fhr.md`  
  Current provisional Chapter 2. Use this file rather than reconstructing the institutional background from conversation.

### Raw data and documentation

- `data/raw/ssjda1331.dta`
- `data/raw/ssjda1331.csv`
- `data/raw/ssjda1331_labels.txt`
- `data/raw/ssjda1331_readme.docx`

### External macro file

- `data/external/public_assistance_historical.xls`

### Legacy analysis

- `code/legacy/ssjda1331_preliminary_analysis.do`
- `code/legacy/ssjda1331_regressions_revised.do`
- `code/legacy/ssjda1331_full_robustness.do`

These are exploratory and must be audited.

### Prompts

- `prompts/00_start_here.md`: master prompt.
- `prompts/01_reproduce_and_audit.md`: raw-data audit and reproduction.
- `prompts/02_upgrade_empirics.md`: improved analysis and robustness.
- `prompts/03_draft_empirical_sections.md`: manuscript drafting.
- `prompts/04_final_audit.md`: hostile-reviewer audit.

### Prior numerical benchmarks

- `docs/preliminary_results_to_reproduce.md`

## Important

All final work must be in English. Do not treat the conversation-reported coefficients as verified results. The supplied Chapter 2 is the current source-based draft, but any future factual edit must be source-verified and logged.
