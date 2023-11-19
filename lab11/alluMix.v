module ALU(
    input [3:0]ALU_control,  Ain, Bin, 
    output reg [3:0] ACC_out,
    output reg v,z,c
);
    reg [3:0] ALU_out;

    always @* begin
          case (ALU_control)
            4'b0001 : ALU_out = Ain + Bin;
            4'b0010 : ALU_out = Ain - Bin;
            4'b0101 : ALU_out = Ain & Bin;
            4'b0110 : ALU_out = Ain | Bin;
            4'b0111 : ALU_out = ~Ain;
            4'b1000 : ALU_out = Ain << 2;
            4'b1100 : ALU_out = Ain >>> 2;
            default: ALU_out = 4'b0;
        endcase

    z = (ALU_out == 4'b0) ? 1 : 0;

    if (ALU_control == 4'b0001 || ALU_control == 4'b0010) begin
            if ((Ain[3] & Bin[3] & ~ALU_out[3]) | (~Ain[3] & Bin[3] & ALU_out[3]))
                v = 1;
            else
                v = 0;
        end else begin
            v = 0;
        end

    if(ALU_control == 4'b0001) begin
        if(Ain[3] & Bin[3] | Ain[3] & ~ALU_out[3] | Bin[3] & ~ALU_out[3]) 
            c = 1;
        else c = 0;
    end
    else c = 0;

    ACC_out = ALU_out;

    end


endmodule