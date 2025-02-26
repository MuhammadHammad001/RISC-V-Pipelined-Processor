module decode(clk, rst_n, InstrD, PCD, PCPlus4D, rd_wdata, reg_we, RdW, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcAD, ALUSrcBD, rs1_data, rs2_data, PCD_out, immExtD, PCPlus4D_out, RdD);
    input  logic         clk;
    input  logic         rst_n;
    input  logic [31: 0] InstrD ;
    input  logic [31: 0] PCD;
    input  logic [31: 0] PCPlus4D;
    input  logic [31: 0] rd_wdata;
    input  logic         reg_we;
    input  logic [ 4: 0] RdW;
    output logic         RegWriteD;
    output logic [1:0]   ResultSrcD;
    output logic         MemWriteD;
    output logic         JumpD;
    output logic         BranchD;
    output logic [3:0]   ALUControlD;
    output logic         ALUSrcAD;
    output logic         ALUSrcBD;
    output logic [31: 0] rs1_data;
    output logic [31: 0] rs2_data;
    output logic [31: 0] PCD_out;
    output logic [31: 0] immExtD;
    output logic [31: 0] PCPlus4D_out;
    output logic [4:0]   RdD;

    //interim signals.
    logic [4:0]  rs1_reg;
    logic [4:0]  rs2_reg;
    logic [2:0]  ImmSrcD;

    assign rs1_reg = InstrD [19:15];
    assign rs2_reg = InstrD [24:20];

    //Rd assignment
    assign RdD = InstrD [11:7];

    //Direct assignments
    assign PCPlus4D_out = PCPlus4D;
    assign PCD_out = PCD;

    controlunit controller (
        .InstrD(InstrD),
        .RegWriteD(RegWriteD),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD),
        .ALUControlD(ALUControlD),
        .ALUSrcAD(ALUSrcAD),
        .ALUSrcBD(ALUSrcBD),
        .ImmSrcD(ImmSrcD)
    );

    regfile rf (
        .clk(clk),
        .rst_n(rst_n),
        .rs1_reg(rs1_reg),
        .rs2_reg(rs2_reg),
        .rd_reg(RdW),
        .wdata(rd_wdata),
        .we(reg_we),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // fp_regfile floating_point_rf(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .rs1_addr(rs1_reg),
    //     .rs1_data(rs1_data),
    //     .rs2_addr(),
    //     .rs2_data(),
    //     .write_en(),
    //     .rd_addr(),
    //     .rd_data()
    // );

    imm_gen sign_extender (
        .instr(InstrD),
        .ext_sel(ImmSrcD),
        .out(immExtD)
    );
endmodule