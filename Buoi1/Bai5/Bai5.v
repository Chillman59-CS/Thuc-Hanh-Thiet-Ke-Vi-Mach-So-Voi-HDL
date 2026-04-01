module Bai5 (SW, LEDR);
input [4:1]SW;
output [5:1]LEDR;

assign LEDR[4:1] = SW[4:1];
assign LEDR[5] = ((~SW[4] & ~SW[3] & SW[2] & SW[1]) | (SW[4] & ~SW[3] & ~SW[2] & SW[1]) | (SW[4] & SW[3] & SW[2] & SW[1]));

endmodule