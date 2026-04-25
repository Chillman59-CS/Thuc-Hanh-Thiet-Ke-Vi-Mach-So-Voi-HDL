module full_adder(co, s, a, b, ci);
    input a, b, ci;
    output co, s;

    // tong = a xor b xor ci
    assign s  = a ^ b ^ ci;

    // carry = (a&b) hoac (ci&(a xor b))
    assign co = (a & b) | (ci & (a ^ b));
endmodule

module square3bit(p, A);
    input [2:0] A;
    output [5:0] p;

    // cac day carry trung gian
    wire c1,c2,c3,c4;

    // bit thap nhat
    // A0 * A0 = A0
    assign p[0] = A[0]&A[0];

    // cong cac tich rieng phan bang FA
    // hang 1
    full_adder FA1(c1, p[1], A[1]&A[0], A[0]&A[1], 1'b0);

    // hang 2
    full_adder FA2(c2, p[2], A[2]&A[0], A[1]&A[1], c1);

    // hang 3
    full_adder FA3(c3, p[3], A[2]&A[1], c2, 1'b0);

    // hang 4
    full_adder FA4(c4, p[4], A[2]&A[2], c3, 1'b0);

    // carry cuoi
    assign p[5] = c4;
endmodule

module mult3bit(p, C, B);
    input [2:0] C, B;
    output [5:0] p;

    // cac carry trung gian
    wire d1,d2,d3,d4;

    // bit dau tien
    assign p[0] = C[0]&B[0];

    // hang 1
    full_adder FB1(d1, p[1], C[1]&B[0], C[0]&B[1], 1'b0);

    // hang 2
    full_adder FB2(d2, p[2], C[2]&B[0], C[1]&B[1], d1);

    // hang 3
    full_adder FB3(d3, p[3], C[2]&B[1], C[0]&B[2], d2);

    // hang 4
    full_adder FB4(d4, p[4], C[2]&B[2], d3, 1'b0);

    // carry cuoi
    assign p[5] = d4;
endmodule

module add6bit(P, A2, CB);
    input [5:0] A2, CB;
    output [6:0] P;

    // day carry
    wire k1,k2,k3,k4,k5,k6;

    // ripple adder (noi tiep FA)
    full_adder F0(k1, P[0], A2[0], CB[0], 1'b0);
    full_adder F1(k2, P[1], A2[1], CB[1], k1);
    full_adder F2(k3, P[2], A2[2], CB[2], k2);
    full_adder F3(k4, P[3], A2[3], CB[3], k3);
    full_adder F4(k5, P[4], A2[4], CB[4], k4);
    full_adder F5(k6, P[5], A2[5], CB[5], k5);

    // carry cuoi
    assign P[6] = k6;
endmodule

module LED7seg(seg, x);
    input [3:0] x;
    output reg [6:0] seg;

    // giai ma he 16 sang led 7 doan
    always @(*) begin
        case(x)
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
        endcase
    end
endmodule

module bai4 (SW, HEX6, HEX4, HEX2, HEX1, HEX0);
    input [11:0] SW;
    output [6:0] HEX6, HEX4, HEX2, HEX1, HEX0;

    // tach input tu switch
    wire [2:0] A = SW[2:0];   // so A
    wire [2:0] B = SW[5:3];   // so B
    wire [2:0] C = SW[8:6];   // so C

    // ket qua trung gian
    wire [5:0] A2; // A binh phuong
    wire [5:0] CB; // C nhan B
    wire [6:0] P;  // tong cuoi

    // ===== CAC KHOI TINH TOAN =====
    square3bit U1(A2, A);   // tinh A^2
    mult3bit   U2(CB, C, B); // tinh C*B
    add6bit    U3(P, A2, CB); // cong 2 ket qua

    // ===== HIEN THI =====
    // hien thi input
    LED7seg H6(HEX6, {1'b0, A});
    LED7seg H4(HEX4, {1'b0, B});
    LED7seg H2(HEX2, {1'b0, C});

    // hien thi ket qua P (hex)
    LED7seg H0(HEX0, P[3:0]);          // 4 bit thap
    LED7seg H1(HEX1, {3'b000, P[6:4]});// 3 bit cao

endmodule