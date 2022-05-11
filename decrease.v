`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 10:30:19
// Design Name: 
// Module Name: decrease
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


module decrease
    #(
        parameter seed  =  500
    )(
        input               clk,
        input               rst_n,
        input               en,
        output reg         change,
        output reg [11:0]  data
    );
    reg en_d;
    wire en_p;
    
always@(posedge clk)
begin
    en_d <= en;
end
assign en_p = en & ~en_d;
always@(posedge clk)
begin
    if(data == 12'd1023)    change <= 1'b1;
    else                    change <= 1'b0;
end
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)          data <= seed;
    else if(en_p)       data <= data - 1'b1;
    else if(data == 1)  data <= 12'd1023;
    else                data <= data;
end    
endmodule
