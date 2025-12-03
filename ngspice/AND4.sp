.include TSMC_180nm.txt

.subckt NAND4 a b c d n vdd gnd L=0.18u Wn=3.6u Wp=1.8u
Mn1 n a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b n2 gnd cmosn W={Wn} L={L}
Mn3 n2 c n3 gnd cmosn W={Wn} L={L}
Mn4 n3 d gnd gnd cmosn W={Wn} L={L}
Mp1 n a vdd vdd cmosp W={Wp} L={L}
Mp2 n b vdd vdd cmosp W={Wp} L={L}
Mp3 n c vdd vdd cmosp W={Wp} L={L}
Mp4 n d vdd vdd cmosp W={Wp} L={L}
.ends NAND4

.subckt INV x y vdd gnd Wn=0.9u Wp=1.8u L=0.18u
Mn y x gnd gnd cmosn W={Wn} L={L}
Mp y x vdd vdd cmosp W={Wp} L={L}
.ends INV

.subckt AND4 a b c d y vdd gnd
Xn a b c d n1 vdd gnd NAND4
Xi n1 y vdd gnd INV
.ends AND4

.param T=20n

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2} {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T} {2*T})
Vc c 0 PULSE(0 1.8 0 1p 1p {3*T/2} {3*T})
Vd d 0 PULSE(0 1.8 0 1p 1p {2*T} {4*T})

X1 a b c d y vdd 0 AND4
Cload y 0 10f

.tran 0.1n {8*T}
.param Vmid=0.9

.measure tran t_rise TRIG V(a) VAL={Vmid} RISE=1 TARG V(y) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(a) VAL={Vmid} FALL=1 TARG V(y) VAL={Vmid} FALL=1

.save V(a) V(b) V(c) V(d) V(y)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(d)+8) (V(y))
.endc

.end
