`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    21:14:20 03/30/2016 
// Design Name: 
// Module Name:    Deco_Formato_Hora 
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
module Deco_Formato_Hora(
	input SF_24_12,SF_Timer,
	output reg [7:0] Data_WI,Data_WF
    );

always @*

	begin
		Data_WI={3'b000,SF_24_12,SF_Timer,3'b000};
		Data_WF={3'b001,SF_24_12,SF_Timer,3'b000};
	end
	//SF_24_12 SF_Timer
	
	
endmodule
