// Master-Slave D flip-flop implemented using NAND2 gates
// Positive-edge triggered: master enabled when CLK=0 (nCLK=1), slave enabled when CLK=1
module master_slave_D_FF(
    input D,
    input CLK,
    output Q,
    output QN
);
    wire nD;   // ~D
    wire nCLK; // ~CLK

    // invert D and CLK using NAND as inverter
    wire n1, n2;
    NAND2 invD (.A(D), .B(D), .Y(nD));
    NAND2 invCLK(.A(CLK), .B(CLK), .Y(nCLK));

    // Master latch inputs (enabled when nCLK = 1 i.e., CLK=0)
    wire S_m, R_m;
    NAND2 mS (.A(D), .B(nCLK), .Y(S_m));
    NAND2 mR (.A(nD), .B(nCLK), .Y(R_m));

    // Master latch (NAND SR latch)
    wire Qm, Qm_bar;
    NAND2 mL1 (.A(S_m), .B(Qm_bar), .Y(Qm));
    NAND2 mL2 (.A(R_m), .B(Qm), .Y(Qm_bar));

    // Slave latch inputs (enabled when CLK = 1)
    wire S_s, R_s;
    NAND2 sS (.A(Qm), .B(CLK), .Y(S_s));
    NAND2 sR (.A(Qm_bar), .B(CLK), .Y(R_s));

    // Slave latch (NAND SR latch) -> outputs Q and QN
    wire Q_bar;
    NAND2 sL1 (.A(S_s), .B(Q_bar), .Y(Q));
    NAND2 sL2 (.A(R_s), .B(Q), .Y(Q_bar));

    // Provide complementary output
    assign QN = Q_bar;

endmodule
