`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 08:44:56 AM
// Design Name: 
// Module Name: decod
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


module decod(
    input  logic [6:0] opcode,
    output logic [3:0] uPCd
    );
    
    
    always_comb
    begin
        case(opcode)
            7'b0110011 : uPCd = 4'h3;
            7'b0010011 : uPCd = 4'h6;
            default : uPCd = 4'h0;
        endcase
    end
    
    
endmodule
