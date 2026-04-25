module bai2 (
    input wire [2:0] SW,    // SW[0]:C, SW[1]:RS, SW[2]:CK
    output reg [1:0] LEDR   // LEDR[0]:Y1 (001), LEDR[1]:Y2 (110)
);

    parameter START = 3'b000,
              S0    = 3'b001, 
              S1    = 3'b010, 
              S2    = 3'b011, 
              S3    = 3'b100, 
              S4    = 3'b101, 
              S5    = 3'b110; 

    reg [2:0] current_state, next_state;

    // 1. Khoi xac dinh trang thai tiep theo (Combinational)
    always @(*) begin 
        case (current_state)
            START: next_state = (SW[0]) ? S1 : S0;
            S0:    next_state = (SW[0]) ? S1 : S2;
            S1:    next_state = (SW[0]) ? S3 : S0;
            S2:    next_state = (SW[0]) ? S4 : S2;
            S3:    next_state = (SW[0]) ? S3 : S5;
            S4:    next_state = (SW[0]) ? S1 : S0;
            S5:    next_state = (SW[0]) ? S1 : S2;
            default: next_state = START;
        endcase
    end

    // 2. Khoi chuyen trang thai (Sequential)
    always @(negedge SW[2]) begin
        if (SW[1]) 
            current_state <= START;
        else 
            current_state <= next_state;
    end

    // 3. Khoi xac dinh ngo ra (Output Logic)
    always @(*) begin
        LEDR[0] = (current_state == S4); // Sang khi tim thay 001
        LEDR[1] = (current_state == S5); // Sang khi tim thay 110
    end

endmodule