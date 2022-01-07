`timescale 1ns / 1ps


module ImmGen(
    input [11:0] immIn,
    output [31:0] immOut
    );
    
    assign immOut = {20'h0, immIn};
    
endmodule