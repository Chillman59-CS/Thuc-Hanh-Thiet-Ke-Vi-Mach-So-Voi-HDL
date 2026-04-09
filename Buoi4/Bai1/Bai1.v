module Bai1 (
    input  [15:0] SW,              // 16 switch
    output [6:0] HEX0, HEX1, HEX2, HEX3  // 4 LED 7 đoạn
);

// Gọi 4 bộ giải mã
decoder7seg d0 (.in(SW[3:0]),   .out(HEX0));
decoder7seg d1 (.in(SW[7:4]),   .out(HEX1));
decoder7seg d2 (.in(SW[11:8]),  .out(HEX2));
decoder7seg d3 (.in(SW[15:12]), .out(HEX3));

endmodule

module decoder7seg (
    input  [3:0] in,
    output reg [6:0] out
);

always @(*) begin
    case(in)
        4'd0: out = 7'b1000000; // 0
        4'd1: out = 7'b1111001; // 1
        4'd2: out = 7'b0100100; // 2
        4'd3: out = 7'b0110000; // 3
        4'd4: out = 7'b0011001; // 4
        4'd5: out = 7'b0010010; // 5
        4'd6: out = 7'b0000010; // 6
        4'd7: out = 7'b1111000; // 7
        4'd8: out = 7'b0000000; // 8
        4'd9: out = 7'b0010000; // 9

        default: out = 7'b1111111; // tắt LED
    endcase
end

endmodule