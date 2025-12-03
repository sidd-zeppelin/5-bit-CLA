.include "TSMC_180nm.txt"
.include "gen_prop.spice"

VDD VDD 0 1.8

VA A 0 PULSE(0 1.8 0 50p 50p 5n  10n)
VB B 0 PULSE(0 1.8 0 50p 50p 10n 20n)

.tran 0.1n 40n

.control
run
plot v(A) v(B)+2 v(G)+4 v(P)+6
.endc

.end
