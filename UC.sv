`timescale 1ns / 1ps


module UC(
    input clk,
    input logic [6:0] opcode,
    input logic [14:0] r,
    output [18:0] en_sig,
    input ALU_carry
    );

    // typedef enum logic [4: 0] {f0, f1, f2, a0, a1, a2, ai0, ai1, ai2, lw0, lw1, lw2, lw3, sw0, sw1, sw2, sw3, jr0} uState;
    // typedef enum {n, d, f, b} uinst;
    
    mypack::uState uPCd, uPC, uPC1;
    
    //assign uPC1 = uPC + 1;
    
    mypack::uinst next;
    
    
    always_comb
    begin
        case(next)
            mypack::n : uPC = uPC.next();
            mypack::d : uPC = uPCd;
            mypack::f : uPC = uPC.first();
            default : uPC = uPC.first();
        endcase
    end
    
    
    decod decod(.opcode(opcode),
                .uPCd  (uPCd_b  ));
    
    ControlStore ControlStore(.uPC (uPC   ),
                              .r   (r     ),
                              .en  (en_sig),
                              .next(next  )
                              );
    
    
endmodule


