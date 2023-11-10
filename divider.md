
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 11:05:31 AM
// Design Name: 
// Module Name: divider1
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


module divider1 ( 
    input clock, 
    output clk_out,
    output reg [3:0] AN
);
    reg elapsed;//elapsed time 1 second 
    reg [27:0] state;

    begin
        always @ (posedge clock)
            if (state == 100000000) state <= 0; 
            else state <= state + 1;

        always @ (state)
            case(state[15])
            1'b0:
                AN <= 4'b1110;
            1'b1:
                AN <= 4'b1101;
            endcase
        
        always @(state)
            if (state == 100000000) elapsed = 1;
            else elapsed = 0; 
        assign clk_out = elapsed;
    end

  
endmodule