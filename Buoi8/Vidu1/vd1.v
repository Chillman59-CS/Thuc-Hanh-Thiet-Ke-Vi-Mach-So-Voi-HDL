module vd1(SW, LEDG);
	input [7:0]SW;
	output [4:0]LEDG;
	
	wire [3:0]a, b;
	wire [4:0]s;
	wire n1, n2, n3;
	
	assign a=SW[3:0];
	assign b=SW[7:4];
	assign LEDG=s;
	
	cong1bit (n1, s[0], a[0], b[0], 1'b0);
	cong1bit (n2, s[1], a[1], b[1], n1);
	cong1bit (n3, s[2], a[2], b[2], n2);
	cong1bit (s[4], s[3], a[3], b[3], n3);
endmodule

module cong1bit(co, s, a, b, ci);
	input a, b, ci;
	output co, s;
	
	wire n1, n2, n3, n4;
	xor (n1, a, b);
	xor (s, ci, n1);
	not (n2, n1);
	and (n3, n2, b);
	and (n4, ci, n1);
	or (co, n3, n4);
endmodule