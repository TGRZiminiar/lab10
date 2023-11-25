`timescale 1ns / 1ps
module DigitalClock (
    input clk,
    input sw,
    input trigger,
    output reg [3:0] s1,
    output reg [3:0] s2,
    output reg [3:0] m1,
    output reg [3:0] m2,
    output reg [3:0] h1,
    output reg [3:0] h2
);

    initial begin
        h2 <= 4'b0001; // 1
        h1 <= 4'b0011; // 2
        
        m2 <= 4'b0100; // 3
        m1 <= 4'b0101; // 0
        
        s2 <= 4'b0001; // 5
        s1 <= 4'b0001; // 0

    end
    // 1  2  :  3  0  :  5  0
    // h2 h1 :  m2 m1 :  s2 s1

    // always @(trigger) begin
    //     if(sw == 1'b1) begin
    //         // reset everything to 0
    //         {s1, s2, m1, m2, h1, h2} <= 4'b0000;
    //     end

    //     // if time is one second
    //     if (trigger == 1) begin

    //     end
    

    always @(posedge trigger) begin
            // Update seconds
            if (s1 == 4'b1001 && s2 == 4'b0101) begin
                s1 <= 4'b0000;
                s2 <= 4'b0000;

                // Update minutes
                if (m1 == 4'b1001 && m2 == 4'b0101) begin
                    m1 <= 4'b0000;
                    m2 <= 4'b0000;

                    // Update hours
                    if (h1 == 4'b0100 && h2 == 4'b0010) begin
                        h1 <= 4'b0000;
                        h2 <= 4'b0000;
                    end 
                    else if (h1 == 4'b1001) begin
                        h2 <= h2 + 4'b0001;
                        h1 <= 4'b0000;
                    end 
                    else if (h2 != 4'b0010) begin
                        h1 <= h1 + 4'b0001;
                    end

                end else if (m1 == 4'b1001) begin
                    m2 <= m2 + 4'b0001;
                    m1 <= 4'b0000;
                end else begin
                    m1 <= m1 + 4'b0001;
                end
            end else if (s1 == 4'b1001) begin
                s2 <= s2 + 4'b0001;
                s1 <= 4'b0000;
            end else begin
                s1 <= s1 + 4'b0001;
            end
    end

   
    
endmodule