module demux1_8 (input data,output reg [7:0] y,input [2:0] select, input enable);
    always @(*) begin
        y = 8'b00000000; 
        if (enable) begin
            y[select] = data; 
        end
    end
endmodule

module Bai4_Demux (input [4:0] SW, output [15:0] LEDR);
    demux1_8 u1 (SW[4],LEDR[7:0],SW[2:0],~SW[3]);
    demux1_8 u2 (SW[4],LEDR[15:8],SW[2:0],SW[3]);
endmodule