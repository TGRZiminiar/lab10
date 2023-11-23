// Overflow
module subtractor(
  input signed [3:0] Ain, Bin,
  input mode,
  output reg [3:0] ans,
  output reg  V, C
);
  
  always @(Ain or Bin) begin
    case(mode)
      0: begin
        {C,ans} = Ain + Bin;
        V = (Ain[3] ^ Bin[3]) ? 0 : (Ain[3] ^ ans[3]);
      end
      1: begin
        {C,ans} = Ain - Bin;
        V = (Ain[3] ^ ~Bin[3]) ? 0 : (Ain[3] ^ ans[3]);
      end
    endcase
  end
endmodule

module top_module;
  reg [3:0] Ain, Bin;
  reg mode;
  wire [3:0] ans;
  wire V, C;
  
  subtractor waew(
    .Ain(Ain),
    .Bin(Bin),
    .mode(mode),
    .ans(ans),
    .V(V),
    .C(C)
  );
  
  initial begin
	Ain = 4'b0001;
    Bin = 4'b0001;
    mode = 0;
  end
  
  initial $monitor("ans = %d\n Ain = %d, Bin = %d, V = %d, C = %d", ans, Ain, Bin, V, C);
  
endmodule