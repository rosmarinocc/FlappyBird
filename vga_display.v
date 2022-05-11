`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 13:46:19
// Design Name: 
// Module Name: vga_display
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


module vga_display
    #(          parameter BIRD_HEIGHT    = 12'd40,
                parameter BIRD_WIDTH     = 12'd40,
                parameter PIPE_WIDTH     = 12'd60,
                parameter IMG_HEIGHT     = 12'd768,
                parameter IMG_WIDTH      = 12'd1024
     )(
        //input
        input           vga_clk,
        input           rstn,
        input           hs,
        input           vs,
        input           de,
        input   [11:0]  rgb,
        input   [11:0]  pix_x,
        input   [11:0]  pix_y,
        input   [11:0]  bird_x,
        input   [11:0]  bird_y,
        input   [11:0]  pipe1_x,
        input   [11:0]  pipe1_y,
        input   [11:0]  pipe2_x,                    
        input   [11:0]  pipe2_y,
        input   [11:0]  pipe3_x,
        input   [11:0]  pipe3_y,
        //output
        output          vga_hs,
        output          vga_vs,
        output  [11:0]  vga_rgb
);
reg         hs_d0;
reg         hs_d1;
reg         hs_d2;
reg         vs_d0;
reg         vs_d1;
reg         vs_d2;
reg [11:0]  rgb_d0;
reg [11:0]  rgb_d1;
reg [11:0]  rgb_d2;
reg [11:0]  addr;
reg [11:0]  t_data;      
reg [2:0]   flag = 0;
reg [2:0]   flag_d0;
reg [2:0]   flag_d1;
wire        vs_p;
wire [23:0]  data;
assign vs_p = vs & ~vs_d0;
assign vga_hs   = hs_d2;
assign vga_vs   = vs_d2;
assign vga_rgb  = t_data;
always@(posedge vga_clk)
begin
    hs_d0   <= hs;
    hs_d1   <= hs_d0;
    hs_d2   <= hs_d1;
    vs_d0   <= vs;
    vs_d1   <= vs_d0;
    vs_d2   <= vs_d1;
    rgb_d0  <= rgb;
    rgb_d1  <= rgb_d0;
    rgb_d2  <= rgb_d2;
    flag_d0 <= flag;
    flag_d1 <= flag_d0;
end
always@(posedge vga_clk)
begin
    if(pix_x >= bird_x  && pix_x <= bird_x + BIRD_WIDTH - 1'b1 && pix_y >= bird_y && pix_y <= bird_y + BIRD_HEIGHT - 1'b1)
        flag <= 3'b1;
    else if(pix_x >= pipe1_x  && pix_x <= pipe1_x + PIPE_WIDTH - 1'b1 && pix_y >= IMG_HEIGHT - pipe1_y && pix_y <= IMG_HEIGHT - 1'b1)    
        flag <= 3'd2;
    else if(pix_x >= pipe2_x  && pix_x <= pipe2_x + PIPE_WIDTH - 1'b1 && pix_y >= IMG_HEIGHT - pipe2_y && pix_y <= IMG_HEIGHT - 1'b1)    
        flag <= 3'd2;
    else if(pix_x >= pipe3_x  && pix_x <= pipe3_x + PIPE_WIDTH - 1'b1 && pix_y >= IMG_HEIGHT - pipe3_y && pix_y <= IMG_HEIGHT - 1'b1)    
        flag <= 3'd2;
    else
        flag <= 3'd0;    
end

always@(posedge vga_clk or negedge rstn)
begin
    if(~rstn)               addr    <=  12'd0;
    else if(vs_p)           addr    <= 12'd0;
    else if(flag == 3'd1)   addr    <=  addr +1'b1;
    else                    addr    <=  addr;    
end

always@(posedge vga_clk)
begin
    if(flag_d1 == 1)        t_data  <=   {data[23:20],data[15:12],data[3:0]};
    else if(flag_d1 == 2)   t_data  <=   12'h0f0;
    else                    t_data  <=   rgb_d1;
end
    blk_mem_gen_0 osd_rom_m0 (                                  //delay 2 clk
    .clka                       (vga_clk),      
    .addra                      (addr   ), 
    .douta                      (data   )  
);
endmodule
