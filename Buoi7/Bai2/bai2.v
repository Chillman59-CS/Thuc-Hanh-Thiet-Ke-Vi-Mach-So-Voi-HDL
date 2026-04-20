module f_0_25HZ (
    input CLOCK_50,
    output reg clock_025
);
    integer q = 0;
    always @(posedge CLOCK_50) begin
        if (q == 50000000) begin
            q <= 0;
            clock_025 <= 1'b1;
        end else begin
            q <= q + 1;
            clock_025 <= 1'b0;
        end
    end
endmodule

module control_logic (
    input clk,
    input tick,
    output reg led_out
);
    reg [1:0] q_state = 2'd0;

    always @(posedge clk) begin
        if (tick) begin
            if (q_state < 3)
                led_out <= 1'b1;
            else
                led_out <= 1'b0;

            if (q_state == 3)
                q_state <= 0;
            else
                q_state <= q_state + 1;
        end
    end
endmodule

module bai2 (
    input CLOCK_50,
    output [1:1] LEDR
);
    wire clk025;   // Dây nối tín hiệu nhịp
    wire led; // Dây nối tín hiệu LED

    f_0_25HZ khoi1 (
        .CLOCK_50(CLOCK_50),
        .clock_025(clk025)
    );

    control_logic khoi2 (
        .clk(CLOCK_50),
        .tick(clk025),
        .led_out(led)
    );

    assign LEDR[1] = led;

endmodule