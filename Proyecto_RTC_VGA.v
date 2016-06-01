`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:13 04/15/2016 
// Design Name: 
// Module Name:    Proyecto_RTC_VGA 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:51 03/30/2016 
// Design Name: 
// Module Name:    top_vga 
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
module Proyecto_RTC_VGA(
	input wire reset,clk, 
	input wire SW_prog_clk,SF_Timer,SF_24_12,SW_Activar,SF_AM_PM, IRQ1,//switches
	input wire PB_left_SA,PB_right_SA,PB_program_SA,PB_up_SA,PB_down_SA,//botones
	output wire A_D,RD,WR,CS,
	output wire hsync,vsync,
	output wire [2:0] text_rgb,
	output wire clk2,
	inout  [7:0]io_port
    );
	 
	 
wire IRQ;
wire [3:0] digUH, digDH, digUM, digDM, digUS, digDS, digUD, digDD, digUME, digDME, digUA, digDA, digUHC, digDHC, digUMC, digDMC, digUSC, digDSC;
wire [7:0] seg_VGA,min_VGA,hora_VGA,day_VGA,month_VGA,year_VGA,seg_t_VGA,min_t_VGA,hora_t_VGA;
wire horasiete, horasiete2;

assign clk2 = clk;
assign IRQ = ~IRQ1;
assign horasiete = SF_24_12 && ~hora_VGA[7];
assign horasiete2 = SF_24_12 && hora_VGA[7];
assign digUH = hora_VGA[3:0];
assign digDH = {1'b0,hora_VGA[6:4]};
assign digUM = min_VGA[3:0];
assign digDM = min_VGA[7:4];
assign digUS = seg_VGA[3:0];
assign digDS = seg_VGA[7:4];
assign digUD = day_VGA[3:0];
assign digDD = day_VGA[7:4];
assign digUME = month_VGA[3:0];
assign digDME = month_VGA[7:4];
assign digUA = year_VGA[3:0];
assign digDA = year_VGA[7:4];
assign digUHC = hora_t_VGA[3:0];
assign digDHC = hora_t_VGA[7:4];
assign digUMC = min_t_VGA[3:0];
assign digDMC = min_t_VGA[7:4];
assign digUSC = seg_t_VGA[3:0];
assign digDSC = seg_t_VGA[7:4];

RTC Modulo_RTC (
    .reset(reset), 
    .clk(clk), 
    .SW_prog_clk(SW_prog_clk), 
    .SF_Timer(SF_Timer), 
    .SF_24_12(SF_24_12), 
    .SW_Activar(SW_Activar), 
    .SF_AM_PM(SF_AM_PM), 
    .PB_left_SA(PB_left_SA), 
    .PB_right_SA(PB_right_SA), 
    .PB_program_SA(PB_program_SA), 
    .PB_up_SA(PB_up_SA), 
    .PB_down_SA(PB_down_SA), 
    .A_D(A_D), 
    .RD(RD), 
    .WR(WR), 
    .CS(CS), 
    .seg_VGA(seg_VGA), 
    .min_VGA(min_VGA), 
    .hora_VGA(hora_VGA), 
    .day_VGA(day_VGA), 
    .month_VGA(month_VGA), 
    .year_VGA(year_VGA), 
    .seg_t_VGA(seg_t_VGA), 
    .min_t_VGA(min_t_VGA), 
    .hora_t_VGA(hora_t_VGA), 
    .io_port(io_port)
    );
	 
top_vga Modulo_VGA (
    .clk(clk), 
	 .IRQ(IRQ),
	 .horasiete(horasiete),
	 .horasiete2(horasiete2),
    .reset(reset), 
    .digUH(digUH), 
    .digDH(digDH), 
    .digUM(digUM), 
    .digDM(digDM), 
    .digUS(digUS), 
    .digDS(digDS), 
    .digUD(digUD), 
    .digDD(digDD), 
    .digUME(digUME), 
    .digDME(digDME), 
    .digUA(digUA), 
    .digDA(digDA), 
    .digUHC(digUHC), 
    .digDHC(digDHC), 
    .digUMC(digUMC), 
    .digDMC(digDMC), 
    .digUSC(digUSC), 
    .digDSC(digDSC), 
    .hsync(hsync), 
    .vsync(vsync), 
    .text_rgb(text_rgb)
    );
endmodule
