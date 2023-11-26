`timescale 1ns / 1ps
module DigitalClock (
    input clk,
    input sw, swClearAlarm, swSubmitAlarm,
    input trigger,
    output [3:0] s1,
    output [3:0] s2,
    output [3:0] m1,
    output [3:0] m2,
    output [3:0] h1,
    output [3:0] h2,
    output reg currentMode, // intial value is CLOCK
    output reg pos, // intial value is 1
    output reg hrup, // btn use to increment hour
    output reg minup, // btn use to increment min
    input btnC, btnU, btnL, btnR, btnD,
    output reg ledAlarmMode, ledTimeAlarm
);

    
    // 1  2  :  3  0  :  5  0
    // h2 h1 :  m2 m1 :  s2 s1

    integer clkc = 0;
    
    localparam zero = 4'b0000; // 0
    localparam numberOne = 4'b0001;
    localparam numberTwo  = 4'b0010;
    localparam numberFour  = 4'b0100;
    localparam numberFive = 4'b0101;
    localparam numberNine = 4'b1001;
    localparam onesec = 100_000_00; // 1 second
    
    localparam CLOCK = 1'b0;
    localparam ALARM = 1'b1; 

    reg [5:0] hour = 0, min = 0, sec = 0; // max is 60 2^6 = 64
    reg [5:0] hourAlarm = 0, minAlarm = 0, secAlarm = 0; // max is 60 2^6 = 64
    reg btnL_prev, btnR_prev, btnC_prev, btnU_prev, btnD_prev;
    
    // 2 Mode = CLOCK, ALARM
    

    initial begin
        hour <= 6'd12;
        min <= 6'd58;
        pos = 1'b0;
        currentMode = CLOCK;    
    end

    

    always @(posedge clk) begin
        if(sw == 1'b1) begin
            // reset everything to 0
            {hour, min, sec} <= 0;
        end

        if (btnL && !btnL_prev) begin
            pos <= (pos == 1'b0) ? 1'b1 : 1'b0;
        end
        
        if (btnR && !btnR_prev) begin
            pos <= (pos == 1'b1) ? 1'b0 : 1'b1;
        end
        
        if(btnC && !btnC_prev) begin
            currentMode <= (1'b0) ? 1'b1 : 1'b0;
        end
    

        case (currentMode)
            //Normal Clock
            CLOCK: begin
                
                case (pos)
                    1'b0: begin
                        if (btnU && !btnU_prev) begin   
                            if (min == 6'd59) begin
                                min <= 0;
                            end
                            else begin
                                min <= min + 1'd1;
                            end
                        end
                        else if(btnD && !btnD_prev) begin
                            if (min == 6'd0) begin
                                min <= 6'd59;
                            end
                            else begin
                                min <= min - 1'd1;
                            end
                        end
                    end

                    1'b1: begin
                        if (btnU && !btnU_prev) begin
                            if (hour == 6'd24) begin
                                hour <= 0;
                            end
                            else begin
                                hour <= hour + 1'd1;
                            end
                        end
                        else if(btnD && !btnD_prev) begin
                            if (hour == 6'd0) begin
                                hour <= 6'd59;
                            end
                            else begin
                                hour <= hour - 1'd1;
                            end
                        end
                    end 
                    default: begin
                        if (btnU && !btnU_prev) begin
                            if (hour == 6'd24) begin
                                hour <= 0;
                            end
                            else begin
                                hour <= hour + 1'd1;
                            end
                        end
                        else if(btnD && !btnD_prev) begin
                            if (hour == 6'd0) begin
                                hour <= 6'd59;
                            end
                            else begin
                                hour <= hour - 1'd1;
                            end
                        end
                    end
                endcase

                if(hour == hourAlarm && min == minAlarm) ledTimeAlarm = 1'b1;
                else ledTimeAlarm = 1'b0;

                // 24 Hour Clock Code 
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
            end // end of CLOCK Mode


            //Alarm Clock
            ALARM: begin
                hourAlarm = hour;
                minAlarm = min;
                case (pos)
                    1'b0: begin
                        if (btnU && !btnU_prev) begin   
                            if (minAlarm == 6'd59) begin
                                minAlarm <= 0;
                            end
                            else begin
                                minAlarm <= minAlarm + 1'd1;
                            end
                        end
                        else if(btnD && !btnD_prev) begin
                            if (minAlarm == 6'd0) begin
                                minAlarm <= 6'd59;
                            end
                            else begin
                                minAlarm <= minAlarm - 1'd1;
                            end
                        end
                    end

                    1'b1: begin
                        if (btnU && !btnU_prev) begin
                            if (hourAlarm == 6'd24) begin
                                hourAlarm <= 0;
                            end
                            else begin
                                hourAlarm <= hourAlarm + 1'd1;
                            end
                        end
                        else if(btnD && !btnD_prev) begin
                            if (hourAlarm == 6'd0) begin
                                hourAlarm <= 6'd59;
                            end
                            else begin
                                hourAlarm <= hourAlarm - 1'd1;
                            end
                        end
                    end 
                    default: begin
                        if (btnU && !btnU_prev) begin
                            if (hourAlarm == 6'd24) begin
                                hourAlarm <= 0;
                            end
                            else begin
                                hourAlarm <= hourAlarm + 1'd1;
                            end
                        end
                        else if(btnD && !btnD_prev) begin
                            if (hourAlarm == 6'd0) begin
                                hourAlarm <= 6'd59;
                            end
                            else begin
                                hourAlarm <= hourAlarm - 1'd1;
                            end
                        end
                    end
                endcase

                if(swSubmitAlarm) begin
                    currentMode <= CLOCK;
                end

            end

        endcase
        
        btnC_prev <= btnC;
        btnL_prev <= btnL;
        btnR_prev <= btnR;
        btnU_prev <= btnU;
        btnD_prev <= btnD;
       
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