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
        input clk, sw, clk2,
        output [6:0] seg,
        output [12:6] seg2,
        output [3:0] AN,
        output [6:3] AN2
        );
        wire [3:0] count, count2;
        wire clk_out;

        divider1 divide(clk, clk_out, AN);
        
        counter1 encoder(clk_out, sw, count, count2);
    
        bcdto7seg1 visualizer(count, count2, seg, AN);
        
    endmodule
