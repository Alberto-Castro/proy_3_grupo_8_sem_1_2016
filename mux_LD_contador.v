`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    12:27:20 03/31/2016 
// Design Name: 
// Module Name:    mux_LD_contador 
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
module mux_LD_contador(
   input [7:0] seg,min,day,month,year,seg_t,min_t,hora_t,
	input [7:0] hora,
	input [3:0] sel_LD,
	output reg [7:0] Ld_BCD
    );

always @*
	case (sel_LD)
		4'b0000: Ld_BCD = seg;
		4'b0001: Ld_BCD = min;
		4'b0010: Ld_BCD= {1'b0,hora[6:0]};
		4'b0011: Ld_BCD = day;
		4'b0100: Ld_BCD = month;
		4'b0101: Ld_BCD = year;
		4'b0110: Ld_BCD = seg_t;
		4'b0111: Ld_BCD = min_t;
		4'b1000: Ld_BCD = hora_t;
		default: Ld_BCD = seg;
	endcase

endmodule
