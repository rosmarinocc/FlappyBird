`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/28 21:47:40
// Design Name: 
// Module Name: random
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


////////////////模块功能：实现随机数///////////////////////////
module random
             #(
             parameter seed = 12'b0000_1111_1111
             )
             (input         clk,
              input         rst_n,
              input         en,
              output  [11:0] rand);
    
    reg [11:0] rand_r;
    reg [11:0] rand_new;
    reg        en_d; 
    wire       en_p;
    wire       w0;
    wire       w1;
    assign w0 = rand_r[11]^~rand_r[9];
    assign w1 = rand_r[0]^rand_r[10];
    assign rand   = {2'b0,rand_r[8:0]};
    initial rand_r = seed;
    
    always@(*)
    begin
        rand_new = {rand_r[10:0],w0};
    end
    always@(posedge clk)
    begin
        en_d <= en;
    end
    assign en_p = en & ~ en_d;
    always@(posedge clk)
    begin
        if(~rst_n)
            rand_r <= seed;
        else if(en_p)
            rand_r <= rand_new;        
    end
    
endmodule
    
