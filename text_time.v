`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:22 03/29/2016 
// Design Name: 
// Module Name:    text_time 
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
module text_time
	 (
		input wire clk,
		input wire [9:0] pix_x, pix_y,
		input wire [3:0] digUH, digDH, digUM, digDM, digUS, digDS, digUD, digDD, digUME, digDME, digUA, digDA, digUHC, digDHC, digUMC, digDMC, digUSC, digDSC,
		output wire [2:0] text_on,
		output reg [7:0] text_rgb
		
    );
	 
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
	
	
	 // instantiate font ROM
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
		
	
	//digitos de fecha
	
	assign digfecha_on = (pix_y[9:5]==2) &&
                    (3<=pix_x[9:4]) && (pix_x[9:4]<=12);
   assign row_addr_digfecha = pix_y[4:1];
   assign bit_addr_digfecha = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_digfecha = {3'b011, digDD}; // dig1(decenas)
         4'h4: char_addr_digfecha = {3'b011, digUD}; // dig0(unidades)
         4'h5: char_addr_digfecha = 7'h2f; // "/"
         4'h6: char_addr_digfecha = {3'b011, digDME};
			4'h7: char_addr_digfecha = {3'b011, digUME};
			4'h8: char_addr_digfecha = 7'h2f; // "/"
			4'h9: char_addr_digfecha = {3'b011, digFD};
			4'ha: char_addr_digfecha = {3'b011, digFU};
			4'hb: char_addr_digfecha = {3'b011, digDA};
			default: char_addr_digfecha = {3'b011, digUA}; 
      endcase
		
		
	//digitos hora
	
	assign dighora_on = (pix_y[9:5]==5) &&(3<=pix_x[9:4]) && (pix_x[9:4]<=10);
   assign row_addr_dighora = pix_y[4:1];
   assign bit_addr_dighora = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_dighora = {3'b011, digDH}; // dig1(decenas)
         4'h4: char_addr_dighora = {3'b011, digUH}; // dig0(unidades)
         4'h5: char_addr_dighora = 7'h3a; // ":"
         4'h6: char_addr_dighora = {3'b011, digDM};
			4'h7: char_addr_dighora = {3'b011, digUM};
			4'h8: char_addr_dighora = 7'h3a; // ":"
			4'h9: char_addr_dighora = {3'b011, digDS};
			default: char_addr_dighora = {3'b011, digUS}; 
      endcase	
		

	//Dígitos crónometros
	
	assign digcrono_on = (pix_y[9:5]==8) &&(3<=pix_x[9:4]) && (pix_x[9:4]<=10);
   assign row_addr_digcrono = pix_y[4:1];
   assign bit_addr_digcrono = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_digcrono = {3'b011, digDHC}; // dig1(decenas)
         4'h4: char_addr_digcrono = {3'b011, digUHC}; // dig0(unidades)
         4'h5: char_addr_digcrono = 7'h3a; // ":"
         4'h6: char_addr_digcrono = {3'b011, digDMC};
			4'h7: char_addr_digcrono = {3'b011, digUMC};
			4'h8: char_addr_digcrono = 7'h3a; // ":"
			4'h9: char_addr_digcrono = {3'b011, digDSC};
			default: char_addr_digcrono = {3'b011, digUSC}; 
      endcase	
		
	
   // mux for font ROM addresses and rgb
    always @*
   begin
      text_rgb = 8'b00000000;  // background, yellow

      if (digfecha_on)
         begin
            char_addr = char_addr_digfecha;
            row_addr = row_addr_digfecha;
            bit_addr = bit_addr_digfecha;
            if (font_bit)
               text_rgb = 8'b00000001;
         end

		else if (dighora_on)
         begin
            char_addr = char_addr_dighora;
            row_addr = row_addr_dighora;
            bit_addr = bit_addr_dighora;
            if (font_bit)
               text_rgb = 8'b00000001;
         end

      else if (digcrono_on)
         begin
            char_addr = char_addr_digcrono;
            row_addr = row_addr_digcrono;
            bit_addr = bit_addr_digcrono;
            if (font_bit)
               text_rgb = 8'b00000001;
         end

		else
			text_rgb = 8'b00000000;
	 
   end

   assign text_on = {digfecha_on, dighora_on, digcrono_on};
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

endmodule
