`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:00:37 05/31/2016 
// Design Name: 
// Module Name:    Prueba_Pico 
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
module Prueba_Pico(input clk,
	input wire ps2d, ps2c,
	output wire [7:0]  rgb,
	output wire hsync_o, vsync_o,
	output wire A_D,RD,WR,CS,
	inout  [7:0]io_port
    );

wire [7:0] seg_VGA,min_VGA,hora_VGA,day_VGA,month_VGA,year_VGA,seg_t_VGA,min_t_VGA,hora_t_VGA;
wire [3:0] digUH, digDH, digUM, digDM, digUS, digDS, digUD, digDD, digUME, digDME, digUA, digDA, digUHC, digDHC, digUMC, digDMC, digUSC, digDSC;
wire reset;
wire [7:0]key_code;
wire listo,SF_Timer,SF_24_12,SF_AM_PM,PB_program_SA,PB_up_SA,PB_left_SA,PB_right_SA,PB_down_SA;
wire [2:0]PS2;

assign reset = PS2[2];
assign digUH = hora_VGA[3:0];
assign digDH = hora_VGA[7:4];
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

Interfaz_PS2_RTC PS2_RTC (
    .key_code(key_code), 
    .listo(listo), 
    .clk(clk), 
    .reset(reset), 
    .var(var), 
    .PS2(PS2), 
    .SF_Timer(SF_Timer), 
    .SF_24_12(SF_24_12), 
    .SF_AM_PM(SF_AM_PM), 
    .PB_program_SA(PB_program_SA), 
    .PB_up_SA(PB_up_SA), 
    .PB_left_SA(PB_left_SA), 
    .PB_right_SA(PB_right_SA), 
    .PB_down_SA(PB_down_SA)
    );

kb_code modulo_PS2 (
    .clk(clk), 
    .reset(reset), 
    .var(var), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .rd_key_code(rd_key_code), 
    .key_code(key_code), 
    .listo(listo)
    );

RTC RTC (
    .reset(reset), 
    .clk(clk), 
    .SF_Timer(SF_Timer), 
    .SF_24_12(SF_24_12), 
    .SF_AM_PM(SF_AM_PM), 
    .PB_program_SA(PB_program_SA), 
    .PB_up_SA(PB_up_SA), 
    .PB_left_SA(PB_left_SA), 
    .PB_right_SA(PB_right_SA), 
    .PB_down_SA(PB_down_SA), 
    .PS2(PS2), 
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

MainActivity VGA(
    .rgb(rgb), 
    .clk_i(clk), 
    .reset_i(reset), 
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
    .hsync_o(hsync_o), 
    .vsync_o(vsync_o)
    );
	 
endmodule
