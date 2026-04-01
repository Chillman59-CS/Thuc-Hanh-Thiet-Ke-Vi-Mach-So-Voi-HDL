module demux1_8 (input data,output [7:0] y,input [2:0] select, input enable);
    assign y[0]=data&~enable&~select[2]&~select[1]&~select[0];
	 assign y[1]=data&~enable&~select[2]&~select[1]&select[0];
	 assign y[2]=data&~enable&~select[2]&select[1]&~select[0];
	 assign y[3]=data&~enable&~select[2]&select[1]&select[0];
	 assign y[4]=data&~enable&select[2]&~select[1]&~select[0];
	 assign y[5]=data&~enable&select[2]&~select[1]&select[0];
	 assign y[6]=data&~enable&select[2]&select[1]&~select[0];
	 assign y[7]=data&~enable&select[2]&select[1]&select[0];
endmodule

module Bai5_Demux (input [4:0] SW, output [15:0] LEDR);
    demux1_8 u1 (SW[4],LEDR[7:0],SW[2:0],SW[3]);
    demux1_8 u2 (SW[4],LEDR[15:8],SW[2:0],~SW[3]);
endmodule