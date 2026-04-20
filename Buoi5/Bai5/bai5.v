module bai5 (
    input wire [0:0] KEY, 		//KEY[0]: Clock
	 input wire [0:0] SW,		//SW[0]: Reset
    output wire [6:0] HEX0,
    output wire [6:0] HEX1
);
    reg [4:0] count;
    wire [3:0] tens;
    wire [3:0] ones;
	 
    always @(posedge KEY[0] or posedge SW[0]) begin	//CK tac dong canh len, Rs khong dong bo tich cuc muc cao
        if (SW[0]) begin
            count <= 5'd27;
        end 
		  else begin
            if (count == 5'd0) begin
                count <= 5'd27;
            end 
				else begin
                count <= count - 1'b1;
            end
        end
    end
	 
    assign tens = count / 10;
    assign ones = count % 10;
    hex_decoder dec_hex0 (ones,HEX0);
    hex_decoder dec_hex1 (tens,HEX1);
endmodule

module hex_decoder (bin, seg);
    input wire [3:0] bin;
    output reg [6:0] seg;
    always @(*) begin
        case (bin)
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