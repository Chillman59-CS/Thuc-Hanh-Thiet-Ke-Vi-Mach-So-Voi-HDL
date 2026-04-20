module bai8 (
    input  wire [3:2] KEY,   // KEY[2] là Ck, KEY[3] là RS
    output reg  [8:1] LEDR   
);

    wire Ck = KEY[2];
    wire RS = KEY[3];

    always @(negedge Ck or negedge RS) begin
        if (!RS) 
            // Reset về 17 (0001_0111)
            LEDR <= 8'b00010111; 
				
        else if (LEDR == 8'b00000000) 
            // Đang là 00 thì quay lại 17
            LEDR <= 8'b00010111;                     
            
				// Nếu hàng đơn vị là 0
        else if (LEDR[4:1] == 4'b0000) 
            LEDR <= {LEDR[8:5] - 4'b0001, 4'b1001};   
            
        else 
            // Các trường hợp còn lại: trừ đi 1 bình thường
            LEDR <= LEDR - 8'b00000001;              
    end

endmodule