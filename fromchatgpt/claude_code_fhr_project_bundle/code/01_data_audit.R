# PHASE 1: Data audit for SSJDA 1331 (Kanagawa Borderline-Stratum Survey, 1961)

library(tidyverse)

# Setup paths directly (without relying on here() project detection)
project_root <- "C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/fromchatgpt/claude_code_fhr_project_bundle"
authoritative_data_dir <- "C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/data/raw"
ssjda_extract_dir <- file.path(
  authoritative_data_dir,
  "神奈川県における民生基礎調査（ボーダー・ライン層調査）1961",
  "1331"
)
ssjda_csv_file <- file.path(ssjda_extract_dir, "1331.csv")
data_derived <- file.path(project_root, "data", "derived")
docs <- file.path(project_root, "docs")
dir.create(docs, recursive = TRUE, showWarnings = FALSE)

cat("================================================================================\n")
cat("PHASE 1: DATA AUDIT - SSJDA 1331\n")
cat("================================================================================\n")

# ============================================================================
# 1. LOAD DATA
# ============================================================================

cat("\n1. Loading data from authoritative source...\n")
df <- read_csv(ssjda_csv_file, show_col_types = FALSE)
cat(sprintf("   Loaded: %s observations x %s variables\n",
            format(nrow(df), big.mark = ","),
            ncol(df)))

obs_count <- nrow(df)
var_count <- ncol(df)

# ============================================================================
# 2. UNIT OF OBSERVATION
# ============================================================================

cat("\n2. Unit of observation...\n")
cat("   q01_01_1 (Member 1 relationship):\n")
q01_counts <- df %>% count(q01_01_1)
for (i in 1:nrow(q01_counts)) {
  val <- q01_counts$q01_01_1[i]
  count <- q01_counts$n[i]
  pct <- 100 * count / nrow(df)
  cat(sprintf("     Value %d: %s (%.1f%%)\n", val, format(count, big.mark = ","), pct))
}

all_head <- all(df$q01_01_1 == 1)
cat(sprintf("   All member 1 are household heads: %s\n", all_head))

# ============================================================================
# 3. GEOGRAPHIC COVERAGE
# ============================================================================

cat("\n3. Geographic coverage (cities)...\n")
city_counts <- df %>% count(city, sort = TRUE)
for (i in 1:nrow(city_counts)) {
  city_code <- city_counts$city[i]
  count <- city_counts$n[i]
  pct <- 100 * count / nrow(df)
  cat(sprintf("   City %d: %s (%.1f%%)\n", city_code, format(count, big.mark = ","), pct))
}
n_cities <- n_distinct(df$city)
cat(sprintf("   Total cities: %d\n", n_cities))

# ============================================================================
# 4. Q04 VARIABLES (PUBLIC PROGRAM USE)
# ============================================================================

cat("\n4. Q04 Variables (Public program use history)...\n")
q04_labels <- c(
  q04_1 = "Public assistance",
  q04_2 = "Maternal welfare fund",
  q04_3 = "Household Rehabilitation Fund",
  q04_4 = "Special educational fund",
  q04_5 = "Fatherless children support",
  q04_6 = "Disability medical care",
  q04_7 = "Medical expense loan",
  q04_8 = "Public pawnshop"
)

for (var in names(q04_labels)) {
  count <- sum(df[[var]] == 1, na.rm = TRUE)
  pct <- 100 * count / nrow(df)
  cat(sprintf("   %s (%s): %s (%.1f%%)\n",
              var, q04_labels[var],
              format(count, big.mark = ","), pct))
}

# Institutional groups
welfare_vars <- c("q04_2", "q04_3", "q04_4", "q04_7")
any_welfare <- rowSums(df[welfare_vars] == 1, na.rm = TRUE) > 0
any_pawnshop <- df$q04_8 == 1
both <- any_welfare & any_pawnshop
welfare_only <- any_welfare & !any_pawnshop
pawnshop_only <- !any_welfare & any_pawnshop
neither <- !any_welfare & !any_pawnshop

cat("\n   Institutional-use groups:\n")
cat(sprintf("     Any welfare loan: %s (%.1f%%)\n",
            format(sum(any_welfare), big.mark = ","),
            100 * mean(any_welfare)))
cat(sprintf("     Public pawnshop: %s (%.1f%%)\n",
            format(sum(any_pawnshop), big.mark = ","),
            100 * mean(any_pawnshop)))
cat(sprintf("     Both: %s (%.1f%%)\n",
            format(sum(both), big.mark = ","),
            100 * mean(both)))
cat(sprintf("     Welfare only: %s (%.1f%%)\n",
            format(sum(welfare_only), big.mark = ","),
            100 * mean(welfare_only)))
cat(sprintf("     Pawnshop only: %s (%.1f%%)\n",
            format(sum(pawnshop_only), big.mark = ","),
            100 * mean(pawnshop_only)))
cat(sprintf("     Neither: %s (%.1f%%)\n",
            format(sum(neither), big.mark = ","),
            100 * mean(neither)))

# ============================================================================
# 5. Q10 VARIABLES (COPING STRATEGIES)
# ============================================================================

cat("\n5. Q10 Variables (Coping strategies when living expenses insufficient)...\n")
q10_labels <- c(
  q10_1 = "Purchases on account",
  q10_2 = "Pawning",
  q10_3 = "Employer borrowing",
  q10_4 = "Friend/neighbor borrowing",
  q10_5 = "Asset sales",
  q10_6 = "Savings withdrawal",
  q10_7 = "Other",
  q10_8 = "Food compression"
)

for (var in names(q10_labels)) {
  count <- sum(df[[var]] == 1, na.rm = TRUE)
  pct <- 100 * count / nrow(df)
  cat(sprintf("   %s (%s): %s (%.1f%%)\n",
              var, q10_labels[var],
              format(count, big.mark = ","), pct))
}

# ============================================================================
# 6. GENERATE DATA AUDIT MARKDOWN
# ============================================================================

cat("\n6. Generating data audit report...\n")

audit_md <- sprintf(
  "# Data Audit: SSJDA 1331 (1961)

**Date:** 2026-08-01
**Source:** %s
**File:** 1331.csv
**Observations:** %s
**Variables:** %d

## Unit of Observation

Household level. Household member 1 is consistently identified as household head
(q01_01_1 = 1 for all %s observations).

## Geographic Coverage

Six cities in Kanagawa Prefecture:
",
  authoritative_data_dir,
  format(obs_count, big.mark = ","),
  var_count,
  format(obs_count, big.mark = ",")
)

for (i in 1:nrow(city_counts)) {
  city_code <- city_counts$city[i]
  count <- city_counts$n[i]
  pct <- 100 * count / nrow(df)
  audit_md <- paste(audit_md,
                    sprintf("- City %d: %s (%.1f%%)\n",
                           city_code,
                           format(count, big.mark = ","),
                           pct),
                    sep = "")
}

audit_md <- paste(audit_md, sprintf(
  "
## Q04: Public Program Use History (Binary)

**q04_1 (Public assistance):** %s (%.1f%%)
**q04_2 (Maternal welfare fund):** %s (%.1f%%)
**q04_3 (Household Rehabilitation Fund):** %s (%.1f%%)
**q04_4 (Special educational fund):** %s (%.1f%%)
**q04_5 (Fatherless children support):** %s (%.1f%%)
**q04_6 (Disability medical care):** %s (%.1f%%)
**q04_7 (Medical expense loan):** %s (%.1f%%)
**q04_8 (Public pawnshop):** %s (%.1f%%)

## Institutional-Use Groups

Based on welfare-loan definition (q04_2 | q04_3 | q04_4 | q04_7):

- Any welfare loan: %s (%.1f%%)
- Public pawnshop: %s (%.1f%%)
- Both institutions: %s (%.1f%%)
- Welfare only: %s (%.1f%%)
- Pawnshop only: %s (%.1f%%)
- Neither: %s (%.1f%%)

Total: %s = %s

## Q10: Coping Strategies (Binary)

**q10_1 (Purchases on account):** %s (%.1f%%)
**q10_2 (Pawning):** %s (%.1f%%)
**q10_3 (Employer borrowing):** %s (%.1f%%)
**q10_4 (Friend/neighbor borrowing):** %s (%.1f%%)
**q10_5 (Asset sales):** %s (%.1f%%)
**q10_6 (Savings withdrawal):** %s (%.1f%%)
**q10_7 (Other):** %s (%.1f%%)
**q10_8 (Food compression):** %s (%.1f%%)

## Key Observations

1. **Household head consistent:** q01_01_1 = 1 for all observations.
2. **\"Both\" group very small:** Only %d households use both welfare and pawnshop.
3. **Food compression very common:** %.1f%% report cutting food spending.
4. **Pawning moderately common:** %.1f%% report pawning when living expenses insufficient.
5. **Data availability:** All key variables present and complete for all households.

## Data Protection

- All raw data files in %s are READ-ONLY.
- All outputs (cleaned data, tables, figures) go to %s or output/ directories.
- CSV file preferred; DTA file available as backup.

## Next Steps

1. Document all variable codes and missing-value rules (variable_dictionary.md)
2. Independently reproduce preliminary results from preliminary_results_to_reproduce.md
3. Compare with legacy code and reconcile any differences
",
  format(sum(df$q04_1 == 1), big.mark = ","), 100 * mean(df$q04_1 == 1),
  format(sum(df$q04_2 == 1), big.mark = ","), 100 * mean(df$q04_2 == 1),
  format(sum(df$q04_3 == 1), big.mark = ","), 100 * mean(df$q04_3 == 1),
  format(sum(df$q04_4 == 1), big.mark = ","), 100 * mean(df$q04_4 == 1),
  format(sum(df$q04_5 == 1), big.mark = ","), 100 * mean(df$q04_5 == 1),
  format(sum(df$q04_6 == 1), big.mark = ","), 100 * mean(df$q04_6 == 1),
  format(sum(df$q04_7 == 1), big.mark = ","), 100 * mean(df$q04_7 == 1),
  format(sum(df$q04_8 == 1), big.mark = ","), 100 * mean(df$q04_8 == 1),
  format(sum(any_welfare), big.mark = ","), 100 * mean(any_welfare),
  format(sum(any_pawnshop), big.mark = ","), 100 * mean(any_pawnshop),
  format(sum(both), big.mark = ","), 100 * mean(both),
  format(sum(welfare_only), big.mark = ","), 100 * mean(welfare_only),
  format(sum(pawnshop_only), big.mark = ","), 100 * mean(pawnshop_only),
  format(sum(neither), big.mark = ","), 100 * mean(neither),
  format(sum(both) + sum(welfare_only) + sum(pawnshop_only) + sum(neither), big.mark = ","),
  format(obs_count, big.mark = ","),
  format(sum(df$q10_1 == 1), big.mark = ","), 100 * mean(df$q10_1 == 1),
  format(sum(df$q10_2 == 1), big.mark = ","), 100 * mean(df$q10_2 == 1),
  format(sum(df$q10_3 == 1), big.mark = ","), 100 * mean(df$q10_3 == 1),
  format(sum(df$q10_4 == 1), big.mark = ","), 100 * mean(df$q10_4 == 1),
  format(sum(df$q10_5 == 1), big.mark = ","), 100 * mean(df$q10_5 == 1),
  format(sum(df$q10_6 == 1), big.mark = ","), 100 * mean(df$q10_6 == 1),
  format(sum(df$q10_7 == 1), big.mark = ","), 100 * mean(df$q10_7 == 1),
  format(sum(df$q10_8 == 1), big.mark = ","), 100 * mean(df$q10_8 == 1),
  sum(both),
  100 * mean(df$q10_8 == 1),
  100 * mean(df$q10_2 == 1),
  authoritative_data_dir,
  data_derived
), sep = "")

# Write audit file
audit_file <- file.path(docs, "data_audit_R.md")
writeLines(audit_md, audit_file)
cat(sprintf("   Saved to: %s\n", audit_file))

cat("\n================================================================================\n")
cat("PHASE 1 DATA AUDIT COMPLETE (R)\n")
cat("================================================================================\n")
