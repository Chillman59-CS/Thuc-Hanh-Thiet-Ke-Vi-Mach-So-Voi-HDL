module bai1 (SW, KEY, LEDR);
	// Khai bao cac trang thai
	parameter start = 3'b000;
	parameter s1    = 3'b001;
	parameter s10   = 3'b010;
	parameter s101  = 3'b011;
	parameter s1010 = 3'b100;

	input [1:0] SW;   
	input [2:2]KEY;       
	output reg [4:0] LEDR; 

	reg [2:0] current_state, next_state; 

	// --- Khoi 1: Logic xac dinh trang thai tiep theo (To hop) ---
	always @ (*) begin 
		 case (current_state) 
			  start: 
					if (SW[0])  next_state = s1;    
					else        next_state = start; 
			  s1: 
					if (~SW[0]) next_state = s10;   
					else        next_state = s1;    
			  s10: 
					if (SW[0])  next_state = s101;  
					else        next_state = start; 
			  s101: 
					if (~SW[0]) next_state = s1010; 
					else        next_state = s1;    
			  s1010: 
					if (SW[0])  next_state = s101;  
					else        next_state = start; 
			  default: next_state = start; 
		 endcase 
	end 

	// --- Khoi 2: Cap nhat trang thai (Tuan tu) ---
	always @ (negedge KEY[2] or negedge SW[1]) begin 
		 if (~SW[1]) 
			  current_state <= start; 
		 else        
			  current_state <= next_state; 
	end 

	// --- Khoi 3: Logic ngõ ra (Den LED bao hieu) ---
	always @ (*) begin 
		 LEDR = 5'b00000;
		 
		 case (current_state)
			  start: LEDR = 5'b00000; // Chua co gi
			  
			  s1:    LEDR = 5'b00010; // Sang den LEDR1 (Xong bit 1)
			  
			  s10:   LEDR = 5'b00110; // Sang LEDR1, LEDR2 (Xong bit 1-0)
			  
			  s101:  LEDR = 5'b01110; // Sang LEDR1, 2, 3 (Xong bit 1-0-1)
			  
			  s1010: LEDR = 5'b11111; 
			  
			  default: LEDR = 5'b00000;
		 endcase 
	end 
endmodule