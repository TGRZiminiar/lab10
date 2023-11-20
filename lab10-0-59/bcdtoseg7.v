`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 08:23:17 PM
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
            4'b0000: seg <= 7'b1000000;  // Display 0
            4'b0001: seg <= 7'b1111001;  // Display 1
            4'b0010: seg <= 7'b0100100;  // Display 2
            4'b0011: seg <= 7'b0110000;  // Display 3
            4'b0100: seg <= 7'b0011001;  // Display 4
            4'b0101: seg <= 7'b0010010;  // Display 5
            4'b0110: seg <= 7'b0000010;  // Display 6
            4'b0111: seg <= 7'b1111000;  // Display 7
            4'b1000: seg <= 7'b0000000;  // Display 8
            4'b1001: seg <= 7'b0010000;  // Display 9
            default: seg <= 7'b1111111;   // Display nothing (7-segment off)
        endcase
    end 
  
endmodule