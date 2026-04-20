module bai10(KEY, SW, HEX0, HEX1);
input [2:2] KEY;
input [2:1] SW;
output [6:0] HEX0;
output [6:0] HEX1;

wire Ck;
wire RS;
wire S;

assign Ck = KEY[2];
assign RS = SW[1];
assign S = SW[2];

reg [3:0] bcd0;
reg [3:0] bcd1;

always @(negedge Ck) begin
    if (RS == 1'b0) begin
        bcd0 <= 4'd0;
        bcd1 <= 4'd0;
    end else begin
        if (S == 1'b1) begin
            if (bcd0 == 4'd9) begin
                bcd0 <= 4'd0;
                if (bcd1 == 4'd9) begin
                    bcd1 <= 4'd0;
                end 
					 else begin
                    bcd1 <= bcd1 + 1'b1;
                end
            end 
				else begin
                bcd0 <= bcd0 + 1'b1;
            end
        end 
		  else begin
            if (bcd0 == 4'd0) begin
                bcd0 <= 4'd9;
                if (bcd1 == 4'd0) begin
                    bcd1 <= 4'd9;
                end 
					 else begin
                    bcd1 <= bcd1 - 1'b1;
                end
            end 
				else begin
                bcd0 <= bcd0 - 1'b1;
            end
        end
    end
end

hex_decoder u0(bcd0, HEX0);
hex_decoder u1(bcd1, HEX1);

endmodule

module hex_decoder(bcd, seg);
input [3:0] bcd;
output reg [6:0] seg;
    always @(*) begin
        case(bcd)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule