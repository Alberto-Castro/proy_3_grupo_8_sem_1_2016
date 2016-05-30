`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    09:49:58 03/25/2016 
// Design Name: 
// Module Name:    Contador_4bits 
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
module Contador_4bits(
   input wire clk,reset_clk,
	output wire [4:0] conta_1
    );
	 
reg[4:0] conta;

//procedieminto para el contador
always @ (posedge clk)
	begin 
		if (reset_clk==1)
			conta=5'b00000;
		else
			if (conta==5'd27)
				conta=5'b00000;
			else
				conta=conta+1'b1;
	end
	
assign conta_1=conta;

endmodule
