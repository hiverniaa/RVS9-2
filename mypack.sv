`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2022 02:48:25 PM
// Design Name: 
// Module Name: mypack
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
    typedef enum logic [5: 0] {f0, f1, f2, a0, a1, a2, a3, ai0, ai1, ai2, ai3, lw0, lw1, lw2, lw3, sw0, sw1, sw2, sw3, jr0, jr1, jr2, jr3, init} uState;
    typedef enum {x0, rd, rs1, rs2} RF_reg;
    typedef enum {n, d, f, b} uinst;
endpackage
