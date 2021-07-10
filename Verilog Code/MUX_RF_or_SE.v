`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 01:50:39
// Design Name: 
// Module Name: MUX_RF_or_SE
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


module MUX_RF_or_SE(
	output [63:0] out,
	input[63:0] rf, se,
	input select
);

	assign out = select ? se : rf;

endmodule
