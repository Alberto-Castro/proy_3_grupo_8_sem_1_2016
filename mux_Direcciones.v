`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    15:25:52 03/30/2016 
// Design Name: 
// Module Name:    mux_Direcciones 
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
module mux_Direcciones(
	input [3:0] Addr_L,Addr_W,Addr_I,
	input wire [1:0] dir_sel,
	output reg [3:0] Address_WR
    );
	
always @*
	
	case (dir_sel)
		2'b00: Address_WR = Addr_L;
		2'b01: Address_WR = Addr_W;
		2'b10: Address_WR = Addr_I;
		2'b11: Address_WR = 4'b0000;
		default: Address_WR = 4'b0000;
	endcase

endmodule
