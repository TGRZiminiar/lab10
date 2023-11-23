`timescale 1ns / 1ps


module topmodule(
    input clk, sw,
    output [6:0] seg,
    output [3:0] AN
    );
    wire [3:0] count;
    wire clk_out;w

    // 0 -> 1 -> 2 
    // delay 1 s
    divider1 divide(clk, clk_out);

    // บวกเลข
    counter1 encoder(clk_out, sw, count);

    // แสดงเลข
    bcdto7seg1 visualizer(count, seg, AN);
    
    // 0 0 0 1

endmodule