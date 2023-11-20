`timescale 1ns / 1ps

module counter1(
    input clk_out,
    input sw,
    output reg[3:0] count
    );
    // 0
    initial count = 4'b0000;

    always @(posedge clk_out) begin
        if (sw)
            count <= 4'b0000;
        else 
            if(clk_out == 1)
                // count >= 9
                if (count >= 4'b1001)
                    count <= 4'b0000;
                else
                    // count += 1
                    count = count + 4'b0001;
    end
endmodule