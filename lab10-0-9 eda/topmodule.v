`timescale 1ns / 1ps


module topmodule;
    input clk, sw,
    wire [6:0] seg,
    wire [3:0] AN
    wire [3:0] count;
    wire clk_out;

    divider1 divide(clk, clk_out);

    counter1 encoder(clk_out, sw, count);

    bcdto7seg1 visualizer(count, seg, AN);
    
endmodule
// initial $monitor("%b", count);