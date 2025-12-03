`timescale 1ns/1ps
module tb_OR3;
    reg A, B, C;
    wire Y;
    integer i;

    OR3 uut(.A(A), .B(B), .C(C), .Y(Y));

    initial begin
        $dumpfile("or3.vcd");
        $dumpvars(0, tb_OR3);

        for (i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;
            #10;
        end

        #20 $finish;
    end
endmodule
