`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:47 04/03/2016 
// Design Name: 
// Module Name:    mux_ctrl_AD 
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
module mux_ctrl_AD(
   input wire AD_W, AD_I,
	input wire sel_ctrl_AD,
	output reg sel_AD
    );

always @*
	case (sel_ctrl_AD)
		1'b0: sel_AD = AD_W;
		1'b1: sel_AD = AD_I;
	endcase
	
endmodule
