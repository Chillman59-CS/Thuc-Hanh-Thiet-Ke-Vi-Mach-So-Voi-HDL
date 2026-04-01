module mux2_1 (
    input a, b, s,
    output y
);
    wire s_n, w1, w2;

    not (s_n, s);       // s_n = ~s
    and (w1, a, s_n);   // w1 = a & ~s
    and (w2, b, s);     // w2 = b & s
    or  (y, w1, w2);    // y = w1 | w2
endmodule

module Bai3 (
    input  [7:0] SW,   // SW[0]=a, SW[1]=b, SW[2]=c, SW[3]=d, SW[4]=e, SW[7:5]=s
    output [0:0] LEDR
);

    wire y0, y1, y2;

    // Tầng 1
    mux2_1 m0 (SW[0], SW[1], SW[5], y0); // a,b
    mux2_1 m1 (SW[2], SW[3], SW[5], y1); // c,d

    // Tầng 2
    mux2_1 m2 (y0, y1, SW[6], y2);

    // Tầng 3
    mux2_1 m3 (y2, SW[4], SW[7], LEDR[0]); // e

endmodule