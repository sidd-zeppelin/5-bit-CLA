*===============================================================
* 5-BIT CLA ADDER: FINAL TIMING VERIFICATION TESTBENCH
* Siddharth Sinha (2024112011)
*===============================================================

.TITLE 5-bit CLA timing testbench

.include "TSMC_180nm.txt"
.include "cla_final.spice"

.param supply=1.8

vdd vdd gnd dc 1.8
Vclk clk gnd PULSE(0 1.8 2ns 0ns 0ns 3ns 6ns)

* FIX: add 2ns delay so first rising edge happens during transient
Va0 A0i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Va1 A1i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Va2 A2i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Va3 A3i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Va4 A4i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)

Vb0 B0i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Vb1 B1i gnd 0
Vb2 B2i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Vb3 B3i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)
Vb4 B4i gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)

Vcin Cini gnd PULSE(0 1.8 2ns 0ns 0ns 20ns 40ns)

.tran 0.1ns 200ns

* Delay Measurements
.measure tran dff_in_delay TRIG v(A4i) VAL=0.9 RISE=1  TARG v(a4)  VAL=0.9 RISE=1
.measure tran cla_delay    TRIG v(a0)  VAL=0.9 RISE=1  TARG v(s4)  VAL=0.9 RISE=1
.measure tran dff_out_delay TRIG v(s4) VAL=0.9 RISE=1  TARG v(s4o) VAL=0.9 RISE=1

.measure tran total_delay PARAM='dff_in_delay + cla_delay + dff_out_delay'
.measure tran tclk_min    PARAM='total_delay'
.measure tran fmax        PARAM='1/tclk_min'

.control
run

print dff_in_delay
print cla_delay
print dff_out_delay
print total_delay
print tclk_min
print fmax

set curplottitle=Inputs
plot A0i A1i+2 A2i+4 A3i+6 A4i+8 B0i+10 B1i+12 B2i+14 B3i+16 B4i+18 Cini+20 clk+22

set curplottitle=After_Input_DFF
plot a0 a1+2 a2+4 a3+6 a4+8 b0+10 b1+12 b2+14 b3+16 b4+18 cin+20 clk+22

set curplottitle=CLA_Internal
plot s0 s1+2 s2+4 s3+6 s4+8 cout+10 clk+12

set curplottitle=Final_Outputs
plot s0o s1o+2 s2o+4 s3o+6 s4o+8 couto+10 clk+12

.endc
.end
