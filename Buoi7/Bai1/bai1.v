module timer_05s (
    input clk,
    output reg tick
);
    integer q = 0;
    always @(posedge clk) begin
        if (q == 25000000) begin
            q <= 0;
            tick <= 1'b1; // Phát xung tick cao trong 1 chu kỳ clock
        end else begin
            q <= q + 1;
            tick <= 1'b0;
        end
    end
endmodule

// Khối 2: Bộ điều khiển xung - Tỷ lệ 1:3

module pulse_logic (
    input clk,
    input tick_en,
    output reg led_out
);
    reg [1:0] state = 2'd0;
    always @(posedge clk) begin
        if (tick_en) begin
            // Logic: Nhịp 0 sáng, nhịp 1-2-3 tắt
            if (state == 2'd0) 
                led_out <= 1'b1;
            else 
                led_out <= 1'b0;

            // Đếm trạng thái 0 -> 3
            if (state == 2'd3) 
                state <= 2'd0;
            else 
                state <= state + 1;
        end
    end
endmodule

// Khối 3: Top Module - Kết nối các khối lại với nhau

module bai1 (
    input CLOCK_50,
    output [1:1] LEDR 
);
    wire w_tick; // Sợi dây nội bộ nối từ Khối 1 sang Khối 2

    timer_05s m1 (
        .clk(CLOCK_50),
        .tick(w_tick)
    );

    pulse_logic m2 (
        .clk(CLOCK_50),
        .tick_en(w_tick),
        .led_out(LEDR[1])
    );

endmodule