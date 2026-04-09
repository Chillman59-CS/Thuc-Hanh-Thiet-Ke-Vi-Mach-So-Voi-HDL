module Bai5(input [3:0] SW, output reg [6:0] HEX0, output reg [6:0] HEX1);
    always @(SW) begin
        case(SW)
            4'd0: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b11000000; 
            end
            4'd1: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b11111001;
            end
            4'd2: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10100100;
            end
            4'd3: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10110000; 
            end
            4'd4: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10011001;
            end
            4'd5: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10010010;
            end
            4'd6: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10000010;
            end
            4'd7: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b11111000;
            end
            4'd8: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10000000;
            end
            4'd9: begin
                HEX1 = 8'b11000000; 
                HEX0 = 8'b10010000;
            end
            4'd10: begin
                HEX1 = 8'b11111001;
                HEX0 = 8'b11000000;
            end
            4'd11: begin
                HEX1 = 8'b11111001; 
                HEX0 = 8'b11111001;
            end
            4'd12: begin
                HEX1 = 8'b11111001; 
                HEX0 = 8'b10100100;
            end
            4'd13: begin
                HEX1 = 8'b11111001; 
                HEX0 = 8'b10110000;
            end
            4'd14: begin
                HEX1 = 8'b11111001; 
                HEX0 = 8'b10011001;
            end
            4'd15: begin
                HEX1 = 8'b11111001; 
                HEX0 = 8'b10010010;
            end
            default: begin
                HEX1 = 8'b11111111; 
                HEX0 = 8'b11111111;
            end
        endcase
    end
endmodule