module tb_alu;

    reg [3:0] ALU_control, a, b;
    wire [3:0] ALU_out;
    wire c,v,z;

    ALU uut(ALU_control, a, b, ALU_out, c, v, z);

    initial begin
        a = 4'b0011;
        b = 4'b1000;
    	ALU_control = 4'b1000;
    end

    initial $monitor("ALU_OUT = %b v = %b, z = %b, c = %b", ALU_out, v, z, c);

endmodule