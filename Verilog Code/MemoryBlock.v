`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 12:15:24
// Design Name: 
// Module Name: MemoryBlock
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


module MemoryBlock(
	output reg [63:0] ReadData,
	input [63:0] address, WriteData,
	input MemWrite, MemRead, clk
);

	reg [63:0] mem[0:255];
	integer i;
	initial begin
		for(i=0; i<256; i = i+1) begin 
			mem[i] = i+256;
		end
	end
	
	always @(negedge clk) begin
		if(MemWrite == 1) begin 
			mem[address] = WriteData;
		end
		else if (MemRead == 1) begin
			ReadData = mem[address];
		end
	end
	
endmodule
