import pandas as pd

# ----------------------------------------
# USER SETTINGS
# ----------------------------------------
INPUT_FILE  = "truth_table.txt"
OUTPUT_FILE = "truth_table_parsed.csv"

VDD = 1.8
VIL = 0.3 * VDD
VIH = 0.7 * VDD

# ----------------------------------------
# Convert voltage → logic 0/1
# ----------------------------------------
def to_logic(v):
    if v <= VIL:
        return 0
    elif v >= VIH:
        return 1
    else:
        return "X"

# ----------------------------------------
# Load NGSPICE wrdata file
# ----------------------------------------
df = pd.read_csv(INPUT_FILE, sep=r"\s+", comment="*", engine="python")

# Drop the "time" column (first column)
time_col = df.columns[0]
df = df.drop(columns=[time_col])

# Convert all voltages to logic levels
logic_df = df.applymap(to_logic)

# ----------------------------------------
# Keep only "stable points" where signals stop changing
# ----------------------------------------
stable_rows = [0]  # always keep first row

for i in range(1, len(logic_df)):
    if not logic_df.iloc[i].equals(logic_df.iloc[i-1]):
        stable_rows.append(i)

logic_df = logic_df.iloc[stable_rows]

# Reset indexing
logic_df = logic_df.reset_index(drop=True)

# ----------------------------------------
# Save output
# ----------------------------------------
logic_df.to_csv(OUTPUT_FILE, index=False)

print("Converted truth table saved to:", OUTPUT_FILE)
print(logic_df)
