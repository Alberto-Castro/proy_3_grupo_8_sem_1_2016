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
module Prueba_Pico(input reset,clk,SF_Timer,SF_24_12,SF_AM_PM,PB_program_SA,PB_up_SA,PB_left_SA,PB_right_SA,PB_down_SA,
	input [2:0]PS2,
	input [3:0]sel,
	output wire A_D,RD,WR,CS,Read_Ready,
	output wire [3:0] anod,
	output wire [7:0] cat,
	inout  [7:0]io_port
    );

reg [7:0]num_display1,num_display;
wire [7:0] seg_VGA,min_VGA,hora_VGA,day_VGA,month_VGA,year_VGA,seg_t_VGA,min_t_VGA,hora_t_VGA;
reg [7:0]num1,num2,num3;

always @*
case (sel)
	4'b0000: num_display1 = seg_VGA;
	4'b0001: num_display1 = min_VGA;
	4'b0010: num_display1 = hora_VGA;
	4'b0011: num_display1 = day_VGA;
	4'b0100: num_display1 = month_VGA;
	4'b0101: num_display1 = year_VGA;
	4'b0110: num_display1 = seg_t_VGA;
	4'b0111: num_display1 = min_t_VGA;
	4'b1000: num_display1 = hora_t_VGA;
	default: num_display1 = 8'b00000000;
endcase

always @*
begin
	num1 = {4'b0,num_display1[3:0]};
	num2 = {2'b0,num_display1[7:4],2'b0};
	num3 = {3'b0,num_display1[7:4],1'b0};
	num_display = num1 + num2 + num3;
end
	

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

divisor_display display_clk (
    .clk(clk), 
    .reset(reset), 
    .D(D)
    );

Display display (
    .num_display(num_display), 
    .clk(D), 
    .reset(reset), 
    .anod(anod), 
    .cat(cat)
    );
	 
endmodule
