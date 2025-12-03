.include TSMC_180nm.txt

* OR6
.subckt NOR6 a b c d e f n vdd gnd L=0.18u Wn=0.9u Wp=10.8u
Mp1 n a n1 vdd cmosp W={Wp} L={L}
Mp2 n1 b n2 vdd cmosp W={Wp} L={L}
Mp3 n2 c n3 vdd cmosp W={Wp} L={L}
Mp4 n3 d n4 vdd cmosp W={Wp} L={L}
Mp5 n4 e n5 vdd cmosp W={Wp} L={L}
Mp6 n5 f vdd vdd cmosp W={Wp} L={L}
Mn1 n a gnd gnd cmosn W={Wn} L={L}
Mn2 n b gnd gnd cmosn W={Wn} L={L}
Mn3 n c gnd gnd cmosn W={Wn} L={L}
Mn4 n d gnd gnd cmosn W={Wn} L={L}
Mn5 n e gnd gnd cmosn W={Wn} L={L}
Mn6 n f gnd gnd cmosn W={Wn} L={L}
.ends NOR6

.subckt INV x y vdd gnd Wn=0.9u Wp=1.8u L=0.18u
Mn y x gnd gnd cmosn W={Wn} L={L}
Mp y x vdd vdd cmosp W={Wp} L={L}
.ends INV

.subckt OR6 a b c d e f y vdd gnd
Xn a b c d e f n1 vdd gnd NOR6
Xi n1 y vdd gnd INV
.ends OR6

.param T=20n

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2}     {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T}       {2*T})
Vc c 0 PULSE(0 1.8 0 1p 1p {2*T}     {4*T})
Vd d 0 PULSE(0 1.8 0 1p 1p {4*T}     {8*T})
Ve e 0 PULSE(0 1.8 0 1p 1p {8*T}     {16*T})
Vf f 0 PULSE(0 1.8 0 1p 1p {16*T}    {32*T})

X1 a b c d e f y vdd 0 OR6
Cload y 0 10f

.tran 0.1n {64*T}
.param Vmid=0.9

.save V(a) V(b) V(c) V(d) V(e) V(f) V(y)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(d)+8) (V(e)+10) (V(f)+12) (V(y))
.endc

.end
