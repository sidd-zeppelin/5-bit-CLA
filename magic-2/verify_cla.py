import numpy as np

THRESH = 0.9

def to_bit(v):
    return 1 if v > THRESH else 0

def load_truth_table(filename):
    rows = []

    with open(filename, "r") as f:
        for line in f:
            parts = line.strip().split()

            # Skip blank lines and header lines
            if len(parts) == 0:
                continue
            if parts[0] == "time":
                continue

            # Must contain exactly 15 numeric columns
            if len(parts) != 15:
                continue

            try:
                vals = [float(x) for x in parts]
            except:
                continue

            rows.append(vals)

    return rows


def expected_outputs(A_bits, B_bits, Cin):
    A = A_bits[0] + 2*A_bits[1] + 4*A_bits[2] + 8*A_bits[3]
    B = B_bits[0] + 2*B_bits[1] + 4*B_bits[2] + 8*B_bits[3]

    total = A + B + Cin

    S = [
        (total >> 0) & 1,
        (total >> 1) & 1,
        (total >> 2) & 1,
        (total >> 3) & 1
    ]
    C4 = 1 if total >= 16 else 0

    return S, C4


def verify(filename):
    table = load_truth_table(filename)

    if len(table) == 0:
        print("Error: No valid rows found.")
        return

    errors = 0

    print("\n=== CLA 4-bit Verification ===\n")

    for i, row in enumerate(table):

        # Column mapping
        time = row[0]
        Avals = row[1:5]
        Bvals = row[5:9]
        Cin   = row[9]
        Svals = row[10:14]
        C4val = row[14]

        # Convert analog -> bits
        A = [to_bit(x) for x in Avals]
        B = [to_bit(x) for x in Bvals]
        Cin_b = to_bit(Cin)

        S_actual = [to_bit(x) for x in Svals]
        C4_actual = to_bit(C4val)

        # Expected outputs
        S_exp, C4_exp = expected_outputs(A, B, Cin_b)

        # Compare
        if S_actual != S_exp or C4_actual != C4_exp:
            errors += 1
            print(f"Row {i}: FAIL  (time={time} s)")
            print(f"  A={A}, B={B}, Cin={Cin_b}")
            print(f"  Expected: S={S_exp}, C4={C4_exp}")
            print(f"  Got:      S={S_actual}, C4={C4_actual}\n")

    print("=== SUMMARY ===")
    print(f"Total rows checked: {len(table)}")
    print(f"Errors: {errors}")
    print("================")

    if errors == 0:
        print("CLA is CORRECT ✓\n")
    else:
        print("CLA has ERRORS ✗\n")


if __name__ == "__main__":
    verify("truth_table.txt")
