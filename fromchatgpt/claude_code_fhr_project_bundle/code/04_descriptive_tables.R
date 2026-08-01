# Phase 3: Descriptive Tables and Figures
# Create publication-quality tables and figures showing:
# 1. Prevalence of each program and coping strategy
# 2. Household characteristics by institutional-use group
# 3. UpSet plot of credit strategy combinations

library(tidyverse)
library(ggplot2)
library(modelsummary)

# Setup paths
project_root <- "C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/fromchatgpt/claude_code_fhr_project_bundle"
data_derived <- file.path(project_root, "data", "derived")
tables_dir <- file.path(project_root, "tables")
figures_dir <- file.path(project_root, "figures")
output_logs <- file.path(project_root, "output", "logs")
docs <- file.path(project_root, "docs")

dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figures_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(output_logs, recursive = TRUE, showWarnings = FALSE)
dir.create(docs, recursive = TRUE, showWarnings = FALSE)

cat("================================================================================\n")
cat("PHASE 3: DESCRIPTIVE TABLES AND FIGURES\n")
cat("================================================================================\n")

# ============================================================================
# 1. LOAD DATA
# ============================================================================

cat("\n1. Loading analysis data...\n")
df <- read_csv(file.path(data_derived, "ssjda1331_analysis.csv"), show_col_types = FALSE)
cat(sprintf("   Loaded: %s observations\n", format(nrow(df), big.mark = ",")))

# ============================================================================
# 2. TABLE 1: PREVALENCE OF PUBLIC PROGRAMS AND COPING STRATEGIES
# ============================================================================

cat("\n2. Creating Table 1: Prevalence of programs and coping strategies...\n")

# Public programs
programs <- data.frame(
  Program = c("Public assistance", "Maternal welfare fund", "Household rehab fund",
              "Special education fund", "Fatherless children support",
              "Disability medical care", "Medical expense loan", "Public pawnshop"),
  Variable = c("q04_1", "q04_2", "q04_3", "q04_4", "q04_5", "q04_6", "q04_7", "q04_8"),
  stringsAsFactors = FALSE
)

prevalence_programs <- programs %>%
  mutate(
    N = sapply(Variable, function(v) sum(df[[v]] == 1, na.rm = TRUE)),
    Prevalence = sapply(Variable, function(v) 100 * mean(df[[v]] == 1, na.rm = TRUE)),
    Pct_Format = sprintf("%.1f%%", Prevalence)
  ) %>%
  select(Program, N, Prevalence, Pct_Format) %>%
  arrange(desc(Prevalence))

# Coping strategies
coping_vars <- c("coping_account", "coping_pawn", "coping_employer", "coping_friend",
                 "coping_asset_sale", "coping_savings", "coping_other", "coping_food")
coping_labels <- c("Purchases on account", "Pawning", "Employer borrowing",
                   "Friend/neighbor borrowing", "Asset sales", "Savings withdrawal",
                   "Other", "Food compression")

prevalence_coping <- data.frame(
  Coping_Strategy = coping_labels,
  Variable = coping_vars,
  stringsAsFactors = FALSE
) %>%
  mutate(
    N = sapply(Variable, function(v) sum(df[[v]] == 1, na.rm = TRUE)),
    Prevalence = sapply(Variable, function(v) 100 * mean(df[[v]] == 1, na.rm = TRUE)),
    Pct_Format = sprintf("%.1f%%", Prevalence)
  ) %>%
  select(Coping_Strategy, N, Prevalence, Pct_Format) %>%
  arrange(desc(Prevalence))

# Combine and save
prevalence_all <- bind_rows(
  prevalence_programs %>% rename(Item = Program) %>% select(Item, N, Pct_Format),
  prevalence_coping %>% rename(Item = Coping_Strategy) %>% select(Item, N, Pct_Format)
)

# Create markdown table
table1_md <- "# Table 1: Prevalence of Public Programs and Coping Strategies\n\n"
table1_md <- paste0(table1_md, "## Public Programs\n\n")
table1_md <- paste0(table1_md, "| Program | N | Prevalence |\n")
table1_md <- paste0(table1_md, "|---------|---|------------|\n")
for (i in 1:nrow(prevalence_programs)) {
  row <- prevalence_programs[i, ]
  table1_md <- paste0(table1_md, sprintf("| %s | %s | %s |\n",
                                         row$Program,
                                         format(row$N, big.mark = ","),
                                         row$Pct_Format))
}

table1_md <- paste0(table1_md, "\n## Coping Strategies\n\n")
table1_md <- paste0(table1_md, "| Strategy | N | Prevalence |\n")
table1_md <- paste0(table1_md, "|----------|---|------------|\n")
for (i in 1:nrow(prevalence_coping)) {
  row <- prevalence_coping[i, ]
  table1_md <- paste0(table1_md, sprintf("| %s | %s | %s |\n",
                                         row$Coping_Strategy,
                                         format(row$N, big.mark = ","),
                                         row$Pct_Format))
}

table1_file <- file.path(tables_dir, "table1_prevalence.md")
writeLines(table1_md, table1_file)
cat(sprintf("   Saved: %s\n", table1_file))

# ============================================================================
# 3. TABLE 2: HOUSEHOLD CHARACTERISTICS BY INSTITUTIONAL-USE GROUP
# ============================================================================

cat("\n3. Creating Table 2: Household characteristics by institution-use group...\n")

# Create institutional groups
df <- df %>%
  mutate(
    institution_group = case_when(
      welfare_only == 1 ~ "Welfare only",
      pawnshop_only == 1 ~ "Pawnshop only",
      both_institutions == 1 ~ "Both",
      neither_institution == 1 ~ "Neither",
      TRUE ~ NA_character_
    )
  )

# Key demographic and risk variables
demo_vars <- c("head_age", "female_head", "household_size", "n_workers",
               "public_assistance", "asset_count")
demo_labels <- c("Head age (years)", "Female head (%)", "Household size",
                 "Workers", "Public assistance (%)", "Asset count")

risk_vars <- c("war_damage", "business_failure", "prolonged_illness",
               "low_living_ability", "weak_household_head", "unemployment")
risk_labels <- c("War damage (%)", "Business failure (%)", "Prolonged illness (%)",
                 "Low living ability (%)", "Weak household head (%)", "Unemployment (%)")

# Compute statistics by group
groups <- c("Neither", "Welfare only", "Pawnshop only", "Both")

table2_data <- data.frame()

for (var in demo_vars) {
  for (group in groups) {
    subset_data <- df %>% filter(institution_group == group)
    mean_val <- mean(subset_data[[var]], na.rm = TRUE)
    sd_val <- sd(subset_data[[var]], na.rm = TRUE)
    n_val <- sum(!is.na(subset_data[[var]]))

    table2_data <- bind_rows(table2_data, data.frame(
      Variable = demo_labels[which(demo_vars == var)],
      Group = group,
      Mean = mean_val,
      SD = sd_val,
      N = n_val
    ))
  }
}

# Create markdown table
table2_md <- "# Table 2: Household Characteristics by Institutional-Use Group\n\n"
table2_md <- paste0(table2_md, "| Variable | Neither | Welfare only | Pawnshop only | Both |\n")
table2_md <- paste0(table2_md, "|----------|---------|--------------|---------------|------|\n")

for (var in unique(table2_data$Variable)) {
  var_data <- table2_data %>% filter(Variable == var)
  row_str <- sprintf("| %s |", var)
  for (group in groups) {
    group_data <- var_data %>% filter(Group == group)
    if (nrow(group_data) > 0) {
      mean_val <- group_data$Mean[1]
      row_str <- paste0(row_str, sprintf(" %.2f |", mean_val))
    } else {
      row_str <- paste0(row_str, " -- |")
    }
  }
  table2_md <- paste0(table2_md, row_str, "\n")
}

table2_file <- file.path(tables_dir, "table2_characteristics.md")
writeLines(table2_md, table2_file)
cat(sprintf("   Saved: %s\n", table2_file))

# ============================================================================
# 4. FIGURE 1: DISTRIBUTION BY INSTITUTIONAL GROUP
# ============================================================================

cat("\n4. Creating Figure 1: Distribution by institutional-use group...\n")

institution_dist <- df %>%
  group_by(institution_group) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  mutate(
    Pct = 100 * Count / sum(Count),
    institution_group = factor(institution_group, levels = c("Neither", "Welfare only",
                                                             "Pawnshop only", "Both"))
  ) %>%
  arrange(institution_group)

fig1 <- ggplot(institution_dist, aes(x = institution_group, y = Count, fill = institution_group)) +
  geom_col(alpha = 0.8) +
  geom_text(aes(label = sprintf("%s\n(%.1f%%)", format(Count, big.mark = ","), Pct)),
            vjust = -0.3, size = 3.5) +
  scale_fill_manual(values = c("Neither" = "#E8E8E8", "Welfare only" = "#A6CEE3",
                               "Pawnshop only" = "#FB9A99", "Both" = "#FDBF6F")) +
  labs(
    title = "Distribution of Households by Institutional-Use Group",
    subtitle = "Public welfare loans vs. public pawnshop (SSJDA 1331, 1961)",
    x = "Institutional-Use Group",
    y = "Number of Households",
    fill = NULL
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 10, color = "gray30"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

ggsave(file.path(figures_dir, "fig1_institution_distribution.png"), fig1,
       width = 8, height = 5, dpi = 300)
cat(sprintf("   Saved: %s\n", file.path(figures_dir, "fig1_institution_distribution.png")))

# ============================================================================
# 5. FIGURE 2: COPING STRATEGIES BY INSTITUTIONAL GROUP
# ============================================================================

cat("\n5. Creating Figure 2: Coping strategies by institutional-use group...\n")

coping_by_group <- data.frame()
for (var in coping_vars) {
  for (group in groups) {
    subset_data <- df %>% filter(institution_group == group)
    pct <- 100 * mean(subset_data[[var]] == 1, na.rm = TRUE)

    coping_by_group <- bind_rows(coping_by_group, data.frame(
      Strategy = coping_labels[which(coping_vars == var)],
      Group = group,
      Prevalence = pct
    ))
  }
}

coping_by_group <- coping_by_group %>%
  mutate(
    Strategy = factor(Strategy, levels = rev(coping_labels)),
    Group = factor(Group, levels = c("Neither", "Welfare only", "Pawnshop only", "Both"))
  )

fig2 <- ggplot(coping_by_group, aes(x = Prevalence, y = Strategy, fill = Group)) +
  geom_col(position = "dodge", alpha = 0.8) +
  scale_fill_manual(values = c("Neither" = "#E8E8E8", "Welfare only" = "#A6CEE3",
                               "Pawnshop only" = "#FB9A99", "Both" = "#FDBF6F")) +
  labs(
    title = "Coping Strategies by Institutional-Use Group",
    subtitle = "% of households reporting each strategy when living expenses insufficient",
    x = "Prevalence (%)",
    y = "Coping Strategy",
    fill = "Institution Use"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 10, color = "gray30"),
    legend.position = "bottom"
  )

ggsave(file.path(figures_dir, "fig2_coping_by_group.png"), fig2,
       width = 10, height = 6, dpi = 300)
cat(sprintf("   Saved: %s\n", file.path(figures_dir, "fig2_coping_by_group.png")))

# ============================================================================
# 6. SAVE SUMMARY
# ============================================================================

cat("\n6. Saving summary...\n")

summary_report <- sprintf(
  "# Phase 3.1: Descriptive Tables and Figures

**Date:** 2026-08-01
**Language:** R with ggplot2, modelsummary

## Files Created

### Tables
- `tables/table1_prevalence.md` - Prevalence of public programs and coping strategies
- `tables/table2_characteristics.md` - Household characteristics by institutional-use group

### Figures
- `figures/fig1_institution_distribution.png` - Distribution by institution-use group
- `figures/fig2_coping_by_group.png` - Coping strategies by institutional-use group

## Key Findings

### Institutional-Use Distribution
- Neither: %d (%.1f%%)
- Welfare only: %d (%.1f%%)
- Pawnshop only: %d (%.1f%%)
- Both: %d (%.1f%%)

### Most Common Coping Strategies
1. Food compression: %.1f%%
2. Friend/neighbor borrowing: %.1f%%
3. Purchases on account: %.1f%%

## Next: Logit/Probit Analysis with Marginal Effects

",
  sum(df$neither_institution), 100 * mean(df$neither_institution),
  sum(df$welfare_only), 100 * mean(df$welfare_only),
  sum(df$pawnshop_only), 100 * mean(df$pawnshop_only),
  sum(df$both_institutions), 100 * mean(df$both_institutions),
  100 * mean(df$coping_food == 1, na.rm = TRUE),
  100 * mean(df$coping_friend == 1, na.rm = TRUE),
  100 * mean(df$coping_account == 1, na.rm = TRUE)
)

summary_file <- file.path(docs, "PHASE_3_1_DESCRIPTIVE_SUMMARY.md")
writeLines(summary_report, summary_file)
cat(sprintf("   Summary saved: %s\n", summary_file))

cat("\n================================================================================\n")
cat("PHASE 3.1 COMPLETE: DESCRIPTIVE TABLES AND FIGURES\n")
cat("================================================================================\n")
cat("Next: Phase 3.2 - Logit/Probit analysis with marginal effects\n")

# Save workspace
save.image(file.path(output_logs, "phase3_1_workspace.RData"))
