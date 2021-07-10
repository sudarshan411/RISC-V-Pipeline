`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: Datapath_Complete
// Description: This is the RISC-V Processor with a pipelined datapath
// Name: Ashutosh Anand, Sudarshan Sundarrajan
// Roll Number: 191CS111, 191CS255
// Date: 12/04/2021
//////////////////////////////////////////////////////////////////////////////////


module Datapath_Complete(
	input clk, reset
);

	wire [31:0] instruction;
	reg [63:0] PC;
	wire [4:0] rd, rs1, rs2;
	wire [6:0] opcode;
	wire ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, select;
	wire [1:0] ALUop;
	reg [63:0] x[0:31];
	integer i;
	initial begin
		for(i = 0; i<31; i=i+1) begin 
			x[i] = i;
		end
	end
	
	
	assign rd = instruction[11:7];
	assign rs1 = instruction[19:15];
	assign rs2 = instruction[24:20];
	assign opcode = instruction[6:0];

	wire[63:0] rd1, rd2, wd, alu2, imm, alu_res, readd;
	wire[3:0] funct, ALUCtrl;
	wire ALU_OF, ALU_zero;
	assign rd1 = x[rs1];
	assign rd2 = x[rs2];
	assign select = Branch & ALU_zero;
    
	//Select input = (ALU_Zero) & (Branch)
    assign funct = {instruction[30], instruction[14:12]};
    
    initial begin 
    	PC = 0;
    end
    
    
    MainControlUnit MCU(opcode, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop);
    InstructionFetch InF(instruction, reset, clk, Branch, ALU_zero, PC, imm);
    SignExt SE(imm, instruction);
    MUX_RF_or_SE MUX1(alu2, rd2, imm, ALUsrc);
    ALU_Control ALUC(ALUCtrl, ALUop, funct);
    ALU_64b_CASCADE ALU(alu_res, ALU_OF, ALU_zero, rd1, alu2, ALUCtrl);
    MemoryBlock MEM(readd, alu_res, rd2, MemWrite, MemRead, clk);
    MUX_Mem_OR_ALU MUX2(wd, readd, alu_res, MemtoReg);
	
	always @(posedge clk) begin
		if(RegWrite == 1)
			x[rd] <= wd;
	end
//	always @(posedge clk) begin
//		$monitor ("Instruction: %0h, RD1: %0d, RD2: %0d, rd: %0d, rs1: %0d, rs2: %0d, ALUsrc: %b, MemtoReg: %b, RegWrite: %b, MemRead: %b, MemWrite: %b, Branch: %b, ALUop: %b"
//		          ,instruction, rd1, rd2, rd, rs1, rs2, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUop);
//	end
	always @(posedge clk) begin
		if(Branch == 1 & ALU_zero == 1) begin
			PC = PC + (imm << 1);
		end
		else
			PC = PC + 64'd4;
	end

    

endmodule
