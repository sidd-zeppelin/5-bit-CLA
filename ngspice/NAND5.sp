.include TSMC_180nm.txt

* nand5
.subckt NAND5 a b c d e out vdd gnd L=0.18u Wn=4.5u Wp=1.8u
Mn1 out a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b n2 gnd cmosn W={Wn} L={L}
Mn3 n2 c n3 gnd cmosn W={Wn} L={L}
Mn4 n3 d n4 gnd cmosn W={Wn} L={L}
Mn5 n4 e gnd gnd cmosn W={Wn} L={L}
Mp1 out a vdd vdd cmosp W={Wp} L={L}
Mp2 out b vdd vdd cmosp W={Wp} L={L}
Mp3 out c vdd vdd cmosp W={Wp} L={L}
Mp4 out d vdd vdd cmosp W={Wp} L={L}
Mp5 out e vdd vdd cmosp W={Wp} L={L}
.ends NAND5

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 1n 1p 1p 10n 50n)
Vb b 0 PULSE(0 1.8 3n 1p 1p 10n 50n)
Vc c 0 PULSE(0 1.8 5n 1p 1p 10n 50n)
Vd d 0 PULSE(0 1.8 7n 1p 1p 10n 50n)
Ve e 0 PULSE(0 1.8 9n 1p 1p 10n 50n)

X1 a b c d e out vdd 0 NAND5
Cload out 0 10f

.tran 0.1n 120n
.param Vmid=0.9
.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(out) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(out) VAL={Vmid} FALL=1
.save V(a) V(b) V(c) V(d) V(e) V(out)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(d)+8) (V(e)+10) (V(out))
.endc

.end
