.include "TSMC_180nm.txt"
.include "INV.spice"

VDD VDD 0 1.8
VA A 0 PULSE(0 1.8 0 50p 50p 5n 10n)

.tran 0.1n 40n

.control
run
plot v(A) v(OUT)+2
.endc

.end
