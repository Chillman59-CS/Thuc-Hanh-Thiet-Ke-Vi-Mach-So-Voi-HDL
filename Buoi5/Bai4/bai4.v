module bai4 (
    input wire [1:0]KEY, //key0 la clk con key1 la reset
    output reg [3:0] LEDR
);

always @(posedge KEY[0] or negedge KEY[1]) begin
    if (!KEY[1])
        LEDR <= 4'd11;
    else begin
        if (LEDR == 4'd0)
            LEDR <= 4'd11;
        else
            LEDR <= LEDR - 1;
    end
end

endmodule