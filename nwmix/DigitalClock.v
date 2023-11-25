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
    output [3:0] h2,
    output reg pos,
    output reg hrup, // btn use to increment hour
    output reg minup, // btn use to increment min
    output reg btnLclr_prev,
    input btnLclr,
    output reg btnRclr_prev,
    input btnRclr
);

    
    // 1  2  :  3  0  :  5  0
    // h2 h1 :  m2 m1 :  s2 s1

    
    localparam zero = 4'b0000; // 0
    localparam numberOne = 4'b0001;
    localparam numberTwo  = 4'b0010;
    localparam numberFour  = 4'b0100;
    localparam numberFive = 4'b0101;
    localparam numberNine = 4'b1001;
    
    reg [5:0] hour = 0, min = 0, sec = 0; // max is 60 2^6 = 64
    integer clkc = 0;
    localparam onesec = 100_000_00; // 1 second
  
     always @(posedge clk) begin


        btnLclr_prev <= btnLclr;
        btnRclr_prev <= btnRclr;
        if(btnLclr_prev == 1'b0 && btnLclr == 1'b1) hrup <= 1'b1;
        else  hrup <= 0;

        if(btnRclr_prev == 1'b0 && btnRclr == 1'b1) minup <= 1'b1;
        else  minup <= 0;

        if(sw == 1'b1) begin
            // reset everything to 0
            {hour, min, sec} <= 0;
        end

        // set clock
        // minute up btn on
        else if(minup == 1'b1) begin
            if(min == 6'd59) begin
                min <= 0;
            end
            else begin
                min <= min + 1'd1;
            end
        end
        // hour up btn on
        else if(hrup == 1'b1) begin
            if(hour == 23) begin
                hour <= 0;
            end
            else begin
                hour <= hour + 1'd1;
            end
        end

        // count 
        else begin
            if (clkc == onesec) begin
                clkc <= 0;
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
            else begin
                clkc <= clkc + 1;
            end
        end
    end

    BinaryToBcd second(.binary(sec), .tens(s2), .ones(s1));    
    BinaryToBcd minute(.binary(min), .tens(m2), .ones(m1));    
    BinaryToBcd hourBinary(.binary(hour), .tens(h2), .ones(h1));    


    
endmodule

// initial begin
//         h2 <= 4'b0001; // 1
//         h1 <= 4'b0011; // 2
        
//         m2 <= 4'b0100; // 3
//         m1 <= 4'b0101; // 0
        
//         s2 <= 4'b0001; // 5
//         s1 <= 4'b0001; // 0

//     end
//     // 1  2  :  3  0  :  5  0
//     // h2 h1 :  m2 m1 :  s2 s1

    
//     localparam zero = 4'b0000; // 0
//     localparam numberTwo  = 4'b0010;
//     localparam numberFour  = 4'b0100;
//     localparam numberFive = 4'b0101;
//     localparam numberNine = 4'b1001;
    
//     always @(posedge clk) begin
//             if(sw) begin
//                 h1 <= 4'b0000;
//                 h2 <= 4'b0000;
//                 m1 <= 4'b0000;
//                 m2 <= 4'b0000;
//                 s1 <= 4'b0000;
//                 s2 <= 4'b0000;
//             end
//             // Update seconds
//             if (s1 == numberNine && s2 == numberFive) begin
//                 s1 <= 4'b0000;
//                 s2 <= 4'b0000;

//                 // Update minutes
//                 if (m1 == numberNine && m2 == numberFive) begin
//                     m1 <= 4'b0000;
//                     m2 <= 4'b0000;

//                     // Update hours
//                     if (h1 == numberFour && h2 == numberTwo) begin
//                         h1 <= 4'b0000;
//                         h2 <= 4'b0000;
//                     end 
//                     else if (h1 == numberNine) begin
//                         h2 <= h2 + 4'b0001;
//                         h1 <= 4'b0000;
//                     end 
//                     else if (h2 != numberTwo) begin
//                         h1 <= h1 + 4'b0001;
//                     end

//                 end else if (m1 == numberNine) begin
//                     m2 <= m2 + 4'b0001;
//                     m1 <= 4'b0000;
//                 end else begin
//                     m1 <= m1 + 4'b0001;
//                 end
//             end 
//             else if (s1 == numberNine) begin
//                 s2 <= s2 + 4'b0001;
//                 s1 <= 4'b0000;
//             end 
//             else begin
//                 s1 <= s1 + 4'b0001;
//             end
//     end