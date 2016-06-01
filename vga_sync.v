`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:12 03/16/2016 
// Design Name: 
// Module Name:    vga_sync 
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
module vga_sync(
	input wire clk_i, reset_i,
	output wire hsync_o, vsync_o,
	output wire [9:0] pixel_x_o, pixel_y_o
    );
//constant declaration_o
//VGA 640-by480 sync parameters
	localparam HD = 640;//Display horizontal 
	localparam HF = 48; 	//Borde izquierdo
	localparam HB = 16; //Borde derecho
	localparam HR = 96;//horizontal retrace
	localparam VD = 480;	//Display vertical area
	localparam VF = 10;// Borde superior
	localparam VB = 33;// Borde inferior
	localparam VR = 2;// vertical retrace

	
// mod-2 counter
reg mod2_reg;
wire mod2_next ;
// sync c o u n t e r s
reg [9:0] h_count_reg, h_count_next;// crea los registros para que el contador incremente 
reg [9:0] v_count_reg , v_count_next ;
 // outpzit b u f f e r
reg v_sync_reg , h_sync_reg ;
wire v_sync_next , h_sync_next ;
// s t a t u s s i g n a l
wire h_end , v_end , pixel_tick;

// body
// r e g i s t e r s
always @(posedge clk_i , posedge reset_i)// se inicialzan los contadores
	if (reset_i) // la variable reset es necesaria para iniciar los contadores en 0
		begin
		mod2_reg <= 1'b0;
		v_count_reg <= 0;
		h_count_reg <= 0 ;
		v_sync_reg <= 1'b0;
		h_sync_reg <= 1'b0;
		end
	else // Si no se encuentra activa la variable reset se le asigna a las salida el valor de los registros de conteo
		begin
		mod2_reg <= mod2_next ; 
		v_count_reg <= v_count_next;
		h_count_reg <= h_count_next;
		v_sync_reg <= v_sync_next ;
		h_sync_reg <= h_sync_next ;
		end
   // mod-2 c i r c u i t t o g e n e r a t e 25 MHz e n a b l e t i c k
	assign mod2_next = ~mod2_reg;
	assign pixel_tick = mod2_reg;
// s t a t u s s i g n a l s
// end o f h o r i z o n t a l c o u n t e r ( 7 9 9 )
	assign h_end = (h_count_reg==(HD+HF+HB+HR-1)) ;
// end o f v e r t i c a l c o u n t e r ( 5 2 4 )
	assign v_end = (v_count_reg==(VD+VF+VB+VR-1)) ;

// siguiente estado del contador horizontal
always @* // se  suma 1 al valor de 
	if (pixel_tick) // 25 MHz p u l s e
		if (h_end)
			h_count_next = 0 ;
		else
			h_count_next = h_count_reg + 1'b1;
	else
		h_count_next = h_count_reg;

// siguiente estado  del contador vertical 
always @*
	if (pixel_tick & h_end)
		if (v_end)
			v_count_next = 0;
		else
			v_count_next = v_count_reg + 1'b1;
	else
		v_count_next = v_count_reg;
// h o r i z o n t a l and v e r t i c a l s y n c , b u f f e r e d t o a v o i d g l i t c h
// h-svnc-next a s s e r t e d between 656 and 751
	assign h_sync_next = (h_count_reg>=(HD+HB) &&
	h_count_reg<=(HD+HB+HR-1));
 // vh-sync-next a s s e r t e d between 490 and 491
	assign v_sync_next = (v_count_reg>=(VD+VF) && v_count_reg<=(VD+VF+VR-1));

// Asignación del contenido de los registros a las salidas
assign hsync_o = ~h_sync_reg; // se le asignan el valor negado debido a que los tiempos están invertidos
assign vsync_o = ~v_sync_reg; // se le asignan el valor negado debido a que los tiempos están invertidos
assign pixel_x_o = h_count_reg;
assign pixel_y_o = v_count_reg;


endmodule 		