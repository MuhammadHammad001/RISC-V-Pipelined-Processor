module controlunit(InstrD, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, ImmSrcD);
    input  logic [31:0] InstrD;
    output logic        RegWriteD;
    output logic [1:0]  ResultSrcD;
    output logic        MemWriteD;
    output logic        JumpD;
    output logic        BranchD;
    output logic [3:0]  ALUControlD;
    output logic        ALUSrcD;
    output logic [2:0]  ImmSrcD;

    //Opcodes for Integer-type instructions
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

    //TODO: Add the opcodes for floating point here.

    //decode logic
    logic [6:0] func7;
    logic [6:0] opcode;
    logic [2:0] func3;

    assign opcode = InstrD [6:0];
    assign func3  = InstrD [14:12];
    assign func7  = InstrD [31:25];

    always_comb begin
        // Default assignments to prevent x (unknown values)
        RegWriteD   = 1'b0;
        ResultSrcD  = 2'b00;
        MemWriteD   = 1'b0;
        JumpD       = 1'b0;
        BranchD     = 1'b0;
        ALUControlD = 3'b000;
        ALUSrcD     = 1'b0;
        ImmSrcD     = 3'b000;
        case (opcode)
            7'b0110011 : begin            //R-type instruction.
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b00 ;               //result source = ALU result
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b0  ;               //ALU src is not immediate.
                ImmSrcD     = 3'bxxx;               //ImmSrc is don't care.
                case (func7)
                    7'b0000000 : begin
                        case (func3)
                            3'b000 : ALUControlD = ADD ;
                            3'b001 : ALUControlD = SLL ;
                            3'b010 : ALUControlD = SLT ;
                            3'b011 : ALUControlD = SLTU;
                            3'b100 : ALUControlD = XOR ;
                            3'b101 : ALUControlD = SRL ;
                            3'b110 : ALUControlD = OR  ;
                            3'b111 : ALUControlD = AND ;
                        endcase
                    end
                    7'b0100000 : begin
                        case (func3)
                            3'b000 : ALUControlD = SUB ;
                            3'b101 : ALUControlD = SRA ;
                        endcase
                    end
                    //TODO: Add the support for FPU here.
                endcase
            end
            7'b0010011 : begin              //I-type instruction --- Without loads.
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b00 ;               //result source = ALU result
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b1  ;               //ALU src is immediate.
                ImmSrcD     = 3'b000;               //ImmSrc is I type.
                case (func3)
                    3'b000 : ALUControlD = ADD ;
                    3'b001 : ALUControlD = SLL ;
                    3'b010 : ALUControlD = SLT ;
                    3'b011 : ALUControlD = SLTU;
                    3'b100 : ALUControlD = XOR ;
                    3'b101 : begin
                        case (func7)
                            (7'b0000000) : ALUControlD = SRL ;
                            (7'b0100000) : ALUControlD = SRA ;
                        endcase
                    end
                    3'b110 : ALUControlD = OR  ;
                    3'b111 : ALUControlD = AND ;
                endcase
            end

            7'b0000011 : begin              //I-type instruction --- loads.
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b01 ;               //result source = Data Memory
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b1  ;               //ALU src is immediate.
                ImmSrcD     = 3'b000;               //ImmSrc is I type.
                ALUControlD = ADD   ;
            end

            7'b0100011 : begin              //S-type instruction.
                RegWriteD   = 1'b0  ;               //No write to the register file
                ResultSrcD  = 2'bxx ;               //result source = Don't Care.
                MemWriteD   = 1'b1  ;               //write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b1  ;               //ALU src is immediate.
                ImmSrcD     = 3'b001;               //ImmSrc is S type.
                ALUControlD = ADD   ;
            end

            7'b0010111 : begin              //U-type instruction --- AUIPC.
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b00 ;               //result source = ALU Result.
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'bx  ;               //ALU src is immediate.
                ImmSrcD     = 3'b100;               //ImmSrc is U type.
                ALUControlD = ADD ;
            end

            7'b0110111 : begin              //U-type instruction --- LUI.
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b00 ;               //result source = ALU Result.
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b1  ;               //ALU src is immediate.
                ImmSrcD     = 3'b100;               //ImmSrc is U type.
                ALUControlD = LUI ;
            end

            7'b1100011 : begin              //B-type instruction
                RegWriteD   = 1'b0  ;               //No write to the register file
                ResultSrcD  = 2'bxx ;               //result source = Don't care.
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b0  ;               //No jump
                BranchD     = 1'b1  ;               //Branch
                ALUSrcD     = 1'b0  ;               //ALU src is not immediate.
                ImmSrcD     = 3'b010;               //ImmSrc is B type.
                ALUControlD = SUB ;
            end

            7'b1101111 : begin              //J-type instruction -- JAL
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b10 ;               //result source = PC + 4.
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b1  ;               //Jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b1  ;               //ALU src is immediate.
                ImmSrcD     = 3'b011;               //ImmSrc is J type.
                ALUControlD = ADD ;
            end

            7'b1100111 : begin              //I-type instruction -- JALR
                RegWriteD   = 1'b1  ;               //write to the register file
                ResultSrcD  = 2'b10 ;               //result source = PC + 4.
                MemWriteD   = 1'b0  ;               //No write to Data Mem.
                JumpD       = 1'b1  ;               //Jump
                BranchD     = 1'b0  ;               //No Branch
                ALUSrcD     = 1'b1  ;               //ALU src is immediate.
                ImmSrcD     = 3'b000;               //ImmSrc is I type.
                ALUControlD = ADD ;
            end

    endcase
    end
endmodule