module bai1(KEY, LEDR, SW);
	input [0:0]KEY;   // KEY[0]: clock
	input [1:0]SW; 	  // SW[0]: Clear, SW[1]: enable
	output [3:0]LEDR;

	wire q0, q1, q2, q3;

	wire ck;
	assign ck = KEY[0]; 

	wire rs;
	assign rs = SW[0];
	
	wire en;
	assign en = SW[1]; 

	// cac tin hieu T
	wire t0, t1, t2, t3;

	assign t0 = en;
	assign t1 = en & q0;
	assign t2 = en & q0 & q1;
	assign t3 = en & q0 & q1 & q2;

	// goi T flip-flop
	T_ff ff0(ck, t0, rs, q0);
	T_ff ff1(ck, t1, rs, q1);
	T_ff ff2(ck, t2, rs, q2);
	T_ff ff3(ck, t3, rs, q3);

	// dua ra LED
	assign LEDR = {q3, q2, q1, q0};

endmodule

module T_ff(ck, t, rs, q);
	input ck, t, rs;
	output reg q;
	
	always @ (posedge ck or negedge rs)
		begin
			if (rs == 1'b0) q <= 1'b0;
			else if (t == 1'b0) q <= q;
			else 	q <= !q;
		end
endmodule