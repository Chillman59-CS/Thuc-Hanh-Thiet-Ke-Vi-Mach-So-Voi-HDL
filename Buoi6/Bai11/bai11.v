module decoder_7seg (
    input [3:0] bcd,
    output reg [6:0] seg
);
    always @(*) begin
        case (bcd)
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

module clock_counter (
    input clk,
    input reset,
    output reg [3:0] m1, 
    output reg [3:0] m10, 
    output reg [3:0] h1, 
    output reg [3:0] h10
);
    always @(posedge clk) begin
        if (reset) begin
            m1  <= 4'd0;
            m10 <= 4'd0;
            h1  <= 4'd0;
            h10 <= 4'd0;
        end 
        else begin
            if (m1 > 0) begin
                m1 <= m1 - 1;
            end
            else begin
                m1 <= 4'd9;
                if (m10 > 0) begin
                    m10 <= m10 - 1;
                end
                else begin
                    m10 <= 4'd5;
                    // Logic xử lý khi phút về 00 (giảm giờ)
                    if (h10 == 0 && h1 == 0) begin
                        h10 <= 4'd2; 
                        h1  <= 4'd3; // Quay vòng về 23:59
                    end
                    else if (h1 == 0) begin
                        h1  <= 4'd9; 
                        h10 <= h10 - 1;
                    end
                    else begin
                        h1 <= h1 - 1;
                    end
                end
            end
        end
    end
endmodule

module bai11 (
    input [0:0] KEY,    // KEY[0] làm xung Clock (nhấn để đếm)
    input [0:0] SW,     // SW[0] làm tín hiệu Reset
    output [6:0] HEX0,  // Đơn vị phút
    output [6:0] HEX1,  // Chục phút
    output [6:0] HEX2,  // Đơn vị giờ
    output [6:0] HEX3   // Chục giờ
);

    // Các đường dây kết nối giữa Counter và Decoder
    wire [3:0] w_m1, w_m10, w_h1, w_h10;

    // Khởi tạo Module Bộ đếm
    clock_counter timer_core (
        .clk(KEY[0]),
        .reset(SW[0]),
        .m1(w_m1),
        .m10(w_m10),
        .h1(w_h1),
        .h10(w_h10)
    );

    // Khởi tạo 4 Module Giải mã cho 4 LED 7 đoạn
    // Ánh xạ các dây tín hiệu từ Counter vào đầu vào của Decoder
    decoder_7seg led0 (.bcd(w_m1),  .seg(HEX0));
    decoder_7seg led1 (.bcd(w_m10), .seg(HEX1));
    decoder_7seg led2 (.bcd(w_h1),  .seg(HEX2));
    decoder_7seg led3 (.bcd(w_h10), .seg(HEX3));

endmodule