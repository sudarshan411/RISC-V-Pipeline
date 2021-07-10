`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: ALU_1b
// Description: 1-bit ALU capable of doing Logical AND, OR, NAND and NOR,
//				Addition, Subtraction. For the slt operation, this module is
//				responsible for calculating the difference between each bit, and
//				sending the carry-in for the next module in the 64-bit ALU.
// Name: Ashutosh Anand, Sudarshan Sundarrajan
// Roll Number: 191CS111, 191CS255
// Date: 11/03/2021
//////////////////////////////////////////////////////////////////////////////////


module ALU_1b(
    output reg result, c_out,
    input A, B, A_in, B_in, less, c_in,
    input [1:0] op
);

    
    reg a, b;
    
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
                        c_out = 1'b0;
                   end
            //Logical OR
            2'b01: begin
                        result = a|b;
                        c_out = 1'b0;
                   end
            //Addition
            2'b10: begin
                        result = a^b^c_in;
                        c_out = (a&b) | (b&c_in) | (a&c_in);
                   end
            //Set less than
            2'b11: begin
                        result = less;
                        c_out = (a&b) | (b&c_in) | (a&c_in);
                   end
         endcase

         end
    
    
endmodule
