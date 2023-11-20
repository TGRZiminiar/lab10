`timescale 1ns / 1ps



module divider1 ( 
    input clock, 
    output clk_out
);
    reg elapsed; // โปรแกรทรันครบ 1 วิแล้ว 
    reg [27:0] state;

    // took 1 second
    always @ (posedge clock)
        if (state == 100000000) state <= 0;
        else state <= state + 1;
    
    always @(state)
        if (state == 100000000) elapsed = 1;
        else elapsed = 0; 

    assign clk_out = elapsed;
endmodule