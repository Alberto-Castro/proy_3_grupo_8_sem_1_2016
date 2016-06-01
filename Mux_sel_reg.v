`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:23 04/11/2016 
// Design Name: 
// Module Name:    Mux_sel_reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mux_sel_reg(
	input wire [3:0] sel_reg_W, sel_reg_L,
	input wire selec,
	output reg [3:0] sel_reg
    );

always @*
	case (selec)
		1'b0: sel_reg = sel_reg_L;
		1'b1: sel_reg = sel_reg_W;
	endcase
	
endmodule
