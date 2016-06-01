`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:31 04/02/2016 
// Design Name: 
// Module Name:    Control_Escribir 
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
module Control_Escribir(
	input wire Inicio_E,PB_left,PB_right,PB_program,SF_Timer,SF_24_12,clk, reset,
	output wire Fin_E, Num_Ld,Wr_reg,sel_hora,
	output wire [3:0]sel_reg_W, sel_LD,
	output wire [6:0] Cont_max
    );

wire [4:0]ctrl_E;

FMS_Escribir maquina_escribir (
    .Inicio_E(Inicio_E), 
    .PB_left(PB_left), 
    .PB_right(PB_right), 
    .PB_program(PB_program), 
    .SF_Timer(SF_Timer), 
    .SF_24_12(SF_24_12), 
    .clk(clk), 
    .reset(reset), 
    .ctrl_E(ctrl_E)
    );
	 
Deco_Escribir deco_escribir (
    .ctrl_E(ctrl_E), 
    .Fin_E(Fin_E), 
    .Num_Ld(Num_Ld), 
    .Wr_reg(Wr_reg),
	 .sel_hora(sel_hora),
    .sel_reg_W(sel_reg_W), 
    .sel_LD(sel_LD), 
    .Cont_max(Cont_max)
    );

endmodule
