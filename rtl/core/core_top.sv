module PipelinedProcessor(clk, rst_n);
    input logic clk;
    input logic rst_n;

    logic         PCSrcE;                                                       //Fetch Stage Signals.
    logic [31: 0] PCTargetE, PCF_curr, PCPlus4FD, InstrFD;                      //Fetch Stage Signals.
    logic [31: 0] InstrD, PCD, PCPlus4D;                                        //Fetch-decode stage Signals.
    logic [31: 0] rs1_dataD, rs2_dataD, PCD_out, immExtD, PCPlus4D_out;         //Decode stage Signals.
    logic         RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcAD, ALUSrcBD;     //Decode Stage Signals.
    logic [ 1: 0] ResultSrcD;                                                   //Decode Stage Signals.
    logic [ 3: 0] ALUControlD;                                                  //Decode Stage Signals.
    logic [ 4: 0] RdD;                                                          //Decode Stage Signals.
    logic         RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcAE, ALUSrcBE;     //Decode-Execute Stage Signals.
    logic [31: 0] rs1_dataE, rs2_dataE, PCE, immExtE, PCPlus4E;                 //Decode-Execute Stage Signals.
    logic [ 1: 0] ResultSrcE;                                                   //Decode-Execute Stage Signals.
    logic [ 3: 0] ALUControlE;                                                  //Decode-Execute Stage Signals.
    logic [ 4: 0] RdE;                                                          //Decode-Execute Stage Signals.
    logic         RegWriteE_out, MemWriteEout;                                  //Execute Stage Signals.
    logic [ 1: 0] ResultSrcE_out;                                               //Execute Stage Signals.
    logic [31: 0] ALUResultE, WriteDataE, PCPlus4E_out;                         //Execute Stage Signals.
    logic [ 4: 0] RdE_out;                                                      //Execute Stage Signals.
    logic         RegWriteM, MemWriteM;                                         //Execute-Memory Stage Signals.
    logic [ 1: 0] ResultSrcM;                                                   //Execute-Memory Stage Signals.
    logic [31: 0] ALUResultM, WriteDataM, PCPlus4M;                             //Execute-Memory Stage Signals.
    logic [ 4: 0] RdM;                                                          //Execute-Memory Stage Signals.
    logic         RegWriteM_out;                                                //Memory Stage Signals.
    logic [ 1: 0] ResultSrcM_out;                                               //Memory Stage Signals.
    logic [31: 0] RdataM, PCPlus4M_out, ALUResultM_out;                         //Memory Stage Signals.
    logic [ 4: 0] RdM_out;                                                      //Memory Stage Signals.
    logic         RegWriteW;                                                    //Memory-WriteBack Stage Signals.
    logic [ 1: 0] ResultSrcW;                                                   //Memory-WriteBack Stage Signals.
    logic [31: 0] RdataW, PCPlus4W, ALUResultW;                                 //Memory-WriteBack Stage Signals.
    logic [ 4: 0] RdW;                                                          //Memory-WriteBack Stage Signals.
    logic [31: 0] ResultW;                                                      //WriteBack Stage Signals.
    logic [ 4: 0] RdW_out;                                                      //WriteBack Stage Signals.
    logic         RegWriteW_out;                                                //WriteBack Stage Signals.


    fetch FetchStage(
        .clk(clk),
        .rst_n(rst_n),
        .PCSrcE(PCSrcE),                //output of Execute Stage
        .PCTargetE(PCTargetE),
        .PCF_curr(PCF_curr),
        .PCPlus4FD(PCPlus4FD),
        .InstrFD(InstrFD)
    );

    RegisterFD FetchDecodeStage(
        .clk(clk),
        .rst_n(rst_n),
        .InstrFD(InstrFD),
        .PCF_curr(PCF_curr),
        .PCPlus4FD(PCPlus4FD),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    decode DecodeStage(
        .clk(clk),
        .rst_n(rst_n),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .rd_wdata(ResultW),
        .reg_we(RegWriteW_out),
        .RdW(RdW_out),
        .RegWriteD(RegWriteD),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD),
        .ALUControlD(ALUControlD),
        .ALUSrcAD(ALUSrcAD),
        .ALUSrcBD(ALUSrcBD),
        .rs1_data(rs1_dataD),
        .rs2_data(rs2_dataD),
        .PCD_out(PCD_out),
        .immExtD(immExtD),
        .PCPlus4D_out(PCPlus4D_out),
        .RdD(RdD)
    );

    RegisterDE  DecodeExecuteStage(
        .clk(clk),
        .rst_n(rst_n),
        .RegWriteD(RegWriteD),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD),
        .ALUControlD(ALUControlD),
        .ALUSrcAD(ALUSrcAD),
        .ALUSrcBD(ALUSrcBD),
        .rs1_data(rs1_dataD),
        .rs2_data(rs2_dataD),
        .PCD_out(PCD_out),
        .immExtD(immExtD),
        .PCPlus4D_out(PCPlus4D_out),
        .RdD(RdD),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .ALUSrcAE(ALUSrcAE),
        .ALUSrcBE(ALUSrcBE),
        .rs1_data_E(rs1_dataE),
        .rs2_data_E(rs2_dataE),
        .PCE(PCE),
        .immExtE(immExtE),
        .PCPlus4E(PCPlus4E),
        .RdE(RdE)
    );

    execute ExecuteStage(
        .clk(clk),
        .rst_n(rst_n),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .ALUSrcAE(ALUSrcAE),
        .ALUSrcBE(ALUSrcBE),
        .rs1_data_E(rs1_dataE),
        .rs2_data_E(rs2_dataE),
        .PCE(PCE),
        .immExtE(immExtE),
        .PCPlus4E(PCPlus4E),
        .RdE(RdE),
        .RegWriteE_out(RegWriteE_out),
        .ResultSrcE_out(ResultSrcE_out),
        .MemWriteE_out(MemWriteEout),
        .PCTargetE(PCTargetE),
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .RdE_out(RdE_out),
        .PCPlus4E_out(PCPlus4E_out)
    );

    RegisterEM ExecuteMemoryStage(
        .clk(clk),
        .rst_n(rst_n),
        .RegWriteE_out(RegWriteE_out),
        .ResultSrcE_out(ResultSrcE_out),
        .MemWriteE_out(MemWriteEout),
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .RdE_out(RdE_out),
        .PCPlus4E_out(PCPlus4E_out),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M)
    );

    Memory MemoryStage(
        .clk(clk),
        .rst_n(rst_n),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M),
        .RegWriteM_out(RegWriteM_out),
        .ResultSrcM_out(ResultSrcM_out),
        .ALUResultM_out(ALUResultM_out),
        .RdataM(RdataM),
        .RdM_out(RdM_out),
        .PCPlus4M_out(PCPlus4M_out)
    );

    RegisterMW MemoryWriteBackStage(
        .clk(clk),
        .rst_n(rst_n),
        .RegWriteM(RegWriteM_out),
        .ResultSrcM(ResultSrcM_out),
        .ALUResultM(ALUResultM_out),
        .RdataM(RdataM),
        .RdM(RdM_out),
        .PCPlus4M(PCPlus4M),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .RdataW(RdataW),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W)
    );

    Writeback WriteBackStage(
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .RdataW(RdataW),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W),
        .RdW_out(RdW_out),
        .RegWriteW_out(RegWriteW_out),
        .ResultW(ResultW)
    );

endmodule
