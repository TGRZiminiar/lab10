module TimeChecker (
    output reg [3:0] s1,
    output reg [3:0] s2,
    output reg [3:0] m1,
    output reg [3:0] m2,
    output reg [3:0] h1,
    output reg [3:0] h2
);


    localparam zero = 4'b0000; // 0
    localparam numberTwo  = 4'b0010;
    localparam numberFour  = 4'b0100;
    localparam numberFive = 4'b0101;
    localparam numberNine = 4'b1001;
    

    if (s1 == numberNine && s2 == numberFive) begin
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
    
endmodule