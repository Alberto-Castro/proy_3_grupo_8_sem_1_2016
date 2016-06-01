`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:37 04/05/2016 
// Design Name: 
// Module Name:    Control 
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
module Control(
	input wire reset,clk,SW_prog_clk,PB_left,PB_right,PB_program,SF_Timer,SF_24_12,SW_Activar,
	output wire Num_Ld,Wr_reg,A_D,RD,WR,CS,Dato_1,Dato_2,AD_M,sel_hora,
	output wire [3:0] sel_reg, sel_LD,Addr_W,sel_prog,Addr_L,Addr_I,
	output wire [6:0] Cont_max,
	output wire [1:0] data_sel,dir_sel,
	output wire [7:0] Data_I
    );

wire Fin_E,Inicio_E,Fin_W,Fin_L,Fin_I,Inicio_L,Inicio_W,Inicio_I,Final_WR,selec;
wire AD_W,AD_I,AD_L;
wire I,OP,AD;
wire [3:0] sel_reg_W,sel_reg_L;

assign I = I_L || I_W || I_I;
assign OP = Op_W || Op_L || Op_I;
assign AD = AD_W || AD_I || AD_L;
assign AD_M = AD;
assign selec = Wr_reg;

Control_Escribir Ctrl_Escribir (
    .Inicio_E(Inicio_E), 
    .PB_left(PB_left), 
    .PB_right(PB_right), 
    .PB_program(PB_program), 
    .SF_Timer(SF_Timer), 
    .SF_24_12(SF_24_12), 
    .clk(clk), 
    .reset(reset), 
    .Fin_E(Fin_E), 
    .Num_Ld(Num_Ld), 
    .Wr_reg(Wr_reg),
	 .sel_hora(sel_hora),
    .sel_reg_W(sel_reg_W), 
    .sel_LD(sel_LD), 
    .Cont_max(Cont_max)
    );
	 
Control_General Control_Gen (
    .reset(reset), 
    .clk(clk), 
    .Fin_W(Fin_W), 
    .Fin_L(Fin_L), 
    .Fin_I(Fin_I), 
    .SW_prog_clk(SW_prog_clk),
	 .SW_Activar(SW_Activar),
    .Inicio_W(Inicio_W), 
    .Inicio_L(Inicio_L), 
    .Inicio_I(Inicio_I),
	 .dir_sel(dir_sel)
    );

Control_Inicializar Ctrl_Iniciar (
    .Inicio_I(Inicio_I), 
    .clk(clk), 
    .reset(reset), 
    .Final_WR(Final_WR), 
    .Fin_I(Fin_I), 
    .Op_I(Op_I), 
    .I_I(I_I),
	 .AD_I(AD_I),
    .Addr_I(Addr_I), 
    .Data_I(Data_I)
    );

Control_Read Ctrl_Lectura (
    .Inicio_L(Inicio_L), 
    .clk(clk), 
    .reset(reset), 
    .Final_WR(Final_WR), 
    .Fin_L(Fin_L), 
    .Op_L(Op_L), 
    .I_L(I_L),
	 .AD_L(AD_L),
	 .sel_reg_L(sel_reg_L),
    .Addr_L(Addr_L)
    );	 

Control_Time_2 Ctrl_Tiempos (
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
	 
Control_programar Ctrl_Programar (
    .Inicio_W(Inicio_W), 
    .clk(clk), 
    .reset(reset), 
    .Final_WR(Final_WR), 
    .Fin_E(Fin_E), 
    .Fin_W(Fin_W), 
    .Op_W(Op_W), 
    .I_W(I_W), 
    .AD_W(AD_W), 
    .Inicio_E(Inicio_E), 
    .Addr_W(Addr_W), 
    .sel_prog(sel_prog), 
    .data_sel(data_sel)
    );

Mux_sel_reg mux_sel_reg (
    .sel_reg_W(sel_reg_W), 
    .sel_reg_L(sel_reg_L), 
    .selec(selec), 
    .sel_reg(sel_reg)
    );	 

endmodule
