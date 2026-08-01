# Setup and path configuration for SSJDA 1331 analysis
# All data paths are strictly read-only. All outputs go to derived/ directories.

# ============================================================================
# PATHS
# ============================================================================

# Project root
project_root <- here::here()

# Authoritative read-only data directory
authoritative_data_dir <- "C:/Users/yuyaa/git/postwar_household_insurance/postwar_household_insurance/data/raw"

# SSJDA 1331 extract directory
ssjda_extract_dir <- file.path(
  authoritative_data_dir,
  "神奈川県における民生基礎調査（ボーダー・ライン層調査）1961",
  "1331"
)

# Specific data files
ssjda_csv_file <- file.path(ssjda_extract_dir, "1331.csv")
ssjda_dta_file <- file.path(ssjda_extract_dir, "1331.dta")
ssjda_labels_file <- file.path(ssjda_extract_dir, "1331label.txt")
ssjda_readme_file <- file.path(ssjda_extract_dir, "1331readme.docx")

# Project output directories
data_derived <- file.path(project_root, "data", "derived")
output_tables <- file.path(project_root, "output", "tables")
output_figures <- file.path(project_root, "output", "figures")
output_logs <- file.path(project_root, "output", "logs")
docs <- file.path(project_root, "docs")

# Create directories if they don't exist
dir.create(data_derived, recursive = TRUE, showWarnings = FALSE)
dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)
dir.create(output_logs, recursive = TRUE, showWarnings = FALSE)
dir.create(docs, recursive = TRUE, showWarnings = FALSE)

# Verify source files exist
if (!file.exists(ssjda_csv_file)) {
  stop(paste("SSJDA CSV file not found:", ssjda_csv_file))
}

cat("================================================================================\n")
cat("PATH CONFIGURATION\n")
cat("================================================================================\n")
cat("Project root:", project_root, "\n")
cat("Read-only data dir:", authoritative_data_dir, "\n")
cat("SSJDA CSV file:", ssjda_csv_file, "\n")
cat("\nOutput directories:\n")
cat("  Derived data:", data_derived, "\n")
cat("  Tables:", output_tables, "\n")
cat("  Figures:", output_figures, "\n")
cat("  Logs:", output_logs, "\n")
cat("  Docs:", docs, "\n")
cat("\n[OK] All paths configured and verified.\n")
