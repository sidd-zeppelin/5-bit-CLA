.include TSMC_180nm.txt

* nand3
.subckt NAND3 a b c out vdd gnd L=0.18u Wn=2.7u Wp=1.8u
Mn1 out a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b n2 gnd cmosn W={Wn} L={L}
Mn3 n2 c gnd gnd cmosn W={Wn} L={L}
Mp1 out a vdd vdd cmosp W={Wp} L={L}
Mp2 out b vdd vdd cmosp W={Wp} L={L}
Mp3 out c vdd vdd cmosp W={Wp} L={L}
.ends NAND3

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 1n 1p 1p 10n 30n)
Vb b 0 PULSE(0 1.8 3n 1p 1p 10n 30n)
Vc c 0 PULSE(0 1.8 5n 1p 1p 10n 30n)

X1 a b c out vdd 0 NAND3
Cload out 0 10f

.tran 0.1n 80n
.param Vmid=0.9
.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(out) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(out) VAL={Vmid} FALL=1
.save V(a) V(b) V(c) V(out)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(out))
.endc

.end
