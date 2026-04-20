module bai5(CLOCK_50, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, LEDR);
	 input CLOCK_50;
    input [17:0] SW;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
    output [17:0] LEDR;
    Real_Time_Clock rtc_inst (CLOCK_50,SW[0],SW[1],SW[17:2],HEX5,HEX4,HEX3,HEX2,HEX1,HEX0,LEDR[1]);
    assign HEX6 = 7'b1111111;
    assign HEX7 = 7'b1111111;
    assign LEDR[17:2] = 16'b0;
endmodule

module Real_Time_Clock(Clock, Reset, ON_OFF, Setting_time, h5, h4, h3, h2, h1, h0, alarm);
	 input Clock;
    input Reset;
    input ON_OFF;
    input [15:0] Setting_time;
    output [6:0] h5, h4, h3, h2, h1, h0;
    output alarm;
    reg [24:0] count_50M;
    reg clk_1hz;
    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            count_50M <= 25'd0;
            clk_1hz <= 1'b0;
        end 
		  else begin
            if (count_50M == 25'd24_999_999) begin
                count_50M <= 25'd0;
                clk_1hz <= ~clk_1hz;
            end 
				else begin
                count_50M <= count_50M + 25'd1;
            end
        end
    end

    reg [3:0] sec_ones, sec_tens;
    reg [3:0] min_ones, min_tens;
    reg [3:0] hr_ones, hr_tens;

    always @(posedge clk_1hz or posedge Reset) begin
        if (Reset) begin
            sec_ones <= 4'd0; sec_tens <= 4'd0;
            min_ones <= 4'd0; min_tens <= 4'd0;
            hr_ones <= 4'd0;  hr_tens <= 4'd0;
        end 
		  else begin
            if (sec_ones == 4'd9) begin
                sec_ones <= 4'd0;
                if (sec_tens == 4'd5) begin
                    sec_tens <= 4'd0;
                    if (min_ones == 4'd9) begin
                        min_ones <= 4'd0;
                        if (min_tens == 4'd5) begin
                            min_tens <= 4'd0;
                            if (hr_tens == 4'd2 && hr_ones == 4'd3) begin
                                hr_ones <= 4'd0;
                                hr_tens <= 4'd0;
                            end 
									 else if (hr_ones == 4'd9) begin
                                hr_ones <= 4'd0;
                                hr_tens <= hr_tens + 4'd1;
                            end 
									 else begin
                                hr_ones <= hr_ones + 4'd1;
                            end
                        end 
								else begin
                            min_tens <= min_tens + 4'd1;
                        end
                    end 
						  else begin
                        min_ones <= min_ones + 4'd1;
                    end
                end 
					 else begin
                    sec_tens <= sec_tens + 4'd1;
                end
            end 
				else begin
                sec_ones <= sec_ones + 4'd1;
            end
        end
    end

    wire alarm_match;
    assign alarm_match = (Setting_time[15:12] == hr_tens) && (Setting_time[11:8]  == hr_ones) && (Setting_time[7:4]   == min_tens) && (Setting_time[3:0]   == min_ones);
    reg alarm_reg;
    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            alarm_reg <= 1'b0;
        end 
		  else begin
            if (ON_OFF) begin
                if (alarm_match && (sec_tens == 4'd0 && sec_ones < 4'd5)) begin
                    alarm_reg <= 1'b1;
                end 
					 else begin
                    alarm_reg <= 1'b0;
                end
            end 
				else begin
                alarm_reg <= 1'b0;
            end
        end
    end
    assign alarm = alarm_reg;
    hex_decoder hex0_inst(sec_ones, h0);
    hex_decoder hex1_inst(sec_tens, h1);
    hex_decoder hex2_inst(min_ones, h2);
    hex_decoder hex3_inst(min_tens, h3);
    hex_decoder hex4_inst(hr_ones,  h4);
    hex_decoder hex5_inst(hr_tens,  h5);
endmodule

module hex_decoder(bcd, seg);
input [3:0] bcd;
output reg [6:0] seg;
    always @(*) begin
        case(bcd)
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