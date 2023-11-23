module top_module;
    
    reg [3:0] A;
    reg [3:0] B;
    reg subtract; // 0 for addition, 1 for subtraction
    wire [3:0] S;
    wire overflow;
  	
  	initial begin
      	A = 4'b1110;
      	B = 4'b0011;
      	subtract = 1;
    end
  
    binary_adder_subtractor uut (
      	.A(A),
        .B(B),
        .subtract(subtract),
        .S(S),
        .overflow(overflow)
    );
    
  initial $monitor("A = %d, B = %d, S = %d, Overflow = %d", A, B, S, overflow);
endmodule
