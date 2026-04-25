module bai5(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, SW);
	parameter s0 = 4'b0000;
	parameter s1 = 4'b0001;
	parameter s2 = 4'b0010;
	parameter s3 = 4'b0011;
	parameter s4 = 4'b0100;
	parameter s5 = 4'b0101;
	parameter s6 = 4'b0110;
	parameter s7 = 4'b0111;
	parameter s8 = 4'b1000;
	
	input CLOCK_50;
	input [1:0] SW;
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	
	integer q = 0;
	reg clock_1s = 1'b0;
	reg [3:0] current_state, next_state;
	
	always@(*)begin
		case(current_state)
			s0: next_state = s1;
			s1: next_state = s2;
			s2: next_state = s3;
			s3: next_state = s4;
			s4: next_state = s5;
			s5: next_state = s6;
			s6: next_state = s7;
			s7: next_state = s0;
			default: next_state = s0;
		endcase
	end
	
	always @(posedge CLOCK_50)begin
		q<=q+1;
		if(q==49999999)begin
			clock_1s <= ~clock_1s;
			q <= 0;
		end
	end
	
	always @(posedge clock_1s or posedge SW[1])begin
		if(SW[1])
			current_state <= s8;
		else 
			current_state<=next_state;
	end
	
	always @(*)begin
			case(current_state)
			s0: begin
				HEX7[6:0]=7'b0000010;
				HEX6[6:0]=7'b0000000;
				HEX5[6:0]=7'b0000000;
				HEX4[6:0]=7'b1000000;
				HEX3[6:0]=7'b1111111;
				HEX2[6:0]=7'b1111111;
				HEX1[6:0]=7'b1111111;
				HEX0[6:0]=7'b1111111;
			end
			s1: begin
				HEX6[6:0]=7'b0000010;
				HEX5[6:0]=7'b0000000;
				HEX4[6:0]=7'b0000000;
				HEX3[6:0]=7'b1000000;
				HEX0[6:0]=7'b1111111;
				HEX1[6:0]=7'b1111111;
				HEX2[6:0]=7'b1111111;
				HEX7[6:0]=7'b1111111;
			end
			s2: begin
				HEX5[6:0]=7'b0000010;
				HEX4[6:0]=7'b0000000;
				HEX3[6:0]=7'b0000000;
				HEX2[6:0]=7'b1000000;
				HEX1[6:0]=7'b1111111;
				HEX0[6:0]=7'b1111111;
				HEX6[6:0]=7'b1111111;
				HEX7[6:0]=7'b1111111;
			end
			s3: begin
				HEX4[6:0]=7'b0000010;
				HEX3[6:0]=7'b0000000;
				HEX2[6:0]=7'b0000000;
				HEX1[6:0]=7'b1000000;
				HEX0[6:0]=7'b1111111;
				HEX5[6:0]=7'b1111111;
				HEX6[6:0]=7'b1111111;
				HEX7[6:0]=7'b1111111;
			end
			s4: begin
				HEX3[6:0]=7'b0000010;
				HEX2[6:0]=7'b0000000;
				HEX1[6:0]=7'b0000000;
				HEX0[6:0]=7'b1000000;
				HEX4[6:0]=7'b1111111;
				HEX5[6:0]=7'b1111111;
				HEX6[6:0]=7'b1111111;
				HEX7[6:0]=7'b1111111;
			end
			s5: begin
				HEX2[6:0]=7'b0000010;
				HEX1[6:0]=7'b0000000;
				HEX0[6:0]=7'b0000000;
				HEX7[6:0]=7'b1000000;
				HEX5[6:0]=7'b1111111;
				HEX6[6:0]=7'b1111111;
				HEX4[6:0]=7'b1111111;
				HEX3[6:0]=7'b1111111;
			end
			s6: begin
				HEX1[6:0]=7'b0000010;
				HEX0[6:0]=7'b0000000;
				HEX7[6:0]=7'b0000000;
				HEX6[6:0]=7'b1000000;
				HEX5[6:0]=7'b1111111;
				HEX4[6:0]=7'b1111111;
				HEX3[6:0]=7'b1111111;
				HEX2[6:0]=7'b1111111;
			end
			s7: begin
				HEX0[6:0]=7'b0000010;
				HEX7[6:0]=7'b0000000;
				HEX6[6:0]=7'b0000000;
				HEX5[6:0]=7'b1000000;
				HEX4[6:0]=7'b1111111;
				HEX3[6:0]=7'b1111111;
				HEX2[6:0]=7'b1111111;
				HEX1[6:0]=7'b1111111;
			end
			s8: begin	
				HEX0[6:0]=7'b1111111;
				HEX1[6:0]=7'b1111111;
				HEX2[6:0]=7'b1111111;
				HEX3[6:0]=7'b1111111;
				HEX4[6:0]=7'b1111111;
				HEX5[6:0]=7'b1111111;
				HEX6[6:0]=7'b1111111;
				HEX7[6:0]=7'b1111111;
			end
		endcase
	end
endmodule