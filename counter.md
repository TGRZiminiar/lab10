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
    output reg[3:0] digit1, digit2
    );

    initial digit1 = 4'b0000;
    initial digit2 = 4'b0000;
    always @(posedge clk_in)
    if (sw) begin
        digit1 <= 4'b0000;
        digit2 <= 4'b0000;
    end
    else 
        if(clk_in == 1)
            if(digit1 >= 4'b1001) begin
                digit1 <= 4'b0000;
                if(digit2 >= 4'b0101) begin
                    digit1 <= 4'b0000;
                    digit2 <= 4'b0000;
                end
                else
                    digit2 = digit2 + 4'b0001;
                end
            else
                digit1 = digit1 + 4'b0001;
endmodule
    