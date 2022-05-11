`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/28 21:42:38
// Design Name: 
// Module Name: flappy
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
module flappy(input sys_clk,//系统时钟100MHz
              input sys_rstn,//外部复位按键
              input btn_m,               //控制小鸟移动按键，低电平up高电平down
              input btn_s,              //game start  
              output vga_hs,//行同步
              output vga_vs,//场同步
              output [11:0]vga_rgb,//rgb444
              output [6:0]oData,//七段数码管显示数据
              output [7:0]select);//七段数码管片选信号
    
    wire vga_clk;//分频65MHz时钟
    wire locked;//分频时钟稳定信号
    wire rstn;//内部复位信号
    wire [11:0] px_data;//像素点颜色rgb444
    wire [11:0] px_x;//像素点x坐标
    wire [11:0] px_y;//像素点y坐标
    wire [11:0] score;//得分
    wire clk_20;//分频20Hz时钟
    wire gameover;
    wire [11:0] bird_y;
    wire [11:0] bird_x;
    wire [11:0] pipe1_x;
    wire [11:0] pipe1_y;
    wire [11:0] pipe2_x;
    wire [11:0] pipe2_y;
    wire [11:0] pipe3_x;
    wire [11:0] pipe3_y;
    
    wire        hs;
    wire        vs;
    wire        de;
    wire [11:0] rgb;
    wire        waiting;
    wire        over;
    wire        clk_100;
    assign rstn = sys_rstn&&locked;//时钟信号稳定后，复位信号有效
    
    //////////65MHz时钟模块////////////////////////////////////
    video_pll video_clk(
     // Clock in ports
     .clk_in1(sys_clk),
    .reset(~sys_rstn),
    //output
    .clk_out1(vga_clk),
    .locked(locked)
    );
    div_100 div_100_uut(.clk(vga_clk),.clk_100(clk_100));
    //////////vga驱动模块////////////////////////////////////
    vga_driver vga_driver_uut(
    //input
    .clk(vga_clk),
    .rst(~rstn),
    //output
    .hs(hs),
    .vs(vs),
    .de(de),
    .rgb(rgb),
    .px_x(px_x),
    .px_y(px_y)
    );
    //=====================game module===================//
    game_module game(
            .clk(vga_clk),
            .rst_n(rstn),  
            .btn_m(btn_m),                            //button ,control bird height
            .btn_s(btn_s),
            .vs(vs),                
            .bird_x(bird_x),
            .bird_y(bird_y),
            .pipe1_x(pipe1_x),
            .pipe1_y(pipe1_y),
            .pipe2_x(pipe2_x),                    
            .pipe2_y(pipe2_y),
            .pipe3_x(pipe3_x),
            .pipe3_y(pipe3_y),
            .score(score),
            .waiting(waiting),
            .over(over)        
        );
        
    //////////vga显示模块////////////////////////////////////
    vga_display vga_display_uut(
    //input
    .vga_clk(vga_clk),
    .rstn(rstn),
    .hs(hs),
    .vs(vs),
    .de(de),
    .rgb(rgb),
    .pix_x(px_x),
    .pix_y(px_y),
    .bird_x(bird_x),
    .bird_y(bird_y),
    .pipe1_x(pipe1_x),
    .pipe1_y(pipe1_y),
    .pipe2_x(pipe2_x),                    
    .pipe2_y(pipe2_y),
    .pipe3_x(pipe3_x),
    .pipe3_y(pipe3_y),
    //output
    .vga_hs(vga_hs),
    .vga_vs(vga_vs),
    .vga_rgb(vga_rgb)
    );
    

    
    //////////7段数码管模块////////////////////////////////////
    display7 display7_uut(
    //input
    .waiting(waiting),
    .over(over),
    .vga_clk(clk_100),
    .rstn(rstn),
    .score(score),
    //output
    .HEX(oData),
    .sec(select)
    );
    

    
endmodule
