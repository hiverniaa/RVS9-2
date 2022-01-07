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

//typedef enum logic [4: 0] {f0, f1, f2, a0, a1, a2, ai0, ai1, ai2, lw0, lw1, lw2, lw3, sw0, sw1, sw2, sw3, jr0} uState;

module decod (
    input  logic [6:0] opcode,
    output mypack::uState uPCd
    );
    
    
    always_comb
    begin
        case(opcode)
            7'b0110011 : uPCd = mypack::a0;
            7'b0010011 : uPCd = mypack::ai0;
            7'b1100111 : uPCd = mypack::jr0;
            7'b0000011 : uPCd = mypack::lw0;
            7'b0100011 : uPCd = mypack::sw0;
            default : uPCd = mypack::f0;
        endcase
    end
    
    
endmodule
