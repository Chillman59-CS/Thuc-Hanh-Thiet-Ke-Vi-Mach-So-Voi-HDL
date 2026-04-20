module bai3 (
    input wire [0:0] KEY,		//KEY[0]: Clock
	 input wire [0:0] SW,		//SW[0]: Reset
    output reg [4:0] LEDR 
);
    always @(negedge KEY[0]) begin
          if (SW[0] == 1'b1) begin 
            LEDR <= 5'd0;      // Tích cực mức cao: Reset về 0
        end 
        else begin
            // Logic đếm lên MOD 25
            if (LEDR >= 5'd24) begin
                LEDR <= 5'd0;  // Đạt 24 thì quay về 0
            end 
            else begin
                LEDR <= LEDR + 5'd1; // Tăng giá trị đếm
            end
        end
    end

endmodule