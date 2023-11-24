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

    initial begin
        h2 <= 4'b0001; // 1
        h1 <= 4'b0010; // 2
        
        m2 <= 4'b0011; // 3
        m1 <= 4'b0000; // 0
        
        s2 <= 4'b0101; // 5
        s1 <= 4'b0000; // 0

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
    // end
    always @(posedge clk or posedge sw) begin
        if (sw) begin
            // Reset everything to 0
            {s1, s2, m1, m2, h1, h2} <= 4'b0000;
            counter <= 27'd0;
        end else begin
            // Increment the counter on each clock edge
            counter <= counter + 1;
        end
    end

    always @(posedge clk) begin
        if (counter == 1_000_000_000) begin
            counter <= 0;

            // Update seconds
            if (s1 == 9 && s2 == 5) begin
                s1 <= 0;
                s2 <= 0;

                // Update minutes
                if (m1 == 9 && m2 == 5) begin
                    m1 <= 0;
                    m2 <= 0;

                    // Update hours
                    if (h1 == 4 && h2 == 2) begin
                        h1 <= 0;
                        h2 <= 0;
                    end 
                    else if (h1 == 9) begin
                        h2 <= h2 + 1;
                        h1 <= 0;
                    end 
                    else if (h2 != 2) begin
                        h1 <= h1 + 1;
                    end

                end else if (m1 == 9) begin
                    m2 <= m2 + 1;
                    m1 <= 0;
                end else begin
                    m1 <= m1 + 1;
                end
            end else if (s1 == 9) begin
                s2 <= s2 + 1;
                s1 <= 0;
            end else begin
                s1 <= s1 + 1;
            end
        end
    end

   
    
endmodule