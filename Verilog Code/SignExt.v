`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 01:29:02
// Design Name: 
// Module Name: SignExt
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


module SignExt(
	output reg [63:0] imm,
	input [31:0] instruction
);

	reg [31:0] temp;
	
	always @(instruction) begin
		temp = instruction;
		if(temp[6:0] == 7'b0000011 || temp[6:0] == 7'b0010011) begin
			imm[11:0] = temp[31:20];
			imm[63:12] = imm[11];
		end
		else if (temp[6:0] == 7'b0100011) begin
			imm[11:0] = {temp[31:25], temp[11:7]};
			imm[63:12] = imm[11];
		end
		else if (temp[6:0] == 7'b1100011) begin
			imm[11:0] = {temp[31], temp[7], temp[30:25], temp[11:8]};
			imm[63:12] = {52{imm[11]}};
		end
	end
	
endmodule
