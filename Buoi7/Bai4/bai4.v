module bai4(CLOCK_50, HEX0, HEX1);
    input CLOCK_50;
    output [6:0] HEX0, HEX1;

    wire [3:0] ch, dv;

    counter_14(CLOCK_50, dv, ch);
    bcd7seg(dv, HEX0);
    bcd7seg(ch, HEX1);

endmodule

module counter_14(ck, bcd1, bcd2);
    input ck;
    output [3:0] bcd1, bcd2;

    reg [3:0] bcd1 = 4; // don vi
    reg [3:0] bcd2 = 1; // hang chuc

    reg clock_400ms = 0;
    integer q = 0;

    // tao xung 400ms
    always @(posedge ck)
    begin
        q = q + 1;
        if (q == 10000000)
        begin
            clock_400ms = ~clock_400ms;
            q = 0;
        end
    end

    // dem giam 14 -> 00
    always @(posedge clock_400ms)
    begin
        if (bcd2 == 0 && bcd1 == 0)
        begin
            bcd2 <= 1;
            bcd1 <= 4;
        end
        else
        begin
            if (bcd1 == 0)
            begin
                bcd1 <= 9;
                bcd2 <= bcd2 - 1;
            end
            else
                bcd1 <= bcd1 - 1;
        end
    end

endmodule

module bcd7seg(bcd, display);
    input [3:0] bcd;
    output [6:0] display;
    reg [6:0] display;

    always @(bcd)
    begin
        case(bcd)
            4'b0000: display = 7'b1000000;
            4'b0001: display = 7'b1111001;
            4'b0010: display = 7'b0100100;
            4'b0011: display = 7'b0110000;
            4'b0100: display = 7'b0011001;
            4'b0101: display = 7'b0010010;
            4'b0110: display = 7'b0000010;
            4'b0111: display = 7'b1111000;
            4'b1000: display = 7'b0000000;
            4'b1001: display = 7'b0010000;
            default: display = 7'b1111111;
        endcase
    end

endmodule