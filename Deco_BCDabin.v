`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:03 03/31/2016 
// Design Name: 
// Module Name:    Deco_BCDabin 
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
module Deco_BCDabin(
   input [7:0] Ld_BCD,
	output [6:0] Ld_bin
    );
	 
reg [6:0] suma1,suma2,suma3;

always @*
begin
	suma1 = {3'b0,Ld_BCD[3:0]};
	suma2 = {2'b0,Ld_BCD[7:4],1'b0};
	suma3 = {Ld_BCD[7:4],3'b0};
end

assign Ld_bin = suma1 + suma2 + suma3;

endmodule
