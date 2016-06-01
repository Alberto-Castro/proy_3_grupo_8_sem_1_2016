`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:35:48 06/01/2016 
// Design Name: 
// Module Name:    Interfaz_PS2_RTC 
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
module Interfaz_PS2_RTC(input [7:0]key_code,
	input listo,clk,reset,
	output reg var,
	output reg [2:0]PS2,
	output reg SF_Timer,SF_24_12,SF_AM_PM,PB_program_SA,PB_up_SA,PB_left_SA,PB_right_SA,PB_down_SA
    );

reg [7:0]Tecla_leida;
reg [1:0] Est_Actual,Est_Sig;
reg listo1;

always @ (posedge clk, posedge reset)
begin 
	if (reset)
		begin
		Est_Actual=2'b00;
		end
	else
		begin
		Est_Actual=Est_Sig;
		end
end 

always @*
begin
	Est_Sig=Est_Actual;
	case (Est_Actual)
		2'b00: 
		begin
			listo1 = 1'b0;
			var = 1'b0;
			if (listo)
				Est_Sig = 2'b01;
			else
			begin
				Est_Sig = 2'b00;
			end
		end
		2'b01:
		begin 
			listo1 = 1'b1;
			var = 1'b1;
			Est_Sig = 2'b10;
		end
		2'b10:
		begin
			listo1 = 1'b0;
			var = 1'b0;
			Est_Sig = 2'b00;
		end 
		default: 
		begin
			Est_Sig = 2'b00;
			listo1 = 1'b0;
			var = 1'b0;
		end
	endcase
end

always @(posedge clk)
begin
	if (reset)
		Tecla_leida = 8'b00000001;
	else
	begin
		if (listo1)
			Tecla_leida = key_code;
		else
			Tecla_leida = 8'b0;
	end
end

always @*
	case(Tecla_leida)
		8'h00:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h01:begin
			PS2 = 3'b000;
			SF_Timer = 1'b0;
			SF_24_12 = 1'b0;
			SF_AM_PM = 1'b0;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h1d:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b1;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h1b:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b1;
		end
		8'h23:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b1;
			PB_down_SA = 1'b0;
		end
		8'h1c:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b1;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h24:begin
			PS2 = 3'b010;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h2d:begin
			PS2 = 3'b100;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h2b:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = ~SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h2a:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = ~SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h43:begin
			PS2 = 3'b100;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h4d:begin
			PS2 = 3'b000;
			SF_Timer = SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b1;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		8'h2c:begin
			PS2 = 3'b000;
			SF_Timer = ~SF_Timer;
			SF_24_12 = SF_24_12;
			SF_AM_PM = SF_AM_PM;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
		default:begin
			PS2 = 3'b000;
			SF_Timer = 1'b0;
			SF_24_12 = 1'b0;
			SF_AM_PM = 1'b0;
			PB_program_SA = 1'b0;
			PB_up_SA = 1'b0;
			PB_left_SA = 1'b0;
			PB_right_SA = 1'b0;
			PB_down_SA = 1'b0;
		end
	endcase

endmodule
