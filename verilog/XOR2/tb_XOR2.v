`timescale 1ns/1ps
module tb_XOR2;
    reg A, B;
    wire Y;

    XOR2 uut(.A(A), .B(B), .Y(Y));

    initial begin
        $dumpfile("xor2.vcd");
        $dumpvars(0, tb_XOR2);

        A = 0; B = 0;
        #10 A = 0; B = 1;
        #10 A = 1; B = 0;
        #10 A = 1; B = 1;
        #10 A = 0; B = 0;

        #20 $finish;
    end
endmodule
