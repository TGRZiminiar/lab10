`timescale 1ns / 1ps
module DigitalClock (
    input clk,
    input sw,
    input trigger,
    output [3:0] s1,
    output [3:0] s2,
    output [3:0] m1,
    output [3:0] m2,
    output [3:0] h1,
    output [3:0] h2
);


    reg [5:0] hour = 0, min = 0, sec = 0; // max is 60 2^6 = 64

    initial begin
        hour <= 6'd12;
        min <= 6'd30;
        sec <= 6'd45;
    end

    always @(trigger) begin
        if(sw == 1'b1) begin
            // reset everything to 0
            {hour, min, sec} <= 0;
        end

        // if time is one second
        if (trigger == 1) begin
            if (sec == 6'd59) begin
                sec <= 0;
                if (min == 6'd59) begin
                    min <= 0;
                    if (hour == 6'd23) begin
                        hour <= 0;
                    end
                    else begin
                        hour <= hour + 1'd1;
                    end
                end
                else begin
                    min <= min + 1'd1;
                end
            end
            else begin
                sec <= sec + 1'd1;
            end            
        end
    end

    // BinaryToBcd second(.binary(sec), .thos(), .hund(), .tens(s2), .ones(s1));    
    // BinaryToBcd minute(.binary(min), .thos(), .hund(), .tens(m2), .ones(m1));    
    // BinaryToBcd hourBinary(.binary(hour), .thos(), .hund(), .tens(h2), .ones(h1));    
    BinaryToBcd second(.binary(sec), .tens(s2), .ones(s1)); // Connect tens and ones to s2 and s1
    BinaryToBcd minute(.binary(min), .tens(m2), .ones(m1)); // Connect tens and ones to m2 and m1
    BinaryToBcd hourBinary(.binary(hour), .tens(h2), .ones(h1)); // Connect tens and ones to h2 and h1
    
    
endmodule