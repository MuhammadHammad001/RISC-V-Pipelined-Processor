module imm_gen(instr, ext_sel, out);
    input  logic [31: 0] instr;
    input  logic [2 : 0] ext_sel;
    output logic [31: 0] out;

    always_comb begin
        case(ext_sel)
            // I-Type instructions
            3'b000: out = {{20{instr[31]}}, instr[31:20]};

            // S-Type instructions
            3'b001: out = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            // B-Type instructions (Fixed)
            3'b010: out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

            // J-Type instructions
            3'b011: out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

            // U-Type instructions (LUI, AUIPC)
            3'b100: out = {instr[31:12], 12'b0};

            // R4-Type instructions -- Floating point operations.
            3'b101: out = {{20{instr[11]}}, instr[31:25]};

            default: out = 32'hx;  // Default case
        endcase
    end
endmodule
