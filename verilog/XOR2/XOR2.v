module XOR2(input A, input B, output Y);
    wire n1, n2, n3;

    // Implement XOR using 4 NAND2 instances
    // n1 = A NAND B
    NAND2 u1 (.A(A), .B(B), .Y(n1));
    // n2 = A NAND n1
    NAND2 u2 (.A(A), .B(n1), .Y(n2));
    // n3 = B NAND n1
    NAND2 u3 (.A(B), .B(n1), .Y(n3));
    // Y = n2 NAND n3
    NAND2 u4 (.A(n2), .B(n3), .Y(Y));

endmodule
