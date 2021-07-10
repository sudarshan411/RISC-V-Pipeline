`timescale 1ns / 1ps



module MainControlUnit(
	input [6:0]opcode,
	output reg ALUsrc,
	output reg MemtoReg,
	output reg RegWrite,
	output reg MemRead,
	output reg MemWrite,
	output reg Branch,
	output reg [1:0]ALUop
);
	
	always @(opcode) begin
		casex (opcode)
			7'b0110011: begin ALUsrc = 0;//R type
						RegWrite = 1;
						ALUop = 2'b10;
						MemWrite = 0;
						MemRead = 0;
						Branch = 0;
						MemtoReg = 0; end
			7'b0000011: begin ALUsrc = 1;//ld type
						RegWrite = 1;
						ALUop = 2'b00;
						MemWrite = 0;
						MemRead = 1;
						Branch = 0;
						MemtoReg = 1; end
			7'b0100011: begin ALUsrc = 1;//sd type
						RegWrite = 0;
						ALUop = 2'b00;
						MemWrite = 1;
						MemRead = 0;
						Branch = 0;
						MemtoReg = 1'bx; end
			7'b1100011:  begin ALUsrc = 0;//branch type
						RegWrite = 0;
						ALUop = 2'b01;
						MemWrite = 0;
						MemRead = 0;
						Branch = 1;
						MemtoReg = 1'bx; end
			default: begin	ALUsrc = 0;
						RegWrite = 0;
						ALUop = 2'b00;
						MemWrite = 0;
						MemRead = 0;
						Branch = 0;
						MemtoReg = 0; end
		endcase
	end
	
endmodule