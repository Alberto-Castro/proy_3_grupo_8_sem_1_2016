`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alberto Castro G. 
// 
// Create Date:    18:01:26 03/27/2016 
// Design Name: 
// Module Name:    BUS_IO 
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
module BUS_IO2(
    input wire clk,      // The standard clock
    input wire Dato_1, Dato_2,  // señal para leer o escribir
    input wire [7:0]data_in,    // Data to send out when direction is 1
    output wire [7:0]data_out,   // Result of input pin when direction is 0
    inout  [7:0]io_port     // The i/o port to send data through
    );

    reg [7:0]a, b;    

    assign io_port  = Dato_2 ? a : 8'bz;
    assign data_out = b;

    always @ (posedge clk)
    begin
	 a <= data_in;
	 if (Dato_1)
       b <= io_port;
    end

endmodule

