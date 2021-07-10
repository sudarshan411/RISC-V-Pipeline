`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: ALU_64b_CASCADE
// Description: 64-bit ALU that is designed using 64 1-bit ALUs.
//				Capable of doing Logical AND, OR, NAND and NOR,
//				Addition, Subtraction, Set Less Than (slt)
// Name: Ashutosh Anand, Sudarshan Sundarrajan
// Roll Number: 191CS111, 191CS255
// Date: 13/03/2021
//////////////////////////////////////////////////////////////////////////////////


module ALU_64b_CASCADE(
	output[63:0] result,
    output overflow, zero,
    input[63:0] A, B,
    input[3:0] ALU_control
);

    
    wire [1:0] op;
    wire A_in, B_in, set, less;
    wire [63:0] carry;
    

    assign op = ALU_control[1:0];
    assign A_in = ALU_control[3];
    assign B_in = ALU_control[2];
    assign carry[0] = B_in;
    assign less = 0;
    
    assign zero = (result == 64'b0) ? 1'b1 : 1'b0;
    
    genvar i;
    
    ALU_1b alu_0(.result(result[0]), .c_out(carry[1]), .A(A[0]), .B(B[0]), .less(set), .A_in(A_in), .B_in(B_in), .c_in(carry[0]), .op(op));
    
    for(i=1; i<63; i=i+1)
    begin
    	ALU_1b alu_x(.result(result[i]), .c_out(carry[i+1]), .A(A[i]), .B(B[i]), .less(less), .A_in(A_in), .B_in(B_in), .c_in(carry[i]), .op(op));
    end
    
    ALU_1b_NL alu_63(.result(result[63]), .set(set), .overflow(overflow), .A(A[63]), .B(B[63]), .less(less), .A_in(A_in), .B_in(B_in), .c_in(carry[63]), .op(op));
    
        
endmodule
