.include TSMC_180nm.txt

.subckt NOR6 a b c d e f out vdd gnd L=0.18u Wn=0.9u Wp=10.8u
Mp1 out a n1 vdd cmosp W={Wp} L={L}
Mp2 n1 b n2 vdd cmosp W={Wp} L={L}
Mp3 n2 c n3 vdd cmosp W={Wp} L={L}
Mp4 n3 d n4 vdd cmosp W={Wp} L={L}
Mp5 n4 e n5 vdd cmosp W={Wp} L={L}
Mp6 n5 f vdd vdd cmosp W={Wp} L={L}
Mn1 out a gnd gnd cmosn W={Wn} L={L}
Mn2 out b gnd gnd cmosn W={Wn} L={L}
Mn3 out c gnd gnd cmosn W={Wn} L={L}
Mn4 out d gnd gnd cmosn W={Wn} L={L}
Mn5 out e gnd gnd cmosn W={Wn} L={L}
Mn6 out f gnd gnd cmosn W={Wn} L={L}
.ends NOR6

.param T=20n

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2} {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T} {2*T})
Vc c 0 PULSE(0 1.8 0 1p 1p {3*T/2} {3*T})
Vd d 0 PULSE(0 1.8 0 1p 1p {2*T} {4*T})
Ve e 0 PULSE(0 1.8 0 1p 1p {5*T/2} {5*T})
Vf f 0 PULSE(0 1.8 0 1p 1p {3*T} {6*T})

X1 a b c d e f out vdd 0 NOR6
Cload out 0 10f

.tran 0.1n {12*T}
.param Vmid=0.9

.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(out) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(out) VAL={Vmid} FALL=1

.save V(a) V(b) V(c) V(d) V(e) V(f) V(out)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(d)+8) (V(e)+10) (V(f)+12) (V(out))
.endc

.end
