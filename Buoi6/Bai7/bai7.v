module bcd_counter_up_18 (
    input wire clk,
    input wire reset,
    output reg [3:0] tens, 
    output reg [3:0] units 
);
    always @(posedge clk) begin
        if (reset) begin
            tens <= 4'd0;
            units <= 4'd0;
        end 
        else begin
            // Kiểm tra giới hạn 18 để vòng về 00
            if (tens == 4'd1 && units == 4'd8) begin
                tens <= 4'd0;
                units <= 4'd0;
            end 
            // Logic đếm BCD: Hàng đơn vị chạm 9 thì reset đơn vị, tăng hàng chục
            else if (units == 4'd9) begin
                units <= 4'd0;
                tens <= tens + 4'd1;
            end 
            else begin
                units <= units + 4'd1;
            end
        end
    end
endmodule

module bai7 (
    input wire [2:2] KEY,    // KEY[2] làm CLOCK
    input wire [1:1] SW,     // SW[1] làm RESET đồng bộ
    output wire [8:1] LEDR   // 8 LED đơn
);
    wire [3:0] w_tens;
    wire [3:0] w_units;
    bcd_counter_up_18 counter_inst (
        .clk(KEY[2]),
        .reset(SW[1]),
        .tens(w_tens),
        .units(w_units)
    );
    assign LEDR[8:5] = w_tens;  
    assign LEDR[4:1] = w_units; 

endmodule