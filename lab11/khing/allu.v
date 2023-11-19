module ALU(
    input [3:0] ALU_control, Ain, Bin,
    output reg [3:0] ACC_out, 
    output reg V, Z, C
    );
    reg [3:0] ALU_out;
    wire c;
    
    always @*
    begin
        case (ALU_control)
            4'b0001 : ALU_out = Ain + Bin;
            4'b0010 : ALU_out = Ain - Bin;
            4'b0101 : ALU_out = Ain & Bin;
            4'b0110 : ALU_out = Ain | Bin;
            4'b0111 : ALU_out = ~Ain;
            4'b1000 : ALU_out = Ain << 2;
            4'b1100 : ALU_out = Ain >>> 2; // Use >>> for logical shift right
            default: ALU_out = 4'b0; // Handle default case
        endcase

        Z = (ALU_out == 4'b0) ? 1 : 0; // Set Z based on ALU_out value

        // Check for overflow (V flag)
        if (ALU_control == 4'b0001 || ALU_control == 4'b0010) begin
            if ((Ain[3] & Bin[3] & ~ALU_out[3]) | (~Ain[3] & ~Bin[3] & ALU_out[3]) | (~Ain[3] & Bin[3] & ALU_out[3]))
                V = 1;
            else
                V = 0;
        end else begin
            V = 0;
        end

        // Carry flag (C) - for addition
        C = (ALU_control == 4'b0001 && ((Ain[3] & Bin[3]) | (Bin[3] & ~ALU_out[3]) | (~ALU_out[3] & Ain[3]))) ? 1 : 0;

        ACC_out = ALU_out;
    end
endmodule