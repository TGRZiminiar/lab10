// Code your design here
// Eda playground
module tb_allu;
  
  reg [3:0] ALU_control, Ain, Bin;
  wire [3:0] ALU_out;
  wire v,z,c;
  

  // // Case8
  initial begin 
      Ain = 4'b1000;
      Bin = 4'b1000;
      ALU_control = 4'b0001;
  end
      
  ALU alu(ALU_control, Ain, Bin, ALU_out, v, z, c);
  
  initial $monitor("ALU_OUT = %b v = %b, z = %b, c = %b", ALU_out, v, z, c);
  
endmodule