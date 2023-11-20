`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 08:24:16 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input clk_in,
    input sw,
    output reg[3:0] first,
    output reg[3:0] second
);
    // 0
    initial first = 4'b0000;
    // 0
    initial second = 4'b0000;
    
    always @(posedge clk_in)
        if (sw) begin
            first = 4'b0000;
            second = 4'b0000;
        end
        // first != 9
        else if (first != 4'b1001)
            first <= first + 4'b0001;
            // first += 1
        
        // if second == 5
        // reset to 0
        else if (second == 4'b0101) begin
            second <= 4'b0000;
            first = 4'b0000;
        end
        // first == 9
        else if (first == 4'b1001) begin
            // second += 1
            second = second + 4'b0001;
            // first = 0
            first = 4'b0000;
        end
endmodule