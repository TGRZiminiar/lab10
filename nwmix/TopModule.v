`timescale 1ns / 1ps
module TopModule (
    input clk,
    input sw,
    input btnC, btnU, btnL, btnR, btnD,
    output [6:0] seg, 
    output [3:0] an,
    output ledD1, ledD2, ledD3, ledD4,
    output [5:0] led // display seconds

);
    wire btnCclr, btnUclr, btnRclr;
    wire [3:0] s1, s2, m1, m2, h1, h2;
    wire trigger;
    wire pos = 1;
    
    oneSecond asd(
        .clk(clk),
        .clk_out(trigger)
    );

    Debounce dbC(clk, btnC, btnCclr);   
    Debounce dbU(clk, btnU, btnUclr); // hour up
    Debounce dbR(clk, btnR, btnRclr); // min up

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
        .h2(h2),
        .pos(pos),
        .btnC(btnC),    
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .ledD1(ledD1),
        .ledD2(ledD2),
        .ledD3(ledD3),
        .ledD4(ledD4)
    );

    // BtnNumber btnHandler(
    //     .btnC(btnC),    
    //     .btnU(btnU),
    //     .btnL(btnL),
    //     .btnR(btnR),
    //     .btnD(btnD),
    //     .ledD1(ledD1),
    //     .ledD2(ledD2),
    //     .ledD3(ledD3),
    //     .ledD4(ledD4),
    //     .m1(m1),
    //     .m2(m2),
    //     .h1(h1),
    //     .h2(h2)
    // );

    assign ledD1 = (pos == 1) ? 1'b1 : 1'b0;
    assign ledD2 = (pos == 2) ? 1'b1 : 1'b0;
    assign ledD3 = (pos == 3) ? 1'b1 : 1'b0;
    assign ledD4 = (pos == 4) ? 1'b1 : 1'b0;

    assign led[0] = (s2 == 1) ? 1'b1 : 1'b0;
    assign led[1] = (s2 == 2) ? 1'b1 : 1'b0;
    assign led[2] = (s2 == 3) ? 1'b1 : 1'b0;
    assign led[3] = (s2 == 4) ? 1'b1 : 1'b0;
    assign led[4] = (s2 == 5) ? 1'b1 : 1'b0;
    assign led[5] = (s2 == 5 && s1 == 9) ? 1'b1 : 1'b0;


endmodule