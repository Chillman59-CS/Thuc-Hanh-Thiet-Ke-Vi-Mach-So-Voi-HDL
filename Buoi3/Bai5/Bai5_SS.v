module Bai5_SS (
    input  [11:0] SW,
    output reg [2:0] LEDR 
);

wire [5:0] A;
wire [5:0] B;

assign A = SW[11:6];     
assign B = SW[5:0];    

always @(*) begin
    if (A > B) begin
        LEDR = 3'b001;
    end
    else if (A == B) begin
        LEDR = 3'b010; 
    end
    else begin
        LEDR = 3'b100;
    end
end

endmodule