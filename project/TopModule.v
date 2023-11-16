module TopModule (
    input clk,
    input sw,
    input btnC, // reset clock
    input btnU, // hour increment
    input btnR, // min increment
    output [6:0] seg, 
    output [3:0] an,
    input [7:0] led, // display seconds

);
    wire [3:0] s1, s2, m1, m2, h1, h2;
    reg hrup, minup;

    wire btnCclr, btnUclr, btnRclr;
    reg btnCclr_prev, btnUclr_prev, btnRclr_prev;

    Debounce dbC(clk, btnC, btnCclr);   
    Debounce dbU(clk, btnU, btnUclr); // hour up
    Debounce dbR(clk, btnR, btnRclr); // min up

    // 1'b0 = clear set to 0
    SevenSegDrive seg7(clk, 1'b0, h2, h1, m2, m1, seg, an); //HH:MM
    DigitalClock clock(clk, sw, btnCclr, hrup, minup, s1, s2, m1, m2, h1, h2);

    always @(posedge clk) begin
        btnUclr_prev <= btnUclr;
        btnRclr_prev <= btnRclr;
        if(btnUclr_prev == 1'b0 && btnUclr == 1'b1) hrup <= 1'b1;
        else  hrup <= 0;
        
        if(btnRclr_prev == 1'b0 && btnRclr == 1'b1) minup <= 1'b1;
        else  minup <= 0;

    end
    assign led[7:0] ={s2, s1};

endmodule