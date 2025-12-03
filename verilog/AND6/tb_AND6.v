`timescale 1ns/1ps
module tb_AND6;
    reg A, B, C, D, E, F;
    wire Y;
    integer i;

    AND6 uut(.A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .Y(Y));

    initial begin
        $dumpfile("and6.vcd");
        $dumpvars(0, tb_AND6);

        for (i = 0; i < 64; i = i + 1) begin
            {A, B, C, D, E, F} = i;
            #10;
        end

        #20 $finish;
    end
endmodule
