.include "TSMC_180nm.txt"
.include "cla5_pre.sp"

.param T=200n

VDD VDD 0 1.8

VA0 A0 0 PULSE(0 1.8 0 0.1n 0.1n {T/2} {T})
VA1 A1 0 PULSE(0 1.8 0 0.1n 0.1n {T} {2*T})
VA2 A2 0 PULSE(0 1.8 0 0.1n 0.1n {2*T} {4*T})
VA3 A3 0 PULSE(0 1.8 0 0.1n 0.1n {4*T} {8*T})
VA4 A4 0 PULSE(0 1.8 0 0.1n 0.1n {8*T} {16*T})

VB0 B0 0 PULSE(0 1.8 0 0.1n 0.1n {T/2} {T})
VB1 B1 0 PULSE(0 1.8 0 0.1n 0.1n {T} {2*T})
VB2 B2 0 PULSE(0 1.8 0 0.1n 0.1n {2*T} {4*T})
VB3 B3 0 PULSE(0 1.8 0 0.1n 0.1n {4*T} {8*T})
VB4 B4 0 PULSE(0 1.8 0 0.1n 0.1n {8*T} {16*T})

VCin Cin 0 PULSE(0 1.8 0 0.1n 0.1n {16*T} {32*T})

CS0 S0 0 10f
CS1 S1 0 10f
CS2 S2 0 10f
CS3 S3 0 10f
CS4 S4 0 10f
CCout Cout 0 10f

XCLA A0 A1 A2 A3 A4 B0 B1 B2 B3 B4 Cin S0 S1 S2 S3 S4 Cout VDD 0 CLA5

.tran 0.2n {64*T} 0 {T/10}

.control
run
set wr_singlescale
set wr_vecnames

plot (v(A0)+2) (v(A1)+4) (v(A2)+6) (v(A3)+8) (v(A4)+10)
plot (v(B0)+12) (v(B1)+14) (v(B2)+16) (v(B3)+18) (v(B4)+20)
plot (v(Cin)+22) (v(S0)+24) (v(S1)+26) (v(S2)+28) (v(S3)+30) (v(S4)+32) (v(Cout)+34)

wrdata cla5_truth_table.txt v(A0) v(A1) v(A2) v(A3) v(A4) v(B0) v(B1) v(B2) v(B3) v(B4) v(Cin) v(S0) v(S1) v(S2) v(S3) v(S4) v(Cout)
.endc

.end
