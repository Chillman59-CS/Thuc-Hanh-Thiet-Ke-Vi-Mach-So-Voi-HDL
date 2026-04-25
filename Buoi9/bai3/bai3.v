module bai3(SW, CLOCK_50, HEX0);
	input [0:0] SW;
	input CLOCK_50;
	output reg [6:0] HEX0;
	
	// state
	parameter s0 = 3'b000; //A
	parameter s1 = 3'b001; //P
	parameter s2 = 3'b010; //Phan cach
	parameter s3 = 3'b011; //P
	parameter s4 = 3'b100; //L
	parameter s5 = 3'b101; //E
	
	reg [2:0] current_state, next_state;
	integer q;
	reg clock_2s = 1'b0;
	
	// chia clock 2s
	always @(posedge CLOCK_50)
	begin
		q = q + 1;
		if (q == 50000000)	//2 giay
		begin
			clock_2s = ~clock_2s;
			q = 0;
		end
	end
	
	// next state
	always @(*)
	begin
		case (current_state)
			s0: next_state = s1;
			s1: next_state = s2;
			s2: next_state = s3;
			s3: next_state = s4;
			s4: next_state = s5;
			s5: next_state = s0;
			default: next_state = s0;
		endcase
	end
	
	always @(posedge clock_2s or posedge SW[0])
	begin
		if (SW[0])
			current_state <= s0;
		else
			current_state <= next_state;
	end
	
	always @(*)
	begin
		if (SW[0])
			HEX0 = 7'b1111111;
		else
		begin
			case (current_state)
				s0: HEX0 = 7'b0001000; //A
				s1: HEX0 = 7'b0001100; //P
				s2: HEX0 = 7'b1111111; //Phan cach
				s3: HEX0 = 7'b0001100; //P
				s4: HEX0 = 7'b1000111; //L
				s5: HEX0 = 7'b0000110; //E
				default: HEX0 = 7'b1111111;
			endcase
		end
	end
endmodule