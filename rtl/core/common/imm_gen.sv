module imm_gen(instr, ext_sel, out);
    input  logic [31: 0] instr;
    input  logic [2 : 0] ext_sel;
    output logic [31: 0] out;

    always_comb begin
        case(ext_sel)
        //I-Type instructions
        3'b000:     out = {{20{instr[31]}}, instr[31:20]};
        //S-Type instructions
        3'b001:     out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        //B-Type instructions
        //TODO: Correct the following after rethinking.
        3'b010:     out = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        //U-Type instructions
        3'b011:     out = {{20{instr[11]}}, instr[31:25]};
        //J-Type instructions
        3'b100:     out = {{20{instr[11]}}, instr[31:25]};
        //R4-Type instructions
        3'b101:     out = {{20{instr[11]}}, instr[31:25]};

        default: out = 32'hx;
    endcase

    end

endmodule