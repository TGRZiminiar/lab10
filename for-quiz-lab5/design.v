module binary_adder_subtractor (
    input signed [3:0] A,
    input signed [3:0] B,
    input subtract,   // 0 for addition, 1 for subtraction
    output reg [3:0] S,
    output reg overflow
);
    
    always @* begin
      if(subtract == 0) begin
        S = A + B;
      	overflow = (A[3] ^ B[3]) ? 0: (S[3] ^ A[3]);
      end
      else begin
      	S = A - B;
        overflow = (A[3] ^ ~B[3]) ? 0: (S[3] ^ A[3]);
      end
      
    end

endmodule

