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