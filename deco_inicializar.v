`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    18:28:05 03/30/2016 
// Design Name: 
// Module Name:    deco_inicializar 
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
module deco_inicializar(
	input wire [3:0] ctrl_I,
	output reg Fin_I,Op_I,I_I,AD_I,
	output reg [3:0]Addr_I,
	output reg [7:0]Data_I
    );

always @* 
	
	case(ctrl_I)
	
		4'b0000: //a 
			begin		
			Fin_I=1;
			Op_I=0;
			I_I=0;
			AD_I=0;
			Addr_I=4'b0000;
			Data_I=8'b00000000;
			end
		
		4'b0001: //b 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=0;
			Addr_I=4'b0010;
			Data_I=8'b00010000;
			end
			
		4'b0010: //c 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=1;
			Addr_I=4'b0010;
			Data_I=8'b00010000;
			end
		
		4'b0011: //d 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=0;
			Addr_I=4'b0010;
			Data_I=8'b00000000;
			end
			
		4'b0100: //e 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=1;
			Addr_I=4'b0010;
			Data_I=8'b00000000;
			end
			
		4'b0101: //f 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=0;
			Addr_I=4'b0011;
			Data_I=8'b11010010;
			end
		
		4'b0110: //g 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=1;
			Addr_I=4'b0011;
			Data_I=8'b11010010;
			end
			
		4'b0111: //h 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=0;
			Addr_I=4'b0000;
			Data_I=8'b00000000;
			end
		
		4'b1000: //i 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=1;
			Addr_I=4'b0000;
			Data_I=8'b00000000;
			end
			
		4'b1001: //j 
			begin		
			Fin_I=1;
			Op_I=0;
			I_I=0;
			AD_I=0;
			Addr_I=4'b0000;
			Data_I=8'b00000000;
			end
		
		4'b1010: //k 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=0;
			Addr_I=4'b0001;
			Data_I=8'b00000100;
			end
		
		4'b1011: //l 
			begin		
			Fin_I=0;
			Op_I=1;
			I_I=1;
			AD_I=1;
			Addr_I=4'b0001;
			Data_I=8'b00000100;
			end
		
		default:
			begin		
			Fin_I=1;
			Op_I=1;
			I_I=0;
			AD_I=0;
			Addr_I=4'b0000;
			Data_I=8'b00000000;
			end
		endcase
		
endmodule
