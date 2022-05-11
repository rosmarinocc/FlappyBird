`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/28 21:48:26
// Design Name: 
// Module Name: crash_check
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

//////////////////////////////模块功能：判断是否小鸟与管道相撞//////////////////////
module crash_check
    #(              parameter BIRD_HEIGHT    = 12'd40,
                    parameter BIRD_WIDTH     = 12'd40,
                    parameter PIPE_WIDTH     = 12'd60,
                    parameter IMG_HEIGHT     = 12'd768,
                    parameter IMG_WIDTH      = 12'd1024
                   

    )(
                   input [11:0]     bird_x,
                   input [11:0]     bird_y,                                          
                   input [11:0]     pipe1_x,
                   input [11:0]     pipe2_x,
                   input [11:0]     pipe3_x,
                   input [11:0]     pipe1_y,
                   input [11:0]     pipe2_y,
                   input [11:0]     pipe3_y,
                   output reg       crash,
                   output            pass);
    
    ////////////////////////////////MAIN CODE/////////////////////////////////////////////////////////////////
always@(*)
begin
         if(bird_x + BIRD_WIDTH>= pipe1_x & bird_x <= pipe1_x + PIPE_WIDTH )
            if(bird_y >= IMG_HEIGHT - pipe1_y )     crash = 1'b1;
            else                                    crash = 1'b0;
    else if(bird_x + BIRD_WIDTH>= pipe2_x & bird_x <= pipe2_x + PIPE_WIDTH )
            if(bird_y >= IMG_HEIGHT - pipe2_y )     crash = 1'b1;
            else                                    crash = 1'b0;
    else if(bird_x + BIRD_WIDTH>= pipe3_x & bird_x <= pipe3_x + PIPE_WIDTH )
            if(bird_y >= IMG_HEIGHT - pipe3_y )     crash = 1'b1;
            else                                    crash = 1'b0;
    else if(bird_y == IMG_HEIGHT )                crash = 1'b1;              
    else                                            crash = 1'b0;
end
assign pass = (bird_x == pipe1_x + PIPE_WIDTH  )|
              (bird_x == pipe2_x + PIPE_WIDTH  )|
              (bird_x == pipe3_x + PIPE_WIDTH  );      
endmodule
    
    
