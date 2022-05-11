`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/28 21:46:06
// Design Name: 
// Module Name: pipe_generate
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


///////////////////////////////模块功能：生成管道并左移/////////////////////
module pipe_generate(input          clk,
                     input          rstn,
                     input          en,
                     input          start,
                     output  [11:0] pipe1_x,
                     output  [11:0] pipe1_y,
                     output  [11:0] pipe2_x,
                     output  [11:0] pipe2_y,
                     output  [11:0] pipe3_x,
                     output  [11:0] pipe3_y
);
wire change1,change2,change3;
random #(.seed(10'd699) )pipy_gen1(.clk(clk),.rst_n(rstn),.en(change1 & start),.rand(pipe1_y));
random #(.seed(10'd799) )pipy_gen2(.clk(clk),.rst_n(rstn),.en(change2 & start),.rand(pipe2_y));
random #(.seed(10'd299) )pipy_gen3(.clk(clk),.rst_n(rstn),.en(change3 & start),.rand(pipe3_y));
decrease #(.seed(10'd999) )pipx_gen1(.clk(clk),.rst_n(rstn),.en(en & start),.change(change1),.data(pipe1_x));
decrease #(.seed(10'd599) )pipx_gen2(.clk(clk),.rst_n(rstn),.en(en & start),.change(change2),.data(pipe2_x));
decrease #(.seed(10'd199) )pipx_gen3(.clk(clk),.rst_n(rstn),.en(en & start),.change(change3),.data(pipe3_x));
endmodule
            
            
