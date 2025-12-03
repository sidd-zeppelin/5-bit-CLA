.include "TSMC_180nm.txt"
.include "cla_final.spice"

Rg GND 0 1e-3
Vdd VDD 0 1.8

* CLK: 20 ns period, 10 ns high
VCLK CLK 0 PULSE(0 1.8 0n 0.1n 0.1n 10n 20n)

* =====================================================
* 10 TESTCASES USING SIMPLE PULSE SOURCES
* Each signal toggles at a different rate so that
* the first 10 combinations appear during the first
* 200 ns of simulation.
* =====================================================

VA0i A0i 0 PULSE(0 1.8 0n 0.1n 0.1n 20n 40n)
VA1i A1i 0 PULSE(0 1.8 0n 0.1n 0.1n 40n 80n)
VA2i A2i 0 PULSE(0 1.8 0n 0.1n 0.1n 80n 160n)
VA3i A3i 0 PULSE(0 1.8 0n 0.1n 0.1n 160n 320n)
VA4i A4i 0 PULSE(0 1.8 0n 0.1n 0.1n 320n 640n)

VB0i B0i 0 PULSE(0 1.8 0n 0.1n 0.1n 20n 40n)
VB1i B1i 0 PULSE(0 1.8 0n 0.1n 0.1n 40n 80n)
VB2i B2i 0 PULSE(0 1.8 0n 0.1n 0.1n 80n 160n)
VB3i B3i 0 PULSE(0 1.8 0n 0.1n 0.1n 160n 320n)
VB4i B4i 0 PULSE(0 1.8 0n 0.1n 0.1n 320n 640n)

VCini Cini 0 PULSE(0 1.8 0n 0.1n 0.1n 10n 20n)

* Output loading capacitors
CS0o S0o 0 10f
CS1o S1o 0 10f
CS2o S2o 0 10f
CS3o S3o 0 10f
CS4o S4o 0 10f
CCouto Couto 0 10f

.tran 0.1n 400n

.control
run
set wr_singlescale
set wr_vecnames
set wr_strobe

set strobeperiod = 20n
set strobestart = 10n


plot  v(CLK)+34  v(A0i)+32  v(A1i)+30  v(A2i)+28  v(A3i)+26  v(A4i)+24 v(B0i)+22  v(B1i)+20  v(B2i)+18  v(B3i)+16  v(B4i)+14 v(Cini)+12  v(S0o)+10  v(S1o)+8  v(S2o)+6  v(S3o)+4  v(S4o)+2  v(Couto)+0
wrdata truth_table.txt v(CLK) v(A0i) v(A1i) v(A2i) v(A3i) v(A4i) v(B0i) v(B1i) v(B2i) v(B3i) v(B4i) v(Cini) v(S0o) v(S1o) v(S2o) v(S3o) v(S4o) v(Couto)

.endc

.end