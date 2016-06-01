`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    11:58:21 03/30/2016 
// Design Name: 
// Module Name:    Deco_lectura 
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
module Deco_lectura(
   input wire [4:0] ctrl_L,
	output reg Fin_L,Op_L,I_L,AD_L,
	output reg [3:0]Addr_L,sel_reg_L
    );
	 
always @* 
	
	case(ctrl_L)
	
		5'b00000: //a 
			begin		
			Fin_L=1;
			Op_L=0;
			I_L=0;
			AD_L=0;
			sel_reg_L=4'b0000;
			Addr_L=4'b0000;
			end
		
		5'b00001: //b 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b1111;
			Addr_L=4'b1101;
			end
			
		5'b00010: //c 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b1111;
			Addr_L=4'b1101;
			end
		
		5'b00011: //d 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0000;
			Addr_L=4'b0100;
			end
			
		5'b00100: //e 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0000;
			Addr_L=4'b0100;
			end
			
		5'b00101: //f 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0001;
			Addr_L=4'b0101;
			end
		
		5'b00110: //g 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0001;
			Addr_L=4'b0101;
			end
			
		5'b00111: //h 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0010;
			Addr_L=4'b0110;
			end
		
		5'b01000: //i 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0010;
			Addr_L=4'b0110;
			end
			
		5'b01001: //j 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0011;
			Addr_L=4'b0111;
			end
		
		5'b01010: //k 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0011;
			Addr_L=4'b0111;
			end
			
		5'b01011: //l 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0100;
			Addr_L=4'b1000;
			end
		
		5'b01100: //m 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0100;
			Addr_L=4'b1000;
			end
			
		5'b01101: //n 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0101;
			Addr_L=4'b1001;
			end
		
		5'b01110: //o 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0101;
			Addr_L=4'b1001;
			end
		
		5'b01111: //p 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0110;
			Addr_L=4'b1010;
			end
		
		5'b10000: //q 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0110;
			Addr_L=4'b1010;
			end
		
		5'b10001: //r 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b0111;
			Addr_L=4'b1011;
			end
		
		5'b10010: //s 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b0111;
			Addr_L=4'b1011;
			end
		
		5'b10011: //t 
			begin		
			Fin_L=0;
			Op_L=1;
			I_L=1;
			AD_L=0;
			sel_reg_L=4'b1000;
			Addr_L=4'b1100;
			end
		
		5'b10100: //u 
			begin		
			Fin_L=0;
			Op_L=0;
			I_L=1;
			AD_L=1;
			sel_reg_L=4'b1000;
			Addr_L=4'b1100;
			end
		
		5'b10101: //v 
			begin		
			Fin_L=1;
			Op_L=0;
			I_L=0;
			AD_L=0;
			sel_reg_L=4'b0000;
			Addr_L=4'b0000;
			end
		
		default:
			begin		
			Fin_L=1;
			Op_L=0;
			I_L=0;
			AD_L=0;
			sel_reg_L=4'b0000;
			Addr_L=4'b0000;
			end
		endcase

endmodule
