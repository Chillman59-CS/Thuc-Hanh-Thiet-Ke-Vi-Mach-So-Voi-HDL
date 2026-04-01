// --- MODULE CON: SO SÁNH 1 BIT ---
module compare_1bit (
    input en, a, b,
    output gt, eq, lt
);
    assign gt = en & (a & ~b);
    assign eq = en & (a == b);
    assign lt = en & (~a & b);
endmodule

// --- MODULE CHÍNH: bai3ss ---
module Bai3_SS (
    input  [8:0] SW,   // SW[8]=E, SW[7:4]=A, SW[3:0]=B
    output [5:0] LEDR  // LEDR[2]=GT, LEDR[1]=EQ, LEDR[0]=LT
);
    // Tách các tín hiệu từ mảng SW để dễ quản lý
    wire E    = SW[8];
    wire [3:0] A = SW[7:4];
    wire [3:0] B = SW[3:0];

    // Các dây nối trung gian giữa các bộ 1 bit
    wire g3, e3, l3;
    wire g2, e2, l2;
    wire g1, e1, l1;
    wire g0, e0, l0;

    // Kết nối tầng 4 bộ so sánh 1 bit
    compare_1bit bit3 (E,   A[3], B[3], g3, e3, l3);
    compare_1bit bit2 (e3,  A[2], B[2], g2, e2, l2);
    compare_1bit bit1 (e2,  A[1], B[1], g1, e1, l1);
    compare_1bit bit0 (e1,  A[0], B[0], g0, e0, l0);

    // Đưa kết quả ra các đèn LEDR như bạn yêu cầu
    assign LEDR[2] = g3 | g2 | g1 | g0; // GT (Lớn hơn)
    assign LEDR[1] = e0;                // EQ (Bằng nhau)
    assign LEDR[0] = l3 | l2 | l1 | l0; // LT (Nhỏ hơn)
    
    // Các đèn LEDR còn lại (3, 4, 5) cho về 0 để không bị sáng mờ
    assign LEDR[5:3] = 3'b000;

endmodule