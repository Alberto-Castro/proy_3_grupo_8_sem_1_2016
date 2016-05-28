`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    14:42:59 03/28/2016 
// Design Name: 
// Module Name:    Control_Time_2 
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
module Control_Time_2(
	input wire clk,reset,I,OP,AD,
	output wire A_D,RD,WR,CS,Dato_1,Dato_2,Final_WR
    );

wire [4:0]control_1;

Maquina_Tiempos maquina (
    .clk(clk), 
    .reset(reset), 
    .I(I), 
    .OP(OP),
	 .AD(AD),
    .control_1(control_1)
    );
	 
Deco_Tiempos decodificador (
    .control_1(control_1), 
    .A_D(A_D), 
    .RD(RD), 
    .WR(WR), 
    .CS(CS), 
    .Dato_1(Dato_1), 
    .Dato_2(Dato_2), 
    .Final_WR(Final_WR)
    );

endmodule
