# clk input is from the 100 MHz oscillator on Boolean board
create_clock -period 10.000 -name gclk [get_ports clk]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {clk}]

# --- a_in[4:0] mapped to SW[0..4] ---
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {a_in[0]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {a_in[1]}]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {a_in[2]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {a_in[3]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {a_in[4]}]

# --- b_in[4:0] mapped to SW[5..9] ---
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {b_in[0]}]
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {b_in[1]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {b_in[2]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {b_in[3]}]
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {b_in[4]}]

# --- sum_out[4:0] mapped to LED[0..4] ---
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {sum_out[0]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {sum_out[1]}]
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports {sum_out[2]}]
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS33} [get_ports {sum_out[3]}]
set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports {sum_out[4]}]

# --- cout_out mapped to LED[5] ---
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {cout_out}]

# --- c0_in mapped to SW[10] ---
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports {c0_in}]
