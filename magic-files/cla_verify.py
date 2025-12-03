import argparse
import subprocess
import tempfile
import os

VDD = 1.8
THRESH = 0.9  # logic threshold

def bit_to_voltage(bit):
    return VDD if bit == '1' else 0

def voltage_to_bit(v):
    try:
        return '1' if float(v) > THRESH else '0'
    except:
        return '?'

def expected_sum(cin, a_bits, b_bits):
    A = int(a_bits, 2)
    B = int(b_bits, 2)
    Cin = int(cin)
    total = A + B + Cin
    S = format(total & 0b11111, '05b')   # S4..S0
    C5 = '1' if total > 31 else '0'
    return S, C5

def run_spice(cin, a_bits, b_bits):
    # Create a temporary SPICE file
    with tempfile.NamedTemporaryFile(delete=False, suffix=".sp") as f:
        spfile = f.name

        f.write(b"""
.include "TSMC_180nm.txt"
.include "comb_cla.spice"

VDD VDD 0 1.8
""")

        # Write DC input sources
        f.write(f"VCin Cin 0 DC {bit_to_voltage(cin)}\n".encode())

        for i, bit in enumerate(a_bits):
            f.write(f"VA{i} A{i} 0 DC {bit_to_voltage(bit)}\n".encode())

        for i, bit in enumerate(b_bits):
            f.write(f"VB{i} B{i} 0 DC {bit_to_voltage(bit)}\n".encode())

        # SPICE output block
        f.write(b"""
.op
.control
run
print v(S4)
print v(S3)
print v(S2)
print v(S1)
print v(S0)
print v(C5)
.endc
.end
""")

    # Run ngspice
    result = subprocess.run(["ngspice", "-b", spfile], capture_output=True, text=True)

    # Parse output line by line
    volt_dict = {"S4": None, "S3": None, "S2": None, "S1": None, "S0": None, "C5": None}

    for line in result.stdout.splitlines():
        line = line.strip().lower()

        for key in volt_dict.keys():
            if line.startswith(f"v({key.lower()})"):
                try:
                    volt = float(line.split("=")[1])
                except:
                    volt = 0.0
                volt_dict[key] = voltage_to_bit(volt)

    # Check that all nodes were found
    for key in volt_dict:
        if volt_dict[key] is None:
            raise RuntimeError(f"Could not find output voltage for {key} in NGSPICE output.")

    sim_sum = volt_dict["S4"] + volt_dict["S3"] + volt_dict["S2"] + volt_dict["S1"] + volt_dict["S0"]
    sim_carry = volt_dict["C5"]

    os.remove(spfile)
    return sim_sum, sim_carry


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cin", required=True)
    parser.add_argument("--a", required=True)
    parser.add_argument("--b", required=True)
    args = parser.parse_args()

    cin = args.cin
    a_bits = args.a
    b_bits = args.b

    print("\n=== INPUTS ===")
    print(f"Cin = {cin}")
    print(f"A   = {a_bits}")
    print(f"B   = {b_bits}")

    print("\nRunning NGSPICE...")
    sim_sum, sim_carry = run_spice(cin, a_bits, b_bits)

    exp_sum, exp_carry = expected_sum(cin, a_bits, b_bits)

    print("\n=== EXPECTED ===")
    print(f"S4..S0 = {exp_sum}")
    print(f"C5     = {exp_carry}")

    print("\n=== SIMULATED ===")
    print(f"S4..S0 = {sim_sum}")
    print(f"C5     = {sim_carry}")

    print("\n=== RESULT ===")
    if sim_sum == exp_sum and sim_carry == exp_carry:
        print("PASS ✓ The CLA output is correct!")
    else:
        print("FAIL ✗ Output mismatch detected!")

    print()


if __name__ == "__main__":
    main()
