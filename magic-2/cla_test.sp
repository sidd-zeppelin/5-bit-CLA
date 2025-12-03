.include "TSMC_180nm.txt"
.include "cla.spice"

Rg GND 0 1e-3
Vdd VDD 0 1.8

VA0 A0 0 PULSE(0 1.8 0n 0.1n 0.1n 10n 20n)
VA1 A1 0 PULSE(0 1.8 0n 0.1n 0.1n 20n 40n)
VA2 A2 0 PULSE(0 1.8 0n 0.1n 0.1n 40n 80n)
VA3 A3 0 PULSE(0 1.8 0n 0.1n 0.1n 80n 160n)

VB0 B0 0 PULSE(0 1.8 0n 0.1n 0.1n 160n 320n)
VB1 B1 0 PULSE(0 1.8 0n 0.1n 0.1n 320n 640n)
VB2 B2 0 PULSE(0 1.8 0n 0.1n 0.1n 640n 1280n)
VB3 B3 0 PULSE(0 1.8 0n 0.1n 0.1n 1280n 2560n)

VCin Cin 0 PULSE(0 1.8 0n 0.1n 0.1n 2560n 5120n)

CS0 S0 0 10f
CS1 S1 0 10f
CS2 S2 0 10f
CS3 S3 0 10f
CC4 C4 0 10f

.tran 0.1n 5120n 0 20n

.control
run
set wr_singlescale
set wr_vecnames
set wr_strobe

wrdata truth_table.txt v(A0) v(A1) v(A2) v(A3) v(B0) v(B1) v(B2) v(B3) v(Cin) v(S0) v(S1) v(S2) v(S3) v(C4)

plot v(A0) v(A1)+2 v(A2)+4 v(A3)+6 v(B0)+8 v(B1)+10 v(B2)+12 v(B3)+14 v(Cin)+16 v(S0)+18 v(S1)+20 v(S2)+22 v(S3)+24 v(C4)+26

hardcopy cla_waveform.svg v(A0) v(A1)+2 v(A2)+4 v(A3)+6 v(B0)+8 v(B1)+10 v(B2)+12 v(B3)+14 v(Cin)+16 v(S0)+18 v(S1)+20 v(S2)+22 v(S3)+24 v(C4)+26

.endc

.end
