`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G.
// 
// Create Date:    18:24:14 03/30/2016 
// Design Name: 
// Module Name:    FMS_Inicializar 
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
module FMS_Inicializar(
	input wire Inicio_I,clk,reset,Final_WR,
	output wire [3:0] ctrl_I
    );
	reg [3:0] control_A,control_N;
	reg [3:0] Est_Actual,Est_Sig;
	localparam [3:0] a=4'b0000,b=4'b0001,c=4'b0010,d=4'b0011,e=4'b0100,f=4'b0101,g=4'b0110,h=4'b0111,i=4'b1000,j=4'b1001,k=4'b1010,l=4'b1011;
	 
always @ (posedge clk, posedge reset)
	begin 
		if (reset)
			begin
			Est_Actual=4'b0;
			control_A=4'b0;
			end
		else
			begin
			Est_Actual=Est_Sig;
			control_A=control_N;
			end
	end 

always @* 
	begin
	Est_Sig=Est_Actual;
	control_N=control_A;
	case(Est_Actual)
			a:
			begin
			   control_N=4'b0000;
				if (Inicio_I)
					begin
					Est_Sig=b;
					end
				else
					begin
					Est_Sig=a;
					end 
			end 
			
			b:
			begin 
				control_N=4'b0001;
				if (Final_WR)
					begin
					Est_Sig=c;
					end
				else
					begin
					Est_Sig=b;
					end
			end
			c:
			begin 
				control_N=4'b0010;
				if (Final_WR)
					begin
					Est_Sig=d;
					end
				else
					begin
					Est_Sig=c;
					end
			end
			
			d:
			begin 
				control_N=4'b0011;
				if (Final_WR)
					begin
					Est_Sig=e;
					end
				else
					begin
					Est_Sig=d;
					end
			end
			
			e:
			begin 
				control_N=4'b0100;
				if (Final_WR)
					begin
					Est_Sig=f;
					end
				else
					begin
					Est_Sig=e;
					end
			end
					
			f:
			begin 
				control_N=4'b0101;
				if (Final_WR)
					begin
					Est_Sig=g;
					end
				else
					begin
					Est_Sig=f;
					end
			end
			
			g:
			begin 
				control_N=4'b0110;
				if (Final_WR)
					begin
					Est_Sig=h;
					end
				else
					begin
					Est_Sig=g;
					end
			end
			
			h:
			begin
				control_N=4'b0111;
				if (Final_WR)
					begin
					Est_Sig=i;
					end
				else
					begin
					Est_Sig=h;
					end
			end
			
			i:
			begin 
				control_N=4'b1000;
				if (Final_WR)
					begin
					Est_Sig=k;
					end
				else
					begin
					Est_Sig=i;
					end
			end
			
			j:
			begin 
				control_N=4'b1001;
				Est_Sig=a;
			end
			
			k:
			begin
				control_N=4'b1010;
				if (Final_WR)
					begin
					Est_Sig=l;
					end
				else
					begin
					Est_Sig=k;
					end
			end
			
			l:
			begin 
				control_N=4'b1011;
				if (Final_WR)
					begin
					Est_Sig=j;
					end
				else
					begin
					Est_Sig=l;
					end
			end
			
			default:Est_Sig=a;
			endcase
		
		end
				
assign ctrl_I = control_A;


endmodule
