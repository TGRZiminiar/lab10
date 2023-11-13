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
    output reg[3:0] led
    );
    initial led = 4'b0000;
    always @(posedge clk_in)
    if (sw)
        led <= 4'b0000;
    else 
        if(clk_in == 1)
            if (led >= 4'b1001)
                led <= 4'b0000;
            else
                led = led + 4'b0001;
    
    endmodule
