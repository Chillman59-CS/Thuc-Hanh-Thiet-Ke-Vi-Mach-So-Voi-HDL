module Bai2 (SW, LEDR);
    input  [1:0] SW;      
    output reg [7:0] LEDR;   

    always @(*) begin
        case (SW)
            // LED 0, 2, 4, 6 sáng -> các vị trí đó phải bằng 0
            2'b00: LEDR = 8'b10101010; 
            
            // LED 1, 3, 5, 7 sáng -> các vị trí đó phải bằng 0
            2'b01: LEDR = 8'b01010101; 
            
            // Tất cả LEDR[7:0] sáng -> tất cả bằng 0
            2'b10: LEDR = 8'b00000000; 
            
            // Tất cả LEDR[7:0] tắt -> tất cả bằng 1
            2'b11: LEDR = 8'b11111111; 
            
            default: LEDR = 8'b11111111;
        endcase
    end
endmodule