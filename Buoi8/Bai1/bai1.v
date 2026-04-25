module bai1 (SW, LEDG);
    input [11:0] SW; 
    
    output [6:0] LEDG;
    
    wire [5:0] a, b;
    wire [6:0] s;
    
    // Khai báo các dây cờ nhớ khớp 100% với sơ đồ (từ c0 đến c5)
    wire c0, c1, c2, c3, c4, c5; 

    assign a = SW[5:0];   
    assign b = SW[11:6]; 
    
    assign LEDG = s; 

    // Đổi tên các khối thành FA0, FA1, FA2... để khớp hình và dễ quản lý
    // Lưu ý: Trong Verilog các tên instance phải khác nhau nên tôi đánh số từ 0 đến 5
    cong1bit FA0 (c0, s[0], a[0], b[0], 1'b0); // ci = 0, co = c0
    cong1bit FA1 (c1, s[1], a[1], b[1], c0);   // ci = c0, co = c1
    cong1bit FA2 (c2, s[2], a[2], b[2], c1);   // ci = c1, co = c2
    cong1bit FA3 (c3, s[3], a[3], b[3], c2);   // ci = c2, co = c3
    cong1bit FA4 (c4, s[4], a[4], b[4], c3);   // ci = c3, co = c4
    cong1bit FA5 (c5, s[5], a[5], b[5], c4);   // ci = c4, co = c5

    // LED6 hiển thị cờ nhớ cuối cùng (dây c5 trên sơ đồ)
    assign s[6] = c5;

endmodule 

module cong1bit (co, s, a, b, ci); 
    input a, b, ci; 
    output co, s; 
    wire n1, n2, n3, n4; 

    xor (n1, a, b); 
    xor (s, ci, n1); 
    not (n2, n1); 
    and (n3, n2, b); 
    and (n4, ci, n1); 
    or (co, n3, n4); 
endmodule