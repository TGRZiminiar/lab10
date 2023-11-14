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


module divider ( 
    input clock,
    output clk_out,
    output reg [3:0] AN    
);

    reg elapsed;
    reg [27:0] state;

    
    always @ (posedge clock) begin
        if (state == 100000000) state <= 0;
        else state <= state + 1;
    end
    
    always @(state) begin
        if(state == 100000000) elapsed = 1;
        else elapsed = 0;
    end
    
    assign clk_out = elapsed;

    // Check If the position at 15 is a bit 0 or 1
    // Why we need to check this
    always @ (state) begin
        case(state[15])
        1'b0:
            // 1110 = 14
            AN <= 4'b1110;
        1'b1:
            // 1101 = 13
            AN <= 4'b1101;
        endcase
    end
        

endmodule