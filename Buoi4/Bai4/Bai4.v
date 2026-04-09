module Bai4(
    input  [17:0] SW,
    output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
    wire [2:0] M;

    mux5to1 m1(
        SW[17:15],
        SW[2:0],
        SW[5:3],
        SW[8:6],
        SW[11:9],
        SW[14:12],
        M
    );

    giaima_LED g1(
        M,
        HEX7, HEX6, HEX5, HEX4,
        HEX3, HEX2, HEX1, HEX0
    );

endmodule


module mux5to1(
    input  [2:0] S, A, B, C, D, E,
    output reg [2:0] M
);
    always @(*) begin
        case(S)
            3'b000: M = A;
            3'b001: M = B;
            3'b010: M = C;
            3'b011: M = D;
            3'b100: M = E;
            default: M = 3'b000;
        endcase
    end
endmodule


module giaima_LED(
    input [2:0] Data,
    output reg [6:0] Display7, Display6, Display5, Display4,
                     Display3, Display2, Display1, Display0
);

    always @(*) begin
        Display7 = 7'b1111111;
        Display6 = 7'b1111111;
        Display5 = 7'b1111111;
        Display4 = 7'b1111111;
        Display3 = 7'b1111111;
        Display2 = 7'b1111111;
        Display1 = 7'b1111111;
        Display0 = 7'b1111111;

        case(Data)
            3'b000: begin
                Display4 = 7'b0001001; // H
                Display3 = 7'b0000110; // E
                Display2 = 7'b1000111; // L
                Display1 = 7'b1000111; // L
                Display0 = 7'b1000000; // O
            end

            3'b001: begin
                Display5 = 7'b0001001;
                Display4 = 7'b0000110;
                Display3 = 7'b1000111;
                Display2 = 7'b1000111;
                Display1 = 7'b1000000;
            end

            3'b010: begin
                Display6 = 7'b0001001;
                Display5 = 7'b0000110;
                Display4 = 7'b1000111;
                Display3 = 7'b1000111;
                Display2 = 7'b1000000;
            end

            3'b011: begin
                Display7 = 7'b0001001;
                Display6 = 7'b0000110;
                Display5 = 7'b1000111;
                Display4 = 7'b1000111;
                Display3 = 7'b1000000;
            end

            3'b100: begin
                Display0 = 7'b0001001;
                Display7 = 7'b0000110;
                Display6 = 7'b1000111;
                Display5 = 7'b1000111;
                Display4 = 7'b1000000;
            end

            3'b101: begin
                Display1 = 7'b0001001;
                Display0 = 7'b0000110;
                Display7 = 7'b1000111;
                Display6 = 7'b1000111;
                Display5 = 7'b1000000;
            end

            3'b110: begin
                Display2 = 7'b0001001;
                Display1 = 7'b0000110;
                Display0 = 7'b1000111;
                Display7 = 7'b1000111;
                Display6 = 7'b1000000;
            end

            3'b111: begin
                Display3 = 7'b0001001;
                Display2 = 7'b0000110;
                Display1 = 7'b1000111;
                Display0 = 7'b1000111;
                Display7 = 7'b1000000;
            end
        endcase
    end

endmodule