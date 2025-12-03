.include "TSMC_180nm.txt"
.include "cla.spice"

Rg GND 0 1e-3
Vdd VDD 0 1.8

VA0 A0 0 PULSE(0 1.8 0n 0.1n 0.1n   20n  40n)
VA1 A1 0 PULSE(0 1.8 0n 0.1n 0.1n   40n  80n)
VA2 A2 0 PULSE(0 1.8 0n 0.1n 0.1n   80n 160n)
VA3 A3 0 PULSE(0 1.8 0n 0.1n 0.1n  160n 320n)
VA4 A4 0 PULSE(0 1.8 0n 0.1n 0.1n  320n 640n)

VB0 B0 0 PULSE(0 1.8 0n 0.1n 0.1n  640n 1280n)
VB1 B1 0 PULSE(0 1.8 0n 0.1n 0.1n 1280n 2560n)
VB2 B2 0 PULSE(0 1.8 0n 0.1n 0.1n 2560n 5120n)
VB3 B3 0 PULSE(0 1.8 0n 0.1n 0.1n 5120n 10240n)
VB4 B4 0 PULSE(0 1.8 0n 0.1n 0.1n 10240n 20480n)

VCin Cin 0 PULSE(0 1.8 0n 0.1n 0.1n 20480n 40960n)

CS0 S0 0 10f
CS1 S1 0 10f
CS2 S2 0 10f
CS3 S3 0 10f
CS4 S4 0 10f
CCout Cout 0 10f

.tran 0.1n 400n 0 40n

.control
run
set wr_singlescale
set wr_vecnames
set wr_strobe

wrdata truth_table_5bit.txt v(A0) v(A1) v(A2) v(A3) v(A4) v(B0) v(B1) v(B2) v(B3) v(B4) v(Cin) v(S0) v(S1) v(S2) v(S3) v(S4) v(Cout)

plot v(A0) v(A1)+2 v(A2)+4 v(A3)+6 v(A4)+8 v(B0)+10 v(B1)+12 v(B2)+14 v(B3)+16 v(B4)+18 v(Cin)+20 v(S0)+22 v(S1)+24 v(S2)+26 v(S3)+28 v(S4)+30 v(Cout)+32


.endc

.end
