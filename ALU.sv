`timescale 1ns / 1ps

module ALU(
    input [31:0] opA,
    input [31:0] opB,
    input alu_func,
    output [31:0] res,
    output carry
    );
    
    logic [32 : 0] temp;
    
    always_comb 
        begin
            case (alu_func)
                0: temp = opA + 4;
                1: temp = opA + opB;
                default : temp = 0;
            endcase
        end
    
    assign res = temp [31 : 0];
    assign carry = temp [32];
    
endmodule

    
