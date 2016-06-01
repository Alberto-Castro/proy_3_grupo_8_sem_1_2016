`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    12:12:59 03/31/2016 
// Design Name: 
// Module Name:    mux_programar 
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
module mux_programar(
	input [7:0] seg,min,hora,day,month,year,seg_t,min_t,hora_t,
	input [3:0] sel_prog,
	output reg [7:0] Data_WR
    );

always @*
	case (sel_prog)
		4'b0000: Data_WR = seg;
		4'b0001: Data_WR = min;
		4'b0010: Data_WR = hora;
		4'b0011: Data_WR = day;
		4'b0100: Data_WR = month;
		4'b0101: Data_WR = year;
		4'b0110: Data_WR = seg_t;
		4'b0111: Data_WR = min_t;
		4'b1000: Data_WR = hora_t;
		4'b1001: Data_WR = 8'b11110000;
		default: Data_WR = seg;
	endcase
	
endmodule
