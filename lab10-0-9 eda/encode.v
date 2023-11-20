`timescale 1ns / 1ps

module counter(
    input clk_in,
    input sw,
    output reg[3:0] count
    );
    initial count = 4'b0000;
    
    always @(posedge clk_in)
        if (sw)
            count <= 4'b0000;
        else 
            if(clk_in == 1)
                // count >= 9
                if (count >= 4'b1001)
                    count <= 4'b0000;
                else
                    // count += 1
                    count = count + 4'b0001;
    
    endmodule