`timescale 1ns / 1ps
module TopModule (
    input clk,
    input sw,
    output [6:0] seg, 
    output reg [3:0] an
);
    wire [3:0] s1, s2, m1, m2, h1, h2;
    wire trigger;

    oneSecond triggerWhenOneSecond(
        .clk(clk),
        .clk_out(trigger)
    );

    SevenSegDrive manage4digit(
        .clk(clk),
        .clr(sw),
        .trigger(trigger),
        .in1(h2),
        .in2(h1),
        .in3(m2),
        .in4(m1),
        .seg(seg),
        .an(an)
    );
    
    DigitalClock makeTime(
        .clk(clk),
        .sw(sw),
        .trigger(trigger),
        .s1(s1),
        .s2(s2),
        .m1(m1),
        .m2(m2),
        .h1(h1),
        .h2(h2)
    );

endmodule