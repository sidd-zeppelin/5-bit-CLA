.include TSMC_180nm.txt

* OR3
.subckt NOR3 a b c n vdd gnd L=0.18u Wn=0.9u Wp=5.4u
Mp1 n a n1 vdd cmosp W={Wp} L={L}
Mp2 n1 b n2 vdd cmosp W={Wp} L={L}
Mp3 n2 c vdd vdd cmosp W={Wp} L={L}
Mn1 n a gnd gnd cmosn W={Wn} L={L}
Mn2 n b gnd gnd cmosn W={Wn} L={L}
Mn3 n c gnd gnd cmosn W={Wn} L={L}
.ends NOR3

.subckt INV x y vdd gnd Wn=0.9u Wp=1.8u L=0.18u
Mn y x gnd gnd cmosn W={Wn} L={L}
Mp y x vdd vdd cmosp W={Wp} L={L}
.ends INV

.subckt OR3 a b c y vdd gnd
Xn a b c n1 vdd gnd NOR3
Xi n1 y vdd gnd INV
.ends OR3

.param T=20n

Vdd vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2}   {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T}     {2*T})
Vc c 0 PULSE(0 1.8 0 1p 1p {2*T}   {4*T})

X1 a b c y vdd 0 OR3
Cload y 0 10f

.tran 0.1n {8*T}
.param Vmid=0.9

.save V(a) V(b) V(c) V(y)

.control
run
plot (V(a)+2) (V(b)+4) (V(c)+6) (V(y))
.endc

.end
