`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    21:44:40 03/29/2016 
// Design Name: 
// Module Name:    FMS_lectura 
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
module FMS_lectura(
    input wire Inicio_L, clk, reset, Final_WR,
	 output wire [4:0] ctrl_L
	 );
	 
	 reg [4:0] control_A,control_N;
	 reg [4:0] Est_Actual,Est_Sig;
	 localparam [4:0] a=5'b00000,b=5'b00001,c=5'b00010,d=5'b00011,e=5'b00100,f=5'b00101,g=5'b00110,h=5'b00111,i=5'b01000,j=5'b01001,k=5'b01010,l=5'b01011,m=5'b01100,n=5'b01101,o=5'b01110,p=5'b01111,q=5'b10000,r=5'b10001,s=5'b10010,t=5'b10011,u=5'b10100,v=5'b10101;
	 
always @ (posedge clk, posedge reset)
	begin 
		if (reset)
			begin
			Est_Actual=5'b0;
			control_A=5'b0;
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
			   control_N=5'b00000;
				if (Inicio_L)
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
				control_N=5'b00001;
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
				control_N=5'b00010;
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
				control_N=5'b00011;
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
				control_N=5'b00100;
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
				control_N=5'b00101;
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
				control_N=5'b00110;
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
				control_N=5'b00111;
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
				control_N=5'b01000;
				if (Final_WR)
					begin
					Est_Sig=j;
					end
				else
					begin
					Est_Sig=i;
					end
			end
			
			j:
			begin 
				control_N=5'b01001;
				if (Final_WR)
					begin
					Est_Sig=k;
					end
				else
					begin
					Est_Sig=j;
					end
			end
			
			k:
			begin 
				control_N=5'b01010;
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
				control_N=5'b01011;
				if (Final_WR)
					begin
					Est_Sig=m;
					end
				else
					begin
					Est_Sig=l;
					end
			end
			
			m:
			begin 
				control_N=5'b01100;
				if (Final_WR)
					begin
					Est_Sig=n;
					end
				else
					begin
					Est_Sig=m;
					end
			end
			
			n:
			begin 
				control_N=5'b01101;
				if (Final_WR)
					begin
					Est_Sig=o;
					end
				else
					begin
					Est_Sig=n;
					end
			end
			
			o:
			begin 
				control_N=5'b01110;
				if (Final_WR)
					begin
					Est_Sig=p;
					end
				else
					begin
					Est_Sig=o;
					end
			end
			
			p:
			begin 
				control_N=5'b01111;
				if (Final_WR)
					begin
					Est_Sig=q;
					end
				else
					begin
					Est_Sig=p;
					end
			end
			
			q:
			begin 
				control_N=5'b10000;
				if (Final_WR)
					begin
					Est_Sig=r;
					end
				else
					begin
					Est_Sig=q;
					end
			end
			
			r:
			begin 
				control_N=5'b10001;
				if (Final_WR)
					begin
					Est_Sig=s;
					end
				else
					begin
					Est_Sig=r;
					end
			end
			
			s:
			begin 
				control_N=5'b10010;
				if (Final_WR)
					begin
					Est_Sig=t;
					end
				else
					begin
					Est_Sig=s;
					end
			end
			
			t:
			begin 
				control_N=5'b10011;
				if (Final_WR)
					begin
					Est_Sig=u;
					end
				else
					begin
					Est_Sig=t;
					end
			end
			
			u:
			begin 
				control_N=5'b10100;
				if (Final_WR)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=u;
					end
			end
			
			v:
				begin 
				control_N=5'b10101;
				Est_Sig=a;
				end
			
			default:Est_Sig=a;
			endcase
		
		end
				
assign ctrl_L = control_A;

endmodule
