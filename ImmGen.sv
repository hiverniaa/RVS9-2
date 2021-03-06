`timescale 1ns / 1ps


module ImmGen(
    input [31:0] immIn,
    output [31:0] immOut
    );
    
    logic [31:0] sig;
    
    always_comb begin
        case (immIn[6:0])
            7'b0010011 : sig = {20'h0, immIn[31:20]}; //addi
            7'b0100011 : sig = {20'h0, immIn[31:25], immIn[11:7]}; //sw
            7'b0000011 : sig = {20'h0, immIn[31:20]}; //lw
            7'b1100111 : sig = {20'h0, immIn[31:20]}; //jr
            default : sig = 32'h0;
        endcase
    end
    
    assign immOut = sig;
    
endmodule