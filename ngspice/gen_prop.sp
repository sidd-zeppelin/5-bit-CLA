.include TSMC_180nm.txt

* nand2
.subckt NAND2 a b out vdd gnd L=0.18u Wn=1.8u Wp=1.8u
Mn1 out a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b gnd gnd cmosn W={Wn} L={L}
Mp1 out a vdd vdd cmosp W={Wp} L={L}
Mp2 out b vdd vdd cmosp W={Wp} L={L}
.ends NAND2

* inv
.subckt INV x y vdd gnd Wn=0.9u Wp=1.8u L=0.18u
Mn y x gnd gnd cmosn W={Wn} L={L}
Mp y x vdd vdd cmosp W={Wp} L={L}
.ends INV

* xor2
.subckt XOR2 a b y vdd gnd
X1 a b n1 vdd gnd NAND2
X2 a n1 n2 vdd gnd NAND2
X3 b n1 n3 vdd gnd NAND2
X4 n2 n3 y  vdd gnd NAND2
.ends XOR2

* and2
.subckt AND2 a b y vdd gnd
Xn a b n1 vdd gnd NAND2
Xi n1 y vdd gnd INV
.ends AND2

* gp
.subckt GP a b g p vdd gnd
Xg a b g vdd gnd AND2
Xp a b p vdd gnd XOR2
.ends GP

.param T=20n

Vsup vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2} {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T}   {2*T})

Xgp a b G P vdd 0 GP
Cg G 0 10f
Cp P 0 10f

.tran 0.1n {4*T}

.save V(a) V(b) V(G) V(P)

.control
run
plot (V(a)+2) (V(b)+4) (V(G)+6) (V(P)+8)
.endc

.end
