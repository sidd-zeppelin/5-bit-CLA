`timescale 1ns/1ps
module tb_AND2;
    reg A, B;
    wire Y;

    AND2 uut(.A(A), .B(B), .Y(Y));

    initial begin
        $dumpfile("and2.vcd");
        $dumpvars(0, tb_AND2);

        A = 0; B = 0;
        #10 A = 0; B = 1;
        #10 A = 1; B = 0;
        #10 A = 1; B = 1;
        #10 A = 0; B = 0;

        #20 $finish;
    end
endmodule
