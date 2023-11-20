`timescale 1ns / 1ps


module bcdto7seg1(
    input [3:0] count,
    output reg[6:0] seg, 
    output reg [3:0] AN
    );

    always @(count) begin
        case (count)
        // 0
        4'b0000 : seg <= 7'b1000000;
        // 1
        4'b0001 : seg <= 7'b1111001;
        // 2
        4'b0010 : seg <= 7'b0100100;
        // 3
        4'b0011 : seg <= 7'b0110000;
        // 4
        4'b0100 : seg <= 7'b0011001;
        // 5
        4'b0101 : seg <= 7'b0010010;
        // 6
        4'b0110 : seg <= 7'b0000010;
        // 7
        4'b0111 : seg <= 7'b1111000;
        // 8
        4'b1000 : seg <= 7'b0000000;
        // 9
        4'b1001 : seg <= 7'b0010000;
        default: seg<=7'b1111111;
        endcase
        AN <= 4'b1110;
    end
endmodule
