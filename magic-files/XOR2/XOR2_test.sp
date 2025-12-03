.include "TSMC_180nm.txt"
.include "XOR.spice"

Rg GND 0 1e-3
Vdd VDD 0 1.8

VA A 0 PULSE(0 1.8 0n 0.1n 0.1n 20n 40n)
VB B 0 PULSE(0 1.8 0n 0.1n 0.1n 40n 80n)

Cout OUT 0 10f

.tran 0.1n 100n

.control
run
    plot v(A) v(B)+2 v(OUT)+4
.endc

.end
