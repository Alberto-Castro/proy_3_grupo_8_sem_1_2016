`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:20 05/15/2016 
// Design Name: 
// Module Name:    mux 
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
module mux(
	input wire clk_i,hsync_o,vsync_o,h1,v1,h2,v2,
	input wire[7:0]rgb1,
	input wire[7:0]rgb2,
	output wire [7:0]rgb);
reg h3,v3;

reg [7:0]rgb3;
reg clk=0;
always @(posedge clk_i)begin     
		clk <= ~clk;	//Slow down the counter to 25MHz
	end
always @ (posedge clk_i)
   begin
      if (clk) 
		begin
			rgb3=rgb1;
			h3=h1;
			v3=v1;
			end
				else begin
				rgb3=rgb2;
				h3=h2;
				v3=v2;
				end
			end
assign rgb=rgb3;
assign hsync_o=h3;
assign vsync_o=v3;
endmodule
