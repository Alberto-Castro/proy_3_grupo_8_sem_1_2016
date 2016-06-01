`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Montvydas Klumbys 
// 
// Create Date:    
// Design Name: 
// Module Name:    MainActivity 
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
module MainActivity(
   output wire [7:0]  rgb,
	input wire clk_i, reset_i,
	//input wire sw,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,
	input wire [3:0] dig,
	output wire hsync_o, vsync_o
	);
	
	wire [3:0] digUH, digDH, digUM, digDM, digUS, digDS, digUD, digDD, digUME, digDME, digUA, digDA, digUHC, digDHC, digUMC, digDMC, digUSC, digDSC;
	wire [9:0] pixel_x_o, pixel_y_o;
	wire [2:0] text_on;
	reg [7:0] text_rgb;
	reg En = 1'b0; 
	reg clk1 = 0;		//need a downcounter to 25MHz
	//Tamaño de fecha
	parameter Gimpy1 = 13'd7700;
	//Tamaño de Hora
	parameter Gimpy3 = 13'd5665;//hora
	//Tamaño de crono
	parameter Gimpy4 = 13'd6426;
	//tamaño de metro
	parameter Gimpy5 = 13'd6426;
	//tamaño de alarma
	parameter Gimpy6 = 13'd7980;


	// Parámetros de la imagen
	//parámetros para fecha
	parameter y1 = 7'd55;	//tamaño de la imagen 31x249
	parameter x1 =9'd140;
	//Parametros para hora
	parameter y3 = 7'd55;
	parameter x3 = 7'd103;
	//Parametros para crono
	parameter y4 = 7'd54;
	parameter x4 = 9'd119;
	//Parametros para metro
	parameter y5 = 7'd54;
	parameter x5 = 9'd119;
	//Parametros para alarma
	parameter y6 = 7'd84;
	parameter x6 = 7'd95;
	
	
//Divisor de frecuencia
always @(posedge clk_i)begin     
		clk1 <= ~clk1;	//Slow down the counter to 25MHz
	end	
 vga_sync vga (	
 .clk_i(clk1), .reset_i(reset_i),.hsync_o(hsync_o), .vsync_o(vsync_o),.pixel_x_o(pixel_x_o), .pixel_y_o(pixel_y_o));
 	 // instantiate font ROM
 
  
//VGA Interface gets values of pix_x and pix_y by puting COLOUR_IN, gets valid output COLOUR_OUT
//Also gets a trigger, when the screen is refreshed
//Posicion de fecha
	reg signed [10:0]X = 10'd80;//maximo en x
	reg signed [9:0]Y = 9'd0;//maximo en y
	//posicion de hora
	reg signed [10:0]X3 = 10'd80;
	reg signed [9:0]Y3 = 9'd150;
	//posicion de crono
	reg signed [10:0]X4 = 10'd80;
	reg signed [9:0]Y4 = 9'd300;
	//posicion de metro
	reg signed [10:0]X5 = 10'd199;
	reg signed [9:0]Y5 = 9'd300;
	//posicion de alarma
	reg signed [10:0]X6 = 10'd420;
	reg signed [9:0]Y6 = 9'd300;
	
	wire [12:0] STATE1;//fecha
	wire [12:0] STATE3;//hora
	wire [12:0] STATE4;//crono
	wire [12:0] STATE5;//metro
	wire [12:0] STATE6;//alarma
	
	
	reg [7:0] COLOUR_DATA1   [0:Gimpy1];//fec
	reg [7:0] COLOUR_DATA12 [0:Gimpy3];//hora
	reg [7:0] COLOUR_DATA13 [0:Gimpy4];//crono
	reg [7:0] COLOUR_DATA14 [0:Gimpy5];//metro
	reg [7:0] COLOUR_DATA15 [0:Gimpy6];//alarma
	reg [7:0] rg;// registro máscara de la salida de rgb


// Declaración de Imagenes 
	initial
	$readmemh ("fecha1.list", COLOUR_DATA1);//Lee la imagen en hexadecimal
	initial
	$readmemh ("hora1.list", COLOUR_DATA12);//Lee la imagen en hexadecimal
	initial
	$readmemh ("crono1.list", COLOUR_DATA13);//Lee la imagen en hexadecimal
	initial
	$readmemh ("metro1.list", COLOUR_DATA14);//Lee la imagen en hexadecimal
	initial
	$readmemh ("alarma1.list", COLOUR_DATA15);//Lee la imagen en hexadecimal

	
// Asignación de tamaño de la imagen
	assign STATE1 = (pixel_x_o-X)*y1+pixel_y_o-Y;
	assign STATE3 =(pixel_x_o-X3)*y3+pixel_y_o-Y3;
	assign STATE4 =(pixel_x_o-X4)*y4+pixel_y_o-Y4;
	assign STATE5 =(pixel_x_o-X5)*y5+pixel_y_o-Y5;
	assign STATE6 =(pixel_x_o-X6)*y6+pixel_y_o-Y6;
	
	
   wire[3:0] digFD = 4'b0010;
	wire[3:0] digFU = 4'b0000;
	    // signal declaration
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_digfecha, char_addr_dighora, char_addr_digcrono;
   reg [3:0] row_addr;
   wire [3:0] row_addr_digfecha,row_addr_dighora, row_addr_digcrono;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_digfecha, bit_addr_dighora, bit_addr_digcrono;
   wire [7:0] font_word;
   wire font_bit, digfecha_on, dighora_on, digcrono_on;
   wire [7:0] rule_rom_addr; 

 font_rom font_unit
      (.clk(clk_i), .addr(rom_addr), .data(font_word));
	
	//digitos de fecha
	
	assign digfecha_on = (pixel_y_o[9:5]==3) &&
                    (6<=pixel_x_o[9:4]) && (pixel_x_o[9:4]<=15);
   assign row_addr_digfecha = pixel_y_o[4:1];
   assign bit_addr_digfecha = pixel_x_o[3:1];
   always @*
      case(pixel_x_o[7:4])
         4'h6: char_addr_digfecha = {3'b011, digDD}; // dig1(decenas)
         4'h7: char_addr_digfecha = {3'b011, digUD}; // dig0(unidades)
         4'h8: char_addr_digfecha = 7'h2f; // "/"
         4'h9: char_addr_digfecha = {3'b011, digDME};
			4'ha: char_addr_digfecha = {3'b011, digUME};
			4'hb: char_addr_digfecha = 7'h2f; // "/"
			4'hc: char_addr_digfecha = {3'b011, digFD};
			4'hd: char_addr_digfecha = {3'b011, digFU};
			4'he: char_addr_digfecha = {3'b011, digDA};
			default: char_addr_digfecha = {3'b011, digUA}; 
      endcase
		
		
	
	assign dighora_on = (pixel_y_o[9:5]==8) &&(6<=pixel_x_o[9:4]) && (pixel_x_o[9:4]<=13);
   assign row_addr_dighora = pixel_y_o[4:1];
   assign bit_addr_dighora = pixel_x_o[3:1];
   always @*
      case(pixel_x_o[7:4])
         4'h6: char_addr_dighora = {3'b011, digDH}; // dig1(decenas)
         4'h7: char_addr_dighora = {3'b011, digUH}; // dig0(unidades)
         4'h8: char_addr_dighora = 7'h3a; // ":"
         4'h9: char_addr_dighora = {3'b011, digDM};
			4'ha: char_addr_dighora = {3'b011, digUM};
			4'hb: char_addr_dighora = 7'h3a; // ":"
			4'hc: char_addr_dighora = {3'b011, digDS};
			default: char_addr_dighora = {3'b011, digUS}; 
      endcase	
		

	
	assign digcrono_on = (pixel_y_o[9:5]==12) &&(6<=pixel_x_o[9:4]) && (pixel_x_o[9:4]<=13);
   assign row_addr_digcrono = pixel_y_o[4:1];
   assign bit_addr_digcrono = pixel_x_o[3:1];
   always @*
      case(pixel_x_o[7:4])
         4'h6: char_addr_digcrono = {3'b011, digDHC}; // dig1(decenas)
         4'h7: char_addr_digcrono = {3'b011, digUHC}; // dig0(unidades)
         4'h8: char_addr_digcrono = 7'h3a; // ":"
         4'h9: char_addr_digcrono = {3'b011, digDMC};
			4'ha: char_addr_digcrono = {3'b011, digUMC};
			4'hb: char_addr_digcrono = 7'h3a; // ":"
			4'hc: char_addr_digcrono = {3'b011, digDSC};
			default: char_addr_digcrono = {3'b011, digUSC}; 
      endcase	
 
	
// Generación del multiplexor de imagenes tanto variables como estáticas
	always @* begin// Indica la posición en donde se ubicara la imagen si esta se encuentra dentro del margen definido 
	rg = 8'b00000000; 
		if (pixel_x_o>=X && pixel_x_o<X+x1
			&& pixel_y_o>=Y && pixel_y_o<Y+y1)
				rg = COLOUR_DATA1[{STATE1}];
				
			else if (pixel_x_o>=X3 && pixel_x_o<X3+x3
			&& pixel_y_o>=Y3 && pixel_y_o<Y3+y3)
				rg = COLOUR_DATA12[{STATE3}];
			else if (pixel_x_o>=X4 && pixel_x_o<X4+x4
			&& pixel_y_o>=Y4 && pixel_y_o<Y4+y4)
				rg = COLOUR_DATA13[{STATE4}];
			else if (pixel_x_o>=X5 && pixel_x_o<X5+x5
			&& pixel_y_o>=Y5 && pixel_y_o<Y5+y5)
				rg = COLOUR_DATA14[{STATE5}];
			else if (pixel_x_o>=X6 && pixel_x_o<X6+x6
			&& pixel_y_o>=Y6 && pixel_y_o<Y6+y6)
				rg = COLOUR_DATA15[{STATE6}];
			else if (digfecha_on)
         begin
            char_addr = char_addr_digfecha;
            row_addr = row_addr_digfecha;
            bit_addr = bit_addr_digfecha;
            if (font_bit)
               rg = 8'b00001111;
			end
			else if (dighora_on)
         begin
            char_addr = char_addr_dighora;
            row_addr = row_addr_dighora;
            bit_addr = bit_addr_dighora;
            if (font_bit)
               rg = 8'b00001111;
         end
			
			else if (digcrono_on)
         begin
            char_addr = char_addr_digcrono;
            row_addr = row_addr_digcrono;
            bit_addr = bit_addr_digcrono;
            if (font_bit)
               rg = 8'b00001111;
         end		
        
			else 
				rg = 8'h00;
	end
	
	assign digUH = dig;
	assign digDH = dig;
	assign digUM = dig;
	assign digDM = dig;
	assign digUS = dig;
	assign digDS = dig;
	assign digUD = dig;
	assign digDD = dig;
	assign digUME = dig;
	assign digDME = dig;
	assign digUA = dig;
	assign digDA = dig;
	assign digUHC = dig;
	assign digDHC = dig;
	assign digUMC = dig;
	assign digDMC = dig;
	assign digUSC = dig;
	assign digDSC = dig;
	
   assign text_on = {digfecha_on, dighora_on, digcrono_on};
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

   assign rgb=rg; // Se asigna el valor de la salida del sistema


	
endmodule
