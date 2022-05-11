`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 21:41:28
// Design Name: 
// Module Name: div_60
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


module div_100(
    input   clk,
    output  reg clk_100
    );
    reg [19:0] cnt;
    always@(posedge clk )
    begin
        if(cnt == 64999)   cnt <= 20'd0;
        else                cnt <= cnt +1'b1;
    end

    always@(posedge clk )
    begin
        if(cnt == 64999)   clk_100 <= ~clk_100;
        else                clk_100 <= clk_100;
    end
    
endmodule
