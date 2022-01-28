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

module top_rv(
    input clk,
    input rst,
    output [15:0] LED
    );    
        
    logic UC_pc_bus_en;
    logic UC_ALU_bus_en;
    logic UC_immgen_bus_en;	
    logic UC_rf_bus_en;
    logic UC_rd_bus_en;
    logic UC_pc_en;
    logic UC_a_en;
    logic UC_b_en;
    logic UC_ir_en;
    logic UC_wd_en;
    logic UC_rf_wen;
    logic UC_rf_ren;
    logic [4:0] UC_rf_addr_sel;	
    logic UC_alu_func;
    logic UC_ram_wen;
    logic [31:0] instr;
    logic [18:0] UC_en_sig;
    logic [31:0] databus;
    logic [31:0] rdata;
    logic [31:0] WD;
    
    UT UT(.clk(clk),
    .rst(rst),
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
    .rd_bus_en(UC_rd_bus_en),
    .rd_data(rdata),
    .databus(databus),
    .instr(instr),
    .ALU_carry()
    );
    
    UC UC(
    .clk        (clk        ),
    .rst        (rst        ),
    .opcode     (instr[6:0] ),
    .r          ({instr[11:7], instr[24:20], instr[19:15]}), // {rd, rs2, rs1}
    .en_sig     (UC_en_sig  ),
    .ALU_carry  (           )
    );
    
    logic [9:0] memreqaddr;
    
    always_ff @(posedge(clk)) begin
        if (rst)
            memreqaddr <= 0;
        else
            memreqaddr <= databus;
    end
 
    always_ff @(posedge(clk)) begin
        if (rst)
            WD <= 0;
        else if (UC_wd_en)
            WD <= databus;
    end 
    
    RAM RAM(
        .addr  (databus[11:2]),
        .din   (WD),           
        .clk   (clk    ),                           
        .we    (UC_ram_wen),                
        .regce (1'b1),                         
        .dout  (rdata)         
    );

//    xilinx_simple_dual_port_1_clock_ram RAM2(
//      .addra (databus[11:2]), // Write address bus, width determined from RAM_DEPTH
//      .addrb(databus[11:2]), // Read address bus, width determined from RAM_DEPTH
//      .dina(databus),          // RAM input data
//      .clka(clk),                          // Clock
//      .wea(UC_ram_wen),                           // Write enable
//      .enb(1'b1),                           // Read Enable, for additional power savings, disable when not in use
//      .rstb(1'b0),                          // Output reset (does not affect memory contents)
//      .regceb(UC_rd_bus_en),                        // Output register enable
//      .doutb(rdata)         // RAM output data
//    );

    assign UC_pc_bus_en        = UC_en_sig[18];
    assign UC_ALU_bus_en       = UC_en_sig[17];
    assign UC_immgen_bus_en	   = UC_en_sig[16];
    assign UC_rf_bus_en        = UC_en_sig[15];
    assign UC_rd_bus_en        = UC_en_sig[14];
    assign UC_pc_en            = UC_en_sig[13];
    assign UC_a_en             = UC_en_sig[12];
    assign UC_b_en             = UC_en_sig[11];
    assign UC_ir_en	           = UC_en_sig[10];
    assign UC_wd_en	           = UC_en_sig[9];
    assign UC_rf_wen           = UC_en_sig[8];
    assign UC_rf_ren           = UC_en_sig[7];
    assign UC_rf_addr_sel      = UC_en_sig[6:2];
    assign UC_alu_func         = UC_en_sig[1];
    assign UC_ram_wen	       = UC_en_sig[0];

    
//    always_ff @(posedge clk) begin
//        if 
//    end
    assign LED = databus[15:0];
endmodule
