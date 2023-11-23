// Full Adder Subtract
module halfadder(output s,c, input x,y);
  xor(s,x,y);
  and(c,x,y);//carry 1+1
endmodule

module fulladder(output s,c,input x, y, c0);
  wire s1,c1,c2;
  halfadder ha0(s1,c1,x,y);
  halfadder ha1(s,c2,s1,c0); //add sum product with carry
  or(c,c1,c2); //  x y c 1 1 1 = 1| 110:1|011:1
endmodule

module alu(input [3:0] a,b,
            input c,
           output [3:0] out,
           output v,c4,z
  );
  wire c1,c2,c3;
  wire bp0,bp1,bp2,bp3;
  
  // first complement
  xor(bp0, b[0], c);
  xor(bp1, b[1], c);
  xor(bp2, b[2], c);
  xor(bp3, b[3], c);
  
  // second complement
  fulladder fa0(out[0], c1,a[0],bp0,c),
     fa1(out[1], c2,a[1],bp1,c1),
     fa2(out[2], c3,a[2],bp2,c2),
     fa3(out[3], c4,a[3],bp3,c3);
  
  assign z = (out == 4'b0000);
  
  assign v = c4^c3;
	
endmodule

// Code your testbench here
// or browse Examples
// V = overflow
module tb_alu;

  reg signed [3:0] a,b;
  wire [3:0] alu_out;
  wire c,v,z;
   // integer i;

    // Instantiate the Unit Under Test (UUT)
  alu uut (a,b,1,alu_out,v,c,z); // change the module name

//Apply inputs
    initial begin // chage the opcode
      a= 4'b0111; // change Ain
      b= 4'b1000; // change Bin
      #40;
      a= 4'b0001; // change Ain
      b= 4'b0100; // change Bin
    end
  initial begin
    
    $monitor("A = %d\n B = %d\n alu_out = %d\n c= %b\n z= %b\n v= %b\n ",a , b,alu_out, c,z,v ); // you cancopy and add more test cases after this
    
  end
      
endmodule
