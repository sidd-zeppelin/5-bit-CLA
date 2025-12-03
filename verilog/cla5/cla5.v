module cla5(
    input  [4:0] A,
    input  [4:0] B,
    input        Cin,
    output [4:0] S,
    output       Cout
);
    // Generate and Propagate signals
    wire G0, G1, G2, G3, G4;
    wire P0, P1, P2, P3, P4;

    gen_prop gp0(.A(A[0]), .B(B[0]), .G(G0), .P(P0));
    gen_prop gp1(.A(A[1]), .B(B[1]), .G(G1), .P(P1));
    gen_prop gp2(.A(A[2]), .B(B[2]), .G(G2), .P(P2));
    gen_prop gp3(.A(A[3]), .B(B[3]), .G(G3), .P(P3));
    gen_prop gp4(.A(A[4]), .B(B[4]), .G(G4), .P(P4));

    // Carry wires: c0 is Cin, c1..c5 (c5 is Cout)
    wire c0 = Cin;
    wire c1, c2, c3, c4, c5;

    // Intermediate AND terms for carries
    wire t_p0_c0;
    AND2 a_p0_c0(.A(P0), .B(c0), .Y(t_p0_c0));
    OR2  o_c1(.A(G0), .B(t_p0_c0), .Y(c1));

    wire t_p1_g0, t_p1p0_c0;
    AND2 a_p1_g0(.A(P1), .B(G0), .Y(t_p1_g0));
    AND3 a_p1p0_c0(.A(P1), .B(P0), .C(c0), .Y(t_p1p0_c0));
    OR3  o_c2(.A(G1), .B(t_p1_g0), .C(t_p1p0_c0), .Y(c2));

    wire t_p2_g1, t_p2p1_g0, t_p2p1p0_c0;
    AND2 a_p2_g1(.A(P2), .B(G1), .Y(t_p2_g1));
    AND3 a_p2p1_g0(.A(P2), .B(P1), .C(G0), .Y(t_p2p1_g0));
    AND4 a_p2p1p0_c0(.A(P2), .B(P1), .C(P0), .D(c0), .Y(t_p2p1p0_c0));
    OR4  o_c3(.A(G2), .B(t_p2_g1), .C(t_p2p1_g0), .D(t_p2p1p0_c0), .Y(c3));

    wire t_p3_g2, t_p3p2_g1, t_p3p2p1_g0, t_p3p2p1p0_c0;
    AND2 a_p3_g2(.A(P3), .B(G2), .Y(t_p3_g2));
    AND3 a_p3p2_g1(.A(P3), .B(P2), .C(G1), .Y(t_p3p2_g1));
    AND4 a_p3p2p1_g0(.A(P3), .B(P2), .C(P1), .D(G0), .Y(t_p3p2p1_g0));
    AND5 a_p3p2p1p0_c0(.A(P3), .B(P2), .C(P1), .D(P0), .E(c0), .Y(t_p3p2p1p0_c0));
    OR5  o_c4(.A(G3), .B(t_p3_g2), .C(t_p3p2_g1), .D(t_p3p2p1_g0), .E(t_p3p2p1p0_c0), .Y(c4));

    wire t_p4_g3, t_p4p3_g2, t_p4p3p2_g1, t_p4p3p2p1_g0, t_p4p3p2p1p0_c0;
    AND2 a_p4_g3(.A(P4), .B(G3), .Y(t_p4_g3));
    AND3 a_p4p3_g2(.A(P4), .B(P3), .C(G2), .Y(t_p4p3_g2));
    AND4 a_p4p3p2_g1(.A(P4), .B(P3), .C(P2), .D(G1), .Y(t_p4p3p2_g1));
    AND5 a_p4p3p2p1_g0(.A(P4), .B(P3), .C(P2), .D(P1), .E(G0), .Y(t_p4p3p2p1_g0));
    AND6 a_p4p3p2p1p0_c0(.A(P4), .B(P3), .C(P2), .D(P1), .E(P0), .F(c0), .Y(t_p4p3p2p1p0_c0));
    OR6  o_c5(.A(G4), .B(t_p4_g3), .C(t_p4p3_g2), .D(t_p4p3p2_g1), .E(t_p4p3p2p1_g0), .F(t_p4p3p2p1p0_c0), .Y(c5));

    assign Cout = c5;

    // Sum bits: S = P XOR Ci
    XOR2 x_s0(.A(P0), .B(c0), .Y(S[0]));
    XOR2 x_s1(.A(P1), .B(c1), .Y(S[1]));
    XOR2 x_s2(.A(P2), .B(c2), .Y(S[2]));
    XOR2 x_s3(.A(P3), .B(c3), .Y(S[3]));
    XOR2 x_s4(.A(P4), .B(c4), .Y(S[4]));

endmodule
