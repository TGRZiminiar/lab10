module topModule (
    input clk, sw,
    output [6:0] seg,
    output [3:0] AN

);

    wire [3:0] counter;
    wire clk_out;

    divider divide(clk, clk_out);

    counter counter(clk_out, sw, counter);

    bcdto7seg bcdto7seg(counter, seg, AN)

endmodule;


module divider (
    input clk,
    output clk_out
);
    reg elasped;
    reg [27:0] state;

    always @(posedge clk)
        if (state == 100000000) state <= 0;
        else state <= state + 1;

    always @(state)
        if (state == 100000000) elasped = 1;
        else elasped = 0;

    assign clk_out = elasped

endmodule

module counter (
    input clk_out,
    input sw,
    output reg [3:0] counter
);
    initial counter = 4'b0000;

    always @(clk_out) begin
        if(sw) counter = 4'b0000;
        else begin
            if(clk_out == 1) begin
                // 9 = 1001
                if(counter == 4'b1001) counter = 4'b0000;
                else counter = counter + 4'b0001;
            end
        end  
    end
endmodule

module bcdto7seg (
    input [3:0] counter, 
    output reg [6:0] seg, 
    output reg [3:0] AN
);

    always @(counter) begin
        case (counter)
        4'b0000 : seg <= 7'b1000000;
        4'b0001 : seg <= 7'b1111001;
        4'b0010 : seg <= 7'b0100100;
        4'b0011 : seg <= 7'b0110000;
        4'b0100 : seg <= 7'b0011001;
        4'b0101 : seg <= 7'b0010010;
        4'b0110 : seg <= 7'b0000010;
        4'b0111 : seg <= 7'b1111000;
        4'b1000 : seg <= 7'b0000000;
        4'b1001 : seg <= 7'b0010000;
        default: seg <= 7'b1111111;
        endcase
        AN <= 4'b1110;

    end

endmodule