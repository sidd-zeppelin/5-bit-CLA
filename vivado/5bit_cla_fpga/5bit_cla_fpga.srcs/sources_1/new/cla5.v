// cla5_neg.v
`timescale 1ns/1ps

module pg_bit (
    input  wire a,
    input  wire b,
    output wire p,
    output wire g
);
    assign p = a ^ b;
    assign g = a & b;
endmodule

module carry_lookahead5 (
    input  wire [4:0] p,
    input  wire [4:0] g,
    input  wire       c0,
    output wire [5:1] c
);
    assign c[1] = g[0] | (p[0] & c0);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c0);
    assign c[3] = g[2] |
                  (p[2] & g[1]) |
                  (p[2] & p[1] & g[0]) |
                  (p[2] & p[1] & p[0] & c0);
    assign c[4] = g[3] |
                  (p[3] & g[2]) |
                  (p[3] & p[2] & g[1]) |
                  (p[3] & p[2] & p[1] & g[0]) |
                  (p[3] & p[2] & p[1] & p[0] & c0);
    assign c[5] = g[4] |
                  (p[4] & g[3]) |
                  (p[4] & p[3] & g[2]) |
                  (p[4] & p[3] & p[2] & g[1]) |
                  (p[4] & p[3] & p[2] & p[1] & g[0]) |
                  (p[4] & p[3] & p[2] & p[1] & p[0] & c0);
endmodule

module sum_bit (
    input  wire p,
    input  wire c_prev,
    output wire sum
);
    assign sum = p ^ c_prev;
endmodule

// Negative-edge triggered single DFF
module dff_neg (
    input  wire clk,
    input  wire d,
    output reg  q
);
    always @(negedge clk) begin
        q <= d;
    end
endmodule

// Vector of negative-edge DFFs
module dff_vec_neg #(
    parameter WIDTH = 1
)(
    input  wire              clk,
    input  wire [WIDTH-1:0]  d,
    output wire [WIDTH-1:0]  q
);
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : dffs
            dff_neg u_dff (
                .clk(clk),
                .d(d[i]),
                .q(q[i])
            );
        end
    endgenerate
endmodule

module cla5_registered (
    input  wire        clk,
    input  wire [4:0]  a_in,
    input  wire [4:0]  b_in,
    input  wire        c0_in,
    output wire [4:0]  sum_out,
    output wire        cout_out
);
    wire [4:0] a_reg;
    wire [4:0] b_reg;
    wire       c0_reg;

    dff_vec_neg #(.WIDTH(5)) dff_a (
        .clk(clk),
        .d(a_in),
        .q(a_reg)
    );

    dff_vec_neg #(.WIDTH(5)) dff_b (
        .clk(clk),
        .d(b_in),
        .q(b_reg)
    );

    dff_neg dff_c0 (
        .clk(clk),
        .d(c0_in),
        .q(c0_reg)
    );

    wire [4:0] p;
    wire [4:0] g;
    genvar idx;
    generate
        for (idx = 0; idx < 5; idx = idx + 1) begin : pggen
            pg_bit u_pg (
                .a(a_reg[idx]),
                .b(b_reg[idx]),
                .p(p[idx]),
                .g(g[idx])
            );
        end
    endgenerate

    wire [5:1] c_internal;
    carry_lookahead5 u_cla (
        .p(p),
        .g(g),
        .c0(c0_reg),
        .c(c_internal)
    );

    wire [4:0] sum_comb;
    generate
        for (idx = 0; idx < 5; idx = idx + 1) begin : sumgen
            if (idx == 0) begin
                sum_bit u_sum0 (.p(p[0]), .c_prev(c0_reg),        .sum(sum_comb[0]));
            end else begin
                sum_bit u_sumi  (.p(p[idx]), .c_prev(c_internal[idx]), .sum(sum_comb[idx]));
            end
        end
    endgenerate

    wire [4:0] sum_reg;
    wire       cout_reg;

    dff_vec_neg #(.WIDTH(5)) dff_sum (
        .clk(clk),
        .d(sum_comb),
        .q(sum_reg)
    );

    dff_neg dff_cout (
        .clk(clk),
        .d(c_internal[5]),
        .q(cout_reg)
    );

    assign sum_out  = sum_reg;
    assign cout_out = cout_reg;
endmodule
