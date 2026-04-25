module bai3 (
    input [11:0] SW,
    output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
    wire [2:0] A, B, C, D;
    wire [5:0] M1, M2;
    wire [6:0] P;

    assign A = SW[11:9];
    assign B = SW[8:6];
    assign C = SW[5:3];
    assign D = SW[2:0];

    Multiplier_3x3 mult1 (.A(A), .B(B), .P(M1));
    Multiplier_3x3 mult2 (.A(C), .B(D), .P(M2));

    Adder_6bit main_adder (
        .X(M1),
        .Y(M2),
        .S(P)
    );

    Hex_to_7Seg hex7 (.hex({1'b0, A}), .seg(HEX7));
    Hex_to_7Seg hex6 (.hex({1'b0, B}), .seg(HEX6));
    Hex_to_7Seg hex5 (.hex({1'b0, C}), .seg(HEX5));
    Hex_to_7Seg hex4 (.hex({1'b0, D}), .seg(HEX4));

    assign HEX3 = 7'b0110111;

    Hex_to_7Seg hex2 (.hex(4'b0000), .seg(HEX2));
    Hex_to_7Seg hex1 (.hex({1'b0, P[6:4]}), .seg(HEX1));
    Hex_to_7Seg hex0 (.hex(P[3:0]), .seg(HEX0));

endmodule

module Multiplier_3x3 (
    input [2:0] A,
    input [2:0] B,
    output [5:0] P
);
    wire a0b0 = A[0]&B[0];
    wire a0b1 = A[0]&B[1]; 
	 wire a1b0 = A[1]&B[0];
    wire a2b0 = A[2]&B[0]; 
	 wire a1b1 = A[1]&B[1];
    wire a0b2 = A[0]&B[2]; 
	 wire a1b2 = A[1]&B[2];
    wire a2b1 = A[2]&B[1]; 
	 wire a2b2 = A[2]&B[2];

    wire s0, c0, s1, c1, s2, c2, s3, c3, s4, c4, s5, c5;

    assign P[0] = a0b0;

    FA fa_m0 (a0b1, a1b0, 1'b0, s0, c0);
    assign P[1] = s0;

    FA fa_m1 (a2b0, a1b1, c0, s1, c1);
    FA fa_m2 (a2b1, 1'b0, c1, s2, c2);
    FA fa_m3 (a0b2, s1, 1'b0, s3, c3);
    assign P[2] = s3;

    FA fa_m4 (a1b2, s2, c3, s4, c4);
    assign P[3] = s4;

    FA fa_m5 (a2b2, c4, c2, s5, c5);
    assign P[4] = s5;
    assign P[5] = c5;
endmodule

module Adder_6bit (
    input [5:0] X,
    input [5:0] Y,
    output [6:0] S
);
    wire c1, c2, c3, c4, c5;

    FA fa0 (X[0], Y[0], 1'b0, S[0], c1);
    FA fa1 (X[1], Y[1], c1,   S[1], c2);
    FA fa2 (X[2], Y[2], c2,   S[2], c3);
    FA fa3 (X[3], Y[3], c3,   S[3], c4);
    FA fa4 (X[4], Y[4], c4,   S[4], c5);
    FA fa5 (X[5], Y[5], c5,   S[5], S[6]);
endmodule

module FA (
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module Hex_to_7Seg (
    input [4:0] hex,
    output reg [6:0] seg
);
    always @(*) begin
        case(hex[3:0])
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end
endmodule