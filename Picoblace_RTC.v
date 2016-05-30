`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:38 05/29/2016 
// Design Name: 
// Module Name:    Picoblace_RTC 
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
module Picoblace_RTC(input clk,reset,
	input [7:0]PS2,
	input [6:0]Tecla_lista,
	output wire[7:0]VGA_sg,VGA_mn,VGA_hr,VGA_di,VGA_me,VGA_an,VGA_sgT,VGA_mnT,VGA_hrT,tecla_leida,
	output wire A_D,RD,WR,CS,
	inout  [7:0]io_port 
    );

reg [7:0] RTC_LEC,CONTROL;
wire [7:0] data_in;
wire [7:0] Ctrl_wr_rd;
reg OP,I,AD;
wire Final_WR;
wire [7:0] data_out;
wire [7:0] Data,Direccion;

always @*
begin
	OP = Ctrl_wr_rd[0];
	AD = Ctrl_wr_rd[1];
	I = Ctrl_wr_rd[2];
	RTC_LEC = data_out;
end

always @(Final_WR or Tecla_lista)
begin
	CONTROL = {Tecla_lista[6:0],Final_WR};
end

BUS_IO2 Bus_datos (
    .clk(clk), 
    .Dato_1(Dato_1), 
    .Dato_2(Dato_2), 
    .data_in(data_in), 
    .data_out(data_out), 
    .io_port(io_port)
    );

Control_Time_2 Interfaz_control (
    .clk(clk), 
    .reset(reset), 
    .I(I), 
    .OP(OP), 
    .AD(AD), 
    .A_D(A_D), 
    .RD(RD), 
    .WR(WR), 
    .CS(CS), 
    .Dato_1(Dato_1), 
    .Dato_2(Dato_2), 
    .Final_WR(Final_WR)
    );
	 
Picoblaze Picoblaze (
    .clk(clk), 
    .RTC_LEC(RTC_LEC), 
    .PS2(PS2), 
    .CONTROL(CONTROL), 
    .Ctrl_wr_rd(Ctrl_wr_rd), 
    .Data(Data), 
    .Direccion(Direccion), 
    .VGA_sg(VGA_sg), 
    .VGA_mn(VGA_mn), 
    .VGA_hr(VGA_hr), 
    .VGA_di(VGA_di), 
    .VGA_me(VGA_me), 
    .VGA_an(VGA_an), 
    .VGA_sgT(VGA_sgT), 
    .VGA_mnT(VGA_mnT), 
    .VGA_hrT(VGA_hrT), 
    .tecla_leida(tecla_leida)
    );
	 
mux_data_address mux2a1 (
    .Data(Data), 
    .Address(Direccion), 
    .AD_M(AD), 
    .data_in(data_in)
    );

endmodule
