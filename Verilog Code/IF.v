`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 18:16:55
// Design Name: 
// Module Name: IF
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

module PC(
	output reg [63:0] pc,
	input [63:0] PC_next,
	input clk, reset
);
   
	always@(posedge clk or posedge reset) begin 
		if(reset == 0)
			pc <= PC_next; 
		else if(reset == 1)
			pc = 0;
	end
endmodule

module InstructionMemory (
    output reg [31:0] instruction,
    input [63:0] PC,
    input clk
);
    reg [31:0] IM[0:63];
    
    initial begin
//        	IM[0] = 32'h000DB303;
//			IM[1] = 32'h001DB383;
//			IM[2] = 32'h002DBE03;
//			IM[3] = 32'h00600EB3;
//			IM[4] = 32'h007E8EB3;
//			IM[5] = 32'h01CE8EB3;
//			IM[6] = 32'b0;
			$readmemh("inst.mem", IM, 0, 5);
    end

    always @(posedge clk) begin
        instruction = IM[(PC-4)/4];
    end
endmodule


module InstructionFetch(
    output [31:0] ins,
    input reset, clk, Branch, ALU_zero,
    //branch, ALU_zero
    input [63:0] pc, imm
);
    // wire[63:0] PC_next;
	// wire[63:0] temp;
    
    // // reg [31:0] instruction
    // //changes start here
    // wire [63:0] Jump;
    // wire [63:0] PC4;
    // assign PC4 = PC_next + 4;
    // //immediate?
    // assign Jump = PC_next + (imm<<1);
    // PC_MUX PM(.PC_next(PC_next),/*branch, ALU_Zero*/,.Jump(Jump),.PC4(PC4));
    //changes endhere
    // PC Module -> pc as input to IM
    // based on opcode, we assign Branch accordingly
    // add accordingly and pass that to the mux
    
    // always @() begin
    InstructionMemory I(.instruction(ins), .PC(pc), .clk(clk));
    
    initial begin
    	$monitor("Instruction: %h, PC: %d", ins, pc);
     end
//    always @(posedge clk) begin
//		if(Branch == 1 & ALU_zero == 1) begin
//			pc = pc + (imm << 1);
//		end
//		else
//			pc = pc + 64'd4;
//	end
    
    // end


endmodule
