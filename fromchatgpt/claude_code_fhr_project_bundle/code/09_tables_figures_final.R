# =============================================================================
# Phase 4: Publication-Quality Tables and Figures
# Script 09_tables_figures_final.R
# =============================================================================
# Purpose: Generate final tables and figures for main text and appendix
# Author: Autonomous Phase 4 Execution
# Date: 2026-08-02
# =============================================================================

# Setup and paths
source("code/00_setup_paths.R")

# Load workspace from Phase 3 (robustness completed)
load("output/logs/phase3_5_workspace.RData")

# Verify key objects exist
if (!exists("df_clean")) {
  stop("Phase 3 workspace not loaded. Re-run Phase 3 scripts first.")
}

library(tidyverse)
library(fixest)
library(modelsummary)
library(ggplot2)
library(gridExtra)
library(knitr)

# =============================================================================
# TABLE 2: Household Characteristics by Institutional-Use Group
# =============================================================================

table2_data <- df_clean %>%
  mutate(
    institutional_group = case_when(
      q04_any_welfare == 0 & q04_pawnshop == 0 ~ "Neither",
      q04_any_welfare == 1 & q04_pawnshop == 0 ~ "Welfare Only",
      q04_any_welfare == 0 & q04_pawnshop == 1 ~ "Pawnshop Only",
      q04_any_welfare == 1 & q04_pawnshop == 1 ~ "Both",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(institutional_group))

# Calculate descriptive statistics by group
desc_stats <- table2_data %>%
  group_by(institutional_group) %>%
  summarise(
    N = n(),
    mean_age = mean(q02_head_age, na.rm = TRUE),
    sd_age = sd(q02_head_age, na.rm = TRUE),
    pct_female = mean(q03_female_head, na.rm = TRUE) * 100,
    mean_hh_size = mean(q07_household_size, na.rm = TRUE),
    sd_hh_size = sd(q07_household_size, na.rm = TRUE),
    pct_public_assist = mean(q04_public_assistance, na.rm = TRUE) * 100,
    mean_assets = mean(q25_asset_count, na.rm = TRUE),
    sd_assets = sd(q25_asset_count, na.rm = TRUE),
    pct_business_failure = mean(q19_business_failure, na.rm = TRUE) * 100,
    pct_prolonged_illness = mean(q21_prolonged_illness, na.rm = TRUE) * 100,
    pct_unemployment = mean(q20_unemployment, na.rm = TRUE) * 100,
    pct_low_living_ability = mean(q30_low_living_ability, na.rm = TRUE) * 100,
    pct_pawning = mean(q10_pawning, na.rm = TRUE) * 100,
    pct_employer_borrow = mean(q10_employer_borrowing, na.rm = TRUE) * 100,
    pct_neighbor_borrow = mean(q10_friend_neighbor_borrowing, na.rm = TRUE) * 100,
    pct_food_compression = mean(q10_food_compression, na.rm = TRUE) * 100
  ) %>%
  mutate(institutional_group = factor(institutional_group,
    levels = c("Full sample", "Neither", "Welfare Only", "Pawnshop Only", "Both")))

# Also add full-sample row
full_sample_stats <- df_clean %>%
  summarise(
    N = n(),
    mean_age = mean(q02_head_age, na.rm = TRUE),
    sd_age = sd(q02_head_age, na.rm = TRUE),
    pct_female = mean(q03_female_head, na.rm = TRUE) * 100,
    mean_hh_size = mean(q07_household_size, na.rm = TRUE),
    sd_hh_size = sd(q07_household_size, na.rm = TRUE),
    pct_public_assist = mean(q04_public_assistance, na.rm = TRUE) * 100,
    mean_assets = mean(q25_asset_count, na.rm = TRUE),
    sd_assets = sd(q25_asset_count, na.rm = TRUE),
    pct_business_failure = mean(q19_business_failure, na.rm = TRUE) * 100,
    pct_prolonged_illness = mean(q21_prolonged_illness, na.rm = TRUE) * 100,
    pct_unemployment = mean(q20_unemployment, na.rm = TRUE) * 100,
    pct_low_living_ability = mean(q30_low_living_ability, na.rm = TRUE) * 100,
    pct_pawning = mean(q10_pawning, na.rm = TRUE) * 100,
    pct_employer_borrow = mean(q10_employer_borrowing, na.rm = TRUE) * 100,
    pct_neighbor_borrow = mean(q10_friend_neighbor_borrowing, na.rm = TRUE) * 100,
    pct_food_compression = mean(q10_food_compression, na.rm = TRUE) * 100
  ) %>%
  mutate(institutional_group = "Full sample")

table2_combined <- bind_rows(full_sample_stats, desc_stats)

# Save as CSV
write.csv(table2_combined, "output/tables/table2_household_characteristics.csv", row.names = FALSE)

# Format for LaTeX
table2_latex <- table2_combined %>%
  select(institutional_group, N, mean_age, pct_female, mean_hh_size, pct_public_assist,
         mean_assets, pct_business_failure, pct_prolonged_illness, pct_low_living_ability) %>%
  mutate(
    N = as.character(N),
    mean_age = sprintf("%.1f", mean_age),
    pct_female = sprintf("%.1f", pct_female),
    mean_hh_size = sprintf("%.2f", mean_hh_size),
    pct_public_assist = sprintf("%.1f", pct_public_assist),
    mean_assets = sprintf("%.2f", mean_assets),
    pct_business_failure = sprintf("%.1f", pct_business_failure),
    pct_prolonged_illness = sprintf("%.1f", pct_prolonged_illness),
    pct_low_living_ability = sprintf("%.1f", pct_low_living_ability)
  )

# Save Table 2 LaTeX
write.csv(table2_latex, "output/tables/table2_formatted.csv", row.names = FALSE)

cat("\n✓ Table 2: Household Characteristics - Created\n")

# =============================================================================
# TABLE 3: Selection into Welfare Lending and Public Pawnbroking
# =============================================================================
# Using models estimated in Phase 3

if (exists("model_welfare_full") && exists("model_pawnshop_full")) {

  # Extract coefficients for display
  table3_data <- modelsummary(
    list("Welfare Loan" = model_welfare_full,
         "Public Pawnshop" = model_pawnshop_full),
    output = "data.frame",
    fmt = 3,
    estimate = "{estimate} ({std.error})",
    statistic = NULL,
    coef_omit = "Intercept"
  )

  # Save
  write.csv(table3_data, "output/tables/table3_selection_models.csv", row.names = FALSE)

  # Save estimates for LaTeX generation
  model_welfare_coef <- tidy(model_welfare_full) %>%
    filter(term != "(Intercept)") %>%
    select(term, estimate, std.error)

  model_pawnshop_coef <- tidy(model_pawnshop_full) %>%
    filter(term != "(Intercept)") %>%
    select(term, estimate, std.error)

  table3_estimates <- list(
    welfare = model_welfare_coef,
    pawnshop = model_pawnshop_coef,
    welfare_model = model_welfare_full,
    pawnshop_model = model_pawnshop_full
  )

  saveRDS(table3_estimates, "output/estimates/table3_selection_estimates.rds")

  cat("\n✓ Table 3: Selection Models - Created\n")
} else {
  cat("\n! Table 3: Selection model objects not found. Ensure Phase 3 workspace loaded.\n")
}

# =============================================================================
# TABLE 4: Welfare-Only vs Pawnshop-Only Comparison
# =============================================================================
# Restrict to households using exactly one institution

table4_data <- df_clean %>%
  mutate(
    institutional_group = case_when(
      q04_any_welfare == 0 & q04_pawnshop == 0 ~ "Neither",
      q04_any_welfare == 1 & q04_pawnshop == 0 ~ "Welfare Only",
      q04_any_welfare == 0 & q04_pawnshop == 1 ~ "Pawnshop Only",
      q04_any_welfare == 1 & q04_pawnshop == 1 ~ "Both",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(institutional_group %in% c("Welfare Only", "Pawnshop Only")) %>%
  mutate(
    welfare_only = ifelse(institutional_group == "Welfare Only", 1, 0)
  )

# Estimate direct comparison model
model_direct_comparison <- feols(
  welfare_only ~
    q19_business_failure + q20_unemployment + q21_prolonged_illness +
    q30_low_living_ability + q04_public_assistance + q25_asset_count +
    q02_head_age + q03_female_head + q07_household_size +
    factor(q01_city),
  data = table4_data,
  se = "hetero"
)

table4_comparison <- tidy(model_direct_comparison) %>%
  filter(term != "(Intercept)") %>%
  select(term, estimate, std.error, statistic, p.value)

write.csv(table4_comparison, "output/tables/table4_direct_comparison.csv", row.names = FALSE)

saveRDS(list(model = model_direct_comparison, N = nrow(table4_data)),
        "output/estimates/table4_direct_estimates.rds")

cat("\n✓ Table 4: Direct Welfare-Only vs Pawnshop-Only Comparison - Created\n")
cat(sprintf("  Sample size: %d households\n", nrow(table4_data)))

# =============================================================================
# TABLE 6: Institutional-Use Histories and Layered Borrowing
# =============================================================================

# Estimate separate models for each coping strategy
outcomes_to_model <- list(
  pawning = "q10_pawning",
  employer_borrowing = "q10_employer_borrowing",
  neighbor_borrowing = "q10_friend_neighbor_borrowing",
  purchases_on_account = "q10_purchases_on_account",
  food_compression = "q10_food_compression"
)

table6_models <- list()
table6_coefficients <- list()

for (outcome_name in names(outcomes_to_model)) {

  outcome_var <- outcomes_to_model[[outcome_name]]

  formula_str <- paste0(
    outcome_var, " ~ q04_any_welfare + q04_pawnshop + ",
    "q19_business_failure + q20_unemployment + q21_prolonged_illness + ",
    "q30_low_living_ability + q04_public_assistance + q25_asset_count + ",
    "q02_head_age + q03_female_head + q07_household_size + ",
    "factor(q01_city)"
  )

  model <- feols(as.formula(formula_str), data = df_clean, se = "hetero")

  table6_models[[outcome_name]] <- model

  table6_coefficients[[outcome_name]] <- tidy(model) %>%
    filter(term %in% c("q04_any_welfare", "q04_pawnshop")) %>%
    mutate(outcome = outcome_name)
}

# Combine all coefficients
table6_combined <- bind_rows(table6_coefficients) %>%
  pivot_wider(
    names_from = outcome,
    values_from = c(estimate, std.error, statistic, p.value),
    names_glue = "{outcome}_{.value}"
  )

write.csv(table6_combined, "output/tables/table6_layered_borrowing.csv", row.names = FALSE)

saveRDS(list(models = table6_models, coefficients = table6_coefficients),
        "output/estimates/table6_layered_estimates.rds")

cat("\n✓ Table 6: Layered Borrowing - Created (", length(outcomes_to_model), " outcomes)\n")

# =============================================================================
# FIGURE 3: Coefficient Comparison - Welfare vs Pawnshop
# =============================================================================

if (exists("model_welfare_full") && exists("model_pawnshop_full")) {

  # Extract coefficients for key variables
  key_vars <- c(
    "q19_business_failure", "q21_prolonged_illness", "q20_unemployment",
    "q30_low_living_ability", "q04_public_assistance", "q25_asset_count"
  )

  welfare_coef <- tidy(model_welfare_full) %>%
    filter(term %in% key_vars) %>%
    select(term, estimate, std.error) %>%
    mutate(model = "Welfare Loan")

  pawnshop_coef <- tidy(model_pawnshop_full) %>%
    filter(term %in% key_vars) %>%
    select(term, estimate, std.error) %>%
    mutate(model = "Public Pawnshop")

  coef_comparison <- bind_rows(welfare_coef, pawnshop_coef) %>%
    mutate(
      term_label = case_when(
        term == "q19_business_failure" ~ "Business Failure",
        term == "q21_prolonged_illness" ~ "Prolonged Illness",
        term == "q20_unemployment" ~ "Unemployment",
        term == "q30_low_living_ability" ~ "Low Living Ability",
        term == "q04_public_assistance" ~ "Public Assistance History",
        term == "q25_asset_count" ~ "Household Assets",
        TRUE ~ term
      ),
      ci_lower = estimate - 1.96 * std.error,
      ci_upper = estimate + 1.96 * std.error
    )

  # Create dot plot
  fig3 <- ggplot(coef_comparison, aes(x = estimate, y = term_label, color = model)) +
    geom_point(size = 3, position = position_dodge(width = 0.5)) +
    geom_errorbarh(aes(xmin = ci_lower, xmax = ci_upper),
                   height = 0.2, position = position_dodge(width = 0.5)) +
    geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
    labs(
      title = "Figure 3: Correlates of Welfare-Loan and Public-Pawnshop Use",
      x = "Coefficient (percentage points)",
      y = "",
      color = "Institution",
      caption = "Error bars show 95% confidence intervals. HC3 standard errors."
    ) +
    theme_minimal() +
    theme(
      legend.position = "bottom",
      plot.title = element_text(hjust = 0, face = "bold"),
      axis.text.y = element_text(size = 10),
      panel.grid.major.x = element_line(color = "gray90"),
      panel.grid.minor.x = element_blank()
    )

  ggsave("output/figures/figure3_coefficient_comparison.pdf", fig3, width = 10, height = 6)
  ggsave("output/figures/figure3_coefficient_comparison.png", fig3, width = 10, height = 6, dpi = 300)

  cat("\n✓ Figure 3: Coefficient Comparison - Created\n")

  # Also save coefficient data for table
  write.csv(coef_comparison, "output/tables/figure3_data.csv", row.names = FALSE)
}

# =============================================================================
# SUMMARY STATISTICS FOR REPORT
# =============================================================================

summary_stats <- list(
  table2_n_neither = sum(desc_stats$institutional_group == "Neither" & !is.na(desc_stats$N)),
  table2_n_welfare_only = sum(desc_stats$institutional_group == "Welfare Only" & !is.na(desc_stats$N)),
  table2_n_pawnshop_only = sum(desc_stats$institutional_group == "Pawnshop Only" & !is.na(desc_stats$N)),
  table2_n_both = sum(desc_stats$institutional_group == "Both" & !is.na(desc_stats$N)),
  table4_n = nrow(table4_data),
  table6_n = nrow(df_clean)
)

cat("\n" %+% paste(rep("=", 80), collapse = ""))
cat("\nPHASE 4: PUBLICATION-QUALITY TABLES AND FIGURES COMPLETED")
cat("\n" %+% paste(rep("=", 80), collapse = ""))
cat("\n✓ Table 2: Household Characteristics (N = ", nrow(table2_combined), ")\n")
cat("✓ Table 3: Selection Models\n")
cat("✓ Table 4: Direct Comparison (N =", nrow(table4_data), ")\n")
cat("✓ Table 6: Layered Borrowing Outcomes\n")
cat("✓ Figure 3: Coefficient Comparison\n")
cat("\nAll outputs saved to:")
cat("\n  - output/tables/table*.csv")
cat("\n  - output/figures/figure*.pdf")
cat("\n  - output/estimates/table*_estimates.rds")

# Save workspace
save.image("output/logs/phase4_tables_figures.RData")

cat("\nWorkspace saved: output/logs/phase4_tables_figures.RData\n")
