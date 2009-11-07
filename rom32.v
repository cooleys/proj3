//-----------------------------------------------------------------------------
// Title         : Read-Only Memory (Instruction ROM)
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : rom32.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Behavioral model of a read-only memory used in the implementations of the MIPS
//   processor subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   Note the use of the Verilog concatenation operator to specify different
//   instruction fields in each memory element.
//
//-----------------------------------------------------------------------------

module rom32(address, data_out);
  input  [31:0] address;
  output [31:0] data_out;
  reg    [31:0] data_out;

  parameter BASE_ADDRESS = 25'd0; // address that applies to this memory

  wire [4:0] mem_offset;
  wire address_select;

  assign mem_offset = address[6:2];  // drop 2 LSBs to get word offset

  assign address_select = (address[31:7] == BASE_ADDRESS);  // address decoding

  always @(address_select or mem_offset)
  begin
    if ((address % 4) != 0) $display($time, " rom32 error: unaligned address %d", address);
    if (address_select == 1)
    begin
      case (mem_offset) 
          //Completely arbitrary assembly script to test addi, j, and bne
          5'd0 : data_out = { 6'd5, 26'd2 };             // jump  2 down
          5'd1 : data_out = { 6'd35, 5'd0, 5'd3, 16'd8 };             // lw $3, 8($0)    r3=2 COULD BE ANYTHING, added, to prove the jump skips it.
          5'd2 : data_out = { 6'd8, 5'd5, 5'd0, 16'd0 };  // addi $5, $0, 0  r5=0
          5'd3 : data_out = { 6'd8, 5'd5, 5'd5, 16'd5 };  // addi $5, $5, 5  r5=5
          5'd4 : data_out = { 6'd8, 5'd6, 5'd0, 16'd0 };  // addi $6, $0, 0  r6=0
          5'd5 : data_out = { 6'd8, 5'd6, 5'd5, 16'd1 };  // addi $6, $6, 1  r6=1
          5'd6 : data_out = { 6'd8, 5'd5, 5'd5, -16'd1 };  // addi $5, $5, -1  r5=r5 - 1 
          5'd7 : data_out = { 6'd5, 5'd5, 5'd6, -16'd2 };             // bne $5, $6, -2  if not, go back 1
          //5'd7 : data_out = { 6'd43, 5'd0, 5'd5, 16'd0 };             // MEM[0] = $5
          // add more cases here as desired
          default data_out = 32'hxxxx;
      endcase
      $display($time, " reading data: rom32[%h] => %h", address, data_out);
    end
  end 
endmodule

