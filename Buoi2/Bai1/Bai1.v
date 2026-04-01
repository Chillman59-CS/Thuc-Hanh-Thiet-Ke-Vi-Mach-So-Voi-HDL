module Bai1 (
    input  [5:0] SW,   // SW[0]=a, SW[1]=b, SW[2]=c, SW[3]=d, SW[5:4]=sel
    output reg [0:0] LEDR
);

always @(*) begin
    case(SW[5:4])
        2'b00: LEDR[0] = SW[0]; // a
        2'b01: LEDR[0] = SW[1]; // b
        2'b10: LEDR[0] = SW[2]; // c
        2'b11: LEDR[0] = SW[3]; // d
    endcase
end

endmodule