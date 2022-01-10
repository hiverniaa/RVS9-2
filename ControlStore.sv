`timescale 1ns / 1ps

module ControlStore(
    input mypack::uState uPC,
    input logic [14:0] r,
    output logic [18:0] en,
    // output logic [1:0] next
    output mypack::uinst next
    );
    
    
//    typedef enum logic [3: 0] {f0, f1, f2, a0, a1, a2, ai0, ai1, ai2} uState;
//    uState uPCi;
    
    logic pc_bus_en;	
    logic ALU_bus_en;	
    logic immgen_bus_en;	
    logic rf_bus_en;
    logic rd_bus_en;
    logic pc_en;
    logic a_en;
    logic b_en;
    logic ir_en;
    logic wd_en;
    logic rf_wen;
    logic rf_ren;
    logic [4:0] rf_addr_sel;
    logic alu_func;
    logic ram_wen;

    assign en = {pc_bus_en, ALU_bus_en,	immgen_bus_en, rf_bus_en, rd_bus_en, pc_en,	a_en, b_en,	ir_en, wd_en, rf_wen, rf_ren, rf_addr_sel, alu_func, ram_wen};

    always_comb
    begin
        case(uPC)
            mypack::f0 :  begin // F0
                        pc_bus_en       = 1;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 1;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;
                        
                        next = mypack::n;
                    end
            mypack::f1 :  begin // F1
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 1;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 1;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;
                        
                        next =mypack::n;
                    end
            mypack::f2 :  begin // F2
                        pc_bus_en       = 0;
                        ALU_bus_en      = 1;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 1;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;

                        next = mypack::d;
                    end
            mypack::a0 :  begin // A0
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 1;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = r[4:0];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::a1 :  begin // A1
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 1;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = r[9:5];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::a2 :  begin // A2
                        pc_bus_en       = 0;
                        ALU_bus_en      = 1;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 1;
                        rf_ren          = 0;
                        rf_addr_sel     = r[14:10];
                        alu_func        = 1;
                        ram_wen         = 0;

                        next = mypack::f;
                    end
            mypack::ai0 :  begin // AI0
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 1;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = r[4:0];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::ai1 :  begin // AI1
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 1;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 1;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::ai2 :  begin // AI2
                        pc_bus_en       = 0;
                        ALU_bus_en      = 1;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 1;
                        wd_en           = 0;
                        rf_wen          = 1;
                        rf_ren          = 0;
                        rf_addr_sel     = r[14:10];
                        alu_func        = 1;
                        ram_wen         = 0;

                        next = mypack::f;
                    end
            mypack::lw0 :  begin // L0
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 1;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = r[4:0];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::lw1 :  begin // L1
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 1;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 1;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::lw2 :  begin // L2
                        pc_bus_en       = 0;
                        ALU_bus_en      = 1;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 1;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::lw3 :  begin // L3
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 1;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 1;
                        rf_ren          = 0;
                        rf_addr_sel     = r[14:10];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next = mypack::f;
                    end
            mypack::sw0 :  begin // S0
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 1;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = r[9:5];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::sw1 :  begin // S1
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 1;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 1;
                        rf_addr_sel     = r[4:0];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::sw2 :  begin // S2
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 1;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 1;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;

                        next =mypack::n;
                    end
            mypack::sw3 :  begin // S3
                        pc_bus_en       = 0;
                        ALU_bus_en      = 1;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 1;
                        ram_wen         = 1;

                        next = mypack::f;
                    end
            mypack::jr0 :  begin // JR0
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 1;
                        rd_bus_en       = 0;
                        pc_en           = 1;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = r[4:0];
                        alu_func        = 0;
                        ram_wen         = 0;

                        next = mypack::f;
                    end
            default:  begin // default
                        pc_bus_en       = 0;
                        ALU_bus_en      = 0;
                        immgen_bus_en   = 0;
                        rf_bus_en       = 0;
                        rd_bus_en       = 0;
                        pc_en           = 0;
                        a_en            = 0;
                        b_en            = 0;
                        ir_en           = 0;
                        wd_en           = 0;
                        rf_wen          = 0;
                        rf_ren          = 0;
                        rf_addr_sel     = 5'b0;
                        alu_func        = 0;
                        ram_wen         = 0;

                        next = mypack::f;
                    end
                                        
        endcase
    end
    
    // always_comb
    // begin
    //     case(uPC)
    //         5'h0 :  begin // F0
    //                     en = 16'b1000010000000000;
    //                     next = 2'b00;
    //                 end
    //         5'h1 :  begin // F1
    //                     en = 16'b0000000100000000;
    //                     next = 2'b00;
    //                 end
    //         5'h2 :  begin // F2
    //                     en = 16'b0100100000000000;
    //                     next = 2'b01;
    //                 end
    //         5'h3 :  begin // A0
    //                     en = {10'b0001010001, r[4:0], 1'b0};
    //                     next = 2'b00;
    //                 end
    //         5'h4 :  begin // A1
    //                     en = {10'b0001001001, r[9:5], 1'b0};
    //                     next = 2'b00;
    //                 end
    //         5'h5 :  begin // A2
    //                     en = {10'b0101000010, r[14:10], 1'b1};
    //                     next = 2'b10;
    //                 end
    //         5'h6 :  begin // AI0
    //                     en = {10'b0001010001, r[4:0], 1'b0};
    //                     next = 2'b00;
    //                 end
    //         5'h7 :  begin // AI1
    //                     en = 16'b0010001000000000;
    //                     next = 2'b00;
    //                 end
    //         5'h8 :  begin // AI2
    //                     en = {10'b0101000010, r[14:10], 1'b1};
    //                     next = 2'b10;
    //                 end
    //     endcase
    // end    
    
endmodule

//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/03/2021 08:54:57 AM
//// Design Name: 
//// Module Name: ControlStore
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module ControlStore(
//    input logic [3:0] uPC,
//    input logic [14:0] r,
//    output logic [16:0] en,
//    output logic [1:0] next
//    );
    
    
////    typedef enum logic [3: 0] {f0, f1, f2, a0, a1, a2, ai0, ai1, ai2} uState;
////    uState uPCi;
    
//    //assign uPCi = uPC;
//    always_comb
//    begin
//        case(uPC)
//            4'h0 :  begin
//                        en = 17'b10000010000000000;
//                        next = 2'b00;
//                    end
//            4'h1 :  begin
//                        en = 17'b00000000100000000;
//                        next = 2'b00;
//                    end
//            4'h2 :  begin
//                        en = 17'b01000100000000000;
//                        next = 2'b01;
//                    end
//            4'h3 :  begin
//                        en = {11'b00010010001, r[4:0], 1'b0};
//                        next = 2'b00;
//                    end
//            4'h4 :  begin
//                        en = {11'b00010001001, r[9:5], 1'b0};
//                        next = 2'b00;
//                    end
//            4'h5 :  begin
//                        en = {11'b01000000010, r[14:10], 1'b1};
//                        next = 2'b10;
//                    end
//            4'h6 :  begin
//                        en = {11'b00010010001, r[4:0], 1'b0};
//                        next = 2'b00;
//                    end
//            4'h7 :  begin
//                        en = 17'b00100001000000000;
//                        next = 2'b00;
//                    end
//            4'h8 :  begin
//                        en = {11'b01000000010, r[14:10], 1'b1};
//                        next = 2'b10;
//                    end
//        endcase
//    end 
// endmodule
