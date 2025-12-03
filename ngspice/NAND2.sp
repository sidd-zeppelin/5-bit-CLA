.include TSMC_180nm.txt

* nand2
.subckt NAND2 a b out vdd gnd L=0.18u Wn=1.8u Wp=1.8u
Mn1 out a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b gnd gnd cmosn W={Wn} L={L}
Mp1 out a vdd vdd cmosp W={Wp} L={L}
Mp2 out b vdd vdd cmosp W={Wp} L={L}
.ends NAND2

* supplies
Vdd vdd 0 1.8

* inputs
Va a 0 PULSE(0 1.8 1n 1n 1n 10n 20n)
Vb b 0 PULSE(0 1.8 5n 1n 1n 10n 20n)

* inst
X1 a b out vdd 0 NAND2

* load
Cload out 0 10f

* sim
.tran 0.1n 50n
.param Vmid=0.9

* delay (using 'a' as reference)
.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(out) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(out) VAL={Vmid} FALL=1

.save V(a) V(b) V(out)

* plot
.control
run
plot (V(a)+2) (V(b)+4) (V(out))
.endc

.end
