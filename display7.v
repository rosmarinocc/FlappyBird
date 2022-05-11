`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/28 21:53:54
// Design Name:
// Module Name: display7
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


////////////////////模块功能：实现七段数码管计分////////////////////\
//根据score的数值输出片选信号与每片的十进制数据
module display7 (input vga_clk,
                 input rstn,
                 input  waiting,
                 input  over,
                 input [11:0] score,
                 output [6:0] HEX,
                 output [7:0] sec);
    
    
    reg [3:0] data[0:2];//score个十???
    reg [2:0] count;
    reg [6:0] oData;
    reg [7:0] select;
    reg [7:0] shift = 8'b1111_1110;
    reg [6:0] temp;    
    wire[6:0] ge;
    wire[6:0] shi;
    wire[6:0] bai;  
assign HEX = temp;
assign sec = shift;    
always@(posedge vga_clk or negedge rstn)
begin
    if(~rstn)  shift   <= 8'b1111_1110;
    else        shift   <= {shift[6:0],shift[7]};
end    
always@(*)
begin
    if(waiting)
        case(shift)
        8'b1111_1110 :  temp    <=  7'b0111111;             //t
        8'b1111_1101 :  temp    <=  7'b0111111;             //r
        8'b1111_1011 :  temp    <=  7'b0111111;             //A
        8'b1111_0111 :  temp    <=  7'b0111111;             //t
        8'b1110_1111 :  temp    <=  7'b0111111;             //S
        default      :  temp    <=  7'b0111111;             //-
        endcase
     else if(over)
        case(shift)
         8'b1111_1110 :  temp    <=  7'b0000110;             //r
         8'b1111_1101 :  temp    <=  7'b0110000;             //v
         8'b1111_1011 :  temp    <=  7'b0000110;             //E
         8'b1111_0111 :  temp    <=  7'b0110000;             //o
         8'b1110_1111 :  temp    <=  7'b0000110;             //e
         8'b1101_1111 :  temp    <=  7'b0110000;             //-
         8'b1011_1111 :  temp    <=  7'b0000110;             //a
         8'b0111_1111 :  temp    <=  7'b0110000;             //g
         default      :  temp    <=  7'b0111111;             //-
         endcase
     else if((~waiting) & (~over))       
         case(shift)  
         8'b1111_1110 :  temp    <=  ge;             
         8'b1111_1101 :  temp    <=  shi;            
         8'b1111_1011 :  temp    <=  bai;            
         8'b1111_0111 :  temp    <=  7'b0111111;            //-
         8'b1110_1111 :  temp    <=  7'b0111111;             //-
         8'b1101_1111 :  temp    <=  7'b0111111;             //-
         8'b1011_1111 :  temp    <=  7'b0111111;             //-
         8'b0111_1111 :  temp    <=  7'b0111111;             //-
         default      :  temp    <=  7'b0111111;             //-
         endcase
    else
         temp    <=  7'b0111111;             //-                 
        
end
reg[3:0]    data1,data2,data3;
    always@(*)begin
    data1 = score%10;
    data2 = (score/10)%10;
    data3 = (score/100)%10;
end
decode gewei(.a(data1),.b(ge));
decode shiwei(.a(data2),.b(shi));
decode baiwei(.a(data3),.b(bai));
endmodule
