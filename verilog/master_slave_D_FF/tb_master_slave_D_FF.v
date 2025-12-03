`timescale 1ns/1ps
module tb_master_slave_D_FF;
    reg D;
    reg CLK;
    wire Q, QN;

    master_slave_D_FF uut(.D(D), .CLK(CLK), .Q(Q), .QN(QN));

    // Clock generator
    initial begin
        CLK = 0;
    end
    always #5 CLK = ~CLK; // 10ns period

    integer i;
    reg expected;

    initial begin
        $dumpfile("D_FF.vcd");
        $dumpvars(0, tb_master_slave_D_FF);

        D = 0;
        #3; // small offset so D changes on negedge below

        // Change D on negedge to ensure stable at posedge
        for (i = 0; i < 20; i = i + 1) begin
            @(negedge CLK);
            D = $random & 1;
        end

        #100 $finish;
    end

    // Check Q shortly after posedge (allow propagation)
    always @(posedge CLK) begin
        #1; // allow propagation through NAND network
        expected = D; // D at posedge (stable because we change on negedge)
        if (Q !== expected) begin
            $display("Mismatch at time %0t: D=%b Q=%b", $time, D, Q);
        end else begin
            $display("Match at time %0t: D=%b Q=%b", $time, D, Q);
        end
    end
endmodule
