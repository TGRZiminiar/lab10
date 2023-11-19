// Case1 ALU_OUT = 1111 v = 1, z = 0, c = 0
initial begin
    Ain = 4'b0111;
    Bin = 4'b1000;
    ALU_control = 4'b0010;
end
 
// Case2 ALU_OUT = 0000 v = 1, z = 1, c = 1
initial begin 
    Ain = 4'b1000;
    Bin = 4'b1000;
    ALU_control = 4'b0001;
end

// Case3 ALU_OUT = 0100 v = 0, z = 0, c = 0
initial begin
    Ain = 4'b0011;
    Bin = 4'b0001;
    ALU_control = 4'b0001;
end

// Case4 ALU_OUT = 0001 v = 0, z = 0, c = 0
initial begin
    Ain = 4'b0011;
    Bin = 4'b0001;
    ALU_control = 4'b0101;
end

// Case5 ALU_OUT = 0011 v = 0, z = 0, c = 0
initial begin
    Ain = 4'b0011;
    Bin = 4'b0001;
    ALU_control = 4'b0110;
end

// Case6 ALU_OUT = 1100 v = 0, z = 0, c = 0
initial begin
    Ain = 4'b0011;
    Bin = 4'b0001;
    ALU_control = 4'b0111;
end

// Case7 ALU_OUT = 1100 v = 0, z = 0, c = 0

initial begin
    Ain = 4'b0011;
    Bin = 4'b0001;
    ALU_control = 4'b1000;
end

// Case8 ALU_OUT = 0000 v = 0, z = 1, c = 0
initial begin
    Ain = 4'b0011;
    Bin = 4'b0001;
    ALU_control = 4'b1100;
end