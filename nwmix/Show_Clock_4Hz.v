module Show_Clock_4Hz (
    input clk_in,
    output clk_out
);
    
    reg [25:0] count = 0;
    reg clk_out;

    always @(posedge clk_in) begin
        count <= count + 1;
        if (count == 3_125_000) begin
            count <= 0;
            clk_out = ~clk_out;
        end
    end
    
endmodule