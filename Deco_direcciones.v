`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    15:22:10 03/30/2016 
// Design Name: 
// Module Name:    Deco_direcciones 
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
module Deco_direcciones(
	input [3:0] Address_WR,
	output reg [7:0] Address
    );

always @*
	case (Address_WR)
		4'b0000: Address = 8'b00000000;//00
		4'b0001: Address = 8'b00000001;//01
		4'b0010: Address = 8'b00000010;//02
		4'b0011: Address = 8'b00010000;//10
		4'b0100: Address = 8'b00100001;//21
		4'b0101: Address = 8'b00100010;//22
		4'b0110: Address = 8'b00100011;//23
		4'b0111: Address = 8'b00100100;//24
		4'b1000: Address = 8'b00100101;//25
		4'b1001: Address = 8'b00100110;//26
		4'b1010: Address = 8'b01000001;//41
		4'b1011: Address = 8'b01000010;//42
		4'b1100: Address = 8'b01000011;//43
		4'b1101: Address = 8'b11110000;//F0
		4'b1110: Address = 8'b11110001;//F1
		4'b1111: Address = 8'b11110010;//F2
		default : Address = 8'b00000000;//00
	endcase
	
endmodule
