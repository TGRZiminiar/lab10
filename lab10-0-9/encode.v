`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 11:06:31 AM
// Design Name: 
// Module Name: counter1
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


module counter1(
    input clk_in,
    input sw,
    output reg[3:0] count
    );
    initial count = 4'b0000;
    
    always @(posedge clk_in)
        if (sw)
            count <= 4'b0000;
        else 
            if(clk_in == 1)
                // count >= 9
                if (count >= 4'b1001)
                    count <= 4'b0000;
                else
                    // count += 1
                    count = count + 4'b0001;
    
    endmodule