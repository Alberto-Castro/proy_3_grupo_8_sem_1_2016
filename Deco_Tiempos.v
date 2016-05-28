`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    12:21:19 03/28/2016 
// Design Name: 
// Module Name:    Deco_Tiempos 
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
module Deco_Tiempos(
	input wire [4:0] control_1,
	output reg A_D,RD,WR,CS,Dato_1,Dato_2,Final_WR
    );
	 
always @* 
	
	case(control_1)
	
		5'b00000: //a 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
		
		5'b00001: //b 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b00010: //c 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
		
		5'b00011: //d 
			begin		
			A_D=1;
			RD=0;
			WR=1;
			CS=0;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b00100: //e 
			begin		
			A_D=1;
			RD=0;
			WR=1;
			CS=0;
			Dato_1=1;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b00101: //f 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=1;
			Dato_2=0;
			Final_WR=0;
			end
		
		5'b00110: //g 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b00111: //h 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b01000: //i 
			begin		
			A_D=1;
			RD=1;
			WR=0;
			CS=0;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b01001: //j 
			begin		
			A_D=1;
			RD=1;
			WR=0;
			CS=0;
			Dato_1=0;
			Dato_2=1;
			Final_WR=0;
			end
			
		5'b01010: //k 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=1;
			Final_WR=0;
			end
			
		5'b01011: //l 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;;
			Final_WR=0;
			end
			
		5'b01100: //m 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=1;
			end
			
		5'b01101: //n 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
		
		5'b01110: //o 
			begin		
			A_D=0;
			RD=1;
			WR=0;
			CS=0;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b01111: //p 
			begin		
			A_D=0;
			RD=1;
			WR=0;
			CS=0;
			Dato_1=0;
			Dato_2=1;
			Final_WR=0;
			end
			
		5'b10000: //q 
			begin		
			A_D=0;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=1;
			Final_WR=0;
			end
			
		5'b10001: //r 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;;
			Final_WR=0;
			end
			
		5'b10010: //s 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
			
		5'b10011: //t 
			begin		
			A_D=0;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
		
		5'b10100: //u 
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
		
		default:
			begin		
			A_D=1;
			RD=1;
			WR=1;
			CS=1;
			Dato_1=0;
			Dato_2=0;
			Final_WR=0;
			end
		endcase

endmodule
