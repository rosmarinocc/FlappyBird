`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 10:27:19
// Design Name: 
// Module Name: fsm_game
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


module fsm_game(
    input               clk,
    input               rst_n,
    input               vs,
    input               start,
    input               move,                   //1 ip  ,0 down
    input  [11:0]       pipe1_x,                //pipe1 x
    input  [11:0]       pipe1_y,                //pipe1 y
    input  [11:0]       pipe2_x,                //pipe2 x
    input  [11:0]       pipe2_y,                //pipe2 y
    input  [11:0]       pipe3_x,                //pipe3 x
    input  [11:0]       pipe3_y,                //pipe3 y
    
    output  [11:0]      bird_x,
    output  [11:0]      bird_y,
    output  reg[11:0]  score,
    output  reg        over,
    output  reg        play,
    output  reg        waiting 
    );
    
    localparam idle     = 4'b0000;
    localparam playing  = 4'b0001;
    localparam gameover = 4'b0010;
    reg [3:0]   state;
    reg [3:0]   next_state;
    reg         pass_d;
    wire        crash;
    wire        pass;
    wire        passp; 
assign passp = pass &~pass_d;    
always@(posedge clk)
begin
    pass_d <= pass;
end               
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        state   <=  4'd0;
    else
        state   <=  next_state;
end
always@(*)
begin
    case(state)
    idle    :   if(start)       next_state  <=  playing;
                else            next_state  <=  idle;
    playing :   if(crash)       next_state  <= gameover;
                else            next_state  <=  playing;
    gameover:                   next_state  <= gameover;
    default :                   next_state  <=  idle;
    endcase                                
end
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)                  begin   over <= 1'b0;   play <= 1'b0;    waiting <= 1'b0;   end
    else if(state == idle)      begin   over <= 1'b0;   play <= 1'b0;    waiting <= 1'b1;   end
    else if(state == playing)   begin   over <= 1'b0;   play <= 1'b1;    waiting <= 1'b0;   end
    else if(state == gameover)  begin   over <= 1'b1;   play <= 1'b0;    waiting <= 1'b0;   end
    else                        begin   over <= over;   play <= play;    waiting <= waiting;   end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)                          score <= 12'b0;
    else if(state == playing & passp)   score <= score + 1'b1;
    else                                score <= score;
end

//////////小鸟移动模块////////////////////////////////////
    bird_generate bird_generate_uut(
     //input
    .clk(clk),
    .rstn(rst_n),
    .en(vs&play),
    .move(move),
    //output
    .bird_x(bird_x),
    .bird_y(bird_y)
    );

    //////////判断撞击结束模块////////////////////////////////////
    crash_check crash_check_uut(
    //input
    .bird_x(bird_x),
    .bird_y(bird_y),                                          //上下移动允许
    .pipe1_x(pipe1_x),
    .pipe1_y(pipe1_y),
    .pipe2_x(pipe2_x),
    .pipe2_y(pipe2_y),
    .pipe3_x(pipe3_x),
    .pipe3_y(pipe3_y),
    //output
    .pass(pass),
    .crash(crash)
    );    
endmodule
