.include TSMC_180nm.txt

* nand2
.subckt NAND2 a b out vdd gnd L=0.18u Wn=1.8u Wp=1.8u
Mn1 out a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b gnd gnd cmosn W={Wn} L={L}
Mp1 out a vdd vdd cmosp W={Wp} L={L}
Mp2 out b vdd vdd cmosp W={Wp} L={L}
.ends NAND2

* inv
.subckt INV in out vdd gnd params: Wn=0.9u Wp=1.8u L=0.18u
Mn out in gnd gnd cmosn W={Wn} L={L}
Mp out in vdd vdd cmosp W={Wp} L={L}
.ends INV

* and2 = inv(nand2)
.subckt AND2 a b y vdd gnd
Xn a b n1 vdd gnd NAND2
Xi n1 y vdd gnd INV
.ends AND2

* supplies
Vdd vdd 0 1.8

* inputs
Va a 0 PULSE(0 1.8 1n 1p 1p 10n 20n)
Vb b 0 PULSE(0 1.8 5n 1p 1p 10n 20n)

* inst
X1 a b y vdd 0 AND2

* load
Cload y 0 10f

* sim
.tran 0.1n 50n
.param Vmid=0.9

* delay
.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(y) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(y) VAL={Vmid} FALL=1

.save V(a) V(b) V(y)

* plot
.control
run
plot (V(a)+2) (V(b)+4) (V(y))
.endc

.end
