`timescale 1ns/1ps
module tb_cla5;
    reg [4:0] A, B;
    reg Cin;
    wire [4:0] S;
    wire Cout;

    cla5 uut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

    integer a, b, c;
    reg [5:0] expected;
    integer errors;

    initial begin
        $dumpfile("cla5.vcd");
        $dumpvars(0, tb_cla5);

        errors = 0;
        for (a = 0; a < 32; a = a + 1) begin
            for (b = 0; b < 32; b = b + 1) begin
                for (c = 0; c < 2; c = c + 1) begin
                    A = a;
                    B = b;
                    Cin = c;
                    #5;
                    expected = A + B + Cin;
                    if ({Cout, S} !== expected) begin
                        $display("Mismatch: A=%0d B=%0d Cin=%0d -> got Cout=%b S=%b expected=%b", a, b, c, Cout, S, expected);
                        errors = errors + 1;
                    end
                end
            end
        end

        if (errors == 0) $display("All vectors matched.");
        else $display("Total mismatches: %0d", errors);

        #20 $finish;
    end
endmodule
