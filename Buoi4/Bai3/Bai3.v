module Bai3(SW, HEX4, HEX3, HEX2, HEX1, HEX0);
    input [17:0] SW; 
    output [6:0] HEX4, HEX3, HEX2, HEX1, HEX0;
    
    wire [2:0] Selected_Data;
    mux3bit5to1 (
        .S(SW[17:15]), 
        .A(SW[14:12]), 
        .B(SW[11:9]),  
        .C(SW[8:6]),   
        .D(SW[5:3]),   
        .E(SW[2:0]),  
        .M(Selected_Data)
    );

    giaima_5_LED (
        .Case_In(Selected_Data),
        .H4(HEX4), .H3(HEX3), .H2(HEX2), .H1(HEX1), .H0(HEX0)
    );

endmodule

module giaima_5_LED(Case_In, H4, H3, H2, H1, H0);
    input [2:0] Case_In;
    output reg [6:0] H4, H3, H2, H1, H0;

    parameter CHAR_H   = 7'b0001001;
    parameter CHAR_E   = 7'b0000110;
    parameter CHAR_L   = 7'b1000111;
    parameter CHAR_O   = 7'b1000000;
    parameter CHAR_OFF = 7'b1111111;

    always @(*) begin
        case(Case_In)
            3'b000: begin H4=CHAR_H; H3=CHAR_E; H2=CHAR_L; H1=CHAR_L; H0=CHAR_O; end // HELLO
            3'b001: begin H4=CHAR_E; H3=CHAR_L; H2=CHAR_L; H1=CHAR_O; H0=CHAR_H; end // ELLOH
            3'b010: begin H4=CHAR_L; H3=CHAR_L; H2=CHAR_O; H1=CHAR_H; H0=CHAR_E; end // LLOHE
            3'b011: begin H4=CHAR_L; H3=CHAR_O; H2=CHAR_H; H1=CHAR_E; H0=CHAR_L; end // LOHEL
            3'b100: begin H4=CHAR_O; H3=CHAR_H; H2=CHAR_E; H1=CHAR_L; H0=CHAR_L; end // OHELL
            default: begin H4=CHAR_OFF; H3=CHAR_OFF; H2=CHAR_OFF; H1=CHAR_OFF; H0=CHAR_OFF; end
        endcase
    end
endmodule

module mux3bit5to1(S, A, B, C, D, E, M);
    input [2:0] S, A, B, C, D, E;
    output reg [2:0] M;
    always @(*) begin
        case(S)
            3'b000: M = A;
            3'b001: M = B;
            3'b010: M = C;
            3'b011: M = D;
            3'b100: M = E;
            default: M = 3'b111; 
        endcase
    end
endmodule