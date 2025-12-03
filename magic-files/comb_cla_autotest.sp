.include "TSMC_180nm.txt"
.include "comb_cla.spice"

VDD VDD 0 1.8

* Stable interval for each test vector = 20ns
* Add minimal 0.1ns delay to avoid simultaneous switching

VCin Cin 0 PULSE(0 1.8 0.1n 1n 1n 10n 20n)

VA0 A0 0 PULSE(0 1.8 0.1n 1n 1n 20n     40n)
VA1 A1 0 PULSE(0 1.8 0.1n 1n 1n 40n     80n)
VA2 A2 0 PULSE(0 1.8 0.1n 1n 1n 80n     160n)
VA3 A3 0 PULSE(0 1.8 0.1n 1n 1n 160n    320n)
VA4 A4 0 PULSE(0 1.8 0.1n 1n 1n 320n    640n)

VB0 B0 0 PULSE(0 1.8 0.1n 1n 1n 640n    1.28u)
VB1 B1 0 PULSE(0 1.8 0.1n 1n 1n 1.28u   2.56u)
VB2 B2 0 PULSE(0 1.8 0.1n 1n 1n 2.56u   5.12u)
VB3 B3 0 PULSE(0 1.8 0.1n 1n 1n 5.12u   10.24u)
VB4 B4 0 PULSE(0 1.8 0.1n 1n 1n 10.24u  20.48u)

* TRAN with strobe = 20ns ensures ONE SAMPLE PER UNIQUE TEST VECTOR
.tran 0.1n 41u 0 20n

.control
run

wrdata truth_table.txt time v(Cin) v(A0) v(A1) v(A2) v(A3) v(A4) v(B0) v(B1) v(B2) v(B3) v(B4) v(S0) v(S1) v(S2) v(S3) v(S4) v(C5)

print "Unique truth table written to truth_table.txt"

.endc

.end
