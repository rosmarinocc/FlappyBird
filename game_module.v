`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 09:39:41
// Design Name: 
// Module Name: game_module
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


module game_module(
        input               clk,
        input               rst_n,  
        input               btn_m,                            //button ,control bird height
        input               btn_s,
        input               vs,hs,
        input   [11:0]      data,        
        
        output  [11:0]      pipe1_x,                //pipe1 x
        output  [11:0]      pipe1_y,                //pipe1 y
        output  [11:0]      pipe2_x,                //pipe2 x
        output  [11:0]      pipe2_y,                //pipe2 y
        output  [11:0]      pipe3_x,                //pipe3 x
        output  [11:0]      pipe3_y,                //pipe3 y
        output  [11:0]      bird_x,                 //bird x    
        output  [11:0]      bird_y,                 //bird y
        //output  reg         o_vs,o_hs,
        //output  reg [11:0]  o_data,
        output  [11:0]      score,        
        output  wire        waiting,
        output  wire        over
    );
    wire    move;
    wire    start;
    wire    playing;

    //////////防抖动////////////////////////////////////////////////
    debounce#(.FREQ(65))debounce_uut0(.clk(clk),.rst(~rst_n),.button_in(btn_m),.button_posedge(move));
    debounce#(.FREQ(65))debounce_uut1(.clk(clk),.rst(~rst_n),.button_in(btn_s),.button_posedge(start));
    //////////水管生成模块////////////////////////////////////
    pipe_generate pipe_generate_uut(
    //input
    .clk(clk),
    .rstn(rst_n),
    .en(vs),
    .start(playing),
    //output
    .pipe1_x(pipe1_x),
    .pipe1_y(pipe1_y),
    .pipe2_x(pipe2_x),
    .pipe2_y(pipe2_y),
    .pipe3_x(pipe3_x),
    .pipe3_y(pipe3_y)
    );
    
    //=========游戏状态机===============================//
    fsm_game fsm(
        .clk(clk),
        .rst_n(rst_n),
        .vs(vs),
        .start(start),
        .move(move),                   //1 ip  ,0 down
        .pipe1_x(pipe1_x),
        .pipe1_y(pipe1_y),
        .pipe2_x(pipe2_x),
        .pipe2_y(pipe2_y),
        .pipe3_x(pipe3_x),
        .pipe3_y(pipe3_y),
        
        .bird_x(bird_x),
        .bird_y(bird_y),
        .score(score),
        .over(over),
        .play(playing),
        .waiting(waiting) 
        );

endmodule
