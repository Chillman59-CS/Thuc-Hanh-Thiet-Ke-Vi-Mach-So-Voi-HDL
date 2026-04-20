module bai2 (
    input wire [1:0] KEY,	//KEY[1]: Reset, KEY[0]: Clock 
    output reg [3:0] LEDR
);

always @(posedge KEY[0] or negedge KEY[1]) begin
    if (!KEY[1])
        LEDR <= 4'd0;   
    else begin
        if (LEDR == 4'd12)
            LEDR <= 4'd0;   
        else
            LEDR <= LEDR + 1;
    end
end

endmodule