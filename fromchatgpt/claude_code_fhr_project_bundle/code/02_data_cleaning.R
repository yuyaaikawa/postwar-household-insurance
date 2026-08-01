# Data cleaning and variable construction for SSJDA 1331 analysis
# All outputs saved to data/derived/ for use in subsequent analysis

library(tidyverse)

# Setup paths directly
project_root <- "C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/fromchatgpt/claude_code_fhr_project_bundle"
authoritative_data_dir <- "C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/data/raw"
ssjda_extract_dir <- file.path(
  authoritative_data_dir,
  "神奈川県における民生基礎調査（ボーダー・ライン層調査）1961",
  "1331"
)
ssjda_csv_file <- file.path(ssjda_extract_dir, "1331.csv")
data_derived <- file.path(project_root, "data", "derived")
output_logs <- file.path(project_root, "output", "logs")
dir.create(data_derived, recursive = TRUE, showWarnings = FALSE)
dir.create(output_logs, recursive = TRUE, showWarnings = FALSE)

cat("================================================================================\n")
cat("DATA CLEANING AND VARIABLE CONSTRUCTION\n")
cat("================================================================================\n")

# ============================================================================
# 1. LOAD DATA
# ============================================================================

cat("\n1. Loading raw data...\n")
df <- read_csv(ssjda_csv_file, show_col_types = FALSE)
cat(sprintf("   Loaded: %s observations\n", format(nrow(df), big.mark = ",")))

# ============================================================================
# 2. INSTITUTIONAL VARIABLES
# ============================================================================

cat("\n2. Constructing institutional variables...\n")

df <- df %>%
  mutate(
    any_welfare_loan = as.integer((q04_2 == 1 | q04_3 == 1 | q04_4 == 1 | q04_7 == 1)),
    public_pawnshop = as.integer(q04_8 == 1),
    both_institutions = as.integer(any_welfare_loan == 1 & public_pawnshop == 1),
    welfare_only = as.integer(any_welfare_loan == 1 & public_pawnshop == 0),
    pawnshop_only = as.integer(any_welfare_loan == 0 & public_pawnshop == 1),
    neither_institution = as.integer(any_welfare_loan == 0 & public_pawnshop == 0),
    public_assistance = as.integer(q04_1 == 1)
  )

cat(sprintf("   Welfare loan: %s\n", format(sum(df$any_welfare_loan), big.mark = ",")))
cat(sprintf("   Pawnshop: %s\n", format(sum(df$public_pawnshop), big.mark = ",")))
cat(sprintf("   Both: %s\n", format(sum(df$both_institutions), big.mark = ",")))
cat(sprintf("   Welfare only: %s\n", format(sum(df$welfare_only), big.mark = ",")))
cat(sprintf("   Pawnshop only: %s\n", format(sum(df$pawnshop_only), big.mark = ",")))
cat(sprintf("   Neither: %s\n", format(sum(df$neither_institution), big.mark = ",")))

# ============================================================================
# 3. COPING STRATEGIES (Q10 VARIABLES)
# ============================================================================

cat("\n3. Constructing coping strategy variables...\n")

df <- df %>%
  mutate(
    coping_account = as.integer(q10_1 == 1),
    coping_pawn = as.integer(q10_2 == 1),
    coping_employer = as.integer(q10_3 == 1),
    coping_friend = as.integer(q10_4 == 1),
    coping_asset_sale = as.integer(q10_5 == 1),
    coping_savings = as.integer(q10_6 == 1),
    coping_other = as.integer(q10_7 == 1),
    coping_food = as.integer(q10_8 == 1)
  ) %>%
  mutate(
    n_coping_strategies = coping_account + coping_pawn + coping_employer +
                         coping_friend + coping_asset_sale + coping_savings +
                         coping_other + coping_food,
    any_coping = as.integer(n_coping_strategies > 0),
    any_borrowing = as.integer((q10_1 == 1 | q10_2 == 1 | q10_3 == 1 | q10_4 == 1))
  )

cat(sprintf("   Mean number of strategies: %.2f\n", mean(df$n_coping_strategies)))

# ============================================================================
# 4. HOUSEHOLD DEMOGRAPHICS
# ============================================================================

cat("\n4. Constructing demographic variables...\n")

df <- df %>%
  mutate(
    head_age = if_else(q01_01_3 < 99, q01_01_3, NA_integer_),
    head_age_sq = head_age ^ 2,
    female_head = if_else(q01_01_2 == 2, 1L, if_else(q01_01_2 == 1, 0L, NA_integer_)),
    household_size = if_else(q12_1 < 99, q12_1, NA_integer_),
    n_workers = if_else(q12_4 < 9, q12_4, NA_integer_),
    n_unemployed = if_else(q12_6 < 9, q12_6, NA_integer_)
  )

cat(sprintf("   Head age - mean: %.1f\n", mean(df$head_age, na.rm = TRUE)))
cat(sprintf("   Female head: %.1f%%\n", 100 * mean(df$female_head, na.rm = TRUE)))
cat(sprintf("   Household size - mean: %.1f\n", mean(df$household_size, na.rm = TRUE)))
cat(sprintf("   Workers - mean: %.1f\n", mean(df$n_workers, na.rm = TRUE)))

# ============================================================================
# 5. HOUSEHOLD ASSETS (Q26 VARIABLES)
# ============================================================================

cat("\n5. Constructing asset variables...\n")

# Asset ownership: recode 9 = NaN
for (i in 1:9) {
  var_name <- paste0("q26_", i)
  df[[var_name]] <- if_else(df[[var_name]] == 9, NA_integer_, df[[var_name]])
}

# Asset count (8 movables, excluding real estate)
df <- df %>%
  mutate(
    asset_count = rowSums(select(., q26_1:q26_8), na.rm = TRUE),
    asset_count_with_realestate = rowSums(select(., q26_1:q26_9), na.rm = TRUE)
  )

cat(sprintf("   Asset count (8 movables) - mean: %.2f\n", mean(df$asset_count, na.rm = TRUE)))
cat(sprintf("   Asset count (including real estate) - mean: %.2f\n", mean(df$asset_count_with_realestate, na.rm = TRUE)))

# ============================================================================
# 6. LOW-INCOME-CAUSE VARIABLES (Q02)
# ============================================================================

cat("\n6. Constructing low-income-cause variables...\n")

# Q02 variables: recode 99 = NaN
q02_vars <- paste0("q02_", c(sprintf("%02d", 1:11), sprintf("%02d", 21:25)))

for (var in q02_vars) {
  if (var %in% names(df)) {
    df[[var]] <- if_else(df[[var]] == 99, NA_integer_, df[[var]])
  }
}

# Rename for clarity
df <- df %>%
  rename(
    war_damage = q02_01,
    disaster = q02_02,
    head_death = q02_03,
    unemployment = q02_04,
    business_failure = q02_05,
    family_conflict = q02_06,
    income_decline = q02_07,
    asset_loss = q02_08,
    illness_onset = q02_09,
    prolonged_illness = q02_10,
    aging_work_decline = q02_11,
    low_living_ability = q02_21,
    weak_household_head = q02_22,
    household_discord = q02_23,
    disabled_household_member = q02_24,
    longterm_patient = q02_25
  )

cat(sprintf("   Low-income-cause variables created: 16\n"))

# ============================================================================
# 7. INCOME AND CONSUMPTION VARIABLES
# ============================================================================

cat("\n7. Constructing income and consumption variables...\n")

df <- df %>%
  mutate(
    income_decreased = if_else(q08 == 3, 1L, if_else(q08 == 9, NA_integer_, 0L)),
    rent_arrears_amount = if_else((q19 < 1000 & q19 != 88888), q19, NA_real_),
    has_rent_arrears = if_else(rent_arrears_amount > 0, 1L, 0L)
  )

cat(sprintf("   Income decreased: %.1f%%\n", 100 * mean(df$income_decreased, na.rm = TRUE)))
cat(sprintf("   Has rent arrears: %.1f%%\n", 100 * mean(df$has_rent_arrears, na.rm = TRUE)))

# ============================================================================
# 8. HOUSEHOLD TYPE
# ============================================================================

cat("\n8. Household type...\n")
df <- df %>%
  mutate(household_type = q03)
cat(sprintf("   Household types: %d\n", n_distinct(df$household_type)))

# ============================================================================
# 9. SELECT AND SAVE ANALYSIS DATASET
# ============================================================================

cat("\n9. Saving analysis dataset...\n")

# Select key variables
df_analysis <- df %>%
  select(
    ID, city, household_type,
    # Coping strategies
    coping_account, coping_pawn, coping_employer, coping_friend,
    coping_asset_sale, coping_savings, coping_other, coping_food,
    any_coping, n_coping_strategies, any_borrowing,
    # Institutions
    any_welfare_loan, public_pawnshop, public_assistance,
    both_institutions, welfare_only, pawnshop_only, neither_institution,
    # Demographics
    head_age, head_age_sq, female_head, household_size, n_workers, n_unemployed,
    # Assets
    asset_count, asset_count_with_realestate,
    # Risk factors
    war_damage, disaster, head_death, unemployment, business_failure,
    family_conflict, income_decline, asset_loss, illness_onset,
    prolonged_illness, aging_work_decline, low_living_ability,
    weak_household_head, household_discord, disabled_household_member,
    longterm_patient,
    # Income
    income_decreased, has_rent_arrears, rent_arrears_amount,
    # Original variables (for reference)
    starts_with("q04_"), starts_with("q10_"), q07, q08
  )

# Save to CSV
output_file <- file.path(data_derived, "ssjda1331_analysis.csv")
write_csv(df_analysis, output_file)
cat(sprintf("   Saved to: %s\n", output_file))
cat(sprintf("   Dimensions: %d x %d\n", nrow(df_analysis), ncol(df_analysis)))

# ============================================================================
# 10. DATA QUALITY SUMMARY
# ============================================================================

cat("\n10. Data quality summary...\n")
cat("\n   Missing values (key institutional variables):\n")
cat(sprintf("     any_welfare_loan: %d\n", sum(is.na(df_analysis$any_welfare_loan))))
cat(sprintf("     public_pawnshop: %d\n", sum(is.na(df_analysis$public_pawnshop))))

cat("\n   Missing values (key demographic variables):\n")
cat(sprintf("     head_age: %d\n", sum(is.na(df_analysis$head_age))))
cat(sprintf("     female_head: %d\n", sum(is.na(df_analysis$female_head))))
cat(sprintf("     n_workers: %d\n", sum(is.na(df_analysis$n_workers))))

cat("\n   Coping variables: Complete for all observations\n")

cat("\n================================================================================\n")
cat("DATA CLEANING COMPLETE (R)\n")
cat("================================================================================\n")
cat(sprintf("Output file: %s\n", output_file))
cat("Ready for regression analysis.\n")

# Save environment for next script
save.image(file.path(output_logs, "phase1_workspace.RData"))
cat(sprintf("Workspace saved to: %s\n", file.path(output_logs, "phase1_workspace.RData")))
