module Bai3 (
    input [1:0] SW,
    output reg [6:0] HEX0, HEX1, HEX2, HEX3
);
always@(SW)begin
	case(SW)
	2'b00: begin
			HEX3=7'b0001110;HEX2=7'b0001100;HEX1=7'b0000010;HEX0=7'b0001000;
			end		
	2'b01: 
			begin
			HEX3=7'b0000011;HEX2=7'b0001000;HEX1=7'b0000011;HEX0=7'b0010001;
			end
	2'b10: 
			begin 
			HEX3=7'b0001110;HEX2=7'b1000111;HEX1=7'b0001000;HEX0=7'b0000010;
			end
	2'b11: 
			begin 
			HEX3=7'b1111111;HEX2=7'b1111111;HEX1=7'b1111111;HEX0=7'b1111111;
			end
	endcase
end
endmodule