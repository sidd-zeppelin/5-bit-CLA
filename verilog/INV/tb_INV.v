`timescale 1ns/1ps

module tb_INV;

    reg A;
    wire Y;

    INV uut (.A(A), .Y(Y));

    initial begin
        $dumpfile("inv.vcd");
        $dumpvars(0, tb_INV);

        A = 0;
        #10 A = 1;
        #10 A = 0;
        #10 A = 1;
        #10 A = 0;

        #20 $finish;
    end

endmodule
