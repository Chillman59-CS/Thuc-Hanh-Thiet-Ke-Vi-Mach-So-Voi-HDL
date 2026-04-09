module Bai2 (
    input [2:0] SW,        // 3 công tắc tạo 8 trạng thái
    output reg [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);

    // ========================================================
    // Định nghĩa mã LED 7 đoạn (Anode chung: 0 sáng, 1 tắt)
    // ========================================================
    parameter H = 7'b0001001;
    parameter A = 7'b0001000;
    parameter P = 7'b0001100;
    parameter Y = 7'b0010001;
    parameter B = 7'b1111111; // Blank (Khoảng trắng tắt LED)

    // ========================================================
    // Khối điều khiển hành vi bằng Switch
    // ========================================================
    always @(SW) begin
        case (SW)
            // Trạng thái 0: HAPPY nằm gọn bên trái
            3'b000: begin HEX7=H; HEX6=A; HEX5=P; HEX4=P; HEX3=Y; HEX2=B; HEX1=B; HEX0=B; end
            
            // Trạng thái 1, 2, 3: Dịch dần sang phải
            3'b001: begin HEX7=B; HEX6=H; HEX5=A; HEX4=P; HEX3=P; HEX2=Y; HEX1=B; HEX0=B; end
            3'b010: begin HEX7=B; HEX6=B; HEX5=H; HEX4=A; HEX3=P; HEX2=P; HEX1=Y; HEX0=B; end
            3'b011: begin HEX7=B; HEX6=B; HEX5=B; HEX4=H; HEX3=A; HEX2=P; HEX1=P; HEX0=Y; end
            
            // Trạng thái 4, 5, 6, 7: Dịch vòng tròn (chữ cái bị đẩy khỏi HEX0 sẽ quay lại HEX7)
            3'b100: begin HEX7=Y; HEX6=B; HEX5=B; HEX4=B; HEX3=H; HEX2=A; HEX1=P; HEX0=P; end
            3'b101: begin HEX7=P; HEX6=Y; HEX5=B; HEX4=B; HEX3=B; HEX2=H; HEX1=A; HEX0=P; end
            3'b110: begin HEX7=P; HEX6=P; HEX5=Y; HEX4=B; HEX3=B; HEX2=B; HEX1=H; HEX0=A; end
            3'b111: begin HEX7=A; HEX6=P; HEX5=P; HEX4=Y; HEX3=B; HEX2=B; HEX1=B; HEX0=H; end
            
            // Đề phòng lỗi (mặc định tắt hết)
            default: begin HEX7=B; HEX6=B; HEX5=B; HEX4=B; HEX3=B; HEX2=B; HEX1=B; HEX0=B; end
        endcase
    end

endmodule