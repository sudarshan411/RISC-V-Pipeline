`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: ALU_1b_NL
// Description: 1-bit ALU capable of doing Logical AND, OR, NAND and NOR,
//				Addition, Subtraction. For the slt operation, this module is
//				responsible for finding the difference between the MSBs of A
//				and B, and setting the flag accordingly in the 64-bit ALU.
// Name: Ashutosh Anand, Sudarshan Sundarrajan
// Roll Number: 191CS111, 191CS255
// Date: 12/03/2021
//////////////////////////////////////////////////////////////////////////////////


module ALU_1b_NL(
    output reg result, set, overflow,
    input A, B, A_in, B_in, less, c_in,
    input [1:0] op
);

    reg a, b, c_out;
    
    always@(*) begin
        
        //inverting A, if A_in is 1
        if(A_in) a = ~A; 
        else a = A;
        
        //inverting B, if B_in is 1
        if(B_in) b = ~B;
        else b = B;
        
        case(op)
            //Logical AND
            2'b00: begin
                        result = a&b;
                        c_out = 0;
                        overflow = 1'b0;
                   end
            //Logical OR
            2'b01: begin
                        result = a|b;
                        c_out = 0;
                        overflow = 1'b0;
                   end
            //Addition
            2'b10: begin
                        result = a^b^c_in;
                        c_out = (a&b) | (b&c_in) | (a&c_in);
                        overflow = c_in^c_out;
                   end
            //Set less than
            2'b11: begin
                        result = less;
                        set = a^b^c_in;
                        overflow = 0;
                   end
         endcase

         end
    
    
endmodule
