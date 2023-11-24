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




endmodule