`timescale 1ns/1ps
module tb_OR5;
    reg A, B, C, D, E;
    wire Y;
    integer i;

    OR5 uut(.A(A), .B(B), .C(C), .D(D), .E(E), .Y(Y));

    initial begin
        $dumpfile("or5.vcd");
        $dumpvars(0, tb_OR5);

        for (i = 0; i < 32; i = i + 1) begin
            {A, B, C, D, E} = i;
            #10;
        end

        #20 $finish;
    end
endmodule
