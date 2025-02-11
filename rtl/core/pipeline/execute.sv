module execute (clk, rst_n, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, rs1_data_E, rs2_data_E, PCE, immExtE, PCPlus4E, RdE, RegWriteE_out, ResultSrcE_out, MemWriteE_out, PCTargetE, ALUResultE, WriteDataE, RdE_out, PCPlus4E_out);

    input  logic         clk;
    input  logic         rst_n;

    input  logic         RegWriteE;
    input  logic [1:0]   ResultSrcE;
    input  logic         MemWriteE;
    input  logic         JumpE;
    input  logic         BranchE;
    input  logic [3:0]   ALUControlE;
    input  logic         ALUSrcE;
    input  logic [31: 0] rs1_data_E;
    input  logic [31: 0] rs2_data_E;
    input  logic [31: 0] PCE;
    input  logic [31: 0] immExtE;
    input  logic [31: 0] PCPlus4E;
    input  logic [4:0]   RdE;

    output logic [31: 0] RegWriteE_out;
    output logic [31: 0] ResultSrcE_out;
    output logic [31: 0] MemWriteE_out;
    output logic [31: 0] PCTargetE;
    output logic [31: 0] ALUResultE;
    output logic [31: 0] WriteDataE;
    output logic [4:0]   RdE_out;
    output logic [31: 0] PCPlus4E_out;

    //interim signals
    logic ZeroE;
    logic [31: 0]ALU_inp2;

    assign PCSrcE = JumpE | (ZeroE & BranchE);

    //direct connections
    assign RegWriteE_out  = RegWriteE;
    assign ResultSrcE_out = ResultSrcE;
    assign MemWriteE_out  = MemWriteE;
    assign RdE_out        = RdE;
    assign PCPlus4E_out   = PCPlus4E;

    mux2x1 ALU_inp2_mux(
        .inp1(rs2_data_E),
        .inp2(immExtE),
        .sel(ALUSrcE),
        .out(ALU_inp2)
    );

    alu ALU(
    .srcA(rs1_data_E),        // First operand
    .srcB(ALU_inp2),          // Second operand or immediate
    .ALUControl(ALUControlE),              // ALU control signal
    .ALUResult(ALUResultE),   // ALU result output
    .ZeroE(ZeroE)             // Zero flag output
    );

    adder PC_Imm_Adder(
        .inp1(PCE),
        .inp2(immExtE),
        .out(PCTargetE)
    );

endmodule