.include TSMC_180nm.txt

* nand2
.subckt NAND2 a b out vdd gnd L=0.18u Wn=1.8u Wp=1.8u
Mn1 out a n1 gnd cmosn W={Wn} L={L}
Mn2 n1 b gnd gnd cmosn W={Wn} L={L}
Mp1 out a vdd vdd cmosp W={Wp} L={L}
Mp2 out b vdd vdd cmosp W={Wp} L={L}
.ends NAND2

* xor2
.subckt XOR2 a b y vdd gnd
X1 a b n1 vdd gnd NAND2
X2 a n1 n2 vdd gnd NAND2
X3 b n1 n3 vdd gnd NAND2
X4 n2 n3 y  vdd gnd NAND2
.ends XOR2

.param T=20n

Vsup vdd 0 1.8
Va a 0 PULSE(0 1.8 0 1p 1p {T/2} {T})
Vb b 0 PULSE(0 1.8 0 1p 1p {T}   {2*T})

Xxor a b y vdd 0 XOR2
Cload y 0 10f

.tran 0.1n {4*T}
.param Vmid=0.9

.save V(a) V(b) V(y)

.control
run
plot (V(a)+2) (V(b)+4) (V(y))
.endc

.end
