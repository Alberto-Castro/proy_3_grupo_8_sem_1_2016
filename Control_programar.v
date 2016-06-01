`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:54:05 04/02/2016 
// Design Name: 
// Module Name:    Control_programar 
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
module Control_programar(
	input wire Inicio_W, clk, reset, Final_WR,Fin_E,
	output wire Fin_W,Op_W,I_W,AD_W,Inicio_E,
	output wire [3:0] Addr_W,sel_prog,
	output wire [1:0] data_sel
    );

wire [4:0] ctrl_W;

FMS_programar maquina_prog (
    .Inicio_W(Inicio_W), 
    .clk(clk), 
    .reset(reset), 
    .Final_WR(Final_WR), 
    .Fin_E(Fin_E), 
    .ctrl_W(ctrl_W)
    );
	 
Deco_programar deco_prog (
    .ctrl_W(ctrl_W), 
    .Fin_W(Fin_W), 
    .Op_W(Op_W), 
    .I_W(I_W), 
    .AD_W(AD_W),
	 .Inicio_E(Inicio_E),
    .Addr_W(Addr_W), 
    .sel_prog(sel_prog), 
    .data_sel(data_sel)
    );
	 

endmodule
