module DigitalClock (
    input clk, // clock with 1hz
    input en,  // enable
    input rst, // reset all of input and output
    input hrup, // btn use to increment hour
    input minup, // btn use to increment min
    output [3:0] s1,
    output [3:0] s2,
    output [3:0] m1,
    output [3:0] m2,
    output [3:0] h1,
    output [3:0] h2
);

    // Time display
    // h2 h1 m2 m1 
    reg [5:0] hour = 0, min = 0, sec = 0; // max is 60 2^6 = 64
    integer clkc = 0;
    localparam onesec = 100_000_00; // 1 second

    always @(posedge clk) begin
        if(rst == 1'b1) begin
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
        else if (en == 1'b1) begin
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

    // To Convert binary BCD to number and display 
    BinaryToBcd second(.binary(sec), .thos(), .hund(), .tens(s2), .ones(s1));    
    BinaryToBcd minute(.binary(min), .thos(), .hund(), .tens(m2), .ones(m1));    
    BinaryToBcd hourBinary(.binary(hour), .thos(), .hund(), .tens(h2), .ones(h1));    
endmodule