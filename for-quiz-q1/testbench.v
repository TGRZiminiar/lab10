// Code your testbench here or browse Examples module
module final1_tb;

reg x1, x2, x3, x4;
wire y;

final1 test(
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .x4(x4),
    .y(y)
);

  initial begin
    x1= 0; x2 =0; x3 = 0; x4=0; //y=0
    #40x1= 0; x2 =0; x3 = 0; x4=1; //y=0
    #40x1= 0; x2 =0; x3 = 1; x4=0; //y=1
    #40x1= 0; x2 =0; x3 = 1; x4=1; //y=1
    #40x1=0; x2 =1; x3 = 0; x4=0; //y=0
    #40x1= 0; x2 =1; x3 = 0; x4=1; //y=0
    #40x1= 0; x2 =1; x3 = 1; x4=0; //y=0
    #40x1= 0; x2 =1; x3 = 1; x4=1; //y=0
    #40x1= 1; x2 =0; x3 = 0; x4=0; //y=0
    #40x1= 1; x2 =0; x3 = 0; x4=1; //y=1
    #40x1= 1; x2 =0; x3 = 1; x4=0; //y=1
    #40x1= 1; x2 =0; x3 = 1; x4=1; //y=1
    #40x1= 1; x2 =1; x3 = 0; x4=0; //y=0
    #40x1= 1; x2 =1; x3 = 0; x4=1; //y=1
    #40x1= 1; x2 =1; x3 = 1; x4=0; //y=0
    #40x1= 1; x2 =1; x3 = 1; x4=1; //y=0
  end
   

	initial begin 
      $monitor ("x1=%b | x2=%b |x3=%b |x4=%b |y=%b ", x1,x2,x3,x4,y);
    end
endmodule
