`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:23 04/02/2016 
// Design Name: 
// Module Name:    FMS_Escribir 
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
module FMS_Escribir(
    input wire Inicio_E,PB_left,PB_right,PB_program,SF_Timer,SF_24_12,clk, reset,
	 output wire [4:0] ctrl_E
	 );
	 
	 reg [4:0] control_A,control_N;
	 reg [4:0] Est_Actual,Est_Sig;
	 localparam [4:0] a=5'b00000,b=5'b00001,c=5'b00010,d=5'b00011,e=5'b00100,f=5'b00101,g=5'b00110,h=5'b00111,i=5'b01000,j=5'b01001,k=5'b01010,l=5'b01011,m=5'b01100,n=5'b01101,o=5'b01110,p=5'b01111,q=5'b10000,r=5'b10001,s=5'b10010,t=5'b10011,u=5'b10100,v=5'b10101,w=5'b10110,x=5'b10111,y=5'b11000;
	 
always @ (posedge clk, posedge reset)
	begin 
		if (reset)
			begin
			Est_Actual=6'b0;
			control_A=6'b0;
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
				if (Inicio_E)
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
				Est_Sig=c;
			end 
			
			c://escribe segundos
			begin 
				control_N=5'b00010;
				if (PB_right)
					begin
					Est_Sig=d;
					end
				else if (PB_left)
					begin
					Est_Sig=u;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=c;
					end
			end
			
			d:
			begin
			   control_N=5'b00011;
				Est_Sig=e;
			end 
			
			e://escribe minutos
			begin 
				control_N=5'b00100;
				if (PB_right)
					begin
					Est_Sig=w;
					end
				else if (PB_left)
					begin
					Est_Sig=b;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=e;
					end
			end
			
			f:
			begin 
				control_N=5'b00101;
				Est_Sig=g;
			end
					
			g://escribe horas
			begin 
				control_N=5'b00110;
				if (PB_right)
					begin
					Est_Sig=h;
					end
				else if (PB_left)
					begin
					Est_Sig=d;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=g;
					end
			end
			
			h:
			begin 
				control_N=5'b00111;
				Est_Sig=i;
			end
					
			i://escribe dia
			begin 
				control_N=5'b01000;
				if (PB_right)
					begin
					Est_Sig=j;
					end
				else if (PB_left)
					begin
					Est_Sig=w;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=i;
					end
			end
			
			j:
			begin 
				control_N=5'b01001;
				Est_Sig=k;
			end
					
			k://escribe mes
			begin 
				control_N=5'b01010;
				if (PB_right)
					begin
					Est_Sig=l;
					end
				else if (PB_left)
					begin
					Est_Sig=h;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=k;
					end
			end
			
			l:
			begin 
				control_N=5'b01011;
				Est_Sig=m;
			end
					
			m://escribe año
			begin 
				control_N=5'b01100;
				if (PB_right)
					begin
					Est_Sig=n;
					end
				else if (PB_left)
					begin
					Est_Sig=j;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=m;
					end
			end
			
			n:
			begin 
				control_N=5'b01101;
				if (SF_Timer)
					begin
					Est_Sig=o;
					end
				else
					begin
					Est_Sig=b;
					end
			end
					
			o:
			begin 
				control_N=5'b01110;
				Est_Sig=p;
			end
					
			p://escribe seg timer
			begin 
				control_N=5'b01111;
				if (PB_right)
					begin
					Est_Sig=q;
					end
				else if (PB_left)
					begin
					Est_Sig=l;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=p;
					end
			end
			
			q:
			begin 
				control_N=5'b10000;
				Est_Sig=r;
			end
					
			r://escribe min timer
			begin 
				control_N=5'b10001;
				if (PB_right)
					begin
					Est_Sig=s;
					end
				else if (PB_left)
					begin
					Est_Sig=o;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=r;
					end
			end
					
			s:
			begin 
				control_N=5'b10010;
				Est_Sig=t;
			end
					
			t://escribe hora timer
			begin 
				control_N=5'b10011;
				if (PB_right)
					begin
					Est_Sig=b;
					end
				else if (PB_left)
					begin
					Est_Sig=q;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=t;
					end
			end
			
			u:
			begin 
				control_N=5'b10100;
				if (SF_Timer)
					begin
					Est_Sig=s;
					end
				else
					begin
					Est_Sig=l;
					end
			end
			
			v:
			begin
				control_N=5'b10101;
				Est_Sig=a;
			end
			
			w:
			begin 
				control_N=5'b10110;
				if (SF_24_12)
					begin
					Est_Sig=x;
					end
				else
					begin
					Est_Sig=f;
					end
			end
					
			x:
			begin 
				control_N=5'b10111;
				Est_Sig=y;
			end
					
			y://escribe hora formato 12
			begin 
				control_N=5'b11000;
				if (PB_right)
					begin
					Est_Sig=h;
					end
				else if (PB_left)
					begin
					Est_Sig=d;
					end
				else if (PB_program)
					begin
					Est_Sig=v;
					end
				else
					begin
					Est_Sig=y;
					end
			end
			
			default:Est_Sig=a;
			endcase
		
		end
				
assign ctrl_E = control_A;

endmodule
