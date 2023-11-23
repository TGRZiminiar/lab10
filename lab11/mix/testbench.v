// Code your testbench here
// or browse Examples
module ALU (
  
  input [3:0] ALU_control, Ain, Bin,
  output reg [3:0] ALU_out,
  output reg v,z,c
  
);
  
  reg [3:0] ACC_out;
  
  always@* begin  
    case(ALU_control)
      4'b0001: ACC_out = Ain + Bin;
      4'b0010: ACC_out = Ain - Bin;
      4'b0101: ACC_out = Ain & Bin;
      4'b0110: ACC_out = Ain | Bin;
      4'b0111: ACC_out = ~Ain;
      4'b1000: ACC_out = Ain << 2;
      4'b1100: ACC_out = Ain >> 2;
     default: ACC_out = 4'b0000;
    endcase

    if(ALU_control == 4'b0010 || ALU_control == 4'b0001) begin
      if((~Ain[3] & Bin[3] & ~ALU_control[3]) | (Ain[3] & Bin[3] && ~ALU_control[3])) begin
        v = 1;
      end
      else begin
        v = 0; 
      end
    end
    else v = 0;

    if(ACC_out == 4'b0000) z = 1;
    else z = 0;
    
    if(ALU_control == 4'b0001) begin
      if(Ain[3] & Bin[3] & ~ALU_control[3]) c = 1;
      else c = 0;
    end
    else c = 0;
    
    ALU_out = ACC_out;
    
    end
endmodule

