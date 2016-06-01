`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    11:40:30 03/31/2016 
// Design Name: 
// Module Name:    Contador_entradas 
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
module Contador_entradas(
	input Num_Ld,PB_up,PB_down,clk,reset,
	input [6:0] Cont_max, Ld_bin,
	output reg [6:0] Wr_bin
    );

always @(posedge clk)
begin
	if (reset)
		Wr_bin = 7'b0000000;
	else if (Num_Ld)
		Wr_bin = Ld_bin;
	else if (PB_up)
		begin
		if (Wr_bin == Cont_max)
			Wr_bin = 7'b0000000;
		else
			Wr_bin = Wr_bin + 1'b1;
		end
	else if (PB_down)
		begin
		if (Wr_bin == 7'b0000000)
			Wr_bin = Cont_max;
		else
			Wr_bin = Wr_bin - 1'b1;
		end
end
		
endmodule
