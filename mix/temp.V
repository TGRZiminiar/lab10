Verilog Code:

module counter_alarmclock(
    input clk,
    input rst,
    output reg [3:0] seconds,
    output reg [2:0] minutes
    );
wire a;
initial seconds = 4'b0000;
initial minutes = 3'b000;
always@(posedge clk)
begin
    if(rst == 1)
    begin
        seconds <= 4'b0000;
        minutes <= 3'b000;
    end
    else if(seconds <= 4'b1000)
    begin
        seconds <= seconds+1;
    end
    else if(seconds <= 4'b1001)
    begin
        seconds <= 4'b0000;
    end
end
assign a = ~(seconds[3]&seconds[0]);
always@(posedge a)
begin
    if(rst == 1)
    begin
        seconds <= 4'b0000;
        minutes <= 3'b000;
    end
    else if(minutes <= 3'b100)
    begin
        minutes <= minutes+1;
    end
    else if(minutes <= 3'b101)
    begin
        minutes <= 3'b000;
    end
end
endmodule
 

Verilog Test Bench Code:

module counter_alarmclock_tb;
    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [3:0] seconds;
    wire [2:0] minutes;

    // Instantiate the Unit Under Test (UUT)
    counter_alarmclock uut(
        .clk(clk),
        .rst(rst),
        .seconds(seconds),
        .minutes(minutes)
    );
    initial begin
    // Initialize Inputs
    clk = 0;
    rst = 0;
    
    // Add stimulus here
    
    end
    always #50 clk = ~clk;
endmodule
 





module myCircuit(
    input A,B,C,
    output F 
);

    wire w1, w2, w3;

    // A and not B
    assign w1 = A & ~B;
    assign w2 = ~A & ~C;
    assign w3 = A & B & C;
    assign F = w1 | w2 | w3;

endmodule

module myCircuit_TB (
    
);

    reg in_A;
    reg in_B;
    reg in_C;
    wire out_F;
    
    myCircuit dut (in_A, in_B, in_C, out_F);

    initial begin
        $monitor("A = %b, B = %b, C = %b, F = %b", in_A, in_B, in_C, out_F);

        // delay each input with a 10ns
        in_A = 1'b0;
        in_B = 1'b0;
        in_C = 1'b0;
        #10
        in_A = 1'b0;
        in_B = 1'b0;
        in_C = 1'b1;
        #10
        in_A = 1'b0;
        in_B = 1'b1;
        in_C = 1'b0;
        #10
        in_A = 1'b0;
        in_B = 1'b1;
        in_C = 1'b1;

    end

endmodule
