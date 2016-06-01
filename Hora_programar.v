`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:43 04/02/2016 
// Design Name: 
// Module Name:    Hora_programar 
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
module Hora_programar(
	input Num_Ld,PB_up,PB_down,clk,reset,SF_24_12,SF_AM_PM,sel_hora,
	input [6:0] Cont_max,
	input [7:0] seg,min,hora,day,month,year,seg_t,min_t,hora_t,
	input [3:0] sel_LD,
	output [7:0] Wr_BCD
    );

wire [7:0] Ld_BCD;
wire [6:0] Ld_bin;
wire [6:0] Wr_bin;

mux_LD_contador mux_contador (
    .seg(seg), 
    .min(min), 
    .hora(hora), 
    .day(day), 
    .month(month), 
    .year(year), 
    .seg_t(seg_t), 
    .min_t(min_t), 
    .hora_t(hora_t), 
    .sel_LD(sel_LD), 
    .Ld_BCD(Ld_BCD)
    );
	 
Deco_BCDabin BCD_bin (
    .Ld_BCD(Ld_BCD), 
    .Ld_bin(Ld_bin)
    );

Contador_entradas contador (
    .Num_Ld(Num_Ld), 
    .PB_up(PB_up), 
    .PB_down(PB_down), 
    .clk(clk), 
    .reset(reset), 
    .Cont_max(Cont_max), 
    .Ld_bin(Ld_bin), 
    .Wr_bin(Wr_bin)
    );

Deco_binaBCD bin_BCD (
    .Wr_bin(Wr_bin),
	 .sel_hora(sel_hora),
	 .SF_AM_PM(SF_AM_PM),
	 .SF_24_12(SF_24_12),
    .Wr_BCD(Wr_BCD)
    );	 
endmodule
