.include "TSMC_180nm.txt"

.subckt NAND2 A B Y VDD GND L=0.18u Wn=0.9u Wp=1.8u
MN1 Y A N1 GND cmosn W={Wn} L={L}
MN2 N1 B GND GND cmosn W={Wn} L={L}
MP1 Y A VDD VDD cmosp W={Wp} L={L}
MP2 Y B VDD VDD cmosp W={Wp} L={L}
.ends NAND2

.subckt SRLATCH S R Q QB VDD GND
XN1 S QB Q VDD GND NAND2
XN2 R Q QB VDD GND NAND2
.ends SRLATCH

.subckt DLATCH D CLK Q QB VDD GND
XINV  D D D_INV VDD GND NAND2
XN1   D CLK S_int VDD GND NAND2
XN2   D_INV CLK R_int VDD GND NAND2
XSR   S_int R_int Q QB VDD GND SRLATCH
.ends DLATCH

.subckt DFF D CLK Q QB VDD GND
XCI   CLK CLK CLK_N VDD GND NAND2
XM    D CLK_N QM QBM VDD GND DLATCH
XS    QM CLK    Q  QB  VDD GND DLATCH
.ends DFF

VDD VDD 0 1.8
VCLK CLK 0 PULSE(0 1.8 10n 0.05n 0.05n 5n 20n)
VD D 0 PULSE(0 1.8 9.6n 0.05n 0.05n 0.8n 200n)

XDFF D CLK Q QB VDD 0 DFF

Cq Q 0 10f
Cqb QB 0 10f

.tran 0.02n 60n 0 0.02n

.measure tran t_clk_to_q TRIG v(CLK) VAL=0.9 RISE=1 TARG v(Q)   VAL=0.9 RISE=1
.measure tran t_setup   TRIG v(D)   VAL=0.9 RISE=1 TARG v(CLK) VAL=0.9 RISE=1
.measure tran t_hold    TRIG v(CLK) VAL=0.9 RISE=1 TARG v(D)   VAL=0.9 FALL=1

.save v(CLK) v(D) v(Q)

.control
run
print t_clk_to_q
print t_setup
print t_hold
plot v(CLK) v(D)+2 v(Q)+4
.endc

.end
