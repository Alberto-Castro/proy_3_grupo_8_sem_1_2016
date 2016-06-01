`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    17:32:21 03/30/2016 
// Design Name: 
// Module Name:    Control_Read 
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
module Control_Read(
	input wire Inicio_L, clk, reset, Final_WR,
	output wire Fin_L,Op_L,I_L,AD_L,
	output wire [3:0]Addr_L,sel_reg_L
    );

wire [4:0]ctrl_L;

FMS_lectura maquina_Read (
    .Inicio_L(Inicio_L), 
    .clk(clk), 
    .reset(reset), 
    .Final_WR(Final_WR), 
    .ctrl_L(ctrl_L)
    );

Deco_lectura decodificador_read (
    .ctrl_L(ctrl_L), 
    .Fin_L(Fin_L), 
    .Op_L(Op_L), 
    .I_L(I_L),
	 .AD_L(AD_L),
	 .sel_reg_L(sel_reg_L),
    .Addr_L(Addr_L)
    );

endmodule
