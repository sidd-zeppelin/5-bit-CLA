.include "TSMC_180nm.txt"
.include "comb_cla.spice"

VDD VDD 0 1.8

VCin Cin 0 PULSE(0 1.8 0   50p 50p 5n   10n)

VA0 A0 0 PULSE(0 1.8 0    50p 50p 10n  20n)
VA1 A1 0 PULSE(0 1.8 0    50p 50p 20n  40n)
VA2 A2 0 PULSE(0 1.8 0    50p 50p 40n  80n)
VA3 A3 0 PULSE(0 1.8 0    50p 50p 80n  160n)
VA4 A4 0 PULSE(0 1.8 0    50p 50p 160n 320n)

VB0 B0 0 PULSE(0 1.8 0    50p 50p 15n  30n)
VB1 B1 0 PULSE(0 1.8 0    50p 50p 30n  60n)
VB2 B2 0 PULSE(0 1.8 0    50p 50p 60n  120n)
VB3 B3 0 PULSE(0 1.8 0    50p 50p 120n 240n)
VB4 B4 0 PULSE(0 1.8 0    50p 50p 240n 480n)

.tran 0.2n 1u

.control
run
plot v(Cin) v(A0)+2 v(A1)+4 v(A2)+6 v(A3)+8 v(A4)+10 v(B0)+12 v(B1)+14 v(B2)+16 v(B3)+18 v(B4)+20 v(S0)+22 v(S1)+24 v(S2)+26 v(S3)+28 v(S4)+30 v(C5)+32
.endc

.end
