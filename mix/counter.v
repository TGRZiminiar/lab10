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


module counters(
    input clk_in,
    input sw,
    output reg [3:0] NumTwo, NumOne    
    );
    initial NumTwo = 4'b0000;
    initial NumOne = 4'b0000;

    always @(posedge clk_in)
        if (sw) begin
            NumOne <= 4'b0000;
            NumTwo <= 4'b0000;
        end

        else
            if(clk_in == 1)
                // NumOne >= 9
                if (NumOne >= 4'b1001) begin
                    // NumOne == 0 || Rest to 0
                    NumOne <= 4'b0000;
                    // NumTwo >= 5 Reset Num1 And Num2 To 0
                    if(NumTwo >= 4'b0101) begin
                        NumOne <= 4'b0000;
                        NumTwo <= 4'b0000;
                    end
                    
                    else
                        NumTwo = NumTwo + 4'b0001;
                    end
                else
                    NumOne = NumOne + 4'b0001;
endmodule

    