`timescale 1ns / 1ps



module divider ( 
    input clock, 
    output clk_out
);
    reg elapsed; //elapsed time 1 second 
    reg [27:0] state;
    
    always @ (posedge clock)
        if (state == 100000000) state <= 0; 
        else state <= state + 1;
    
    always @(state)
        if (state == 100000000) elapsed = 1;
        else elapsed = 0; 

    assign clk_out = elapsed;

endmodule