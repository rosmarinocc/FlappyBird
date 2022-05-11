`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 14:45:03
// Design Name: 
// Module Name: tb
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


module tb();
reg             clk_p,clk_n;
reg             rst_n;
reg             btn_m,btn_s;
wire            vga_hs,vga_vs;
wire    [11:0]  vga_rgb;
wire    [6:0]   hex;
wire    [7:0]   select;
initial begin
    clk_p   =   1'b0;
    clk_n   =   1'b1;
    rst_n   =   1'b0;
    btn_m   =   1'b0;
    btn_s   =   1'b0;
#1000   
    rst_n   =   1'b1;
#10000
    btn_s   =   1'b1;
#1000    
    btn_s   =   1'b0;
#1000
    btn_m   =   1'b1;
#1000    
    btn_m   =   1'b0;                    
end
always # 2.5    clk_p = ~ clk_p;
always # 2.5    clk_n = ~ clk_n;
flappy  top(
              .sys_clk(clk_n),//系统时钟100MHz
              //.sys_clk_p(clk_p),  
              .sys_rstn(rst_n),//外部复位按键
              .btn_m(btn_m),               //控制小鸟移动按键，低电平up高电平down
              .btn_s(btn_s),
              .vga_hs(vga_hs),//行同步
              .vga_vs(vga_vs),//场同步
              .vga_rgb(vga_rgb),//rgb444
              .oData(hex),//七段数码管显示数据
              .select(select));//七段数码管片选信号

endmodule
