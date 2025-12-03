.include "TSMC_180nm.txt"
.include "OR5.spice"

VDD VDD 0 1.8
VA A 0 PULSE(0 1.8 0 50p 50p 5n 10n)
VB B 0 PULSE(0 1.8 0 50p 50p 10n 20n)
VC C 0 PULSE(0 1.8 0 50p 50p 20n 40n)
VD D 0 PULSE(0 1.8 0 50p 50p 40n 80n)
VE E 0 PULSE(0 1.8 0 50p 50p 80n 160n)

.tran 0.1n 320n

.control
run
plot v(A) v(B)+2 v(C)+4 v(D)+6 v(E)+8 v(OUT)+10
.endc

.end
