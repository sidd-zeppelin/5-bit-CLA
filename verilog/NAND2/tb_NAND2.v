`timescale 1ns/1ps
module tb_NAND2;
    reg A, B;
    wire Y;

    NAND2 uut(.A(A), .B(B), .Y(Y));

    initial begin
        $dumpfile("nand2.vcd");
        $dumpvars(0, tb_NAND2);

        A = 0; B = 0;
        #10 A = 0; B = 1;
        #10 A = 1; B = 0;
        #10 A = 1; B = 1;
        #10 A = 0; B = 0;

        #20 $finish;
    end
endmodule
