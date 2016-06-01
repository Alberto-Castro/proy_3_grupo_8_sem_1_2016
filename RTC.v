`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro 
// 
// Create Date:    18:11:42 04/06/2016 
// Design Name: 
// Module Name:    RTC 
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
module RTC(
	input wire reset,clk,
	input wire SW_prog_clk,SF_Timer,SF_24_12,SW_Activar,SF_AM_PM,//switches
	input wire PB_left_SA,PB_right_SA,PB_program_SA,PB_up_SA,PB_down_SA,//botones
	output wire A_D,RD,WR,CS,
	output wire [7:0] seg_VGA,min_VGA,hora_VGA,day_VGA,month_VGA,year_VGA,seg_t_VGA,min_t_VGA,hora_t_VGA,
	inout  [7:0]io_port
    );

wire Num_Ld, Dato_1, Dato_2,Wr_reg,AD_M,En,sel_hora,PB_left,PB_right,PB_up,PB_down,PB_program;
wire [6:0] Cont_max;
wire [7:0] seg,min,hora,day,month,year,seg_t,min_t,hora_t,Data_I,data_in,data_out,data_save,Data, Address,Wr_BCD;
wire [3:0] sel_LD,Addr_L,Addr_W,Addr_I,sel_prog,sel_reg;
wire [1:0] dir_sel, data_sel;

assign En = Wr_reg || Dato_1;

//Anti rebote para los botones
Botones_Entrada AR_up (
    .clk(clk), 
    .reset(reset), 
    .D(PB_up_SA), 
    .Entrada(PB_up)
    );
Botones_Entrada AR_down (
    .clk(clk), 
    .reset(reset), 
    .D(PB_down_SA), 
    .Entrada(PB_down)
    );
Botones_Entrada AR_left (
    .clk(clk), 
    .reset(reset), 
    .D(PB_left_SA), 
    .Entrada(PB_left)
    );
Botones_Entrada AR_right (
    .clk(clk), 
    .reset(reset), 
    .D(PB_right_SA), 
    .Entrada(PB_right)
    );
Botones_Entrada AR_program (
    .clk(clk), 
    .reset(reset), 
    .D(PB_program_SA), 
    .Entrada(PB_program)
    );

/////////////////////////////////////

BUS_IO2 Bus_Datos(
    .clk(clk), 
    .Dato_1(Dato_1), 
    .Dato_2(Dato_2), 
    .data_in(data_in), 
    .data_out(data_out), 
    .io_port(io_port)
    );
	 
Control Control_General (
    .reset(reset), 
    .clk(clk), 
    .SW_prog_clk(SW_prog_clk), 
    .PB_left(PB_left), 
    .PB_right(PB_right), 
    .PB_program(PB_program), 
    .SF_Timer(SF_Timer), 
    .SF_24_12(SF_24_12),
	 .SW_Activar(SW_Activar),
    .Num_Ld(Num_Ld), 
    .Wr_reg(Wr_reg), 
    .A_D(A_D), 
    .RD(RD), 
    .WR(WR), 
    .CS(CS),
	 .AD_M(AD_M),
    .Dato_1(Dato_1), 
    .Dato_2(Dato_2), 
    .sel_reg(sel_reg), 
    .sel_LD(sel_LD), 
    .Addr_W(Addr_W), 
	 .sel_hora(sel_hora),
    .sel_prog(sel_prog), 
    .Addr_L(Addr_L), 
    .Addr_I(Addr_I), 
    .Cont_max(Cont_max), 
    .data_sel(data_sel),
	 .dir_sel(dir_sel),
    .Data_I(Data_I)
    );
	 
Registro_VGA Registros (
    .clk(clk), 
    .reset(reset), 
    .sel_reg(sel_reg), 
    .data_save(data_save),
	 .En(En),
    .seg(seg), 
    .min(min), 
    .hora(hora), 
    .day(day), 
    .month(month), 
    .year(year), 
    .seg_t(seg_t), 
    .min_t(min_t), 
    .hora_t(hora_t)
    );

mux_data_address Mux_AD (
    .Data(Data), 
    .Address(Address), 
    .AD_M(AD_M), 
    .data_in(data_in)
    );

Escritura Mod_Escribir (
    .Num_Ld(Num_Ld), 
    .PB_up(PB_up), 
    .PB_down(PB_down), 
    .clk(clk), 
    .reset(reset), 
    .SF_24_12(SF_24_12),
	 .SF_AM_PM(SF_AM_PM),
	 .sel_hora(sel_hora),
    .SF_Timer(SF_Timer), 
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
    .Data_I(Data_I), 
    .sel_LD(sel_LD), 
    .Addr_L(Addr_L), 
    .Addr_W(Addr_W), 
    .Addr_I(Addr_I), 
    .sel_prog(sel_prog), 
    .dir_sel(dir_sel), 
    .data_sel(data_sel), 
    .Data(Data), 
    .Address(Address), 
    .Wr_BCD(Wr_BCD)
    );

mux_reg Mod_Leer (
    .data_out(data_out), 
    .Wr_BCD(Wr_BCD), 
    .Wr_reg(Wr_reg), 
    .data_save(data_save)
    );	 

assign seg_VGA = seg;
assign min_VGA = min;
assign hora_VGA = hora;
assign day_VGA = day;
assign month_VGA = month;
assign year_VGA = year;
assign seg_t_VGA = seg_t;
assign min_t_VGA = min_t;
assign hora_t_VGA = hora_t;

endmodule
