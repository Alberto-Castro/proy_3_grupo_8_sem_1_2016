`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    21:06:46 03/30/2016 
// Design Name: 
// Module Name:    mux_Data 
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
module mux_Data(
	input [7:0] Data_WI,Data_WF,Data_I,Data_WR,
	input wire [1:0] data_sel,
	output reg [7:0] Data
    );
	 
always @*
	
	case (data_sel)
		2'b00: Data = Data_WI;
		2'b01: Data = Data_WF;
		2'b10: Data = Data_I;
		2'b11: Data = Data_WR;
		default: Data = Data_WR;
	endcase

endmodule
