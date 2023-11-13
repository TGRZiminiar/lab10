`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 11:12:23 AM
// Design Name: 
// Module Name: topmodule
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


module topmodule(
    input clk, sw,
    output [6:0] seg,
    output [3:0] AN
    );
    wire [3:0] count;
    wire clk_out;

    divider1 divide(clk, clk_out);

    counter1 encoder(clk_out, sw, count);

    bcdto7seg1 visualizer(count, seg, AN);
    
endmodule
