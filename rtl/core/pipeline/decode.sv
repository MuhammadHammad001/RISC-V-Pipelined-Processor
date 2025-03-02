module decode(clk, rst_n, InstrD, PCD, PCPlus4D, rd_wdata, reg_we, RdW, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcAD, ALUSrcBD, rs1_regD, rs2_regD, rs1_data, rs2_data, PCD_out, immExtD, PCPlus4D_out, RdD, FPU_fp_we, decoder_fp_we, fp_wdata, fp_rs1_data, fp_rs2_data, fp_rs3_data, StartF, fp_operation);
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
    output logic [ 4: 0] rs1_regD;
    output logic [ 4: 0] rs2_regD;
    output logic [31: 0] rs1_data;
    output logic [31: 0] rs2_data;
    output logic [31: 0] PCD_out;
    output logic [31: 0] immExtD;
    output logic [31: 0] PCPlus4D_out;
    output logic [4:0]   RdD;

    //Floating Point Signals.
    input  logic         FPU_fp_we;                             //FPU returns the signal to decoder's FP regfile to write.
    output logic         decoder_fp_we;                         //Decoder's Controller sends a signal to FPU.
    input  logic [31: 0] fp_wdata;                              //FPU sends the data to be written on FP regfile.
    output logic [31: 0] fp_rs1_data, fp_rs2_data, fp_rs3_data; //Decoder sends the registers data to FPU to process.
    output logic         StartF;                                //Decoder sends a signal to FPU to tell that start process.
    output logic [ 3: 0] fp_operation;                          //Decoder's controller to FPU to decide the operation.
    //interim signals.
    logic [4:0]  rs1_reg;
    logic [4:0]  rs2_reg;
    logic [4:0]  rs3_reg;
    logic [2:0]  ImmSrcD;

    assign rs1_reg  = InstrD [19: 15];
    assign rs2_reg  = InstrD [24: 20];
    assign rs3_reg  = InstrD [31: 27];
    assign rs1_regD = InstrD [19: 15];
    assign rs2_regD = InstrD [24: 20];

    //FPU interim signal.
    logic [ 4: 0] fp_rd_reg;
    assign fp_rd_reg = InstrD[11:7];

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
        .ImmSrcD(ImmSrcD),
        .fp_we(decoder_fp_we),
        .StartF(StartF),
        .fp_operation(fp_operation)
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

    regfile_fp FP_RegisterFile(
        .clk(clk),
        .rst_n(rst_n),
        .fp_we(FPU_fp_we),
        .rs1_reg(rs1_reg),
        .rs2_reg(rs2_reg),
        .rs3_reg(rs3_reg),
        .rd_reg(fp_rd_reg),
        .fp_wdata(fp_wdata),
        .rs1_data(fp_rs1_data),
        .rs2_data(fp_rs2_data),
        .rs3_data(fp_rs3_data)
    );

    imm_gen sign_extender (
        .instr(InstrD),
        .ext_sel(ImmSrcD),
        .out(immExtD)
    );
endmodule