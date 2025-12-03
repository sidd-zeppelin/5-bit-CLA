`timescale 1ns/1ps
module tb_OR4;
    reg A, B, C, D;
    wire Y;
    integer i;

    OR4 uut(.A(A), .B(B), .C(C), .D(D), .Y(Y));

    initial begin
        $dumpfile("or4.vcd");
        $dumpvars(0, tb_OR4);

        for (i = 0; i < 16; i = i + 1) begin
            {A, B, C, D} = i;
            #10;
        end

        #20 $finish;
    end
endmodule
