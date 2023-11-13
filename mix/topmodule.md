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
    
    
    module topmodules(
        input clk, clear,
        output [6:0] seg,
        output [3:0] AN
        );
        wire [3:0] count1, count2;
        wire clk_out;

        divider divide(clk, clk_out, AN);
        
        counters encoder(clk_out, clear, count2, count1);
    
        bcdtosegs7 visualizer(count2, count1, seg, AN);
        
    endmodule
