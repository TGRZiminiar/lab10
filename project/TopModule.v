module TopModule (
    input clk,
    input sw,
    output reg [6:0] seg, 
    output reg [3:0] an
);
    wire [3:0] s1, s2, m1, m2, h1, h2;
    reg [5:0] hour, minute, second;

    reg hrup, minup;

    // Make 4 digit can't be catch by human eye
    //SevenSeg seg7(clk, 1'b0, h2, h1, m2, m1, seg, an); //HH:MM
    
    reg [24:0] clkCounter = 0;
    reg oneSecAlready; // 1 = 1second; 0 = not one sec yet
    localparam onesec = 100_000_00; // 1 second

    always @(posedge clk) begin
        clkCounter <= clkCounter + 1;
        if (clkCounter == onesec) begin
            clkCounter <= 0;
            oneSecAlready = 1;
        end
        else oneSecAlready = 0;
    end

    always @(posedge clk) begin
        if (clkCounter == onesec) begin
            if (sw == 1'b1) begin
                {hour, minute, second} <= 0;
            end
            if(second == 6'd59) begin
                second <= 0;
                if(minute == 6'd59) begin
                    minute <= 0;
                    if(hour == 6'd23) begin
                        hour <= 0;
                    end
                    else begin
                        hour <= hour + 1'd1;
                    end
                end
                else begin
                    minute <= minute + 1'd1;
                end
            end
            else begin
                second <= second + 1'd1;
            end
        end    
    end


    wire [6:0] seg1, seg2, seg3, seg4;
    reg [12:0] segClk;
    localparam LEFT = 2'b00, MIDLEFT = 2'b01, MIDRIGHT = 2'b10, RIGHT = 2'b11;
    reg [1:0] state=LEFT;

    always @(posedge clk) begin
        segClk <= segClk + 1'b1; // Counter up by one
    end

    always @(posedge segClk[12] or posedge sw) begin
        if(sw == 1) begin
            seg <= 7'b0000000;
            an <= 4'b0000;
            state <= LEFT;
        end
        else begin
            case (state)
                LEFT: begin
                    seg <= seg1;
                    an <= 4'b0111;
                    state <= MIDLEFT;
                end

                MIDLEFT: begin
                    seg <= seg2;
                    an <= 4'b1011;
                    state <= MIDRIGHT;
                end
                
                MIDRIGHT: begin
                    seg <= seg3;
                    an <= 4'b1101;
                    state <= RIGHT;
                end

                RIGHT: begin
                    seg <= seg4;
                    an <= 4'b1110;
                    state <= LEFT;
                end
            endcase
        end
    end

    BinaryToBcd second12(.binary(sec), .thos(), .hund(), .tens(s2), .ones(s1));    
    BinaryToBcd minute12(.binary(min), .thos(), .hund(), .tens(m2), .ones(m1));    
    BinaryToBcd hourBinary(.binary(hour), .thos(), .hund(), .tens(h2), .ones(h1));    
    
    Decoder7Segment disp1(h1, seg1);
    Decoder7Segment disp2(h2, seg2);
    Decoder7Segment disp3(m1, seg3);
    Decoder7Segment disp4(m2, seg4);



endmodule