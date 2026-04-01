module baitap4 (SW, sn, cn, LEDR);
	input [2:0]SW; //sw123 lan luot la an bn cn-1
	output sn, cn;
	output [1:0]LEDR;
		assign sn= SW[2] ^ SW[0] ^ SW[1];
		assign cn= (SW[0]&SW[1]) | (SW[1]&SW[2]) | (SW[0]&SW[2]);
		assign LEDR[0] = sn;
		assign LEDR[1] = cn;
	endmodule