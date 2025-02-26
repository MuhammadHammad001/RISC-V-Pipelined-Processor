module alu (
    input  logic [31:0] srcA,       // First operand
    input  logic [31:0] srcB,       // Second operand or immediate
    input  logic [3:0]  ALUControl, // ALU control signal
    output logic [31:0] ALUResult,  // ALU result output
    output logic        ZeroE       // Zero flag output
);

    // ALU control parameters
    parameter [3:0] ADD  = 4'b0000;
    parameter [3:0] SUB  = 4'b0001;
    parameter [3:0] SLL  = 4'b0010;
    parameter [3:0] SLT  = 4'b0011;
    parameter [3:0] SLTU = 4'b0100;
    parameter [3:0] XOR  = 4'b0101;
    parameter [3:0] SRL  = 4'b0110;
    parameter [3:0] SRA  = 4'b0111;
    parameter [3:0] OR   = 4'b1000;
    parameter [3:0] AND  = 4'b1001;
    parameter [3:0] LUI  = 4'b1010;
    parameter [3:0] JAL  = 4'b1011;

    always_comb begin
        case (ALUControl)
            ADD:  ALUResult = srcA + srcB;                                   // Addition
            SUB:  ALUResult = srcA - srcB;                                   // Subtraction
            SLL:  ALUResult = srcA << srcB[4:0];                              // Logical shift left (use lower 5 bits for shift amount)
            SLT:  ALUResult = ($signed(srcA) < $signed(srcB)) ? 32'd1 : 32'd0;  // Set less than (signed)
            SLTU: ALUResult = (srcA < srcB) ? 32'd1 : 32'd0;                   // Set less than (unsigned)
            XOR:  ALUResult = srcA ^ srcB;                                    // Bitwise XOR
            SRL:  ALUResult = srcA >> srcB[4:0];                              // Logical shift right
            SRA:  ALUResult = $signed(srcA) >>> srcB[4:0];                      // Arithmetic shift right
            OR:   ALUResult = srcA | srcB;                                    // Bitwise OR
            AND:  ALUResult = srcA & srcB;                                    // Bitwise AND
            LUI:  ALUResult = {srcB[31:12], 12'b0};                           // Load Upper Immediate: shift immediate left 12 bits
            JAL:  ALUResult = srcA + 32'd4;                                    // Jal (Jump and Link instruction) (PC + 4)
            default: ALUResult = 32'd0;                                        // Default case
        endcase
    end

    // The zero flag is set when the result is zero.
    assign ZeroE = (ALUResult == 32'd0);

endmodule
