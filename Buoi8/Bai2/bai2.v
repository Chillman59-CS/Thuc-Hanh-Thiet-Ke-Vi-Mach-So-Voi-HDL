module bai2 (SW, LEDG);
    input [5:0] SW;       // SW[2:0] là A, SW[5:3] là B
    output [5:0] LEDG;    // Kết quả LEDG[5:0] tương ứng p5...p0

    wire [2:0] A, B;
    assign A = SW[2:0];
    assign B = SW[5:3];

    // Các tích riêng (Partial Products)
    wire a0b0 = A[0]&B[0];
    wire a0b1 = A[0]&B[1]; wire a1b0 = A[1]&B[0];
    wire a2b0 = A[2]&B[0]; wire a1b1 = A[1]&B[1];
    wire a0b2 = A[0]&B[2]; wire a1b2 = A[1]&B[2];
    wire a2b1 = A[2]&B[1]; wire a2b2 = A[2]&B[2];

    // Dây tín hiệu trung gian cho các bộ FA
    wire s0, c0, s1, c1, s2, c2, s3, c3, s4, c4, s5, c5;

    // Phép gán kết quả P0
    assign LEDG[0] = a0b0;

    // Các khối FA theo mô tả của bạn:
    // FA0: a0b1 + a1b0 (ci=0)
    full_adder FA0 (c0, s0, a0b1, a1b0, 1'b0);
    assign LEDG[1] = s0;

    // FA1: a2b0 + a1b1 + c0 (FA0)
    full_adder FA1 (c1, s1, a2b0, a1b1, c0);

    // FA2: a2b1 + 0 (nhưng nối từ FA1)
    full_adder FA2 (c2, s2, a2b1, 1'b0, c1);

    // FA3: a0b2 + s1 (FA1) (ci=0)
    full_adder FA3 (c3, s3, a0b2, s1, 1'b0);
    assign LEDG[2] = s3;

    // FA4: a1b2 + s2 (FA2) + c3 (FA3)
    full_adder FA4 (c4, s4, a1b2, s2, c3);
    assign LEDG[3] = s4;

    // FA5: a2b2 + c2 (FA2) + c4 (FA4)
    // Theo logic của bạn: a2b2 vào FA5, ci là c4, carry vào là c2
    full_adder FA5 (c5, s5, a2b2, c4, c2);
    assign LEDG[4] = s5;
    assign LEDG[5] = c5; // c5 là p5

endmodule

// Module Full Adder cơ bản
module full_adder (co, s, a, b, ci);
    input a, b, ci;
    output co, s;
    assign {co, s} = a + b + ci;
endmodule