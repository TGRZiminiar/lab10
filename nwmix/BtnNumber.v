module BunNumber (
    input btnC, btnU, btnL, btnR, btnD,
    output ledD1, ledD2, ledD3, ledD4,
    output reg [3:0] m1,
    output reg [3:0] m2,
    output reg [3:0] h1,
    output reg [3:0] h2
);
    
    reg [12:0] segClk;
    always @(posedge clk) begin
        segClk <= segClk + 1'b1; // Counter up by one
    end


    // Do the normal increment for clock first!
    //        1  2 :  3  0
    // pos =  4  3    2  1
    
    // position have 4 option = 1, 2, 3, 4
    wire pos = 1;
    
    // 2 Mode = Clock, Alarm
    // reg currentMode = Clock;

    always @(posedge segClk[12]) begin
        if(btnL) begin
            if(pos != 4) begin
                pos = pos + 1;
            end
            else begin
                pos = 1;
            end
        end
        else if(btnR) begin
            if(pos != 1) begin
                pos = pos - 1;
            end
            else begin
                pos = 4;
            end
        end
    end

    assign ledD1 = (pos == 1) ? 1'b1 : 1'b0;
    assign ledD2 = (pos == 2) ? 1'b1 : 1'b0;
    assign ledD3 = (pos == 3) ? 1'b1 : 1'b0;
    assign ledD4 = (pos == 4) ? 1'b1 : 1'b0;
    localparam numberOne = 4'b0001;
    always @(posedge segClk[12]) begin
        if(btnU) begin
            if(pos == 1) begin
                m1 = m1 + numberOne;
            end
            else if(pos == 2) begin
                m2 = m2 + numberOne;
            end
            else if(pos == 3) begin
                h1 = h1 + numberOne;
            end
            else if(pos == 4) begin
                h2 = h2 + numberOne;
            end
        end
        else if (btnD) begin
            if(pos == 1) begin
                m1 = m1 - numberOne;
            end
            else if(pos == 2) begin
                m2 = m2 - numberOne;
            end
            else if(pos == 3) begin
                h1 = h1 - numberOne;
            end
            else if(pos == 4) begin
                h2 = h2 - numberOne;
            end
        end
       
    end

endmodule