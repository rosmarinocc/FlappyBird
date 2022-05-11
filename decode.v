`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 20:52:00
// Design Name: 
// Module Name: decode
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


module decode(
    input   [3:0]   a,
    output  [6:0]   b
    );
    reg [6:0]   oData;
    assign b = oData;
        always@(*)begin
        case(a)
            4'h0:oData    = 7'b1000000;
            4'h1:oData    = 7'b1111001;
            4'h2:oData    = 7'b0100100;
            4'h3:oData    = 7'b0110000;
            4'h4:oData    = 7'b0011001;
            4'h5:oData    = 7'b0010010;
            4'h6:oData    = 7'b0000010;
            4'h7:oData    = 7'b1111000;
            4'h8:oData    = 7'b0000000;
            4'h9:oData    = 7'b0010000;
            4'ha:oData    = 7'b1110111;
            4'hb:oData    = 7'b0000011;
            4'hc:oData    = 7'b1000110;
            4'hd:oData    = 7'b1000001;
            4'he:oData    = 7'b0000110;
            4'hf:oData    = 7'b0001110;
            default:oData = 7'b0000000;
        endcase
        end
endmodule
