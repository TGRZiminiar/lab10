module oneSecond(
    input clk,
    output clk_out,
    output [3:0] an
);

    reg elapsed;
    reg [24:0] state;
    localparam onesec = 100_000_00; // 1 second

    always @ (posedge clk) begin
        if (state == onesec) begin
            state <= 0;
        end
        else begin
            state <= state + 1;
        end
    end

    always @(state) begin
        if(state == onesec) begin
            elapsed = 1;
        end
        else begin
            elapsed = 0;
        end
    end

    assign clk_out = elapsed;

    always @(state) begin
        case (state[14])
        1'b0:
            AN <= 4'b1110;
        1'b1:
            AN <= 4'b1101; 
        endcase
        case (state[15])
        1'b0:
            AN <= 4'b1111;
        1'b1:
            AN <= 4'b1111; 
        endcase
    end

endmodule