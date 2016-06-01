`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:29 06/01/2016 
// Design Name: 
// Module Name:    sonidovga 
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
module sonido(   input clk, 
   input hush,
	input sw1,sw2,
     //input [3:0] note, 
     output ampPWM //speaker port 
     ); 
	  reg [18:0] counter; //binary counter; 16 bits wide 
	  reg mascara;
    // The audio amplifier needs to be enabled, by 
    // default it will be disabled without this:   
     localparam TCQ = 1; 
 
 always @ (posedge clk or negedge hush) 
	begin
     if ( hush == 1'b0) 
         counter <= 'b0; 
     else 
         counter <= counter + 19'd1; 
			end
			
 always @ (posedge clk ) 
	begin
     if (sw1==1'b1) 
         mascara<=counter[17]; 
     else if (sw2==1'b1)
        mascara<=counter[15];
	  else
	  mascara<=counter[16];
			end
 
 assign ampPWM = mascara;   
endmodule

