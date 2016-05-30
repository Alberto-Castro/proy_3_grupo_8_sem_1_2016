//
///////////////////////////////////////////////////////////////////////////////////////////
// Copyright © 2010-2013, Xilinx, Inc.
// This file contains confidential and proprietary information of Xilinx, Inc. and is
// protected under U.S. and international copyright and other intellectual property laws.
///////////////////////////////////////////////////////////////////////////////////////////
//
// Disclaimer:
// This disclaimer is not a license and does not grant any rights to the materials
// distributed herewith. Except as otherwise provided in a valid license issued to
// you by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE
// MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY
// DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
// INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,
// OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable
// (whether in contract or tort, including negligence, or under any other theory
// of liability) for any loss or damage of any kind or nature related to, arising
// under or in connection with these materials, including for any direct, or any
// indirect, special, incidental, or consequential loss or damage (including loss
// of data, profits, goodwill, or any type of loss or damage suffered as a result
// of any action brought by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-safe, or for use in any
// application requiring fail-safe performance, such as life-support or safety
// devices or systems, Class III medical devices, nuclear facilities, applications
// related to the deployment of airbags, or any other applications that could lead
// to death, personal injury, or severe property or environmental damage
// (individually and collectively, "Critical Applications"). Customer assumes the
// sole risk and liability of any use of Xilinx products in Critical Applications,
// subject only to applicable laws and regulations governing limitations on product
// liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
// Definition of a program memory for KCPSM6 including generic parameters for the 
// convenient selection of device family, program memory size and the ability to include 
// the JTAG Loader hardware for rapid software development.
//
// This file is primarily for use during code development and it is recommended that the 
// appropriate simplified program memory definition be used in a final production design. 
//
//
//    Generic                  Values             Comments
//    Parameter                Supported
//  
//    C_FAMILY                 "S6"               Spartan-6 device
//                             "V6"               Virtex-6 device
//                             "7S"               7-Series device 
//                                                  (Artix-7, Kintex-7, Virtex-7 or Zynq)
//
//    C_RAM_SIZE_KWORDS        1, 2 or 4          Size of program memory in K-instructions
//
//    C_JTAG_LOADER_ENABLE     0 or 1             Set to '1' to include JTAG Loader
//
// Notes
//
// If your design contains MULTIPLE KCPSM6 instances then only one should have the 
// JTAG Loader enabled at a time (i.e. make sure that C_JTAG_LOADER_ENABLE is only set to 
// '1' on one instance of the program memory). Advanced users may be interested to know 
// that it is possible to connect JTAG Loader to multiple memories and then to use the 
// JTAG Loader utility to specify which memory contents are to be modified. However, 
// this scheme does require some effort to set up and the additional connectivity of the 
// multiple BRAMs can impact the placement, routing and performance of the complete 
// design. Please contact the author at Xilinx for more detailed information. 
//
// Regardless of the size of program memory specified by C_RAM_SIZE_KWORDS, the complete 
// 12-bit address bus is connected to KCPSM6. This enables the generic to be modified 
// without requiring changes to the fundamental hardware definition. However, when the 
// program memory is 1K then only the lower 10-bits of the address are actually used and 
// the valid address range is 000 to 3FF hex. Likewise, for a 2K program only the lower 
// 11-bits of the address are actually used and the valid address range is 000 to 7FF hex.
//
// Programs are stored in Block Memory (BRAM) and the number of BRAM used depends on the 
// size of the program and the device family. 
//
// In a Spartan-6 device a BRAM is capable of holding 1K instructions. Hence a 2K program 
// will require 2 BRAMs to be used and a 4K program will require 4 BRAMs to be used. It 
// should be noted that a 4K program is not such a natural fit in a Spartan-6 device and 
// the implementation also requires a small amount of logic resulting in slightly lower 
// performance. A Spartan-6 BRAM can also be split into two 9k-bit memories suggesting 
// that a program containing up to 512 instructions could be implemented. However, there 
// is a silicon errata which makes this unsuitable and therefore it is not supported by 
// this file.
//
// In a Virtex-6 or any 7-Series device a BRAM is capable of holding 2K instructions so 
// obviously a 2K program requires only a single BRAM. Each BRAM can also be divided into 
// 2 smaller memories supporting programs of 1K in half of a 36k-bit BRAM (generally 
// reported as being an 18k-bit BRAM). For a program of 4K instructions, 2 BRAMs are used.
//
//
// Program defined by 'ROM_RTC.fidex.psm'.
//
// Generated by KCPSM6 Assembler: 2016-05-30 10:43:28 . 
//
// Assembler used ROM_form template: ROM_form_JTAGLoader_14March13.v
//
//
`timescale 1ps/1ps
module ROM_RTC (address, instruction, enable, rdl, clk);
//
parameter integer C_JTAG_LOADER_ENABLE = 1;                        
parameter         C_FAMILY = "S6";                        
parameter integer C_RAM_SIZE_KWORDS = 1;                        
//
input         clk;        
input  [11:0] address;        
input         enable;        
output [17:0] instruction;        
output        rdl;
//
//
wire [15:0] address_a;
wire        pipe_a11;
wire [35:0] data_in_a;
wire [35:0] data_out_a;
wire [35:0] data_out_a_l;
wire [35:0] data_out_a_h;
wire [35:0] data_out_a_ll;
wire [35:0] data_out_a_lh;
wire [35:0] data_out_a_hl;
wire [35:0] data_out_a_hh;
wire [15:0] address_b;
wire [35:0] data_in_b;
wire [35:0] data_in_b_l;
wire [35:0] data_in_b_ll;
wire [35:0] data_in_b_hl;
wire [35:0] data_out_b;
wire [35:0] data_out_b_l;
wire [35:0] data_out_b_ll;
wire [35:0] data_out_b_hl;
wire [35:0] data_in_b_h;
wire [35:0] data_in_b_lh;
wire [35:0] data_in_b_hh;
wire [35:0] data_out_b_h;
wire [35:0] data_out_b_lh;
wire [35:0] data_out_b_hh;
wire        enable_b;
wire        clk_b;
wire [7:0]  we_b;
wire [3:0]  we_b_l;
wire [3:0]  we_b_h;
//
wire [11:0] jtag_addr;
wire        jtag_we;
wire        jtag_clk;
wire [17:0] jtag_din;
wire [17:0] jtag_dout;
wire [17:0] jtag_dout_1;
wire [0:0]  jtag_en;
//
wire [0:0]  picoblaze_reset;
wire [0:0]  rdl_bus;
//
parameter integer BRAM_ADDRESS_WIDTH = addr_width_calc(C_RAM_SIZE_KWORDS);
//
//
function integer addr_width_calc;
  input integer size_in_k;
    if (size_in_k == 1) begin addr_width_calc = 10; end
      else if (size_in_k == 2) begin addr_width_calc = 11; end
      else if (size_in_k == 4) begin addr_width_calc = 12; end
      else begin
        if (C_RAM_SIZE_KWORDS != 1 && C_RAM_SIZE_KWORDS != 2 && C_RAM_SIZE_KWORDS != 4) begin
          //#0;
          $display("Invalid BlockRAM size. Please set to 1, 2 or 4 K words..\n");
          $finish;
        end
    end
endfunction
//
//
generate
  if (C_RAM_SIZE_KWORDS == 1) begin : ram_1k_generate 
    //
    if (C_FAMILY == "S6") begin: s6 
      //
      assign address_a[13:0] = {address[9:0], 4'b0000};
      assign instruction = {data_out_a[33:32], data_out_a[15:0]};
      assign data_in_a = {34'b0000000000000000000000000000000000, address[11:10]};
      assign jtag_dout = {data_out_b[33:32], data_out_b[15:0]};
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b = {2'b00, data_out_b[33:32], 16'b0000000000000000, data_out_b[15:0]};
        assign address_b[13:0] = 14'b00000000000000;
        assign we_b[3:0] = 4'b0000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b = {2'b00, jtag_din[17:16], 16'b0000000000000000, jtag_din[15:0]};
        assign address_b[13:0] = {jtag_addr[9:0], 4'b0000};
        assign we_b[3:0] = {jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (18),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (18),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'hF6101642F60F1641F60E1626F60D1625F60C1624F60B1623F60A1622F6091621),
                   .INIT_01             (256'h120211000068111012022018002B001BD60F1600F6131620F6121680F6111643),
                   .INIT_02             (256'h1E051F001C06D20512F050000068120111040068120011000068121011D20068),
                   .INIT_03             (256'h95026044D5003504950200551220017FDE031E02DE031E06017FDE031E00DE03),
                   .INIT_04             (256'h2075D34DDE0F1E00DE0F1E01930150000100120030F7B013202B6049D5003502),
                   .INIT_05             (256'hDE031E02DE031E06017FDE031E00DE031E05D2051201202B018AD3442000D32D),
                   .INIT_06             (256'h1E07017FDE031E00DE031E05D104D205124050006055D2430067D2260184017F),
                   .INIT_07             (256'hD323DE0F1E00DE0F1E0193012075607AD500350295025000017FDE031E02DE03),
                   .INIT_08             (256'hD31A20C9D32220C2D32120BBD32420B4D31D20ADD31520A6D31C209FD31B2098),
                   .INIT_09             (256'h1801209860D7D500350295021906180020752170D35A21BCD32A218ED32B20D0),
                   .INIT_0A             (256'h95021909180320A660ECD5003502950219081802209F60D7D500350295021907),
                   .INIT_0B             (256'hD50035029502190B180520B46127D50035029502190A180420AD6141D5003502),
                   .INIT_0C             (256'h20C960D7D50035029502190D180720C260D7D50035029502190C180620BB615B),
                   .INIT_0D             (256'h4706470601C0DD003D809D060D700730930120D060F1D50035029502190E1808),
                   .INIT_0E             (256'h20F1DD003D10BD132075E780C79047D0AD8007309301016BE780C79047064706),
                   .INIT_0F             (256'h9301016BE780C790470647064706470601C0DD003D809D030D7007309301210B),
                   .INIT_10             (256'h3D809D020D70073093012075E780C79001C0DD003D809D240D7047D0AD800730),
                   .INIT_11             (256'h0D7047D0AD8007309301016BE7804700B012C790470647064706470601C0DD00),
                   .INIT_12             (256'h4706470601C0DD003D809D020D70073093012075E780C79001C0DD003D809D13),
                   .INIT_13             (256'hE780C79001C0DD003D809D130D7047D0AD8007309301016BE780C79047064706),
                   .INIT_14             (256'h9301016BE780C790470647064706470601C0DD003D809D040D70073093012075),
                   .INIT_15             (256'h470647064706073093012075E780C79001C0DD003D809D320D7047D0AD800730),
                   .INIT_16             (256'h5000216BD500350295022075E780C79047D0AD8007309301016BE780C7904706),
                   .INIT_17             (256'h9E022177202BDA091B011A010068A2B0A1A01B091A00006801A03ADFBA131200),
                   .INIT_18             (256'h7010B013500000681201110450001F011C01C4C0E4F094005000217FDE003E01),
                   .INIT_19             (256'h70805000019F41A5DF003F809F130F10B012B102207501AC4196D0003010F013),
                   .INIT_1A             (256'h3F800F00B012B1025000F1024100D1089112F01270805000F1024100D108F012),
                   .INIT_1B             (256'h2075F0135008B0135000F102D108111271805000F102D108500001B441B7DF00),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000050003710),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'h620B42A2288AADDA88A226DDD88200B4342288A202282082082A888888888888),
                   .INITP_01            (256'h2A55D103D0A802A55D102D00B402D00B402D00B402D00B402D00B77777777777),
                   .INITP_02            (256'h2D580200B42A00A9542AD1002A55D102AD1002A55D102AD10028255D102AD100),
                   .INITP_03            (256'h00000000000000000000000000000008A0A92ABD00A2628A2F440BD20A0968B4),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
       kcpsm6_rom( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a[31:0]),
                   .DOPA                (data_out_a[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b[31:0]),
                   .DOPB                (data_out_b[35:32]), 
                   .DIB                 (data_in_b[31:0]),
                   .DIPB                (data_in_b[35:32]), 
                   .WEB                 (we_b[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
    end // s6;
    // 
    //
    if (C_FAMILY == "V6") begin: v6 
      //
      assign address_a[13:0] = {address[9:0], 4'b1111};
      assign instruction = data_out_a[17:0];
      assign data_in_a[17:0] = {16'b0000000000000000, address[11:10]};
      assign jtag_dout = data_out_b[17:0];
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b[17:0] = data_out_b[17:0];
        assign address_b[13:0] = 14'b11111111111111;
        assign we_b[3:0] = 4'b0000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b[17:0] = jtag_din[17:0];
        assign address_b[13:0] = {jtag_addr[9:0], 4'b1111};
        assign we_b[3:0] = {jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB18E1 #(.READ_WIDTH_A              (18),
                 .WRITE_WIDTH_A             (18),
                 .DOA_REG                   (0),
                 .INIT_A                    (18'b000000000000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (18'b000000000000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (18),
                 .WRITE_WIDTH_B             (18),
                 .DOB_REG                   (0),
                 .INIT_B                    (18'b000000000000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (18'b000000000000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .SIM_DEVICE                ("VIRTEX6"),
                 .INIT_00                   (256'hF6101642F60F1641F60E1626F60D1625F60C1624F60B1623F60A1622F6091621),
                 .INIT_01                   (256'h120211000068111012022018002B001BD60F1600F6131620F6121680F6111643),
                 .INIT_02                   (256'h1E051F001C06D20512F050000068120111040068120011000068121011D20068),
                 .INIT_03                   (256'h95026044D5003504950200551220017FDE031E02DE031E06017FDE031E00DE03),
                 .INIT_04                   (256'h2075D34DDE0F1E00DE0F1E01930150000100120030F7B013202B6049D5003502),
                 .INIT_05                   (256'hDE031E02DE031E06017FDE031E00DE031E05D2051201202B018AD3442000D32D),
                 .INIT_06                   (256'h1E07017FDE031E00DE031E05D104D205124050006055D2430067D2260184017F),
                 .INIT_07                   (256'hD323DE0F1E00DE0F1E0193012075607AD500350295025000017FDE031E02DE03),
                 .INIT_08                   (256'hD31A20C9D32220C2D32120BBD32420B4D31D20ADD31520A6D31C209FD31B2098),
                 .INIT_09                   (256'h1801209860D7D500350295021906180020752170D35A21BCD32A218ED32B20D0),
                 .INIT_0A                   (256'h95021909180320A660ECD5003502950219081802209F60D7D500350295021907),
                 .INIT_0B                   (256'hD50035029502190B180520B46127D50035029502190A180420AD6141D5003502),
                 .INIT_0C                   (256'h20C960D7D50035029502190D180720C260D7D50035029502190C180620BB615B),
                 .INIT_0D                   (256'h4706470601C0DD003D809D060D700730930120D060F1D50035029502190E1808),
                 .INIT_0E                   (256'h20F1DD003D10BD132075E780C79047D0AD8007309301016BE780C79047064706),
                 .INIT_0F                   (256'h9301016BE780C790470647064706470601C0DD003D809D030D7007309301210B),
                 .INIT_10                   (256'h3D809D020D70073093012075E780C79001C0DD003D809D240D7047D0AD800730),
                 .INIT_11                   (256'h0D7047D0AD8007309301016BE7804700B012C790470647064706470601C0DD00),
                 .INIT_12                   (256'h4706470601C0DD003D809D020D70073093012075E780C79001C0DD003D809D13),
                 .INIT_13                   (256'hE780C79001C0DD003D809D130D7047D0AD8007309301016BE780C79047064706),
                 .INIT_14                   (256'h9301016BE780C790470647064706470601C0DD003D809D040D70073093012075),
                 .INIT_15                   (256'h470647064706073093012075E780C79001C0DD003D809D320D7047D0AD800730),
                 .INIT_16                   (256'h5000216BD500350295022075E780C79047D0AD8007309301016BE780C7904706),
                 .INIT_17                   (256'h9E022177202BDA091B011A010068A2B0A1A01B091A00006801A03ADFBA131200),
                 .INIT_18                   (256'h7010B013500000681201110450001F011C01C4C0E4F094005000217FDE003E01),
                 .INIT_19                   (256'h70805000019F41A5DF003F809F130F10B012B102207501AC4196D0003010F013),
                 .INIT_1A                   (256'h3F800F00B012B1025000F1024100D1089112F01270805000F1024100D108F012),
                 .INIT_1B                   (256'h2075F0135008B0135000F102D108111271805000F102D108500001B441B7DF00),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000050003710),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'h620B42A2288AADDA88A226DDD88200B4342288A202282082082A888888888888),
                 .INITP_01                  (256'h2A55D103D0A802A55D102D00B402D00B402D00B402D00B402D00B77777777777),
                 .INITP_02                  (256'h2D580200B42A00A9542AD1002A55D102AD1002A55D102AD10028255D102AD100),
                 .INITP_03                  (256'h00000000000000000000000000000008A0A92ABD00A2628A2F440BD20A0968B4),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
     kcpsm6_rom( .ADDRARDADDR               (address_a[13:0]),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a[15:0]),
                 .DOPADOP                   (data_out_a[17:16]), 
                 .DIADI                     (data_in_a[15:0]),
                 .DIPADIP                   (data_in_a[17:16]), 
                 .WEA                       (2'b00),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b[13:0]),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b[15:0]),
                 .DOPBDOP                   (data_out_b[17:16]), 
                 .DIBDI                     (data_in_b[15:0]),
                 .DIPBDIP                   (data_in_b[17:16]), 
                 .WEBWE                     (we_b[3:0]),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0));
    end // v6;  
    // 
    //
    if (C_FAMILY == "7S") begin: akv7 
      //
      assign address_a[13:0] = {address[9:0], 4'b1111};
      assign instruction = data_out_a[17:0];
      assign data_in_a[17:0] = {16'b0000000000000000, address[11:10]};
      assign jtag_dout = data_out_b[17:0];
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b[17:0] = data_out_b[17:0];
        assign address_b[13:0] = 14'b11111111111111;
        assign we_b[3:0] = 4'b0000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b[17:0] = jtag_din[17:0];
        assign address_b[13:0] = {jtag_addr[9:0], 4'b1111};
        assign we_b[3:0] = {jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB18E1 #(.READ_WIDTH_A              (18),
                 .WRITE_WIDTH_A             (18),
                 .DOA_REG                   (0),
                 .INIT_A                    (18'b000000000000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (18'b000000000000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (18),
                 .WRITE_WIDTH_B             (18),
                 .DOB_REG                   (0),
                 .INIT_B                    (18'b000000000000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (18'b000000000000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .SIM_DEVICE                ("7SERIES"),
                 .INIT_00                   (256'hF6101642F60F1641F60E1626F60D1625F60C1624F60B1623F60A1622F6091621),
                 .INIT_01                   (256'h120211000068111012022018002B001BD60F1600F6131620F6121680F6111643),
                 .INIT_02                   (256'h1E051F001C06D20512F050000068120111040068120011000068121011D20068),
                 .INIT_03                   (256'h95026044D5003504950200551220017FDE031E02DE031E06017FDE031E00DE03),
                 .INIT_04                   (256'h2075D34DDE0F1E00DE0F1E01930150000100120030F7B013202B6049D5003502),
                 .INIT_05                   (256'hDE031E02DE031E06017FDE031E00DE031E05D2051201202B018AD3442000D32D),
                 .INIT_06                   (256'h1E07017FDE031E00DE031E05D104D205124050006055D2430067D2260184017F),
                 .INIT_07                   (256'hD323DE0F1E00DE0F1E0193012075607AD500350295025000017FDE031E02DE03),
                 .INIT_08                   (256'hD31A20C9D32220C2D32120BBD32420B4D31D20ADD31520A6D31C209FD31B2098),
                 .INIT_09                   (256'h1801209860D7D500350295021906180020752170D35A21BCD32A218ED32B20D0),
                 .INIT_0A                   (256'h95021909180320A660ECD5003502950219081802209F60D7D500350295021907),
                 .INIT_0B                   (256'hD50035029502190B180520B46127D50035029502190A180420AD6141D5003502),
                 .INIT_0C                   (256'h20C960D7D50035029502190D180720C260D7D50035029502190C180620BB615B),
                 .INIT_0D                   (256'h4706470601C0DD003D809D060D700730930120D060F1D50035029502190E1808),
                 .INIT_0E                   (256'h20F1DD003D10BD132075E780C79047D0AD8007309301016BE780C79047064706),
                 .INIT_0F                   (256'h9301016BE780C790470647064706470601C0DD003D809D030D7007309301210B),
                 .INIT_10                   (256'h3D809D020D70073093012075E780C79001C0DD003D809D240D7047D0AD800730),
                 .INIT_11                   (256'h0D7047D0AD8007309301016BE7804700B012C790470647064706470601C0DD00),
                 .INIT_12                   (256'h4706470601C0DD003D809D020D70073093012075E780C79001C0DD003D809D13),
                 .INIT_13                   (256'hE780C79001C0DD003D809D130D7047D0AD8007309301016BE780C79047064706),
                 .INIT_14                   (256'h9301016BE780C790470647064706470601C0DD003D809D040D70073093012075),
                 .INIT_15                   (256'h470647064706073093012075E780C79001C0DD003D809D320D7047D0AD800730),
                 .INIT_16                   (256'h5000216BD500350295022075E780C79047D0AD8007309301016BE780C7904706),
                 .INIT_17                   (256'h9E022177202BDA091B011A010068A2B0A1A01B091A00006801A03ADFBA131200),
                 .INIT_18                   (256'h7010B013500000681201110450001F011C01C4C0E4F094005000217FDE003E01),
                 .INIT_19                   (256'h70805000019F41A5DF003F809F130F10B012B102207501AC4196D0003010F013),
                 .INIT_1A                   (256'h3F800F00B012B1025000F1024100D1089112F01270805000F1024100D108F012),
                 .INIT_1B                   (256'h2075F0135008B0135000F102D108111271805000F102D108500001B441B7DF00),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000050003710),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'h620B42A2288AADDA88A226DDD88200B4342288A202282082082A888888888888),
                 .INITP_01                  (256'h2A55D103D0A802A55D102D00B402D00B402D00B402D00B402D00B77777777777),
                 .INITP_02                  (256'h2D580200B42A00A9542AD1002A55D102AD1002A55D102AD10028255D102AD100),
                 .INITP_03                  (256'h00000000000000000000000000000008A0A92ABD00A2628A2F440BD20A0968B4),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
     kcpsm6_rom( .ADDRARDADDR               (address_a[13:0]),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a[15:0]),
                 .DOPADOP                   (data_out_a[17:16]), 
                 .DIADI                     (data_in_a[15:0]),
                 .DIPADIP                   (data_in_a[17:16]), 
                 .WEA                       (2'b00),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b[13:0]),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b[15:0]),
                 .DOPBDOP                   (data_out_b[17:16]), 
                 .DIBDI                     (data_in_b[15:0]),
                 .DIPBDIP                   (data_in_b[17:16]), 
                 .WEBWE                     (we_b[3:0]),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0));
    end // akv7;  
    // 
  end // ram_1k_generate;
endgenerate
//  
generate
  if (C_RAM_SIZE_KWORDS == 2) begin : ram_2k_generate 
    //
    if (C_FAMILY == "S6") begin: s6 
      //
      assign address_a[13:0] = {address[10:0], 3'b000};
      assign instruction = {data_out_a_h[32], data_out_a_h[7:0], data_out_a_l[32], data_out_a_l[7:0]};
      assign data_in_a = {35'b00000000000000000000000000000000000, address[11]};
      assign jtag_dout = {data_out_b_h[32], data_out_b_h[7:0], data_out_b_l[32], data_out_b_l[7:0]};
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b_l = {3'b000, data_out_b_l[32], 24'b000000000000000000000000, data_out_b_l[7:0]};
        assign data_in_b_h = {3'b000, data_out_b_h[32], 24'b000000000000000000000000, data_out_b_h[7:0]};
        assign address_b[13:0] = 14'b00000000000000;
        assign we_b[3:0] = 4'b0000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b_h = {3'b000, jtag_din[17], 24'b000000000000000000000000, jtag_din[16:9]};
        assign data_in_b_l = {3'b000, jtag_din[8],  24'b000000000000000000000000, jtag_din[7:0]};
        assign address_b[13:0] = {jtag_addr[10:0], 3'b000};
        assign we_b[3:0] = {jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (9),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (9),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'h0200681002182B1B0F0013201280114310420F410E260D250C240B230A220921),
                   .INIT_01             (256'h024400040255207F030203067F03000305000605F0006801046800006810D268),
                   .INIT_02             (256'h030203067F0300030505012B8A44002D754D0F000F0101000000F7132B490002),
                   .INIT_03             (256'h230F000F0101757A000202007F030203077F030003050405400055436726847F),
                   .INIT_04             (256'h0198D7000202060075705ABC2A8E2BD01AC922C221BB24B41DAD15A61C9F1B98),
                   .INIT_05             (256'h0002020B05B4270002020A04AD410002020903A6EC00020208029FD700020207),
                   .INIT_06             (256'h0606C0008006703001D0F10002020E08C9D70002020D07C2D70002020C06BB5B),
                   .INIT_07             (256'h016B809006060606C00080037030010BF1001013758090D08030016B80900606),
                   .INIT_08             (256'h70D08030016B8000129006060606C0008002703001758090C000802470D08030),
                   .INIT_09             (256'h8090C000801370D08030016B809006060606C0008002703001758090C0008013),
                   .INIT_0A             (256'h0606063001758090C000803270D08030016B809006060606C000800470300175),
                   .INIT_0B             (256'h02772B09010168B0A0090068A0DF1300006B000202758090D08030016B809006),
                   .INIT_0C             (256'h80009FA500801310120275AC96001013101300680104000101C0F000007F0001),
                   .INIT_0D             (256'h75130813000208128000020800B4B70080001202000200081212800002000812),
                   .INIT_0E             (256'h0000000000000000000000000000000000000000000000000000000000000010),
                   .INIT_0F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_10             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_11             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_12             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_13             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_14             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_15             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_16             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_17             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_18             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_19             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'hFFFF77FFFF9E3C79F3E7C78F1E7EAAAA84E84203080D4283B908409250000000),
                   .INITP_01            (256'h000000000000000107B7D78E3F58050448C87BFFFBFFFFFEFFFFFFBFFF7FFBFF),
                   .INITP_02            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_03            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
     kcpsm6_rom_l( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a_l[31:0]),
                   .DOPA                (data_out_a_l[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b_l[31:0]),
                   .DOPB                (data_out_b_l[35:32]), 
                   .DIB                 (data_in_b_l[31:0]),
                   .DIPB                (data_in_b_l[35:32]), 
                   .WEB                 (we_b[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (9),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (9),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'h09080008091000006B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B),
                   .INIT_01             (256'h4AB0EA1A4A0009006F0F6F0F006F0F6F0F0F0E69092800090800090800090800),
                   .INIT_02             (256'h6F0F6F0F006F0F6F0F69891080E990E990E96F0F6F0F49280009185810B0EA1A),
                   .INIT_03             (256'hE96F0F6F0F4910B0EA1A4A28006F0F6F0F006F0F6F0F68690928B0E980E90000),
                   .INIT_04             (256'h0C10B0EA1A4A0C0C1090E990E990E990E990E990E990E990E990E990E990E990),
                   .INIT_05             (256'hEA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C),
                   .INIT_06             (256'hA3A380EE1ECE06034910B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0),
                   .INIT_07             (256'h49007363A3A3A3A380EE1ECE0603499090EE1E5E10736323560349007363A3A3),
                   .INIT_08             (256'h06235603490073235863A3A3A3A380EE1ECE06034910736380EE1ECE06235603),
                   .INIT_09             (256'h736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910736380EE1ECE),
                   .INIT_0A             (256'hA3A3A3034910736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910),
                   .INIT_0B             (256'h4F1090ED8D8D0051500D0D00001D5D092890EA1A4A10736323560349007363A3),
                   .INIT_0C             (256'h382880A0EF1FCF0758581080A0E81878385828000908288F8E62724A2890EF1F),
                   .INIT_0D             (256'h1078285828786888382878682880A0EF1F07585828782068C878382878206878),
                   .INIT_0E             (256'h000000000000000000000000000000000000000000000000000000000000281B),
                   .INIT_0F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_10             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_11             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_12             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_13             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_14             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_15             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_16             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_17             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_18             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_19             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'h70818E1C2060C183060C183060D55555531D6BEBAD5AA90C45AD164927AAAAAA),
                   .INITP_01            (256'h0000000000000002CE7E0D5B7039326C6210C70E07807081E01C207806420780),
                   .INITP_02            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_03            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
     kcpsm6_rom_h( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a_h[31:0]),
                   .DOPA                (data_out_a_h[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b_h[31:0]),
                   .DOPB                (data_out_b_h[35:32]), 
                   .DIB                 (data_in_b_h[31:0]),
                   .DIPB                (data_in_b_h[35:32]), 
                   .WEB                 (we_b[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
    end // s6;
    // 
    // 
    if (C_FAMILY == "V6") begin: v6 
      //
      assign address_a = {1'b1, address[10:0], 4'b1111};
      assign instruction = {data_out_a[33:32], data_out_a[15:0]};
      assign data_in_a = {35'b00000000000000000000000000000000000, address[11]};
      assign jtag_dout = {data_out_b[33:32], data_out_b[15:0]};
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b = {2'b00, data_out_b[33:32], 16'b0000000000000000, data_out_b[15:0]};
        assign address_b = 16'b1111111111111111;
        assign we_b = 8'b00000000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b = {2'b00, jtag_din[17:16], 16'b0000000000000000, jtag_din[15:0]};
        assign address_b = {1'b1, jtag_addr[10:0], 4'b1111};
        assign we_b = {jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB36E1 #(.READ_WIDTH_A              (18),
                 .WRITE_WIDTH_A             (18),
                 .DOA_REG                   (0),
                 .INIT_A                    (36'h000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (36'h000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (18),
                 .WRITE_WIDTH_B             (18),
                 .DOB_REG                   (0),
                 .INIT_B                    (36'h000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (36'h000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .EN_ECC_READ               ("FALSE"),
                 .EN_ECC_WRITE              ("FALSE"),
                 .RAM_EXTENSION_A           ("NONE"),
                 .RAM_EXTENSION_B           ("NONE"),
                 .SIM_DEVICE                ("VIRTEX6"),
                 .INIT_00                   (256'hF6101642F60F1641F60E1626F60D1625F60C1624F60B1623F60A1622F6091621),
                 .INIT_01                   (256'h120211000068111012022018002B001BD60F1600F6131620F6121680F6111643),
                 .INIT_02                   (256'h1E051F001C06D20512F050000068120111040068120011000068121011D20068),
                 .INIT_03                   (256'h95026044D5003504950200551220017FDE031E02DE031E06017FDE031E00DE03),
                 .INIT_04                   (256'h2075D34DDE0F1E00DE0F1E01930150000100120030F7B013202B6049D5003502),
                 .INIT_05                   (256'hDE031E02DE031E06017FDE031E00DE031E05D2051201202B018AD3442000D32D),
                 .INIT_06                   (256'h1E07017FDE031E00DE031E05D104D205124050006055D2430067D2260184017F),
                 .INIT_07                   (256'hD323DE0F1E00DE0F1E0193012075607AD500350295025000017FDE031E02DE03),
                 .INIT_08                   (256'hD31A20C9D32220C2D32120BBD32420B4D31D20ADD31520A6D31C209FD31B2098),
                 .INIT_09                   (256'h1801209860D7D500350295021906180020752170D35A21BCD32A218ED32B20D0),
                 .INIT_0A                   (256'h95021909180320A660ECD5003502950219081802209F60D7D500350295021907),
                 .INIT_0B                   (256'hD50035029502190B180520B46127D50035029502190A180420AD6141D5003502),
                 .INIT_0C                   (256'h20C960D7D50035029502190D180720C260D7D50035029502190C180620BB615B),
                 .INIT_0D                   (256'h4706470601C0DD003D809D060D700730930120D060F1D50035029502190E1808),
                 .INIT_0E                   (256'h20F1DD003D10BD132075E780C79047D0AD8007309301016BE780C79047064706),
                 .INIT_0F                   (256'h9301016BE780C790470647064706470601C0DD003D809D030D7007309301210B),
                 .INIT_10                   (256'h3D809D020D70073093012075E780C79001C0DD003D809D240D7047D0AD800730),
                 .INIT_11                   (256'h0D7047D0AD8007309301016BE7804700B012C790470647064706470601C0DD00),
                 .INIT_12                   (256'h4706470601C0DD003D809D020D70073093012075E780C79001C0DD003D809D13),
                 .INIT_13                   (256'hE780C79001C0DD003D809D130D7047D0AD8007309301016BE780C79047064706),
                 .INIT_14                   (256'h9301016BE780C790470647064706470601C0DD003D809D040D70073093012075),
                 .INIT_15                   (256'h470647064706073093012075E780C79001C0DD003D809D320D7047D0AD800730),
                 .INIT_16                   (256'h5000216BD500350295022075E780C79047D0AD8007309301016BE780C7904706),
                 .INIT_17                   (256'h9E022177202BDA091B011A010068A2B0A1A01B091A00006801A03ADFBA131200),
                 .INIT_18                   (256'h7010B013500000681201110450001F011C01C4C0E4F094005000217FDE003E01),
                 .INIT_19                   (256'h70805000019F41A5DF003F809F130F10B012B102207501AC4196D0003010F013),
                 .INIT_1A                   (256'h3F800F00B012B1025000F1024100D1089112F01270805000F1024100D108F012),
                 .INIT_1B                   (256'h2075F0135008B0135000F102D108111271805000F102D108500001B441B7DF00),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000050003710),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_40                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'h620B42A2288AADDA88A226DDD88200B4342288A202282082082A888888888888),
                 .INITP_01                  (256'h2A55D103D0A802A55D102D00B402D00B402D00B402D00B402D00B77777777777),
                 .INITP_02                  (256'h2D580200B42A00A9542AD1002A55D102AD1002A55D102AD10028255D102AD100),
                 .INITP_03                  (256'h00000000000000000000000000000008A0A92ABD00A2628A2F440BD20A0968B4),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0F                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
     kcpsm6_rom( .ADDRARDADDR               (address_a),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a[31:0]),
                 .DOPADOP                   (data_out_a[35:32]), 
                 .DIADI                     (data_in_a[31:0]),
                 .DIPADIP                   (data_in_a[35:32]), 
                 .WEA                       (4'b0000),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b[31:0]),
                 .DOPBDOP                   (data_out_b[35:32]), 
                 .DIBDI                     (data_in_b[31:0]),
                 .DIPBDIP                   (data_in_b[35:32]), 
                 .WEBWE                     (we_b),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0),
                 .CASCADEINA                (1'b0),
                 .CASCADEINB                (1'b0),
                 .CASCADEOUTA               (),
                 .CASCADEOUTB               (),
                 .DBITERR                   (),
                 .ECCPARITY                 (),
                 .RDADDRECC                 (),
                 .SBITERR                   (),
                 .INJECTDBITERR             (1'b0),       
                 .INJECTSBITERR             (1'b0));   
    end // v6;  
    // 
    // 
    if (C_FAMILY == "7S") begin: akv7 
      //
      assign address_a = {1'b1, address[10:0], 4'b1111};
      assign instruction = {data_out_a[33:32], data_out_a[15:0]};
      assign data_in_a = {35'b00000000000000000000000000000000000, address[11]};
      assign jtag_dout = {data_out_b[33:32], data_out_b[15:0]};
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b = {2'b00, data_out_b[33:32], 16'b0000000000000000, data_out_b[15:0]};
        assign address_b = 16'b1111111111111111;
        assign we_b = 8'b00000000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b = {2'b00, jtag_din[17:16], 16'b0000000000000000, jtag_din[15:0]};
        assign address_b = {1'b1, jtag_addr[10:0], 4'b1111};
        assign we_b = {jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB36E1 #(.READ_WIDTH_A              (18),
                 .WRITE_WIDTH_A             (18),
                 .DOA_REG                   (0),
                 .INIT_A                    (36'h000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (36'h000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (18),
                 .WRITE_WIDTH_B             (18),
                 .DOB_REG                   (0),
                 .INIT_B                    (36'h000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (36'h000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .EN_ECC_READ               ("FALSE"),
                 .EN_ECC_WRITE              ("FALSE"),
                 .RAM_EXTENSION_A           ("NONE"),
                 .RAM_EXTENSION_B           ("NONE"),
                 .SIM_DEVICE                ("7SERIES"),
                 .INIT_00                   (256'hF6101642F60F1641F60E1626F60D1625F60C1624F60B1623F60A1622F6091621),
                 .INIT_01                   (256'h120211000068111012022018002B001BD60F1600F6131620F6121680F6111643),
                 .INIT_02                   (256'h1E051F001C06D20512F050000068120111040068120011000068121011D20068),
                 .INIT_03                   (256'h95026044D5003504950200551220017FDE031E02DE031E06017FDE031E00DE03),
                 .INIT_04                   (256'h2075D34DDE0F1E00DE0F1E01930150000100120030F7B013202B6049D5003502),
                 .INIT_05                   (256'hDE031E02DE031E06017FDE031E00DE031E05D2051201202B018AD3442000D32D),
                 .INIT_06                   (256'h1E07017FDE031E00DE031E05D104D205124050006055D2430067D2260184017F),
                 .INIT_07                   (256'hD323DE0F1E00DE0F1E0193012075607AD500350295025000017FDE031E02DE03),
                 .INIT_08                   (256'hD31A20C9D32220C2D32120BBD32420B4D31D20ADD31520A6D31C209FD31B2098),
                 .INIT_09                   (256'h1801209860D7D500350295021906180020752170D35A21BCD32A218ED32B20D0),
                 .INIT_0A                   (256'h95021909180320A660ECD5003502950219081802209F60D7D500350295021907),
                 .INIT_0B                   (256'hD50035029502190B180520B46127D50035029502190A180420AD6141D5003502),
                 .INIT_0C                   (256'h20C960D7D50035029502190D180720C260D7D50035029502190C180620BB615B),
                 .INIT_0D                   (256'h4706470601C0DD003D809D060D700730930120D060F1D50035029502190E1808),
                 .INIT_0E                   (256'h20F1DD003D10BD132075E780C79047D0AD8007309301016BE780C79047064706),
                 .INIT_0F                   (256'h9301016BE780C790470647064706470601C0DD003D809D030D7007309301210B),
                 .INIT_10                   (256'h3D809D020D70073093012075E780C79001C0DD003D809D240D7047D0AD800730),
                 .INIT_11                   (256'h0D7047D0AD8007309301016BE7804700B012C790470647064706470601C0DD00),
                 .INIT_12                   (256'h4706470601C0DD003D809D020D70073093012075E780C79001C0DD003D809D13),
                 .INIT_13                   (256'hE780C79001C0DD003D809D130D7047D0AD8007309301016BE780C79047064706),
                 .INIT_14                   (256'h9301016BE780C790470647064706470601C0DD003D809D040D70073093012075),
                 .INIT_15                   (256'h470647064706073093012075E780C79001C0DD003D809D320D7047D0AD800730),
                 .INIT_16                   (256'h5000216BD500350295022075E780C79047D0AD8007309301016BE780C7904706),
                 .INIT_17                   (256'h9E022177202BDA091B011A010068A2B0A1A01B091A00006801A03ADFBA131200),
                 .INIT_18                   (256'h7010B013500000681201110450001F011C01C4C0E4F094005000217FDE003E01),
                 .INIT_19                   (256'h70805000019F41A5DF003F809F130F10B012B102207501AC4196D0003010F013),
                 .INIT_1A                   (256'h3F800F00B012B1025000F1024100D1089112F01270805000F1024100D108F012),
                 .INIT_1B                   (256'h2075F0135008B0135000F102D108111271805000F102D108500001B441B7DF00),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000050003710),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_40                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'h620B42A2288AADDA88A226DDD88200B4342288A202282082082A888888888888),
                 .INITP_01                  (256'h2A55D103D0A802A55D102D00B402D00B402D00B402D00B402D00B77777777777),
                 .INITP_02                  (256'h2D580200B42A00A9542AD1002A55D102AD1002A55D102AD10028255D102AD100),
                 .INITP_03                  (256'h00000000000000000000000000000008A0A92ABD00A2628A2F440BD20A0968B4),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0F                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
     kcpsm6_rom( .ADDRARDADDR               (address_a),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a[31:0]),
                 .DOPADOP                   (data_out_a[35:32]), 
                 .DIADI                     (data_in_a[31:0]),
                 .DIPADIP                   (data_in_a[35:32]), 
                 .WEA                       (4'b0000),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b[31:0]),
                 .DOPBDOP                   (data_out_b[35:32]), 
                 .DIBDI                     (data_in_b[31:0]),
                 .DIPBDIP                   (data_in_b[35:32]), 
                 .WEBWE                     (we_b),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0),
                 .CASCADEINA                (1'b0),
                 .CASCADEINB                (1'b0),
                 .CASCADEOUTA               (),
                 .CASCADEOUTB               (),
                 .DBITERR                   (),
                 .ECCPARITY                 (),
                 .RDADDRECC                 (),
                 .SBITERR                   (),
                 .INJECTDBITERR             (1'b0),       
                 .INJECTSBITERR             (1'b0));   
    end // akv7;  
    // 
  end // ram_2k_generate;
endgenerate              
//
generate
  if (C_RAM_SIZE_KWORDS == 4) begin : ram_4k_generate 
    if (C_FAMILY == "S6") begin: s6 
      //
      assign address_a[13:0] = {address[10:0], 3'b000};
      assign data_in_a = 36'b000000000000000000000000000000000000;
      //
      FD s6_a11_flop ( .D      (address[11]),
                       .Q      (pipe_a11),
                       .C      (clk));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
       s6_4k_mux0_lut( .I0     (data_out_a_ll[0]),
                       .I1     (data_out_a_hl[0]),
                       .I2     (data_out_a_ll[1]),
                       .I3     (data_out_a_hl[1]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[0]),
                       .O6     (instruction[1]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
       s6_4k_mux2_lut( .I0     (data_out_a_ll[2]),
                       .I1     (data_out_a_hl[2]),
                       .I2     (data_out_a_ll[3]),
                       .I3     (data_out_a_hl[3]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[2]),
                       .O6     (instruction[3]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
       s6_4k_mux4_lut( .I0     (data_out_a_ll[4]),
                       .I1     (data_out_a_hl[4]),
                       .I2     (data_out_a_ll[5]),
                       .I3     (data_out_a_hl[5]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[4]),
                       .O6     (instruction[5]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
       s6_4k_mux6_lut( .I0     (data_out_a_ll[6]),
                       .I1     (data_out_a_hl[6]),
                       .I2     (data_out_a_ll[7]),
                       .I3     (data_out_a_hl[7]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[6]),
                       .O6     (instruction[7]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
       s6_4k_mux8_lut( .I0     (data_out_a_ll[32]),
                       .I1     (data_out_a_hl[32]),
                       .I2     (data_out_a_lh[0]),
                       .I3     (data_out_a_hh[0]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[8]),
                       .O6     (instruction[9]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
      s6_4k_mux10_lut( .I0     (data_out_a_lh[1]),
                       .I1     (data_out_a_hh[1]),
                       .I2     (data_out_a_lh[2]),
                       .I3     (data_out_a_hh[2]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[10]),
                       .O6     (instruction[11]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
      s6_4k_mux12_lut( .I0     (data_out_a_lh[3]),
                       .I1     (data_out_a_hh[3]),
                       .I2     (data_out_a_lh[4]),
                       .I3     (data_out_a_hh[4]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[12]),
                       .O6     (instruction[13]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
      s6_4k_mux14_lut( .I0     (data_out_a_lh[5]),
                       .I1     (data_out_a_hh[5]),
                       .I2     (data_out_a_lh[6]),
                       .I3     (data_out_a_hh[6]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[14]),
                       .O6     (instruction[15]));
      //
      LUT6_2 # (       .INIT   (64'hFF00F0F0CCCCAAAA))
      s6_4k_mux16_lut( .I0     (data_out_a_lh[7]),
                       .I1     (data_out_a_hh[7]),
                       .I2     (data_out_a_lh[32]),
                       .I3     (data_out_a_hh[32]),
                       .I4     (pipe_a11),
                       .I5     (1'b1),
                       .O5     (instruction[16]),
                       .O6     (instruction[17]));
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b_ll = {3'b000, data_out_b_ll[32], 24'b000000000000000000000000, data_out_b_ll[7:0]};
        assign data_in_b_lh = {3'b000, data_out_b_lh[32], 24'b000000000000000000000000, data_out_b_lh[7:0]};
        assign data_in_b_hl = {3'b000, data_out_b_hl[32], 24'b000000000000000000000000, data_out_b_hl[7:0]};
        assign data_in_b_hh = {3'b000, data_out_b_hh[32], 24'b000000000000000000000000, data_out_b_hh[7:0]};
        assign address_b[13:0] = 14'b00000000000000;
        assign we_b_l[3:0] = 4'b0000;
        assign we_b_h[3:0] = 4'b0000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
        assign jtag_dout = {data_out_b_h[32], data_out_b_h[7:0], data_out_b_l[32], data_out_b_l[7:0]};
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b_lh = {3'b000, jtag_din[17], 24'b000000000000000000000000, jtag_din[16:9]};
        assign data_in_b_ll = {3'b000, jtag_din[8],  24'b000000000000000000000000, jtag_din[7:0]};
        assign data_in_b_hh = {3'b000, jtag_din[17], 24'b000000000000000000000000, jtag_din[16:9]};
        assign data_in_b_hl = {3'b000, jtag_din[8],  24'b000000000000000000000000, jtag_din[7:0]};
        assign address_b[13:0] = {jtag_addr[10:0], 3'b000};
        //
        LUT6_2 # (         .INIT   (64'h8000000020000000))
        s6_4k_jtag_we_lut( .I0     (jtag_we),
                           .I1     (jtag_addr[11]),
                           .I2     (1'b1),
                           .I3     (1'b1),
                           .I4     (1'b1),
                           .I5     (1'b1),
                           .O5     (jtag_we_l),
                           .O6     (jtag_we_h));
        //
        assign we_b_l[3:0] = {jtag_we_l, jtag_we_l, jtag_we_l, jtag_we_l};
        assign we_b_h[3:0] = {jtag_we_h, jtag_we_h, jtag_we_h, jtag_we_h};
        //
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
         s6_4k_jtag_mux0_lut( .I0     (data_out_b_ll[0]),
                              .I1     (data_out_b_hl[0]),
                              .I2     (data_out_b_ll[1]),
                              .I3     (data_out_b_hl[1]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[0]),
                              .O6     (jtag_dout[1]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
         s6_4k_jtag_mux2_lut( .I0     (data_out_b_ll[2]),
                              .I1     (data_out_b_hl[2]),
                              .I2     (data_out_b_ll[3]),
                              .I3     (data_out_b_hl[3]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[2]),
                              .O6     (jtag_dout[3]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
         s6_4k_jtag_mux4_lut( .I0     (data_out_b_ll[4]),
                              .I1     (data_out_b_hl[4]),
                              .I2     (data_out_b_ll[5]),
                              .I3     (data_out_b_hl[5]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[4]),
                              .O6     (jtag_dout[5]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
         s6_4k_jtag_mux6_lut( .I0     (data_out_b_ll[6]),
                              .I1     (data_out_b_hl[6]),
                              .I2     (data_out_b_ll[7]),
                              .I3     (data_out_b_hl[7]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[6]),
                              .O6     (jtag_dout[7]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
         s6_4k_jtag_mux8_lut( .I0     (data_out_b_ll[32]),
                              .I1     (data_out_b_hl[32]),
                              .I2     (data_out_b_lh[0]),
                              .I3     (data_out_b_hh[0]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[8]),
                              .O6     (jtag_dout[9]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
        s6_4k_jtag_mux10_lut( .I0     (data_out_b_lh[1]),
                              .I1     (data_out_b_hh[1]),
                              .I2     (data_out_b_lh[2]),
                              .I3     (data_out_b_hh[2]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[10]),
                              .O6     (jtag_dout[11]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
        s6_4k_jtag_mux12_lut( .I0     (data_out_b_lh[3]),
                              .I1     (data_out_b_hh[3]),
                              .I2     (data_out_b_lh[4]),
                              .I3     (data_out_b_hh[4]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[12]),
                              .O6     (jtag_dout[13]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
        s6_4k_jtag_mux14_lut( .I0     (data_out_b_lh[5]),
                              .I1     (data_out_b_hh[5]),
                              .I2     (data_out_b_lh[6]),
                              .I3     (data_out_b_hh[6]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[14]),
                              .O6     (jtag_dout[15]));
        //
        LUT6_2 # (            .INIT   (64'hFF00F0F0CCCCAAAA))
        s6_4k_jtag_mux16_lut( .I0     (data_out_b_lh[7]),
                              .I1     (data_out_b_hh[7]),
                              .I2     (data_out_b_lh[32]),
                              .I3     (data_out_b_hh[32]),
                              .I4     (jtag_addr[11]),
                              .I5     (1'b1),
                              .O5     (jtag_dout[16]),
                              .O6     (jtag_dout[17]));
        //
      end // loader;
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (9),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (9),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'h0200681002182B1B0F0013201280114310420F410E260D250C240B230A220921),
                   .INIT_01             (256'h024400040255207F030203067F03000305000605F0006801046800006810D268),
                   .INIT_02             (256'h030203067F0300030505012B8A44002D754D0F000F0101000000F7132B490002),
                   .INIT_03             (256'h230F000F0101757A000202007F030203077F030003050405400055436726847F),
                   .INIT_04             (256'h0198D7000202060075705ABC2A8E2BD01AC922C221BB24B41DAD15A61C9F1B98),
                   .INIT_05             (256'h0002020B05B4270002020A04AD410002020903A6EC00020208029FD700020207),
                   .INIT_06             (256'h0606C0008006703001D0F10002020E08C9D70002020D07C2D70002020C06BB5B),
                   .INIT_07             (256'h016B809006060606C00080037030010BF1001013758090D08030016B80900606),
                   .INIT_08             (256'h70D08030016B8000129006060606C0008002703001758090C000802470D08030),
                   .INIT_09             (256'h8090C000801370D08030016B809006060606C0008002703001758090C0008013),
                   .INIT_0A             (256'h0606063001758090C000803270D08030016B809006060606C000800470300175),
                   .INIT_0B             (256'h02772B09010168B0A0090068A0DF1300006B000202758090D08030016B809006),
                   .INIT_0C             (256'h80009FA500801310120275AC96001013101300680104000101C0F000007F0001),
                   .INIT_0D             (256'h75130813000208128000020800B4B70080001202000200081212800002000812),
                   .INIT_0E             (256'h0000000000000000000000000000000000000000000000000000000000000010),
                   .INIT_0F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_10             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_11             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_12             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_13             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_14             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_15             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_16             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_17             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_18             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_19             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'hFFFF77FFFF9E3C79F3E7C78F1E7EAAAA84E84203080D4283B908409250000000),
                   .INITP_01            (256'h000000000000000107B7D78E3F58050448C87BFFFBFFFFFEFFFFFFBFFF7FFBFF),
                   .INITP_02            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_03            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
    kcpsm6_rom_ll( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a_ll[31:0]),
                   .DOPA                (data_out_a_ll[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b_ll[31:0]),
                   .DOPB                (data_out_b_ll[35:32]), 
                   .DIB                 (data_in_b_ll[31:0]),
                   .DIPB                (data_in_b_ll[35:32]), 
                   .WEB                 (we_b_l[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (9),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (9),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'h09080008091000006B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B),
                   .INIT_01             (256'h4AB0EA1A4A0009006F0F6F0F006F0F6F0F0F0E69092800090800090800090800),
                   .INIT_02             (256'h6F0F6F0F006F0F6F0F69891080E990E990E96F0F6F0F49280009185810B0EA1A),
                   .INIT_03             (256'hE96F0F6F0F4910B0EA1A4A28006F0F6F0F006F0F6F0F68690928B0E980E90000),
                   .INIT_04             (256'h0C10B0EA1A4A0C0C1090E990E990E990E990E990E990E990E990E990E990E990),
                   .INIT_05             (256'hEA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C),
                   .INIT_06             (256'hA3A380EE1ECE06034910B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0),
                   .INIT_07             (256'h49007363A3A3A3A380EE1ECE0603499090EE1E5E10736323560349007363A3A3),
                   .INIT_08             (256'h06235603490073235863A3A3A3A380EE1ECE06034910736380EE1ECE06235603),
                   .INIT_09             (256'h736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910736380EE1ECE),
                   .INIT_0A             (256'hA3A3A3034910736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910),
                   .INIT_0B             (256'h4F1090ED8D8D0051500D0D00001D5D092890EA1A4A10736323560349007363A3),
                   .INIT_0C             (256'h382880A0EF1FCF0758581080A0E81878385828000908288F8E62724A2890EF1F),
                   .INIT_0D             (256'h1078285828786888382878682880A0EF1F07585828782068C878382878206878),
                   .INIT_0E             (256'h000000000000000000000000000000000000000000000000000000000000281B),
                   .INIT_0F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_10             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_11             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_12             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_13             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_14             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_15             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_16             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_17             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_18             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_19             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'h70818E1C2060C183060C183060D55555531D6BEBAD5AA90C45AD164927AAAAAA),
                   .INITP_01            (256'h0000000000000002CE7E0D5B7039326C6210C70E07807081E01C207806420780),
                   .INITP_02            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_03            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
    kcpsm6_rom_lh( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a_lh[31:0]),
                   .DOPA                (data_out_a_lh[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b_lh[31:0]),
                   .DOPB                (data_out_b_lh[35:32]), 
                   .DIB                 (data_in_b_lh[31:0]),
                   .DIPB                (data_in_b_lh[35:32]), 
                   .WEB                 (we_b_l[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (9),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (9),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_01             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_02             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_03             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_04             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_05             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_06             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_07             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_08             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_09             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_10             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_11             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_12             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_13             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_14             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_15             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_16             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_17             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_18             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_19             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_01            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_02            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_03            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
    kcpsm6_rom_hl( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a_hl[31:0]),
                   .DOPA                (data_out_a_hl[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b_hl[31:0]),
                   .DOPB                (data_out_b_hl[35:32]), 
                   .DIB                 (data_in_b_hl[31:0]),
                   .DIPB                (data_in_b_hl[35:32]), 
                   .WEB                 (we_b_h[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
      // 
      RAMB16BWER #(.DATA_WIDTH_A        (9),
                   .DOA_REG             (0),
                   .EN_RSTRAM_A         ("FALSE"),
                   .INIT_A              (9'b000000000),
                   .RST_PRIORITY_A      ("CE"),
                   .SRVAL_A             (9'b000000000),
                   .WRITE_MODE_A        ("WRITE_FIRST"),
                   .DATA_WIDTH_B        (9),
                   .DOB_REG             (0),
                   .EN_RSTRAM_B         ("FALSE"),
                   .INIT_B              (9'b000000000),
                   .RST_PRIORITY_B      ("CE"),
                   .SRVAL_B             (9'b000000000),
                   .WRITE_MODE_B        ("WRITE_FIRST"),
                   .RSTTYPE             ("SYNC"),
                   .INIT_FILE           ("NONE"),
                   .SIM_COLLISION_CHECK ("ALL"),
                   .SIM_DEVICE          ("SPARTAN6"),
                   .INIT_00             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_01             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_02             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_03             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_04             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_05             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_06             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_07             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_08             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_09             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_0F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_10             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_11             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_12             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_13             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_14             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_15             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_16             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_17             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_18             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_19             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_1F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_20             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_21             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_22             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_23             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_24             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_25             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_26             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_27             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_28             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_29             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_2F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_30             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_31             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_32             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_33             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_34             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_35             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_36             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_37             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_38             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_39             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3A             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3B             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3C             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3D             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3E             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INIT_3F             (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_00            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_01            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_02            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_03            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_04            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_05            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_06            (256'h0000000000000000000000000000000000000000000000000000000000000000),
                   .INITP_07            (256'h0000000000000000000000000000000000000000000000000000000000000000))
    kcpsm6_rom_hh( .ADDRA               (address_a[13:0]),
                   .ENA                 (enable),
                   .CLKA                (clk),
                   .DOA                 (data_out_a_hh[31:0]),
                   .DOPA                (data_out_a_hh[35:32]), 
                   .DIA                 (data_in_a[31:0]),
                   .DIPA                (data_in_a[35:32]), 
                   .WEA                 (4'b0000),
                   .REGCEA              (1'b0),
                   .RSTA                (1'b0),
                   .ADDRB               (address_b[13:0]),
                   .ENB                 (enable_b),
                   .CLKB                (clk_b),
                   .DOB                 (data_out_b_hh[31:0]),
                   .DOPB                (data_out_b_hh[35:32]), 
                   .DIB                 (data_in_b_hh[31:0]),
                   .DIPB                (data_in_b_hh[35:32]), 
                   .WEB                 (we_b_h[3:0]),
                   .REGCEB              (1'b0),
                   .RSTB                (1'b0));
      //
    end // s6;
    //
    //
    if (C_FAMILY == "V6") begin: v6 
      //
      assign address_a = {1'b1, address[11:0], 3'b111};
      assign instruction = {data_out_a_h[32], data_out_a_h[7:0], data_out_a_l[32], data_out_a_l[7:0]};
      assign data_in_a = 36'b00000000000000000000000000000000000;
      assign jtag_dout = {data_out_b_h[32], data_out_b_h[7:0], data_out_b_l[32], data_out_b_l[7:0]};
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b_l = {3'b000, data_out_b_l[32], 24'b000000000000000000000000, data_out_b_l[7:0]};
        assign data_in_b_h = {3'b000, data_out_b_h[32], 24'b000000000000000000000000, data_out_b_h[7:0]};
        assign address_b = 16'b1111111111111111;
        assign we_b = 8'b00000000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b_h = {3'b000, jtag_din[17], 24'b000000000000000000000000, jtag_din[16:9]};
        assign data_in_b_l = {3'b000, jtag_din[8],  24'b000000000000000000000000, jtag_din[7:0]};
        assign address_b = {1'b1, jtag_addr[11:0], 3'b111};
        assign we_b = {jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB36E1 #(.READ_WIDTH_A              (9),
                 .WRITE_WIDTH_A             (9),
                 .DOA_REG                   (0),
                 .INIT_A                    (36'h000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (36'h000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (9),
                 .WRITE_WIDTH_B             (9),
                 .DOB_REG                   (0),
                 .INIT_B                    (36'h000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (36'h000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .EN_ECC_READ               ("FALSE"),
                 .EN_ECC_WRITE              ("FALSE"),
                 .RAM_EXTENSION_A           ("NONE"),
                 .RAM_EXTENSION_B           ("NONE"),
                 .SIM_DEVICE                ("VIRTEX6"),
                 .INIT_00                   (256'h0200681002182B1B0F0013201280114310420F410E260D250C240B230A220921),
                 .INIT_01                   (256'h024400040255207F030203067F03000305000605F0006801046800006810D268),
                 .INIT_02                   (256'h030203067F0300030505012B8A44002D754D0F000F0101000000F7132B490002),
                 .INIT_03                   (256'h230F000F0101757A000202007F030203077F030003050405400055436726847F),
                 .INIT_04                   (256'h0198D7000202060075705ABC2A8E2BD01AC922C221BB24B41DAD15A61C9F1B98),
                 .INIT_05                   (256'h0002020B05B4270002020A04AD410002020903A6EC00020208029FD700020207),
                 .INIT_06                   (256'h0606C0008006703001D0F10002020E08C9D70002020D07C2D70002020C06BB5B),
                 .INIT_07                   (256'h016B809006060606C00080037030010BF1001013758090D08030016B80900606),
                 .INIT_08                   (256'h70D08030016B8000129006060606C0008002703001758090C000802470D08030),
                 .INIT_09                   (256'h8090C000801370D08030016B809006060606C0008002703001758090C0008013),
                 .INIT_0A                   (256'h0606063001758090C000803270D08030016B809006060606C000800470300175),
                 .INIT_0B                   (256'h02772B09010168B0A0090068A0DF1300006B000202758090D08030016B809006),
                 .INIT_0C                   (256'h80009FA500801310120275AC96001013101300680104000101C0F000007F0001),
                 .INIT_0D                   (256'h75130813000208128000020800B4B70080001202000200081212800002000812),
                 .INIT_0E                   (256'h0000000000000000000000000000000000000000000000000000000000000010),
                 .INIT_0F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_10                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_11                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_12                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_13                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_14                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_15                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_16                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_17                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_18                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_19                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_40                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'hFFFF77FFFF9E3C79F3E7C78F1E7EAAAA84E84203080D4283B908409250000000),
                 .INITP_01                  (256'h000000000000000107B7D78E3F58050448C87BFFFBFFFFFEFFFFFFBFFF7FFBFF),
                 .INITP_02                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_03                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0F                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
   kcpsm6_rom_l( .ADDRARDADDR               (address_a),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a_l[31:0]),
                 .DOPADOP                   (data_out_a_l[35:32]), 
                 .DIADI                     (data_in_a[31:0]),
                 .DIPADIP                   (data_in_a[35:32]), 
                 .WEA                       (4'b0000),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b_l[31:0]),
                 .DOPBDOP                   (data_out_b_l[35:32]), 
                 .DIBDI                     (data_in_b_l[31:0]),
                 .DIPBDIP                   (data_in_b_l[35:32]), 
                 .WEBWE                     (we_b),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0),
                 .CASCADEINA                (1'b0),
                 .CASCADEINB                (1'b0),
                 .CASCADEOUTA               (),
                 .CASCADEOUTB               (),
                 .DBITERR                   (),
                 .ECCPARITY                 (),
                 .RDADDRECC                 (),
                 .SBITERR                   (),
                 .INJECTDBITERR             (1'b0),      
                 .INJECTSBITERR             (1'b0));   
      //
      RAMB36E1 #(.READ_WIDTH_A              (9),
                 .WRITE_WIDTH_A             (9),
                 .DOA_REG                   (0),
                 .INIT_A                    (36'h000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (36'h000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (9),
                 .WRITE_WIDTH_B             (9),
                 .DOB_REG                   (0),
                 .INIT_B                    (36'h000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (36'h000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .EN_ECC_READ               ("FALSE"),
                 .EN_ECC_WRITE              ("FALSE"),
                 .RAM_EXTENSION_A           ("NONE"),
                 .RAM_EXTENSION_B           ("NONE"),
                 .SIM_DEVICE                ("VIRTEX6"),
                 .INIT_00                   (256'h09080008091000006B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B),
                 .INIT_01                   (256'h4AB0EA1A4A0009006F0F6F0F006F0F6F0F0F0E69092800090800090800090800),
                 .INIT_02                   (256'h6F0F6F0F006F0F6F0F69891080E990E990E96F0F6F0F49280009185810B0EA1A),
                 .INIT_03                   (256'hE96F0F6F0F4910B0EA1A4A28006F0F6F0F006F0F6F0F68690928B0E980E90000),
                 .INIT_04                   (256'h0C10B0EA1A4A0C0C1090E990E990E990E990E990E990E990E990E990E990E990),
                 .INIT_05                   (256'hEA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C),
                 .INIT_06                   (256'hA3A380EE1ECE06034910B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0),
                 .INIT_07                   (256'h49007363A3A3A3A380EE1ECE0603499090EE1E5E10736323560349007363A3A3),
                 .INIT_08                   (256'h06235603490073235863A3A3A3A380EE1ECE06034910736380EE1ECE06235603),
                 .INIT_09                   (256'h736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910736380EE1ECE),
                 .INIT_0A                   (256'hA3A3A3034910736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910),
                 .INIT_0B                   (256'h4F1090ED8D8D0051500D0D00001D5D092890EA1A4A10736323560349007363A3),
                 .INIT_0C                   (256'h382880A0EF1FCF0758581080A0E81878385828000908288F8E62724A2890EF1F),
                 .INIT_0D                   (256'h1078285828786888382878682880A0EF1F07585828782068C878382878206878),
                 .INIT_0E                   (256'h000000000000000000000000000000000000000000000000000000000000281B),
                 .INIT_0F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_10                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_11                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_12                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_13                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_14                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_15                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_16                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_17                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_18                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_19                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_40                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'h70818E1C2060C183060C183060D55555531D6BEBAD5AA90C45AD164927AAAAAA),
                 .INITP_01                  (256'h0000000000000002CE7E0D5B7039326C6210C70E07807081E01C207806420780),
                 .INITP_02                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_03                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0F                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
   kcpsm6_rom_h( .ADDRARDADDR               (address_a),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a_h[31:0]),
                 .DOPADOP                   (data_out_a_h[35:32]), 
                 .DIADI                     (data_in_a[31:0]),
                 .DIPADIP                   (data_in_a[35:32]), 
                 .WEA                       (4'b0000),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b_h[31:0]),
                 .DOPBDOP                   (data_out_b_h[35:32]), 
                 .DIBDI                     (data_in_b_h[31:0]),
                 .DIPBDIP                   (data_in_b_h[35:32]), 
                 .WEBWE                     (we_b),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0),
                 .CASCADEINA                (1'b0),
                 .CASCADEINB                (1'b0),
                 .CASCADEOUTA               (),
                 .CASCADEOUTB               (),
                 .DBITERR                   (),
                 .ECCPARITY                 (),
                 .RDADDRECC                 (),
                 .SBITERR                   (),
                 .INJECTDBITERR             (1'b0),      
                 .INJECTSBITERR             (1'b0));  
    end // v6;  
    //
    //
    if (C_FAMILY == "7S") begin: akv7 
      //
      assign address_a = {1'b1, address[11:0], 3'b111};
      assign instruction = {data_out_a_h[32], data_out_a_h[7:0], data_out_a_l[32], data_out_a_l[7:0]};
      assign data_in_a = 36'b00000000000000000000000000000000000;
      assign jtag_dout = {data_out_b_h[32], data_out_b_h[7:0], data_out_b_l[32], data_out_b_l[7:0]};
      //
      if (C_JTAG_LOADER_ENABLE == 0) begin : no_loader
        assign data_in_b_l = {3'b000, data_out_b_l[32], 24'b000000000000000000000000, data_out_b_l[7:0]};
        assign data_in_b_h = {3'b000, data_out_b_h[32], 24'b000000000000000000000000, data_out_b_h[7:0]};
        assign address_b = 16'b1111111111111111;
        assign we_b = 8'b00000000;
        assign enable_b = 1'b0;
        assign rdl = 1'b0;
        assign clk_b = 1'b0;
      end // no_loader;
      //
      if (C_JTAG_LOADER_ENABLE == 1) begin : loader
        assign data_in_b_h = {3'b000, jtag_din[17], 24'b000000000000000000000000, jtag_din[16:9]};
        assign data_in_b_l = {3'b000, jtag_din[8],  24'b000000000000000000000000, jtag_din[7:0]};
        assign address_b = {1'b1, jtag_addr[11:0], 3'b111};
        assign we_b = {jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we, jtag_we};
        assign enable_b = jtag_en[0];
        assign rdl = rdl_bus[0];
        assign clk_b = jtag_clk;
      end // loader;
      // 
      RAMB36E1 #(.READ_WIDTH_A              (9),
                 .WRITE_WIDTH_A             (9),
                 .DOA_REG                   (0),
                 .INIT_A                    (36'h000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (36'h000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (9),
                 .WRITE_WIDTH_B             (9),
                 .DOB_REG                   (0),
                 .INIT_B                    (36'h000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (36'h000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .EN_ECC_READ               ("FALSE"),
                 .EN_ECC_WRITE              ("FALSE"),
                 .RAM_EXTENSION_A           ("NONE"),
                 .RAM_EXTENSION_B           ("NONE"),
                 .SIM_DEVICE                ("7SERIES"),
                 .INIT_00                   (256'h0200681002182B1B0F0013201280114310420F410E260D250C240B230A220921),
                 .INIT_01                   (256'h024400040255207F030203067F03000305000605F0006801046800006810D268),
                 .INIT_02                   (256'h030203067F0300030505012B8A44002D754D0F000F0101000000F7132B490002),
                 .INIT_03                   (256'h230F000F0101757A000202007F030203077F030003050405400055436726847F),
                 .INIT_04                   (256'h0198D7000202060075705ABC2A8E2BD01AC922C221BB24B41DAD15A61C9F1B98),
                 .INIT_05                   (256'h0002020B05B4270002020A04AD410002020903A6EC00020208029FD700020207),
                 .INIT_06                   (256'h0606C0008006703001D0F10002020E08C9D70002020D07C2D70002020C06BB5B),
                 .INIT_07                   (256'h016B809006060606C00080037030010BF1001013758090D08030016B80900606),
                 .INIT_08                   (256'h70D08030016B8000129006060606C0008002703001758090C000802470D08030),
                 .INIT_09                   (256'h8090C000801370D08030016B809006060606C0008002703001758090C0008013),
                 .INIT_0A                   (256'h0606063001758090C000803270D08030016B809006060606C000800470300175),
                 .INIT_0B                   (256'h02772B09010168B0A0090068A0DF1300006B000202758090D08030016B809006),
                 .INIT_0C                   (256'h80009FA500801310120275AC96001013101300680104000101C0F000007F0001),
                 .INIT_0D                   (256'h75130813000208128000020800B4B70080001202000200081212800002000812),
                 .INIT_0E                   (256'h0000000000000000000000000000000000000000000000000000000000000010),
                 .INIT_0F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_10                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_11                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_12                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_13                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_14                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_15                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_16                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_17                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_18                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_19                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_40                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'hFFFF77FFFF9E3C79F3E7C78F1E7EAAAA84E84203080D4283B908409250000000),
                 .INITP_01                  (256'h000000000000000107B7D78E3F58050448C87BFFFBFFFFFEFFFFFFBFFF7FFBFF),
                 .INITP_02                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_03                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0F                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
   kcpsm6_rom_l( .ADDRARDADDR               (address_a),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a_l[31:0]),
                 .DOPADOP                   (data_out_a_l[35:32]), 
                 .DIADI                     (data_in_a[31:0]),
                 .DIPADIP                   (data_in_a[35:32]), 
                 .WEA                       (4'b0000),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b_l[31:0]),
                 .DOPBDOP                   (data_out_b_l[35:32]), 
                 .DIBDI                     (data_in_b_l[31:0]),
                 .DIPBDIP                   (data_in_b_l[35:32]), 
                 .WEBWE                     (we_b),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0),
                 .CASCADEINA                (1'b0),
                 .CASCADEINB                (1'b0),
                 .CASCADEOUTA               (),
                 .CASCADEOUTB               (),
                 .DBITERR                   (),
                 .ECCPARITY                 (),
                 .RDADDRECC                 (),
                 .SBITERR                   (),
                 .INJECTDBITERR             (1'b0),      
                 .INJECTSBITERR             (1'b0));   
      //
      RAMB36E1 #(.READ_WIDTH_A              (9),
                 .WRITE_WIDTH_A             (9),
                 .DOA_REG                   (0),
                 .INIT_A                    (36'h000000000),
                 .RSTREG_PRIORITY_A         ("REGCE"),
                 .SRVAL_A                   (36'h000000000),
                 .WRITE_MODE_A              ("WRITE_FIRST"),
                 .READ_WIDTH_B              (9),
                 .WRITE_WIDTH_B             (9),
                 .DOB_REG                   (0),
                 .INIT_B                    (36'h000000000),
                 .RSTREG_PRIORITY_B         ("REGCE"),
                 .SRVAL_B                   (36'h000000000),
                 .WRITE_MODE_B              ("WRITE_FIRST"),
                 .INIT_FILE                 ("NONE"),
                 .SIM_COLLISION_CHECK       ("ALL"),
                 .RAM_MODE                  ("TDP"),
                 .RDADDR_COLLISION_HWCONFIG ("DELAYED_WRITE"),
                 .EN_ECC_READ               ("FALSE"),
                 .EN_ECC_WRITE              ("FALSE"),
                 .RAM_EXTENSION_A           ("NONE"),
                 .RAM_EXTENSION_B           ("NONE"),
                 .SIM_DEVICE                ("7SERIES"),
                 .INIT_00                   (256'h09080008091000006B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B7B0B),
                 .INIT_01                   (256'h4AB0EA1A4A0009006F0F6F0F006F0F6F0F0F0E69092800090800090800090800),
                 .INIT_02                   (256'h6F0F6F0F006F0F6F0F69891080E990E990E96F0F6F0F49280009185810B0EA1A),
                 .INIT_03                   (256'hE96F0F6F0F4910B0EA1A4A28006F0F6F0F006F0F6F0F68690928B0E980E90000),
                 .INIT_04                   (256'h0C10B0EA1A4A0C0C1090E990E990E990E990E990E990E990E990E990E990E990),
                 .INIT_05                   (256'hEA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C),
                 .INIT_06                   (256'hA3A380EE1ECE06034910B0EA1A4A0C0C10B0EA1A4A0C0C10B0EA1A4A0C0C10B0),
                 .INIT_07                   (256'h49007363A3A3A3A380EE1ECE0603499090EE1E5E10736323560349007363A3A3),
                 .INIT_08                   (256'h06235603490073235863A3A3A3A380EE1ECE06034910736380EE1ECE06235603),
                 .INIT_09                   (256'h736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910736380EE1ECE),
                 .INIT_0A                   (256'hA3A3A3034910736380EE1ECE0623560349007363A3A3A3A380EE1ECE06034910),
                 .INIT_0B                   (256'h4F1090ED8D8D0051500D0D00001D5D092890EA1A4A10736323560349007363A3),
                 .INIT_0C                   (256'h382880A0EF1FCF0758581080A0E81878385828000908288F8E62724A2890EF1F),
                 .INIT_0D                   (256'h1078285828786888382878682880A0EF1F07585828782068C878382878206878),
                 .INIT_0E                   (256'h000000000000000000000000000000000000000000000000000000000000281B),
                 .INIT_0F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_10                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_11                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_12                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_13                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_14                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_15                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_16                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_17                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_18                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_19                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_1F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_20                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_21                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_22                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_23                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_24                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_25                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_26                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_27                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_28                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_29                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_2F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_30                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_31                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_32                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_33                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_34                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_35                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_36                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_37                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_38                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_39                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_3F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_40                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_41                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_42                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_43                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_44                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_45                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_46                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_47                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_48                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_49                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_4F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_50                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_51                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_52                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_53                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_54                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_55                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_56                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_57                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_58                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_59                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_5F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_60                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_61                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_62                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_63                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_64                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_65                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_66                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_67                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_68                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_69                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_6F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_70                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_71                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_72                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_73                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_74                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_75                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_76                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_77                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_78                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_79                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7A                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7B                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7C                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7D                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7E                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INIT_7F                   (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_00                  (256'h70818E1C2060C183060C183060D55555531D6BEBAD5AA90C45AD164927AAAAAA),
                 .INITP_01                  (256'h0000000000000002CE7E0D5B7039326C6210C70E07807081E01C207806420780),
                 .INITP_02                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_03                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_04                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_05                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_06                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_07                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_08                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_09                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0A                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0B                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0C                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0D                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0E                  (256'h0000000000000000000000000000000000000000000000000000000000000000),
                 .INITP_0F                  (256'h0000000000000000000000000000000000000000000000000000000000000000))
   kcpsm6_rom_h( .ADDRARDADDR               (address_a),
                 .ENARDEN                   (enable),
                 .CLKARDCLK                 (clk),
                 .DOADO                     (data_out_a_h[31:0]),
                 .DOPADOP                   (data_out_a_h[35:32]), 
                 .DIADI                     (data_in_a[31:0]),
                 .DIPADIP                   (data_in_a[35:32]), 
                 .WEA                       (4'b0000),
                 .REGCEAREGCE               (1'b0),
                 .RSTRAMARSTRAM             (1'b0),
                 .RSTREGARSTREG             (1'b0),
                 .ADDRBWRADDR               (address_b),
                 .ENBWREN                   (enable_b),
                 .CLKBWRCLK                 (clk_b),
                 .DOBDO                     (data_out_b_h[31:0]),
                 .DOPBDOP                   (data_out_b_h[35:32]), 
                 .DIBDI                     (data_in_b_h[31:0]),
                 .DIPBDIP                   (data_in_b_h[35:32]), 
                 .WEBWE                     (we_b),
                 .REGCEB                    (1'b0),
                 .RSTRAMB                   (1'b0),
                 .RSTREGB                   (1'b0),
                 .CASCADEINA                (1'b0),
                 .CASCADEINB                (1'b0),
                 .CASCADEOUTA               (),
                 .CASCADEOUTB               (),
                 .DBITERR                   (),
                 .ECCPARITY                 (),
                 .RDADDRECC                 (),
                 .SBITERR                   (),
                 .INJECTDBITERR             (1'b0),      
                 .INJECTSBITERR             (1'b0));  
    end // akv7;  
    //
  end // ram_4k_generate;
endgenerate      
//
// JTAG Loader 
//
generate
  if (C_JTAG_LOADER_ENABLE == 1) begin: instantiate_loader
    jtag_loader_6  #(  .C_FAMILY              (C_FAMILY),
                       .C_NUM_PICOBLAZE       (1),
                       .C_JTAG_LOADER_ENABLE  (C_JTAG_LOADER_ENABLE),        
                       .C_BRAM_MAX_ADDR_WIDTH (BRAM_ADDRESS_WIDTH),        
                       .C_ADDR_WIDTH_0        (BRAM_ADDRESS_WIDTH))
    jtag_loader_6_inst(.picoblaze_reset       (rdl_bus),
                       .jtag_en               (jtag_en),
                       .jtag_din              (jtag_din),
                       .jtag_addr             (jtag_addr[BRAM_ADDRESS_WIDTH-1 : 0]),
                       .jtag_clk              (jtag_clk),
                       .jtag_we               (jtag_we),
                       .jtag_dout_0           (jtag_dout),
                       .jtag_dout_1           (jtag_dout),  // ports 1-7 are not used
                       .jtag_dout_2           (jtag_dout),  // in a 1 device debug 
                       .jtag_dout_3           (jtag_dout),  // session.  However, Synplify
                       .jtag_dout_4           (jtag_dout),  // etc require all ports are
                       .jtag_dout_5           (jtag_dout),  // connected
                       .jtag_dout_6           (jtag_dout),
                       .jtag_dout_7           (jtag_dout));  
    
  end //instantiate_loader
endgenerate 
//
//
endmodule
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////////
//
// JTAG Loader 
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//
// JTAG Loader 6 - Version 6.00
//
// Kris Chaplin - 4th February 2010
// Nick Sawyer  - 3rd March 2011 - Initial conversion to Verilog
// Ken Chapman  - 16th August 2011 - Revised coding style
//
`timescale 1ps/1ps
module jtag_loader_6 (picoblaze_reset, jtag_en, jtag_din, jtag_addr, jtag_clk, jtag_we, jtag_dout_0, jtag_dout_1, jtag_dout_2, jtag_dout_3, jtag_dout_4, jtag_dout_5, jtag_dout_6, jtag_dout_7);
//
parameter integer C_JTAG_LOADER_ENABLE = 1;
parameter         C_FAMILY = "V6";
parameter integer C_NUM_PICOBLAZE = 1;
parameter integer C_BRAM_MAX_ADDR_WIDTH = 10;
parameter integer C_PICOBLAZE_INSTRUCTION_DATA_WIDTH = 18;
parameter integer C_JTAG_CHAIN = 2;
parameter [4:0]   C_ADDR_WIDTH_0 = 10;
parameter [4:0]   C_ADDR_WIDTH_1 = 10;
parameter [4:0]   C_ADDR_WIDTH_2 = 10;
parameter [4:0]   C_ADDR_WIDTH_3 = 10;
parameter [4:0]   C_ADDR_WIDTH_4 = 10;
parameter [4:0]   C_ADDR_WIDTH_5 = 10;
parameter [4:0]   C_ADDR_WIDTH_6 = 10;
parameter [4:0]   C_ADDR_WIDTH_7 = 10;
//
output [C_NUM_PICOBLAZE-1:0]                    picoblaze_reset;
output [C_NUM_PICOBLAZE-1:0]                    jtag_en;
output [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_din;
output [C_BRAM_MAX_ADDR_WIDTH-1:0]              jtag_addr;
output                                          jtag_clk ;
output                                          jtag_we;  
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_0;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_1;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_2;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_3;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_4;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_5;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_6;
input  [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_7;
//
//
wire   [2:0]                                    num_picoblaze;        
wire   [4:0]                                    picoblaze_instruction_data_width; 
//
wire                                            drck;
wire                                            shift_clk;
wire                                            shift_din;
wire                                            shift_dout;
wire                                            shift;
wire                                            capture;
//
reg                                             control_reg_ce;
reg    [C_NUM_PICOBLAZE-1:0]                    bram_ce;
wire   [C_NUM_PICOBLAZE-1:0]                    bus_zero;
wire   [C_NUM_PICOBLAZE-1:0]                    jtag_en_int;
wire   [7:0]                                    jtag_en_expanded;
reg    [C_BRAM_MAX_ADDR_WIDTH-1:0]              jtag_addr_int;
reg    [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_din_int;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] control_din;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] control_dout;
reg    [7:0]                                    control_dout_int;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] bram_dout_int;
reg                                             jtag_we_int;
wire                                            jtag_clk_int;
wire                                            bram_ce_valid;
reg                                             din_load;
//                                                
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_0_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_1_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_2_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_3_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_4_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_5_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_6_masked;
wire   [C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:0] jtag_dout_7_masked;
reg    [C_NUM_PICOBLAZE-1:0]                    picoblaze_reset_int;
//
initial picoblaze_reset_int = 0;
//
genvar i;
//
generate
  for (i = 0; i <= C_NUM_PICOBLAZE-1; i = i+1)
    begin : npzero_loop
      assign bus_zero[i] = 1'b0;
    end
endgenerate
//
generate
  //
  if (C_JTAG_LOADER_ENABLE == 1)
    begin : jtag_loader_gen
      //
      // Insert BSCAN primitive for target device architecture.
      //
      if (C_FAMILY == "S6")
        begin : BSCAN_SPARTAN6_gen
          BSCAN_SPARTAN6 # (.JTAG_CHAIN (C_JTAG_CHAIN))
          BSCAN_BLOCK_inst (.CAPTURE    (capture),
                            .DRCK       (drck),
                            .RESET      (),
                            .RUNTEST    (),
                            .SEL        (bram_ce_valid),
                            .SHIFT      (shift),
                            .TCK        (),
                            .TDI        (shift_din),
                            .TMS        (),
                            .UPDATE     (jtag_clk_int),
                            .TDO        (shift_dout)); 
            
        end 
      //
      if (C_FAMILY == "V6")
        begin : BSCAN_VIRTEX6_gen
          BSCAN_VIRTEX6 # ( .JTAG_CHAIN   (C_JTAG_CHAIN),
                            .DISABLE_JTAG ("FALSE"))
          BSCAN_BLOCK_inst (.CAPTURE      (capture),
                            .DRCK         (drck),
                            .RESET        (),
                            .RUNTEST      (),
                            .SEL          (bram_ce_valid),
                            .SHIFT        (shift),
                            .TCK          (),
                            .TDI          (shift_din),
                            .TMS          (),
                            .UPDATE       (jtag_clk_int),
                            .TDO          (shift_dout));
        end 
      //
      if (C_FAMILY == "7S")
        begin : BSCAN_7SERIES_gen
          BSCANE2 # (       .JTAG_CHAIN   (C_JTAG_CHAIN),
                            .DISABLE_JTAG ("FALSE"))
          BSCAN_BLOCK_inst (.CAPTURE      (capture),
                            .DRCK         (drck),
                            .RESET        (),
                            .RUNTEST      (),
                            .SEL          (bram_ce_valid),
                            .SHIFT        (shift),
                            .TCK          (),
                            .TDI          (shift_din),
                            .TMS          (),
                            .UPDATE       (jtag_clk_int),
                            .TDO          (shift_dout));
        end 
      //
      // Insert clock buffer to ensure reliable shift operations.
      //
      BUFG upload_clock (.I (drck), .O (shift_clk));
      //        
      //
      // Shift Register 
      //
      always @ (posedge shift_clk) begin
        if (shift == 1'b1) begin
          control_reg_ce <= shift_din;
        end
      end
      // 
      always @ (posedge shift_clk) begin
        if (shift == 1'b1) begin
          bram_ce[0] <= control_reg_ce;
        end
      end 
      //
      for (i = 0; i <= C_NUM_PICOBLAZE-2; i = i+1)
      begin : loop0 
        if (C_NUM_PICOBLAZE > 1) begin
          always @ (posedge shift_clk) begin
            if (shift == 1'b1) begin
              bram_ce[i+1] <= bram_ce[i];
            end
          end
        end 
      end
      // 
      always @ (posedge shift_clk) begin
        if (shift == 1'b1) begin
          jtag_we_int <= bram_ce[C_NUM_PICOBLAZE-1];
        end
      end
      // 
      always @ (posedge shift_clk) begin 
        if (shift == 1'b1) begin
          jtag_addr_int[0] <= jtag_we_int;
        end
      end
      //
      for (i = 0; i <= C_BRAM_MAX_ADDR_WIDTH-2; i = i+1)
      begin : loop1
        always @ (posedge shift_clk) begin
          if (shift == 1'b1) begin
            jtag_addr_int[i+1] <= jtag_addr_int[i];
          end
        end 
      end
      // 
      always @ (posedge shift_clk) begin 
        if (din_load == 1'b1) begin
          jtag_din_int[0] <= bram_dout_int[0];
        end
        else if (shift == 1'b1) begin
          jtag_din_int[0] <= jtag_addr_int[C_BRAM_MAX_ADDR_WIDTH-1];
        end
      end       
      //
      for (i = 0; i <= C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-2; i = i+1)
      begin : loop2
        always @ (posedge shift_clk) begin
          if (din_load == 1'b1) begin
            jtag_din_int[i+1] <= bram_dout_int[i+1];
          end
          if (shift == 1'b1) begin
            jtag_din_int[i+1] <= jtag_din_int[i];
          end
        end 
      end
      //
      assign shift_dout = jtag_din_int[C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1];
      //
      //
      always @ (bram_ce or din_load or capture or bus_zero or control_reg_ce) begin
        if ( bram_ce == bus_zero ) begin
          din_load <= capture & control_reg_ce;
        end else begin
          din_load <= capture;
        end
      end
      //
      //
      // Control Registers 
      //
      assign num_picoblaze = C_NUM_PICOBLAZE-3'h1;
      assign picoblaze_instruction_data_width = C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-5'h01;
      //
      always @ (posedge jtag_clk_int) begin
        if (bram_ce_valid == 1'b1 && jtag_we_int == 1'b0 && control_reg_ce == 1'b1) begin
          case (jtag_addr_int[3:0]) 
            0 : // 0 = version - returns (7:4) illustrating number of PB
                // and [3:0] picoblaze instruction data width
                control_dout_int <= {num_picoblaze, picoblaze_instruction_data_width};
            1 : // 1 = PicoBlaze 0 reset / status
                if (C_NUM_PICOBLAZE >= 1) begin 
                  control_dout_int <= {picoblaze_reset_int[0], 2'b00, C_ADDR_WIDTH_0-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            2 : // 2 = PicoBlaze 1 reset / status
                if (C_NUM_PICOBLAZE >= 2) begin 
                  control_dout_int <= {picoblaze_reset_int[1], 2'b00, C_ADDR_WIDTH_1-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            3 : // 3 = PicoBlaze 2 reset / status
                if (C_NUM_PICOBLAZE >= 3) begin 
                  control_dout_int <= {picoblaze_reset_int[2], 2'b00, C_ADDR_WIDTH_2-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            4 : // 4 = PicoBlaze 3 reset / status
                if (C_NUM_PICOBLAZE >= 4) begin 
                  control_dout_int <= {picoblaze_reset_int[3], 2'b00, C_ADDR_WIDTH_3-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            5:  // 5 = PicoBlaze 4 reset / status
                if (C_NUM_PICOBLAZE >= 5) begin 
                  control_dout_int <= {picoblaze_reset_int[4], 2'b00, C_ADDR_WIDTH_4-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            6 : // 6 = PicoBlaze 5 reset / status
                if (C_NUM_PICOBLAZE >= 6) begin 
                  control_dout_int <= {picoblaze_reset_int[5], 2'b00, C_ADDR_WIDTH_5-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            7 : // 7 = PicoBlaze 6 reset / status
                if (C_NUM_PICOBLAZE >= 7) begin 
                  control_dout_int <= {picoblaze_reset_int[6], 2'b00, C_ADDR_WIDTH_6-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            8 : // 8 = PicoBlaze 7 reset / status
                if (C_NUM_PICOBLAZE >= 8) begin 
                  control_dout_int <= {picoblaze_reset_int[7], 2'b00, C_ADDR_WIDTH_7-5'h01};
                end else begin
                  control_dout_int <= 8'h00;
                end
            15 : control_dout_int <= C_BRAM_MAX_ADDR_WIDTH -1;
            default : control_dout_int <= 8'h00;
            //
          endcase
        end else begin
          control_dout_int <= 8'h00;
        end
      end 
      //
      assign control_dout[C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-1:C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-8] = control_dout_int;
      //
      always @ (posedge jtag_clk_int) begin
        if (bram_ce_valid == 1'b1 && jtag_we_int == 1'b1 && control_reg_ce == 1'b1) begin
          picoblaze_reset_int[C_NUM_PICOBLAZE-1:0] <= control_din[C_NUM_PICOBLAZE-1:0];
        end
      end     
      //
      //
      // Assignments 
      //
      if (C_PICOBLAZE_INSTRUCTION_DATA_WIDTH > 8) begin
        assign control_dout[C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-9:0] = 10'h000;
      end
      //
      // Qualify the blockram CS signal with bscan select output
      assign jtag_en_int = (bram_ce_valid) ? bram_ce : bus_zero;
      //
      assign jtag_en_expanded[C_NUM_PICOBLAZE-1:0] = jtag_en_int; 
      //
      for (i = 7; i >= C_NUM_PICOBLAZE; i = i-1)
        begin : loop4 
          if (C_NUM_PICOBLAZE < 8) begin : jtag_en_expanded_gen
            assign jtag_en_expanded[i] = 1'b0;
          end
        end
      //
      assign bram_dout_int = control_dout | jtag_dout_0_masked | jtag_dout_1_masked | jtag_dout_2_masked | jtag_dout_3_masked | jtag_dout_4_masked | jtag_dout_5_masked | jtag_dout_6_masked | jtag_dout_7_masked;
      //
      assign control_din = jtag_din_int;
      //
      assign jtag_dout_0_masked = (jtag_en_expanded[0]) ? jtag_dout_0 : 18'h00000;
      assign jtag_dout_1_masked = (jtag_en_expanded[1]) ? jtag_dout_1 : 18'h00000;
      assign jtag_dout_2_masked = (jtag_en_expanded[2]) ? jtag_dout_2 : 18'h00000;
      assign jtag_dout_3_masked = (jtag_en_expanded[3]) ? jtag_dout_3 : 18'h00000;
      assign jtag_dout_4_masked = (jtag_en_expanded[4]) ? jtag_dout_4 : 18'h00000;
      assign jtag_dout_5_masked = (jtag_en_expanded[5]) ? jtag_dout_5 : 18'h00000;
      assign jtag_dout_6_masked = (jtag_en_expanded[6]) ? jtag_dout_6 : 18'h00000;
      assign jtag_dout_7_masked = (jtag_en_expanded[7]) ? jtag_dout_7 : 18'h00000;
      //       
      assign jtag_en = jtag_en_int;
      assign jtag_din = jtag_din_int;
      assign jtag_addr = jtag_addr_int;
      assign jtag_clk = jtag_clk_int;
      assign jtag_we = jtag_we_int;
      assign picoblaze_reset = picoblaze_reset_int;
      //
    end
endgenerate
   //
endmodule
//
///////////////////////////////////////////////////////////////////////////////////////////
//
//  END OF FILE ROM_RTC.v
//
///////////////////////////////////////////////////////////////////////////////////////////
//
