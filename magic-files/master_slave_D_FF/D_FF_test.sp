.include "TSMC_180nm.txt"
.include "master_slave_D_FF.spice"

Rgnd GND 0 1e-3
Vdd  VDD 0 1.8
Vclk CLK 0 PULSE(0 1.8 0n 0.1n 0.1n 10n 20n)
Vd   D_in 0 PWL(0n 0  19n 0  21n 1.8  59n 1.8  61n 0  200n 0)

Cq Q 0 10f
.tran 0.1n 200n

.control
run
plot v(CLK) v(D_in)+2 v(Q)+4
.endc

.end
