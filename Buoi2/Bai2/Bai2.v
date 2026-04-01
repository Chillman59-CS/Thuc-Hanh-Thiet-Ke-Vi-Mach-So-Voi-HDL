module Bai2 (
    input  [9:0] SW,    // SW[1:0]=a, SW[3:2]=b, SW[5:4]=c, SW[7:6]=d, SW[9:8]=sel
    output reg [1:0] LEDR
);

always @(*) begin
    case(SW[9:8])
        2'b00: LEDR = SW[1:0]; // a
        2'b01: LEDR = SW[3:2]; // b
        2'b10: LEDR = SW[5:4]; // c
        2'b11: LEDR = SW[7:6]; // d
    endcase
end

endmodule