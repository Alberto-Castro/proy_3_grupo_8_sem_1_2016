`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    18:46:59 03/30/2016 
// Design Name: 
// Module Name:    Control_Inicializar 
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
module Control_Inicializar(
	input wire Inicio_I,clk,reset,Final_WR,
	output wire Fin_I,Op_I,I_I,AD_I,
	output wire [3:0]Addr_I,
	output wire [7:0]Data_I
	);

wire [3:0] ctrl_I;
	
FMS_Inicializar maquina_inicio (
    .Inicio_I(Inicio_I), 
    .clk(clk), 
    .reset(reset), 
    .Final_WR(Final_WR), 
    .ctrl_I(ctrl_I)
    );
	 
deco_inicializar deco_inicio (
    .ctrl_I(ctrl_I), 
    .Fin_I(Fin_I), 
    .Op_I(Op_I), 
    .I_I(I_I), 
    .AD_I(AD_I), 
    .Addr_I(Addr_I), 
    .Data_I(Data_I)
    );

endmodule
