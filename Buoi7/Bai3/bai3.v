module bai3(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
    input CLOCK_50;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

    wire [3:0] dem_s;

    bo_dem clock_dem(CLOCK_50, dem_s);
    giaima_happy hienthi(dem_s, HEX0, HEX1, HEX2, HEX3, HEX4);

    assign HEX5 = 7'b1111111;
    assign HEX6 = 7'b1111111;
    assign HEX7 = 7'b1111111;

endmodule


// Block 1: chia xung 1Hz va dem thoi gian 0 -> 14
module bo_dem(CLOCK_50, dem_s);
    input CLOCK_50;
    output reg [3:0] dem_s = 4'b0000;

    reg clock_1s = 1'b0;
    integer q;

    always @(posedge CLOCK_50)
    begin
        q = q + 1;
        if (q == 25000000)
        begin
            clock_1s = ~clock_1s;
            q = 0;
        end
    end

    always @(posedge clock_1s)
    begin
        if (dem_s == 4'b1110)
            dem_s = 4'b0000;
        else
            dem_s = dem_s + 1'b1;
    end
endmodule


// Block 2: giai ma hien thi HAPPY trong 10s, tat trong 5s
module giaima_happy(dem_s, HEX0, HEX1, HEX2, HEX3, HEX4);
    input [3:0] dem_s;
    output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;

    always @(dem_s)
    begin
        if (dem_s <= 4'b1001)
        begin
            HEX4 = 7'b0001001; // H
            HEX3 = 7'b0001000; // A
            HEX2 = 7'b0001100; // P
            HEX1 = 7'b0001100; // P
            HEX0 = 7'b0010001; // Y
        end
        else
        begin
            HEX4 = 7'b1111111;
            HEX3 = 7'b1111111;
            HEX2 = 7'b1111111;
            HEX1 = 7'b1111111;
            HEX0 = 7'b1111111;
        end
    end
endmodule