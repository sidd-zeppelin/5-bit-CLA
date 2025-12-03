`timescale 1ns/1ps
module tb_gen_prop;
    reg A, B;
    wire G, P;

    gen_prop uut(.A(A), .B(B), .G(G), .P(P));
    integer i;

    initial begin
        $dumpfile("gen_prop.vcd");
        $dumpvars(0, tb_gen_prop);

        for (i = 0; i < 4; i = i + 1) begin
            {A, B} = i;
            #10;
        end

        #20 $finish;
    end
endmodule
