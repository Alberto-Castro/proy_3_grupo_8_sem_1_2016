`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    12:16:51 03/28/2016 
// Design Name: 
// Module Name:    Maquina_Tiempos 
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
module Maquina_Tiempos(
	input wire clk,reset,I,OP,AD,
	output wire [4:0]control_1
    );
	 
wire [4:0]conta_1;
wire reset_clk;
reg reset_c;
	
Contador_4bits contador (
    .clk(clk), 
    .reset_clk(reset_clk), 
    .conta_1(conta_1)
    );

// salidas las cuales irán al decodificador
reg [4:0] control_A,control_N;
reg [4:0] Est_Actual,Est_Sig;
localparam [4:0] a=5'b00000,b=5'b00001,c=5'b00010,d=5'b00011,e=5'b00100,f=5'b00101,g=5'b00110,h=5'b00111,i=5'b01000,j=5'b01001,k=5'b01010,l=5'b01011,m=5'b01100,n=5'b01101,o=5'b01110,p=5'b01111,q=5'b10000,r=5'b10001,s=5'b10010,t=5'b10011,u=5'b10100;

//Parte Secuencial

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
				if (I)
					begin
					Est_Sig=b;
					reset_c=0;
					end
				else
					begin
					Est_Sig=a;
					reset_c=1;
					end 
			end 
			
			b:
			begin
			   control_N=5'b00001;
				if (AD)
					begin
					Est_Sig=c;
					reset_c=1;
					end
				else
					begin
					Est_Sig=t;
					reset_c=1;
					end
			end
			
			c:
			begin 
				control_N=5'b00010;
				if (OP)
					begin
					Est_Sig=i;
					reset_c=0;
					end
				else
					begin
					Est_Sig=d;
					reset_c=0;
					end
			end
			
			d:
			begin
				control_N=5'b00011;
				if (conta_1==5'd5)
					begin
					Est_Sig=e;
					reset_c=0;
					end
				else
					begin
					Est_Sig=d;
					reset_c=0;
					end
			end
					
			
			e:
			begin
				control_N=5'b00100;
				if (conta_1==5'd10)
					begin
					Est_Sig=f;
					reset_c=0;
					end
				else
					begin
					Est_Sig=e;
					reset_c=0;
					end
			end
					
			f:
			begin
				control_N=5'b00101;
				if (conta_1==5'd13)
					begin
					Est_Sig=g;
					reset_c=0;
					end
				else
					begin
					Est_Sig=f;
					reset_c=0;
					end
			end
			
			g:
			begin
				control_N=5'b00110;
				if (conta_1==5'd18)
					begin
					Est_Sig=h;
					reset_c=0;
					end
				else
					begin
					Est_Sig=g;
					reset_c=0;
					end
			end
			
			h:
			begin
				control_N=5'b00111;
				if (conta_1==5'd20)
					begin
					Est_Sig=m;
					reset_c=0;
					end
				else
					begin
					Est_Sig=h;
					reset_c=0;
					end
			end
			
			i:
			begin
				control_N=5'b01000;
				Est_Sig=j;
				reset_c=0;
			end
			
			j:
			begin
				control_N=5'b01001;
				if (conta_1==5'd9)
					begin
					Est_Sig=k;
					reset_c=0;
					end
				else
					begin
					Est_Sig=j;
					reset_c=0;
					end
			end
			
			k:
			begin
				control_N=5'b01010;
				if (conta_1==5'd10)
					begin
					Est_Sig=l;
					reset_c=0;
					end
				else
					begin
					Est_Sig=k;
					reset_c=0;
					end
			end
			
			l:
			begin
				control_N=5'b01011;
				Est_Sig=n;//lo mismo que h en el deco
				reset_c=0;
			end
			
			m:
			begin
				control_N=5'b01100;
				if (conta_1==5'd21)
					begin
					Est_Sig=u;
					reset_c=0;
					end
				else
					begin
					Est_Sig=m;
					reset_c=0;
					end
			end
			
			n:
			begin
				control_N=5'b01101;
				if (conta_1==5'd20)
					begin
					Est_Sig=m;
					reset_c=0;
					end
				else
					begin
					Est_Sig=n;
					reset_c=0;
					end
			end
			
			o:
			begin
				control_N=5'b01110;
				Est_Sig=p;
				reset_c=0;
			end
			
			p:
			begin
				control_N=5'b01111;
				if (conta_1==5'd9)
					begin
					Est_Sig=q;
					reset_c=0;
					end
				else
					begin
					Est_Sig=p;
					reset_c=0;
					end
			end
			
			q:
			begin
				control_N=5'b10000;
				if (conta_1==5'd10)
					begin
					Est_Sig=r;
					reset_c=0;
					end
				else
					begin
					Est_Sig=q;
					reset_c=0;
					end
			end
			
			r:
			begin
				control_N=5'b10001;
				Est_Sig=s;//lo mismo que h en el deco
				reset_c=0;
			end
			
			s:
			begin
				control_N=5'b10010;
				if (conta_1==5'd20)
					begin
					Est_Sig=m;
					reset_c=0;
					end
				else
					begin
					Est_Sig=s;
					reset_c=0;
					end
			end
			
			t:
			begin
				control_N=5'b10011;
				if (conta_1==5'd1)
					begin
					Est_Sig=o;
					reset_c=0;
					end
				else
					begin
					Est_Sig=t;
					reset_c=0;
					end
			end
			
			u:
			begin
				control_N=5'b10100;
				if (conta_1==5'd23)
					begin
					Est_Sig=a;
					reset_c=1;
					end
				else
					begin
					Est_Sig=u;
					reset_c=0;
					end
			end
			
			default:
			begin
				Est_Sig=a;
				reset_c=0;
			end
			
			endcase
		
		end
				
assign control_1=control_A;
assign reset_clk = reset_c;

endmodule
