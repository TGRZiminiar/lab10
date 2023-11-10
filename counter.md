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
    input clk_in2,
    input sw,
    output reg[3:0] led,
    output reg[3:6] led2
    );
    initial led = 4'b0000;
    begin
        always @(posedge clk_in)
        if (sw)
            led <= 4'b0000;
        else 
            if(clk_in == 1)
                if (led >= 4'b1001)
                    led <= 4'b0000;
                else
                    led = led + 4'b0001;
    end

    initial led2 = 4'b0000;
    begin 
        always @(posedge clk_in2)
        if (sw)
            led2 <= 4'b0000;
        else 
            if(clk_in2 == 1)
                if (led2 >= 4'b1001)
                    led2 <= 4'b0000;
                else
                    led2 = led2 + 4'b0001;
    end
endmodule
    