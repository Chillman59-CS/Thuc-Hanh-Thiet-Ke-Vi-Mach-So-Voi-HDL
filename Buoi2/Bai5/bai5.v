module bai5(SW,LEDR);
	input [3:0] SW;
	output [15:0] LEDR;
	decoder3_8 d1(SW[2:0],~SW[3],LEDR[7:0]);
	decoder3_8 d2(SW[2:0],SW[3],LEDR[15:8]);
endmodule
module decoder3_8(x,e,y);
	input [2:0]x;
	input e;
	output [7:0]y;
	assign y[0]=e&~x[2]&~x[1]&~x[0];
	assign y[1]=e&~x[2]&~x[1]&x[0];
	assign y[2]=e&~x[2]&x[1]&~x[0];
	assign y[3]=e&~x[2]&x[1]&x[0];
	assign y[4]=e&x[2]&~x[1]&~x[0];
	assign y[5]=e&x[2]&~x[1]&x[0];
	assign y[6]=e&x[2]&x[1]&~x[0];
	assign y[7]=e&x[2]&x[1]&x[0];
endmodule
