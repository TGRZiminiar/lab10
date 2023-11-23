module topModule (
    input clk, sw, btnC, btnU, btnR,
    output [6:0] seg,
    output [3:0] an,
    output [7:0] led
);
    reg [3:0] s1, s2, m1, m2, h1, h2;

    reg hrup, minup;

    // Make 4 digit can't be catch by human eye
    SevenSeg seg7(clk, 1'b0, h2, h1, m2, m1, seg, an); //HH:MM
    
    reg [24:0] clkCounter = 0;
    reg oneSecAlready; // 1 = 1second; 0 = not one sec yet
    localparam onesec = 100_000_00; // 1 second

    always @(posedge clk) begin
        clkCounter <= clkCounter + 1;
        if (clkCounter == onesec) begin
            clkCounter <= 0;
            oneSecAlready = 1;
        end
        else oneSecAlready = 0;
    end

    
    
endmodule