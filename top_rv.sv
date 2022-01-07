`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 11:53:16 AM
// Design Name: 
// Module Name: top_rv
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
package mypack;
    typedef enum logic [3: 0] {f0, f1, f2, a0, a1, a2, ai0, ai1, ai2} uState ;
    typedef enum {x0, rd, rs1, rs2} RF_reg;
endpackage

module top_rv(
    input clk
    );    
        
    logic UC_pc_bus_en;
    logic UC_ALU_bus_en;
    logic UC_immgen_bus_en;	
    logic UC_rf_bus_en;
    logic UC_pc_en;
    logic UC_a_en;
    logic UC_b_en;
    logic UC_ir_en;	
    logic UC_rf_wen;
    logic UC_rf_ren;
    logic UC_rf_addr_sel;	
    logic UC_alu_func;
    logic UC_ram_wen;
    logic UC_ram_ren;
    logic [31:0] instr;
    logic [15:0] UC_en_sig;
    logic [31:0] databus;
    
    UT UT(.clk(clk),
    .databus(databus),
    .sel_alu_func(UC_alu_func),
    .ir_en(UC_ir_en),
    .immgen_bus_en(UC_immgen_bus_en),
    .ALU_bus_en(UC_ALU_bus_en),
    .a_en(UC_a_en),
    .b_en(UC_b_en),
    .pc_en(UC_pc_en),
    .pc_bus_en(UC_pc_bus_en),
    .rf_wen(UC_rf_wen),
    .rf_ren(UC_rf_ren),
    .rf_bus_en(UC_rf_bus_en),
    .rf_addr_sel(UC_rf_addr_sel),
    .instr(instr),
    .ALU_carry()
    );
    
    UC UC(
    .clk        (clk        ),
    .opcode     (instr[6:0] ),
    .r          ({instr[11:7], instr[24:20], instr[19:15]}), // {rd, rs2, rs1}
    .en_sig     (UC_en_sig  ),
    .ALU_carry  (           )
    );
    
    RAM RAM(
        .addr  (databus),
        .din   (databus),           
        .clk   (clk    ),                           
        .we    (UC_ram_wen),                
        .regce (UC_ram_ren),                         
        .dout  (databus)         
    );

    assign UC_pc_bus_en        = UC_en_sig[15];
    assign UC_ALU_bus_en       = UC_en_sig[14];
    assign UC_immgen_bus_en	   = UC_en_sig[13];
    assign UC_rf_bus_en        = UC_en_sig[12];
    assign UC_pc_en            = UC_en_sig[11];
    assign UC_a_en             = UC_en_sig[10];
    assign UC_b_en             = UC_en_sig[9];
    assign UC_ir_en	           = UC_en_sig[8];
    assign UC_rf_wen           = UC_en_sig[7];
    assign UC_rf_ren           = UC_en_sig[6];
    assign UC_rf_addr_sel      = UC_en_sig[5:1];
    assign UC_alu_func         = UC_en_sig[0];

    
//    always_ff @(posedge clk) begin
//        if 
//    end
    
endmodule
