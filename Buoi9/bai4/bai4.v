module clock_div (
    input CLOCK_50,
    output reg clk_2hz = 0
);

integer q = 0;

always @(posedge CLOCK_50) begin
    q = q + 1;
    if (q == 12500000) begin
        clk_2hz <= ~clk_2hz;
        q <= 0;
    end
end

endmodule

module fsm_love (
    input clk,
    input rst_n,
    output reg [6:0] HEX0,
    output reg [6:0] HEX1,
    output reg [6:0] HEX2,
    output reg [6:0] HEX3
);

// STATE
parameter s0 = 2'b00;
parameter s1 = 2'b01;

reg [1:0] current_state, next_state;

// NEXT STATE
always @(*) begin
    case (current_state)
        s0: next_state = s1;
        s1: next_state = s0;
        default: next_state = s0;
    endcase
end

// STATE REGISTER
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        current_state <= s0;
    else
        current_state <= next_state;
end

// OUTPUT
always @(*) begin
    case (current_state)
        s1: begin
            HEX3 = 7'b1000111; // L
            HEX2 = 7'b1000000; // O
            HEX1 = 7'b1000001; // V
            HEX0 = 7'b0000110; // E
        end
        s0: begin
            HEX3 = 7'b1111111;
            HEX2 = 7'b1111111;
            HEX1 = 7'b1111111;
            HEX0 = 7'b1111111;
        end
    endcase
end

endmodule

module bai4 (
    input CLOCK_50,
    input [1:1] SW,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3
);

wire clk_2hz;

// gọi module chia tần
clock_div U1 (
    .CLOCK_50(CLOCK_50),
    .clk_2hz(clk_2hz)
);

// gọi FSM
fsm_love U2 (
    .clk(clk_2hz),
    .rst_n(SW[1]),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3)
);

endmodule