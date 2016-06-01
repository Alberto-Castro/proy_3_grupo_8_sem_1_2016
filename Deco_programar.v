`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:25 04/02/2016 
// Design Name: 
// Module Name:    Deco_programar 
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
module Deco_programar(
   input wire [4:0] ctrl_W,
	output reg Fin_W,Op_W,I_W,AD_W,Inicio_E,
	output reg [3:0] Addr_W,sel_prog,
	output reg [1:0] data_sel
    );

always @* 
	
	case(ctrl_W)
	
		5'b00000: //a 
			begin		
			Fin_W=1;
			Op_W=0;
			I_W=0;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b10;
			end
		
		5'b00001: //b 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0100;
			sel_prog=4'b0000;
			data_sel=2'b11;
			end
			
		5'b00010: //c 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b0100;
			sel_prog=4'b0000;
			data_sel=2'b11;
			end
		
		5'b00011: //d 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0101;
			sel_prog=4'b0001;
			data_sel=2'b11;
			end
			
		5'b00100: //e 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b0101;
			sel_prog=4'b0001;
			data_sel=2'b11;
			end
			
		5'b00101: //f 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0110;
			sel_prog=4'b0010;
			data_sel=2'b11;
			end
		
		5'b00110: //g 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b0110;
			sel_prog=4'b0010;
			data_sel=2'b11;
			end
			
		5'b00111: //h 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0111;
			sel_prog=4'b0011;
			data_sel=2'b11;
			end
		
		5'b01000: //i 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b0111;
			sel_prog=4'b0011;
			data_sel=2'b11;
			end
			
		5'b01001: //j 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1000;
			sel_prog=4'b0100;
			data_sel=2'b11;
			end
		
		5'b01010: //k 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1000;
			sel_prog=4'b0100;
			data_sel=2'b11;
			end
			
		5'b01011: //l 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1001;
			sel_prog=4'b0101;
			data_sel=2'b11;
			end
		
		5'b01100: //m 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1001;
			sel_prog=4'b0101;
			data_sel=2'b11;
			end
			
		5'b01101: //n 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1010;
			sel_prog=4'b0110;
			data_sel=2'b11;
			end
		
		5'b01110: //o 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1010;
			sel_prog=4'b0110;
			data_sel=2'b11;
			end
		
		5'b01111: //p 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1011;
			sel_prog=4'b0111;
			data_sel=2'b11;
			end
		
		5'b10000: //q 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1011;
			sel_prog=4'b0111;
			data_sel=2'b11;
			end
		
		5'b10001: //r 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1100;
			sel_prog=4'b1000;
			data_sel=2'b11;
			end
		
		5'b10010: //s 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1100;
			sel_prog=4'b1000;
			data_sel=2'b11;
			end
		
		5'b10011: //t 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1101;
			sel_prog=4'b1001;
			data_sel=2'b11;
			end
		
		5'b10100: //u 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1101;
			sel_prog=4'b1001;
			data_sel=2'b11;
			end
		
		5'b10101: //v 
			begin		
			Fin_W=1;
			Op_W=0;
			I_W=0;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b10;
			end
		
		5'b10110: //w 
			begin		
			Fin_W=0;
			Op_W=0;
			I_W=0;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b00;
			end
		
		5'b10111: //x 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b00;
			end
		
		5'b11000: //y 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b01;
			end
		
		5'b11001: //z 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b01;
			end
		
		5'b11010: //A 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b00;
			end
		
		5'b11011: //B 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b1101;
			sel_prog=4'b0000;
			data_sel=2'b11;
			end
		
		5'b11100: //C 
			begin		
			Fin_W=0;
			Op_W=1;
			I_W=1;
			AD_W=1;
			Inicio_E=0;
			Addr_W=4'b1101;
			sel_prog=4'b0000;
			data_sel=2'b11;
			end
		
		5'b11101: //D 
			begin		
			Fin_W=0;
			Op_W=0;
			I_W=0;
			AD_W=0;
			Inicio_E=1;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b00;
			end
		
		default:
			begin		
			Fin_W=1;
			Op_W=1;
			I_W=0;
			AD_W=0;
			Inicio_E=0;
			Addr_W=4'b0000;
			sel_prog=4'b0000;
			data_sel=2'b10;
			end
		endcase
		
endmodule
