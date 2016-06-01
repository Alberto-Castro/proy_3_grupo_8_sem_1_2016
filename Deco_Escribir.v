`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:46 04/02/2016 
// Design Name: 
// Module Name:    Deco_Escribir 
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
module Deco_Escribir(
   input wire [4:0] ctrl_E,
	output reg Fin_E, Num_Ld,Wr_reg,sel_hora,
	output reg [3:0]sel_reg_W, sel_LD,
	output reg [6:0] Cont_max
    );

always @* 
	
	case(ctrl_E)
	
		5'b00000: //a 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=0;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0000000;
			end
		
		5'b00001: //b Empieza segundos
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0111011;
			end
			
		5'b00010: //c 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0111011;
			end
		
		5'b00011: //d Empieza minutos
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0001;
			sel_LD=4'b0001;
			Cont_max=7'b0111011;
			end
			
		5'b00100: //e 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0001;
			sel_LD=4'b0001;
			Cont_max=7'b0111011;
			end
			
		5'b00101: //f Empieza horas formato 24h
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=1;
			sel_reg_W=4'b0010;
			sel_LD=4'b0010;
			Cont_max=7'b0010111;
			end
		
		5'b00110: //g 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=1;
			sel_reg_W=4'b0010;
			sel_LD=4'b0010;
			Cont_max=7'b0010111;
			end
			
		5'b00111: //h Empieza dia
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0011;
			sel_LD=4'b0011;
			Cont_max=7'b0011111;
			end
		
		5'b01000: //i 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0011;
			sel_LD=4'b0011;
			Cont_max=7'b0011111;
			end
			
		5'b01001: //j Empieza mes
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0100;
			sel_LD=4'b0100;
			Cont_max=7'b0001100;
			end
		
		5'b01010: //k 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0100;
			sel_LD=4'b0100;
			Cont_max=7'b0001100;
			end
			
		5'b01011: //l Empieza año
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0101;
			sel_LD=4'b0101;
			Cont_max=7'b1100011;
			end
		
		5'b01100: //m 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0101;
			sel_LD=4'b0101;
			Cont_max=7'b1100011;
			end
			
		5'b01101: //n 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0101;
			sel_LD=4'b0101;
			Cont_max=7'b1100011;
			end
		
		5'b01110: //o Empieza seg timer
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0110;
			sel_LD=4'b0110;
			Cont_max=7'b0111011;
			end
		
		5'b01111: //p 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0110;
			sel_LD=4'b0110;
			Cont_max=7'b0111011;
			end
		
		5'b10000: //q empieza min timer
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0111;
			sel_LD=4'b0111;
			Cont_max=7'b0111011;
			end
		
		5'b10001: //r 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0111;
			sel_LD=4'b0111;
			Cont_max=7'b0111011;
			end
		
		5'b10010: //s Empieza hora timer
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b1000;
			sel_LD=4'b1000;
			Cont_max=7'b00010111;
			end
			
		5'b10011: //t 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b1000;
			sel_LD=4'b1000;
			Cont_max=7'b00010111;
			end
		
		5'b10100: //u 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0111011;
			end
		
		5'b10101: //v Termina de escribir
			begin		
			Fin_E=1;
			Num_Ld=0;
			Wr_reg=0;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0000000;
			end
		
		5'b10110: //w 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=0;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0000000;
			end
		
		5'b10111: //x Empieza hora formato 12h
			begin		
			Fin_E=0;
			Num_Ld=1;
			Wr_reg=1;
			sel_hora=1;
			sel_reg_W=4'b0010;
			sel_LD=4'b0010;
			Cont_max=7'b0001100;
			end
		
		5'b11000: //y 
			begin		
			Fin_E=0;
			Num_Ld=0;
			Wr_reg=1;
			sel_hora=1;
			sel_reg_W=4'b0010;
			sel_LD=4'b0010;
			Cont_max=7'b0001100;
			end
		
		default:
			begin		
			Fin_E=1;
			Num_Ld=0;
			Wr_reg=0;
			sel_hora=0;
			sel_reg_W=4'b0000;
			sel_LD=4'b0000;
			Cont_max=7'b0000000;
			end
		endcase
		
endmodule
