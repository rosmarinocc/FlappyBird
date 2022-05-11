`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 11:06:20
// Design Name: 
// Module Name: bird_generate
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


module bird_generate(
    //input
    input               clk,
    input               rstn,
    input               en,
    input               move,
    //output
    output    [11:0]    bird_x,
    output    [11:0]    bird_y
    );
    reg                 en_d;
    reg     [11:0]      bird_y_temp;
    wire                en_p;
    assign en_p     = en & ~en_d;
    assign bird_x   = 12'd500;
    assign bird_y   = bird_y_temp;   
    always@(posedge clk)
    begin
        en_d <= en;
    end
    always@(posedge clk or negedge rstn)
    begin
        if(~rstn)
            bird_y_temp  <= 12'd380;
        else if(move)            
            bird_y_temp  <=  bird_y_temp - 12'd70;
        else if(en_p)
            bird_y_temp  <=  bird_y_temp + 12'd3;
        else            
            bird_y_temp  <=  bird_y_temp;
    end

    
endmodule
