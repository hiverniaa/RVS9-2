`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2021 11:20:15 AM
// Design Name: 
// Module Name: RF
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


module RF(
input clk,
    input [31:0] data_in,
    input rf_wen,
    input rf_ren,
    output logic [31:0] data_out,
    input [1:0] addr
    );
    
    logic [3:0][31:0] RF_data = '{default: 32'h0};
    
    always_ff @(posedge clk) begin
        if (rf_wen == 0) begin
            if (addr == 0)
                data_out <= 32'h0;
            else
                data_out <= RF_data[addr];
        end
        else begin
            RF_data[addr] <= data_in;
        end
    end

    
endmodule
