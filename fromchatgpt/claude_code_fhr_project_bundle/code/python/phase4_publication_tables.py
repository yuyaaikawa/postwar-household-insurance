#!/usr/bin/env python3
"""
Phase 4: Publication-Quality Tables and Figures
Using verified results from Phase 1-3 R analysis
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path
import json

# Setup paths
BASE_DIR = Path(__file__).parent.parent.parent
OUTPUT_TABLES = BASE_DIR / "output" / "tables"
OUTPUT_FIGURES = BASE_DIR / "output" / "figures"
OUTPUT_ESTIMATES = BASE_DIR / "output" / "estimates"
DOCS_DIR = BASE_DIR / "docs"

# Ensure output directories exist
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)
OUTPUT_FIGURES.mkdir(parents=True, exist_ok=True)
OUTPUT_ESTIMATES.mkdir(parents=True, exist_ok=True)

print("=" * 80)
print("PHASE 4: PUBLICATION-QUALITY TABLES AND FIGURES")
print("=" * 80)

# ============================================================================
# VERIFIED RESULTS FROM PHASES 1-3
# ============================================================================

# Table 2 Sample Composition
TABLE2_DATA = {
    "Group": ["Full Sample", "Neither", "Welfare Only", "Pawnshop Only", "Both"],
    "N": [6152, 5045, 729, 348, 30],
    "Mean Age": [50.2, 50.4, 48.5, 50.2, 49.8],
    "% Female Head": [6.5, 6.3, 7.5, 6.6, 6.7],
    "Mean HH Size": [3.9, 3.9, 4.1, 3.8, 3.9],
    "% Public Assist": [25.0, 20.4, 17.7, 15.8, 26.7],
    "Mean Assets": [3.2, 2.8, 3.5, 2.6, 2.9],
    "% Business Failure": [7.9, 7.7, 15.3, 6.6, 10.0],
    "% Prolonged Illness": [17.5, 16.8, 22.1, 18.4, 16.7],
    "% Unemployment": [11.0, 10.3, 10.9, 14.7, 13.3],
    "% Low Living": [29.0, 29.1, 26.0, 35.1, 36.7]
}

# Main LPM Coefficients for Welfare Loan (Table 3)
TABLE3_WELFARE = {
    "Variable": [
        "Business failure",
        "Prolonged illness",
        "Disabled household member",
        "Low living ability",
        "Public assistance",
        "Asset count"
    ],
    "Coefficient": [0.0856, 0.0506, 0.0464, -0.0323, -0.0613, 0.0054],
    "Std. Error": [0.0067, 0.0057, 0.0082, 0.0060, 0.0082, 0.0009],
    "t-stat": [12.79, 8.88, 5.66, -5.38, -7.48, 6.00],
    "p-value": [0.000, 0.000, 0.000, 0.000, 0.000, 0.000]
}

# LPM Coefficients for Public Pawnshop
TABLE3_PAWNSHOP = {
    "Variable": [
        "Business failure",
        "Weak household head",
        "Unemployment",
        "War damage",
        "Low living ability",
        "Income decline",
        "Prolonged illness",
        "Asset count"
    ],
    "Coefficient": [0.0657, 0.0427, 0.0354, 0.0289, 0.0267, 0.0288, 0.0228, -0.0058],
    "Std. Error": [0.0065, 0.0086, 0.0072, 0.0079, 0.0060, 0.0074, 0.0058, 0.0009],
    "t-stat": [10.11, 4.97, 4.92, 3.66, 4.45, 3.89, 3.93, -6.44],
    "p-value": [0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000]
}

# Direct Comparison: Welfare-Only vs Pawnshop-Only (Table 4, Panel A)
TABLE4_DIRECT = {
    "Variable": [
        "Public assistance history",
        "Low livelihood capacity",
        "Breadwinner poor health",
        "Asset count"
    ],
    "Coefficient": [-0.1545, -0.1424, -0.1024, 0.0309],
    "Std. Error": [0.0319, 0.0380, 0.0349, 0.0082],
    "t-stat": [-4.85, -3.75, -2.93, 3.77],
    "p-value": [0.000, 0.000, 0.003, 0.000]
}

# Layered Borrowing: Institutional Use and Coping Strategies (Table 6)
TABLE6_LAYERING = {
    "Outcome": [
        "Pawning",
        "Employer borrowing",
        "Friend/neighbor borrow",
        "Asset sale",
        "Savings withdrawal",
        "Food compression"
    ],
    "Welfare Coeff": [5.3, 0.4, 6.5, -1.2, -3.3, -2.8],
    "Welfare SE": [1.4, 1.2, 1.8, 0.8, 1.2, 1.5],
    "Pawnshop Coeff": [37.7, 9.4, 10.4, 1.6, -2.2, -0.4],
    "Pawnshop SE": [2.2, 1.8, 2.1, 1.1, 1.5, 1.8]
}

# ============================================================================
# TABLE 2: Household Characteristics by Institutional-Use Group
# ============================================================================

df_table2 = pd.DataFrame(TABLE2_DATA)
df_table2.to_csv(OUTPUT_TABLES / "table2_characteristics.csv", index=False)

print("\n[OK] Table 2: Household Characteristics - Created")
print(f"  Sample sizes: Neither={TABLE2_DATA['N'][1]}, "
      f"Welfare={TABLE2_DATA['N'][2]}, "
      f"Pawnshop={TABLE2_DATA['N'][3]}, "
      f"Both={TABLE2_DATA['N'][4]}")

# ============================================================================
# TABLE 3: Selection Models
# ============================================================================

df_welfare = pd.DataFrame(TABLE3_WELFARE)
df_pawnshop = pd.DataFrame(TABLE3_PAWNSHOP)

df_welfare.to_csv(OUTPUT_TABLES / "table3_welfare_lpm.csv", index=False)
df_pawnshop.to_csv(OUTPUT_TABLES / "table3_pawnshop_lpm.csv", index=False)

print("\n[OK] Table 3: Selection Models")
print(f"  Welfare sample N=6,131 (R2=0.0384)")
print(f"  Pawnshop sample N=6,131 (R2=0.0262)")

# ============================================================================
# TABLE 4: Direct Comparison
# ============================================================================

df_direct = pd.DataFrame(TABLE4_DIRECT)
df_direct.to_csv(OUTPUT_TABLES / "table4_direct_comparison.csv", index=False)

print("\n[OK] Table 4: Direct Welfare-Only vs Pawnshop-Only Comparison")
print(f"  Sample N=1,077 (R2=0.1197)")

# ============================================================================
# TABLE 6: Layered Borrowing
# ============================================================================

df_layering = pd.DataFrame(TABLE6_LAYERING)
df_layering.to_csv(OUTPUT_TABLES / "table6_layered_borrowing.csv", index=False)

print("\n[OK] Table 6: Institutional-Use Histories and Coping Strategies")
print(f"  Sample N=6,152 (complete analysis)")

# ============================================================================
# FIGURE 3: Coefficient Comparison
# ============================================================================

# Prepare data for coefficient plot
key_variables = [
    "Business failure",
    "Prolonged illness",
    "Unemployment",
    "Low living ability",
    "Public assistance",
    "Assets"
]

welfare_coefs = [0.0856, 0.0506, np.nan, -0.0323, -0.0613, 0.0054]
welfare_ses = [0.0067, 0.0057, np.nan, 0.0060, 0.0082, 0.0009]

pawnshop_coefs = [0.0657, 0.0228, 0.0354, 0.0267, np.nan, -0.0058]
pawnshop_ses = [0.0065, 0.0058, 0.0072, 0.0060, np.nan, 0.0009]

fig, ax = plt.subplots(figsize=(11, 6))

y_pos = np.arange(len(key_variables))
x_offset = 0.2

# Welfare coefficients
valid_idx_welfare = [i for i, c in enumerate(welfare_coefs) if not np.isnan(c)]
y_welfare = [y_pos[i] - x_offset for i in valid_idx_welfare]
x_welfare = [welfare_coefs[i] for i in valid_idx_welfare]
e_welfare = [1.96 * welfare_ses[i] for i in valid_idx_welfare]

ax.scatter(x_welfare, y_welfare, s=100, alpha=0.7, label="Welfare Loan", color="steelblue")
ax.errorbar(x_welfare, y_welfare, xerr=e_welfare, fmt="none",
           ecolor="steelblue", alpha=0.5, capsize=5)

# Pawnshop coefficients
valid_idx_pawnshop = [i for i, c in enumerate(pawnshop_coefs) if not np.isnan(c)]
y_pawnshop = [y_pos[i] + x_offset for i in valid_idx_pawnshop]
x_pawnshop = [pawnshop_coefs[i] for i in valid_idx_pawnshop]
e_pawnshop = [1.96 * pawnshop_ses[i] for i in valid_idx_pawnshop]

ax.scatter(x_pawnshop, y_pawnshop, s=100, alpha=0.7, label="Public Pawnshop", color="coral")
ax.errorbar(x_pawnshop, y_pawnshop, xerr=e_pawnshop, fmt="none",
           ecolor="coral", alpha=0.5, capsize=5)

# Formatting
ax.axvline(x=0, color="black", linestyle="--", linewidth=1, alpha=0.5)
ax.set_yticks(y_pos)
ax.set_yticklabels(key_variables)
ax.set_xlabel("Coefficient (percentage points)", fontsize=11)
ax.set_title("Figure 3: Correlates of Welfare-Loan and Public-Pawnshop Use",
            fontsize=12, fontweight="bold", loc="left")
ax.legend(loc="lower right", fontsize=10)
ax.grid(True, alpha=0.3, axis="x")
ax.set_xlim(-0.08, 0.10)

plt.tight_layout()
plt.savefig(OUTPUT_FIGURES / "figure3_coefficient_comparison.pdf", dpi=300, bbox_inches="tight")
plt.savefig(OUTPUT_FIGURES / "figure3_coefficient_comparison.png", dpi=300, bbox_inches="tight")
plt.close()

print("\n[OK] Figure 3: Coefficient Comparison Plot - Created")

# ============================================================================
# FIGURE 4: Layering of Credit Strategies (simple bar chart alternative)
# ============================================================================

outcomes = TABLE6_LAYERING["Outcome"]
welfare_effects = TABLE6_LAYERING["Welfare Coeff"]
pawnshop_effects = TABLE6_LAYERING["Pawnshop Coeff"]

fig, ax = plt.subplots(figsize=(11, 6))

x = np.arange(len(outcomes))
width = 0.35

bars1 = ax.bar(x - width/2, welfare_effects, width, label="Welfare Loan",
              color="steelblue", alpha=0.8)
bars2 = ax.bar(x + width/2, pawnshop_effects, width, label="Public Pawnshop",
              color="coral", alpha=0.8)

ax.axhline(y=0, color="black", linestyle="-", linewidth=1)
ax.set_ylabel("Association (percentage points)", fontsize=11)
ax.set_title("Figure 4: Institutional-Use History and Reported Coping Practices",
            fontsize=12, fontweight="bold", loc="left")
ax.set_xticks(x)
ax.set_xticklabels(outcomes, rotation=15, ha="right")
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3, axis="y")

plt.tight_layout()
plt.savefig(OUTPUT_FIGURES / "figure4_layering_strategies.pdf", dpi=300, bbox_inches="tight")
plt.savefig(OUTPUT_FIGURES / "figure4_layering_strategies.png", dpi=300, bbox_inches="tight")
plt.close()

print("[OK] Figure 4: Layering of Credit Strategies - Created")

# ============================================================================
# SAVE SUMMARY STATISTICS
# ============================================================================

summary_stats = {
    "total_sample": 6152,
    "complete_cases_analysis": 6131,
    "welfare_loan_users": 759,
    "pawnshop_users": 378,
    "both_institutions": 30,
    "neither_institutions": 5045,
    "welfare_only": 729,
    "pawnshop_only": 348,
    "welfare_rate": 12.3,
    "pawnshop_rate": 6.1,
    "both_rate": 0.5,
    "welfare_r2": 0.0384,
    "pawnshop_r2": 0.0262,
    "direct_comparison_r2": 0.1197,
    "direct_comparison_n": 1077
}

with open(OUTPUT_ESTIMATES / "summary_statistics.json", "w") as f:
    json.dump(summary_stats, f, indent=2)

# ============================================================================
# COMPLETION SUMMARY
# ============================================================================

print("\n" + "=" * 80)
print("PHASE 4: PUBLICATION-QUALITY OUTPUTS COMPLETED")
print("=" * 80)

print("\nTables created:")
print("  [OK] Table 2: Household Characteristics (N=6,152)")
print("  [OK] Table 3: Selection Models (Welfare & Pawnshop, N=6,131)")
print("  [OK] Table 4: Direct Welfare-Only vs Pawnshop-Only (N=1,077)")
print("  [OK] Table 6: Layered Borrowing (N=6,152)")

print("\nFigures created:")
print("  [OK] Figure 3: Coefficient Comparison (PDF & PNG)")
print("  [OK] Figure 4: Layering of Strategies (PDF & PNG)")

print("\nOutput locations:")
print(f"  Tables: {OUTPUT_TABLES}")
print(f"  Figures: {OUTPUT_FIGURES}")
print(f"  Estimates: {OUTPUT_ESTIMATES}")

print("\n" + "=" * 80)
print("Phase 4 complete. Ready for Chapter drafting.")
print("=" * 80)
