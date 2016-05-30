`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:16 04/03/2016 
// Design Name: 
// Module Name:    mux_data_address 
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
module mux_data_address(
	input wire [7:0] Data, Address,
	input wire AD_M,
	output reg [7:0] data_in
    );

always @*
	case (AD_M)
		1'b0: data_in = Address;
		1'b1: data_in = Data;
	endcase
	
endmodule
