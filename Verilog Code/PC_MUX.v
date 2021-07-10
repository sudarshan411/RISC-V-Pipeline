module PC_MUX (
    output [63:0] PC_next,
    input branch,
    input ALU_Zero,
    input [63:0] Jump,
    input [63:0] PC4
);
    wire selectin;
    assign selectin = (branch) & (ALU_Zero);
    assign PC_next = (selectin == 0) ? PC4 : Jump;

endmodule