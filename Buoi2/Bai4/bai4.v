module bai4(SW,LEDR);
	input [3:0] SW;
	output [15:0] LEDR;
	decoder3_8 d1(SW[2:0],~SW[3],LEDR[7:0]);
	decoder3_8 d2(SW[2:0],SW[3],LEDR[15:8]);
endmodule

module decoder3_8(x,e,y);
	input [2:0]x;
	input e;
	output reg [7:0]y;
	always @(*)begin
		if(e)begin
			case(x)
			3'b000:y=8'b11111110;
			3'b001:y=8'b11111101;
			3'b010:y=8'b11111011;
			3'b011:y=8'b11110111;
			3'b100:y=8'b11101111;
			3'b101:y=8'b11011111;
			3'b110:y=8'b10111111;
			3'b111:y=8'b01111111;
			endcase
		end
		else begin
		   y=8'b11111111;
		end
	end
endmodule
