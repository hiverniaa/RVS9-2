`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 08:54:57 AM
// Design Name: 
// Module Name: ControlStore
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


module ControlStore(
    input logic [3:0] uPC,
    input logic [14:0] r,
    output logic [16:0] en,
    output logic [1:0] next
    );
    
    
//    typedef enum logic [3: 0] {f0, f1, f2, a0, a1, a2, ai0, ai1, ai2} uState;
//    uState uPCi;
    
    //assign uPCi = uPC;
    always_comb
    begin
        case(uPC)
            4'h0 :  begin
                        en = 17'b10000010000000000;
                        next = 2'b00;
                    end
            4'h1 :  begin
                        en = 17'b00000000100000000;
                        next = 2'b00;
                    end
            4'h2 :  begin
                        en = 17'b01000100000000000;
                        next = 2'b01;
                    end
            4'h3 :  begin
                        en = {11'b00010010001, r[4:0], 1'b0};
                        next = 2'b00;
                    end
            4'h4 :  begin
                        en = {11'b00010001001, r[9:5], 1'b0};
                        next = 2'b00;
                    end
            4'h5 :  begin
                        en = {11'b01000000010, r[14:10], 1'b1};
                        next = 2'b10;
                    end
            4'h6 :  begin
                        en = {11'b00010010001, r[4:0], 1'b0};
                        next = 2'b00;
                    end
            4'h7 :  begin
                        en = 17'b00100001000000000;
                        next = 2'b00;
                    end
            4'h8 :  begin
                        en = {11'b01000000010, r[14:10], 1'b1};
                        next = 2'b10;
                    end
        endcase
    end
    
    
    
    
endmodule
