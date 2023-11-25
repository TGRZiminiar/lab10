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
    output reg [3:0] h2,
    output reg pos,
    input btnC, btnU, btnL, btnR, btnD,
    output ledD1, ledD2, ledD3, ledD4
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

    
    localparam zero = 4'b0000; // 0
    localparam numberOne = 4'b0001;
    localparam numberTwo  = 4'b0010;
    localparam numberFour  = 4'b0100;
    localparam numberFive = 4'b0101;
    localparam numberNine = 4'b1001;
    
    always @(posedge clk) begin
        if(sw) begin
            h1 <= 4'b0000;
            h2 <= 4'b0000;
            m1 <= 4'b0000;
            m2 <= 4'b0000;
            s1 <= 4'b0000;
            s2 <= 4'b0000;
        end
        // Update seconds
        else if (s1 == numberNine && s2 == numberFive) begin
            s1 <= 4'b0000;
            s2 <= 4'b0000;

            // Update minutes
            if (m1 == numberNine && m2 == numberFive) begin
                m1 <= 4'b0000;
                m2 <= 4'b0000;

                // Update hours
                if (h1 == numberFour && h2 == numberTwo) begin
                    h1 <= 4'b0000;
                    h2 <= 4'b0000;
                end 
                else if (h1 == numberNine) begin
                    h2 <= h2 + 4'b0001;
                    h1 <= 4'b0000;
                end 
                else if (h2 != numberTwo) begin
                    h1 <= h1 + 4'b0001;
                end

            end else if (m1 == numberNine) begin
                m2 <= m2 + 4'b0001;
                m1 <= 4'b0000;
            end else begin
                m1 <= m1 + 4'b0001;
            end
        end 
        else if (s1 == numberNine) begin
            s2 <= s2 + 4'b0001;
            s1 <= 4'b0000;
        end 
        else begin
            s1 <= s1 + 4'b0001;
        end


        // Button Hanlder
        if(btnL) begin
            if(pos != 4) begin
                pos = pos + 1;
            end
            else begin
                pos = 1;
            end
        end
        else if(btnR) begin
            if(pos != 1) begin
                pos = pos - 1;
            end
            else begin
                pos = 4;
            end
        end
        
        else if(btnU) begin
            if(pos == 1) begin
                m1 <= m1 + numberOne;
            end
            else if(pos == 2) begin
                m2 <= m2 + numberOne;
            end
            else if(pos == 3) begin
                h1 <= h1 + numberOne;
            end
            else if(pos == 4) begin
                h2 <= h2 + numberOne;
            end
        end
        else if (btnD) begin
            if(pos == 1) begin
                m1 <= m1 - numberOne;
            end
            else if(pos == 2) begin
                m2 <= m2 - numberOne;
            end
            else if(pos == 3) begin
                h1 <= h1 - numberOne;
            end
            else if(pos == 4) begin
                h2 <= h2 - numberOne;
            end
        end

    end

   
    
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