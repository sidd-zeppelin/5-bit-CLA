.include "TSMC_180nm.txt"

* INV
.subckt INV x y vdd gnd Wn=0.9u Wp=1.8u L=0.18u
MINV1 y x gnd gnd cmosn W={Wn} L={L}
MINV2 y x vdd vdd cmosp W={Wp} L={L}
.ends INV

* NAND2
.subckt NAND2 a b y vdd gnd Wn=0.9u Wp=1.8u L=0.18u
MNAND21 y a n1 gnd cmosn W={Wn} L={L}
MNAND22 n1 b gnd gnd cmosn W={Wn} L={L}
MNAND23 y a vdd vdd cmosp W={Wp} L={L}
MNAND24 y b vdd vdd cmosp W={Wp} L={L}
.ends NAND2

* AND2..AND6
.subckt AND2 a b y vdd gnd Wn=1.8u Wp=1.8u L=0.18u
MAND21 y a n1 gnd cmosn W={Wn} L={L}
MAND22 n1 b gnd gnd cmosn W={Wn} L={L}
MAND23 y a vdd vdd cmosp W={Wp} L={L}
MAND24 y b vdd vdd cmosp W={Wp} L={L}
.ends AND2

.subckt AND3 a b c y vdd gnd Wn=2.7u Wp=1.8u L=0.18u
MAND31 y a n1 gnd cmosn W={Wn} L={L}
MAND32 n1 b n2 gnd cmosn W={Wn} L={L}
MAND33 n2 c gnd gnd cmosn W={Wn} L={L}
MAND34 y a vdd vdd cmosp W={Wp} L={L}
MAND35 y b vdd vdd cmosp W={Wp} L={L}
MAND36 y c vdd vdd cmosp W={Wp} L={L}
.ends AND3

.subckt AND4 a b c d y vdd gnd Wn=3.6u Wp=1.8u L=0.18u
MAND41 y a n1 gnd cmosn W={Wn} L={L}
MAND42 n1 b n2 gnd cmosn W={Wn} L={L}
MAND43 n2 c n3 gnd cmosn W={Wn} L={L}
MAND44 n3 d gnd gnd cmosn W={Wn} L={L}
MAND45 y a vdd vdd cmosp W={Wp} L={L}
MAND46 y b vdd vdd cmosp W={Wp} L={L}
MAND47 y c vdd vdd cmosp W={Wp} L={L}
MAND48 y d vdd vdd cmosp W={Wp} L={L}
.ends AND4

.subckt AND5 a b c d e y vdd gnd Wn=4.5u Wp=1.8u L=0.18u
MAND51 y a n1 gnd cmosn W={Wn} L={L}
MAND52 n1 b n2 gnd cmosn W={Wn} L={L}
MAND53 n2 c n3 gnd cmosn W={Wn} L={L}
MAND54 n3 d n4 gnd cmosn W={Wn} L={L}
MAND55 n4 e gnd gnd cmosn W={Wn} L={L}
MAND56 y a vdd vdd cmosp W={Wp} L={L}
MAND57 y b vdd vdd cmosp W={Wp} L={L}
MAND58 y c vdd vdd cmosp W={Wp} L={L}
MAND59 y d vdd vdd cmosp W={Wp} L={L}
MAND5A y e vdd vdd cmosp W={Wp} L={L}
.ends AND5

.subckt AND6 a b c d e f y vdd gnd Wn=5.4u Wp=1.8u L=0.18u
MAND61 y a n1 gnd cmosn W={Wn} L={L}
MAND62 n1 b n2 gnd cmosn W={Wn} L={L}
MAND63 n2 c n3 gnd cmosn W={Wn} L={L}
MAND64 n3 d n4 gnd cmosn W={Wn} L={L}
MAND65 n4 e n5 gnd cmosn W={Wn} L={L}
MAND66 n5 f gnd gnd cmosn W={Wn} L={L}
MAND67 y a vdd vdd cmosp W={Wp} L={L}
MAND68 y b vdd vdd cmosp W={Wp} L={L}
MAND69 y c vdd vdd cmosp W={Wp} L={L}
MAND6A y d vdd vdd cmosp W={Wp} L={L}
MAND6B y e vdd vdd cmosp W={Wp} L={L}
MAND6C y f vdd vdd cmosp W={Wp} L={L}
.ends AND6

* NOR2 explicit nodes
.subckt NOR2 a b y vdd gnd Wn=0.9u Wp=3.6u L=0.18u
* PDN
MNOR21 y a gnd gnd cmosn W={Wn} L={L}
MNOR22 y b gnd gnd cmosn W={Wn} L={L}
* PUN series nodes
MNOR2_P_a y a nor2_p_a vdd cmosp W={Wp} L={L}
MNOR2_P_b nor2_p_a b vdd vdd cmosp W={Wp} L={L}
.ends NOR2

* NOR3 explicit nodes
.subckt NOR3 a b c y vdd gnd Wn=0.9u Wp=5.4u L=0.18u
MNOR31 y a gnd gnd cmosn W={Wn} L={L}
MNOR32 y b gnd gnd cmosn W={Wn} L={L}
MNOR33 y c gnd gnd cmosn W={Wn} L={L}
MNOR3_P_a y a nor3_p_ab vdd cmosp W={Wp} L={L}
MNOR3_P_b nor3_p_ab b nor3_p_bc vdd cmosp W={Wp} L={L}
MNOR3_P_c nor3_p_bc c vdd vdd cmosp W={Wp} L={L}
.ends NOR3

* NOR4 explicit nodes
.subckt NOR4 a b c d y vdd gnd Wn=0.9u Wp=7.2u L=0.18u
MNOR41 y a gnd gnd cmosn W={Wn} L={L}
MNOR42 y b gnd gnd cmosn W={Wn} L={L}
MNOR43 y c gnd gnd cmosn W={Wn} L={L}
MNOR44 y d gnd gnd cmosn W={Wn} L={L}
MNOR4_P_a y a nor4_p_ab vdd cmosp W={Wp} L={L}
MNOR4_P_b nor4_p_ab b nor4_p_bc vdd cmosp W={Wp} L={L}
MNOR4_P_c nor4_p_bc c nor4_p_cd vdd cmosp W={Wp} L={L}
MNOR4_P_d nor4_p_cd d vdd vdd cmosp W={Wp} L={L}
.ends NOR4

* NOR5 explicit nodes
.subckt NOR5 a b c d e y vdd gnd Wn=0.9u Wp=9.0u L=0.18u
MNOR51 y a gnd gnd cmosn W={Wn} L={L}
MNOR52 y b gnd gnd cmosn W={Wn} L={L}
MNOR53 y c gnd gnd cmosn W={Wn} L={L}
MNOR54 y d gnd gnd cmosn W={Wn} L={L}
MNOR55 y e gnd gnd cmosn W={Wn} L={L}
MNOR5_P_a y a nor5_p_ab vdd cmosp W={Wp} L={L}
MNOR5_P_b nor5_p_ab b nor5_p_bc vdd cmosp W={Wp} L={L}
MNOR5_P_c nor5_p_bc c nor5_p_cd vdd cmosp W={Wp} L={L}
MNOR5_P_d nor5_p_cd d nor5_p_de vdd cmosp W={Wp} L={L}
MNOR5_P_e nor5_p_de e vdd vdd cmosp W={Wp} L={L}
.ends NOR5

* NOR6 explicit nodes
.subckt NOR6 a b c d e f y vdd gnd Wn=0.9u Wp=10.8u L=0.18u
MNOR61 y a gnd gnd cmosn W={Wn} L={L}
MNOR62 y b gnd gnd cmosn W={Wn} L={L}
MNOR63 y c gnd gnd cmosn W={Wn} L={L}
MNOR64 y d gnd gnd cmosn W={Wn} L={L}
MNOR65 y e gnd gnd cmosn W={Wn} L={L}
MNOR66 y f gnd gnd cmosn W={Wn} L={L}
MNOR6_P_a y a nor6_p_ab vdd cmosp W={Wp} L={L}
MNOR6_P_b nor6_p_ab b nor6_p_bc vdd cmosp W={Wp} L={L}
MNOR6_P_c nor6_p_bc c nor6_p_cd vdd cmosp W={Wp} L={L}
MNOR6_P_d nor6_p_cd d nor6_p_de vdd cmosp W={Wp} L={L}
MNOR6_P_e nor6_p_de e nor6_p_ef vdd cmosp W={Wp} L={L}
MNOR6_P_f nor6_p_ef f vdd vdd cmosp W={Wp} L={L}
.ends NOR6

* OR2..OR6 via NORk + INV
.subckt OR2 a b y vdd gnd
XNOR2N a b yn vdd gnd NOR2
XNOR2I yn y vdd gnd INV
.ends OR2

.subckt OR3 a b c y vdd gnd
XNOR3N a b c yn vdd gnd NOR3
XNOR3I yn y vdd gnd INV
.ends OR3

.subckt OR4 a b c d y vdd gnd
XNOR4N a b c d yn vdd gnd NOR4
XNOR4I yn y vdd gnd INV
.ends OR4

.subckt OR5 a b c d e y vdd gnd
XNOR5N a b c d e yn vdd gnd NOR5
XNOR5I yn y vdd gnd INV
.ends OR5

.subckt OR6 a b c d e f y vdd gnd
XNOR6N a b c d e f yn vdd gnd NOR6
XNOR6I yn y vdd gnd INV
.ends OR6

* XOR2 structural (INV+AND+OR)
.subckt XOR2 a b y vdd gnd
XINV_A a na vdd gnd INV
XINV_B b nb vdd gnd INV
XAND_A a nb ta vdd gnd AND2
XAND_B b na tb vdd gnd AND2
XOR_OUT ta tb y vdd gnd OR2
.ends XOR2

* GP block
.subckt GP a b g p vdd gnd
XGP_AND a b g vdd gnd AND2
XGP_XOR a b p vdd gnd XOR2
.ends GP

* CLA5 top
.subckt CLA5 A0 A1 A2 A3 A4 B0 B1 B2 B3 B4 Cin S0 S1 S2 S3 S4 Cout VDD GND

XGP0 A0 B0 G0 P0 VDD GND GP
XGP1 A1 B1 G1 P1 VDD GND GP
XGP2 A2 B2 G2 P2 VDD GND GP
XGP3 A3 B3 G3 P3 VDD GND GP
XGP4 A4 B4 G4 P4 VDD GND GP

XC1A P0 Cin T10 VDD GND AND2
XC1  G0 T10 C1 VDD GND OR2

XC2A P1 G0 T20 VDD GND AND2
XC2B P1 P0 Cin T21 VDD GND AND3
XC2  G1 T20 T21 C2 VDD GND OR3

XC3A P2 G1 T30 VDD GND AND2
XC3B P2 P1 G0 T31 VDD GND AND3
XC3C P2 P1 P0 Cin T32 VDD GND AND4
XC3  G2 T30 T31 T32 C3 VDD GND OR4

XC4A P3 G2 T40 VDD GND AND2
XC4B P3 P2 G1 T41 VDD GND AND3
XC4C P3 P2 P1 G0 T42 VDD GND AND4
XC4D P3 P2 P1 P0 Cin T43 VDD GND AND5
XC4  G3 T40 T41 T42 T43 C4 VDD GND OR5

XC5A P4 C4 T50 VDD GND AND2
XC5  G4 T50 Cout VDD GND OR2

XS0 P0 Cin S0 VDD GND XOR2
XS1 P1 C1  S1 VDD GND XOR2
XS2 P2 C2  S2 VDD GND XOR2
XS3 P3 C3  S3 VDD GND XOR2
XS4 P4 C4  S4 VDD GND XOR2

.ends CLA5
