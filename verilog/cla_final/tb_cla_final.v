`timescale 1ns/1ps
module tb_cla_final;
    reg [4:0] A_in, B_in;
    reg Cin_in;
    reg CLK;
    wire [4:0] S_out;
    wire Cout_out;

    cla_final uut(.A_in(A_in), .B_in(B_in), .Cin_in(Cin_in), .CLK(CLK), .S_out(S_out), .Cout_out(Cout_out));

    // Clock generator
    initial CLK = 0;
    always #5 CLK = ~CLK; // 10 ns period

    integer i;

    initial begin
        $dumpfile("cla_final.vcd");
        $dumpvars(0, tb_cla_final);

        // Initialize inputs
        A_in = 0; B_in = 0; Cin_in = 0;
        #3; // offset so input changes on negedge

        // Drive a sequence of vectors; change on negedge so they are captured at posedge
        for (i = 0; i < 20; i = i + 1) begin
            @(negedge CLK);
            A_in = $random & 31;
            B_in = $random & 31;
            Cin_in = $random & 1;
        end

        #200 $finish;
    end
endmodule
