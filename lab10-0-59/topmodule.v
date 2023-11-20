`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:54:08 AM
// Design Name: 
// Module Name: top module
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


module top_module(
    input clk,
    input sw,
    output [6:0] seg,
    output [3:0] an
    );
    wire clk_out;
    wire [3:0] first;
    wire [3:0] second;

    divider d(clk,clk_out,an);
    counter c(clk_out,sw,first,second);
    bcdto7seg dis(first,second,an,seg);
endmodule