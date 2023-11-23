module final1(
	input x1, x2, x3,x4,
  	output y
);
  
  wire notx2, notx3, a, b, c;
  assign notx2 = ~x2;
  assign notx3 = ~x3;
  assign a = x3 & notx2;
  assign b = x1 & notx3;
  assign c = b & x4;
  assign y = a | c;
    
endmodule