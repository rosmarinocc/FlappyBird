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
module flappy(input sys_clk,//ϵͳʱ��100MHz
              input sys_rstn,//�ⲿ��λ����
              input btn_m,               //����С���ƶ��������͵�ƽup�ߵ�ƽdown
              input btn_s,              //game start  
              output vga_hs,//��ͬ��
              output vga_vs,//��ͬ��
              output [11:0]vga_rgb,//rgb444
              output [6:0]oData,//�߶��������ʾ����
              output [7:0]select);//�߶������Ƭѡ�ź�
    
    wire vga_clk;//��Ƶ65MHzʱ��
    wire locked;//��Ƶʱ���ȶ��ź�
    wire rstn;//�ڲ���λ�ź�
    wire [11:0] px_data;//���ص���ɫrgb444
    wire [11:0] px_x;//���ص�x����
    wire [11:0] px_y;//���ص�y����
    wire [11:0] score;//�÷�
    wire clk_20;//��Ƶ20Hzʱ��
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
    assign rstn = sys_rstn&&locked;//ʱ���ź��ȶ��󣬸�λ�ź���Ч
    
    //////////65MHzʱ��ģ��////////////////////////////////////
    video_pll video_clk(
     // Clock in ports
     .clk_in1(sys_clk),
    .reset(~sys_rstn),
    //output
    .clk_out1(vga_clk),
    .locked(locked)
    );
    div_100 div_100_uut(.clk(vga_clk),.clk_100(clk_100));
    //////////vga����ģ��////////////////////////////////////
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
        
    //////////vga��ʾģ��////////////////////////////////////
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
    

    
    //////////7�������ģ��////////////////////////////////////
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
