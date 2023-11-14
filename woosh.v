`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:54:08 AM
// Design Name: 
// Module Name: top module
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


module top_module(
    input clk,
    input clear,
    output [6:0] seg,
    output [3:0] an
    );
    wire clk_out;
    wire [3:0] first;
    wire [3:0] second;
//    second divide (clk,clk_out);
//    count counter (clk_cout,clear,led);
    divide d(clk,clk_out,an);
    counter c(clk_out,clear,first,second);
    bcdto7seg dis(first,second,an,seg);
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:09:53 AM
// Design Name: 
// Module Name: divider
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


module divide(
    input clock,
    output clk_out, 
    output reg [3:0] AN
);
    reg elapsed; //elapsed time 1 second
    reg [27:0] state;
    
    always @ (posedge clock)
        if (state == 100000000) state <= 0;
        else state <= state + 1;
    always @(state)
        if (state == 100000000) elapsed = 1;
        else elapsed = 0;
    assign clk_out = elapsed;
    always @(state)begin
        case(state[15])
        1'b0: AN <= 4'b1101;
        1'b1: AN <= 4'b1110;
    endcase
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:40:40 AM
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
    initial first = 4'b0000;
    initial second = 4'b0000;
//    reg count_for_first = 0;
    
    always @(posedge clk_in)
        if (sw) begin
            first = 4'b0000;
            second = 4'b0000;
        end
        else if (first != 4'b1001)
            first <= first + 4'b0001;
        else if (second == 4'b0101) begin
            second <= 4'b0000;
            first = 4'b0000;
        end
        else if (first == 4'b1001) begin
            second = second + 4'b0001;
            first = 4'b0000;
        end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 10:53:09 AM
// Design Name: 
// Module Name: bcdto7seg
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


module bcdto7seg(
    input [3:0] first,
    input [3:0] second,
    input [3:0] an,
    output reg [6:0] seg
    );
    //    output reg [3:0] an
    reg [3:0] num;
    always @(an) begin
    case(an)
    4'b1101: num <= second;
    4'b1110: num <= first;
    endcase
    end
    always @(an)
    begin
        case(num)
            4'b0000 : seg = 7'b1000000;
            4'b0001 : seg = 7'b1111001;
            4'b0010 : seg = 7'b0100100;
            4'b0011 : seg = 7'b0110000;
            4'b0100 : seg = 7'b0011001;
            4'b0101 : seg = 7'b0010010;
            4'b0110 : seg = 7'b0000010;
            4'b0111 : seg = 7'b1111000;
            4'b1000 : seg = 7'b0000000;
            4'b1001 : seg = 7'b0010000;
            default : seg = 7'b1111111;
        endcase
    end 
  
endmodule