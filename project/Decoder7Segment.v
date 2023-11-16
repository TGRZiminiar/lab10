module Decoder7Segment(
    input [3:0] in,
    output reg [6:0] seg
);
    always @(in) begin
        case(in)

        0: seg=7'b0000001; // active low logic display 0 on segment
        1: seg=7'b1001111; // 1
        2: seg=7'b0010010; // 2
        3: seg=7'b0000110; // 3
        4: seg=7'b1001100; // 4
        5: seg=7'b0100100; // 5
        6: seg=7'b0100000; // 6
        7: seg=7'b0001111; // 7
        8: seg=7'b0000000; // 8
        9: seg=7'b0001100; // 9
        endcase
    end


endmodule