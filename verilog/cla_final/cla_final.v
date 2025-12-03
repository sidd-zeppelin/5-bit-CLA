module cla_final(
    input  [4:0] A_in,
    input  [4:0] B_in,
    input        Cin_in,
    input        CLK,
    output [4:0] S_out,
    output       Cout_out
);
    // Registered inputs (captured on rising edge)
    wire A_reg0, A_reg1, A_reg2, A_reg3, A_reg4;
    wire B_reg0, B_reg1, B_reg2, B_reg3, B_reg4;
    wire Cin_reg;

    // Instantiate D-FFs for A inputs
    master_slave_D_FF dff_a0(.D(A_in[0]), .CLK(CLK), .Q(A_reg0), .QN());
    master_slave_D_FF dff_a1(.D(A_in[1]), .CLK(CLK), .Q(A_reg1), .QN());
    master_slave_D_FF dff_a2(.D(A_in[2]), .CLK(CLK), .Q(A_reg2), .QN());
    master_slave_D_FF dff_a3(.D(A_in[3]), .CLK(CLK), .Q(A_reg3), .QN());
    master_slave_D_FF dff_a4(.D(A_in[4]), .CLK(CLK), .Q(A_reg4), .QN());

    // Instantiate D-FFs for B inputs
    master_slave_D_FF dff_b0(.D(B_in[0]), .CLK(CLK), .Q(B_reg0), .QN());
    master_slave_D_FF dff_b1(.D(B_in[1]), .CLK(CLK), .Q(B_reg1), .QN());
    master_slave_D_FF dff_b2(.D(B_in[2]), .CLK(CLK), .Q(B_reg2), .QN());
    master_slave_D_FF dff_b3(.D(B_in[3]), .CLK(CLK), .Q(B_reg3), .QN());
    master_slave_D_FF dff_b4(.D(B_in[4]), .CLK(CLK), .Q(B_reg4), .QN());

    // D-FF for Cin
    master_slave_D_FF dff_cin(.D(Cin_in), .CLK(CLK), .Q(Cin_reg), .QN());

    // Wires to connect to CLA combinational block
    wire [4:0] A_reg_bus;
    wire [4:0] B_reg_bus;
    wire [4:0] S_comb;
    wire Cout_comb;

    assign A_reg_bus = {A_reg4, A_reg3, A_reg2, A_reg1, A_reg0};
    assign B_reg_bus = {B_reg4, B_reg3, B_reg2, B_reg1, B_reg0};

    // Instantiate the combinational CLA (cla5)
    cla5 cla_inst(.A(A_reg_bus), .B(B_reg_bus), .Cin(Cin_reg), .S(S_comb), .Cout(Cout_comb));

    // Register outputs S and Cout into D-FFs
    master_slave_D_FF dff_s0(.D(S_comb[0]), .CLK(CLK), .Q(S_out[0]), .QN());
    master_slave_D_FF dff_s1(.D(S_comb[1]), .CLK(CLK), .Q(S_out[1]), .QN());
    master_slave_D_FF dff_s2(.D(S_comb[2]), .CLK(CLK), .Q(S_out[2]), .QN());
    master_slave_D_FF dff_s3(.D(S_comb[3]), .CLK(CLK), .Q(S_out[3]), .QN());
    master_slave_D_FF dff_s4(.D(S_comb[4]), .CLK(CLK), .Q(S_out[4]), .QN());

    master_slave_D_FF dff_cout(.D(Cout_comb), .CLK(CLK), .Q(Cout_out), .QN());

endmodule
