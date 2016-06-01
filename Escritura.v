`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:56 04/04/2016 
// Design Name: 
// Module Name:    Escritura 
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
module Escritura(
	input Num_Ld,PB_up,PB_down,clk,reset,SF_24_12,SF_Timer,sel_hora,SF_AM_PM,
	input [6:0] Cont_max,
	input [7:0] seg,min,hora,day,month,year,seg_t,min_t,hora_t,Data_I,
	input [3:0] sel_LD,Addr_L,Addr_W,Addr_I,sel_prog,
	input [1:0] dir_sel, data_sel,
	output [7:0] Data,Address,Wr_BCD
    );

wire [3:0] Address_WR;
wire [7:0] Data_WI,Data_WF,Data_WR;

Hora_programar decodificacion_entradas (
    .Num_Ld(Num_Ld), 
    .PB_up(PB_up), 
    .PB_down(PB_down), 
    .clk(clk), 
    .reset(reset),
	 .SF_24_12(SF_24_12),
	 .SF_AM_PM(SF_AM_PM),
	 .sel_hora(sel_hora),
    .Cont_max(Cont_max), 
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
    .Wr_BCD(Wr_BCD)
    );

mux_Data sel_data (
    .Data_WI(Data_WI), 
    .Data_WF(Data_WF), 
    .Data_I(Data_I), 
    .Data_WR(Data_WR), 
    .data_sel(data_sel), 
    .Data(Data)
    );

mux_Direcciones sel_direccion (
    .Addr_L(Addr_L), 
    .Addr_W(Addr_W), 
    .Addr_I(Addr_I), 
    .dir_sel(dir_sel), 
    .Address_WR(Address_WR)
    );

mux_programar sel_param (
    .seg(seg), 
    .min(min), 
    .hora(hora), 
    .day(day), 
    .month(month), 
    .year(year), 
    .seg_t(seg_t), 
    .min_t(min_t), 
    .hora_t(hora_t), 
    .sel_prog(sel_prog), 
    .Data_WR(Data_WR)
    );
 
Deco_Formato_Hora formato_hora (
    .SF_24_12(SF_24_12), 
    .SF_Timer(SF_Timer), 
    .Data_WI(Data_WI), 
    .Data_WF(Data_WF)
    );

Deco_direcciones decodificador_dir (
    .Address_WR(Address_WR), 
    .Address(Address)
    );

endmodule
