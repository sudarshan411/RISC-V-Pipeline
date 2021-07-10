`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 01:56:36
// Design Name: 
// Module Name: MUX_Mem_OR_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MUX_Mem_OR_ALU(
	output [63:0] out,
	input[63:0] mem, alu,
	input select
);

	assign out = select ? mem : alu;

endmodule
