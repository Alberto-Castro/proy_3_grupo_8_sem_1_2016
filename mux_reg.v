`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:20 04/03/2016 
// Design Name: 
// Module Name:    mux_reg 
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
module mux_reg(
	input wire [7:0] data_out, Wr_BCD,
	input wire Wr_reg,
	output reg [7:0] data_save
    );

always @*
	case (Wr_reg)
		1'b0: data_save = data_out;
		1'b1: data_save = Wr_BCD;
	endcase
	
endmodule
