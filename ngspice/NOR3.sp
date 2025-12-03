.include TSMC_180nm.txt

.subckt NOR3 a b c out vdd gnd L=0.18u Wn=0.9u Wp=5.4u
Mp1 out a n1 vdd cmosp W={Wp} L={L}
Mp2 n1 b n2 vdd cmosp W={Wp} L={L}
Mp3 n2 c vdd vdd cmosp W={Wp} L={L}
Mn1 out a gnd gnd cmosn W={Wn} L={L}
Mn2 out b gnd gnd cmosn W={Wn} L={L}
Mn3 out c gnd gnd cmosn W={Wn} L={L}
.ends NOR3

.param T=20n

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2} {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T} {2*T})
Vc c 0 PULSE(0 1.8 0 1p 1p {3*T/2} {3*T})

X1 a b c out vdd 0 NOR3
Cload out 0 10f

.tran 0.1n {6*T}
.param Vmid=0.9

.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(out) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(out) VAL={Vmid} FALL=1

.save V(a) V(b) V(c) V(out)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(out))
.endc

.end
