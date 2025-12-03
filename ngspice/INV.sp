.include TSMC_180nm.txt

.subckt INV in out vdd gnd params: Wn=0.9u Wp=1.8u L=0.18u
Mn out in gnd gnd cmosn W={Wn} L={L}
Mp out in vdd vdd cmosp W={Wp} L={L}
.ends INV

Vdd vdd 0 1.8

Vin in 0 PULSE(0 1.8 1n 1p 1p 10n 20n)

X1 in out vdd 0 INV

Cload out 0 10f

.tran 0.1n 50n
.param Vmid=0.9

.measure tran t_rise TRIG V(in) VAL={Vmid} RISE=1 TARG V(out) VAL={Vmid} RISE=1
.measure tran t_fall TRIG V(in) VAL={Vmid} FALL=1 TARG V(out) VAL={Vmid} FALL=1

.save V(in) V(out)

.control
run
plot (V(in)+2) (V(out))
.endc

.end
