module gen_prop(input A, input B, output G, output P);
    // G = Generate = A & B
    // P = Propagate = A ^ B

    // Instantiate AND2 and XOR2 modules (existing in project)
    AND2 u_and (.A(A), .B(B), .Y(G));
    XOR2 u_xor (.A(A), .B(B), .Y(P));

endmodule
