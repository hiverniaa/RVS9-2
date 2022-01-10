`timescale 1ns / 1ps


module UT(
    input clk,
    input rst,
    input sel_alu_func,
    input ir_en,
    input immgen_bus_en,
    input ALU_bus_en,
    input a_en,
    input b_en,
    input pc_en,
    input pc_bus_en,
    input rf_wen,
    input rf_ren,
    input rf_bus_en,
    input [4:0] rf_addr_sel,
    input rd_bus_en,
    input [31:0] rd_data,
    output [31 : 0] databus,
    output [31:0] instr,
    output ALU_carry
    );
    
    logic [31 : 0] data_bus;
    logic [31 : 0] bus_ALUopA;
    logic [31 : 0] bus_ALUopB;
    logic [31 : 0] bus_RF;
    logic [31 : 0] RF_bus;
    logic [31 : 0] ALUout_bus;
    logic [31 : 0] bus_ImmGen;
    logic [31 : 0] ImmGen_bus;
    logic [31 : 0] PC = 0;
    logic [3 : 0] RF_addr;
    
    
    ALU ALU (.opA(bus_ALUopA), 
               .opB(bus_ALUopB),
               .alu_func(sel_alu_func),
               .res(ALUout_bus),
               .carry(ALU_carry));
               
   ImmGen ImmGen(.immIn(bus_ImmGen),
                 .immOut(ImmGen_bus));
                 
   assign instr = bus_ImmGen;
   
   RF RF(.clk(clk),
         .data_in(data_bus),
         .rf_wen(rf_wen),
         .rf_ren(rf_ren),
         .data_out(RF_bus),
         .addr(RF_addr)
    );          

    always_ff @(posedge clk) begin
        //-----------------------------------------
        //Affectation du bus aux registres d'entrée
        //-----------------------------------------
        if (ir_en == 1) begin
            bus_ImmGen <= data_bus;
        end
        else if (a_en == 1) begin
            bus_ALUopA <= data_bus;
        end
        if (b_en == 1) begin
            bus_ALUopB <= data_bus;
        end
        if (pc_en == 1) begin
            PC <= data_bus;
        end
        if (rf_bus_en == 1) begin
            bus_RF <= data_bus;
        end          
    end
    
    always_comb begin
        //----------------------------------
        //Affectation des sorties sur le bus
        //----------------------------------
        if (immgen_bus_en == 1)
            data_bus <= ImmGen_bus;
        else if (ALU_bus_en == 1)
            data_bus <= ALUout_bus;
        else if (pc_bus_en == 1)
            data_bus <= PC;
        else if (rf_bus_en == 1)
            data_bus <= RF_bus;
        else if (rd_bus_en == 1)
            data_bus <= rd_data;
    end
    
    assign databus = data_bus;
    
    always_comb begin
        case (rf_addr_sel)
            0 : RF_addr =  0;
            1 : RF_addr =  1;
            2 : RF_addr =  2;
            3 : RF_addr =  3;
        endcase
    end

endmodule
