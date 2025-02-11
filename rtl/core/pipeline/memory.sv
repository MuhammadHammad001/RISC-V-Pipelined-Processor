module Memory(clk, rst_n, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M,
                RegWriteM_out, ResultSrcM_out, ALUResultM_out, RdataM, RdM_out, PCPlus4M_out
);
    input  logic         clk;
    input  logic         rst_n;
    input  logic [31: 0] RegWriteM;
    input  logic [1:  0] ResultSrcM;
    input  logic [31: 0] MemWriteM;
    input  logic [31: 0] ALUResultM;
    input  logic [31: 0] WriteDataM;
    input  logic [4:  0] RdM;
    input  logic [31: 0] PCPlus4M;

    output logic [31: 0] RegWriteM_out;
    output logic [1:  0] ResultSrcM_out;
    output logic [31: 0] ALUResultM_out;
    output logic [31: 0] RdataM;
    output logic [4:  0] RdM_out;
    output logic [31: 0] PCPlus4M_out;

    //direct connections
    assign RegWriteM_out  = RegWriteM;
    assign ResultSrcM_out = ResultSrcM;
    assign ALUResultM_out = ALUResultM;
    assign RdM_out        = RdM;
    assign PCPlus4M_out   = PCPlus4M;

    dmem data_memory(
        .clk(clk),
        .rst_n(clk),
        .we(MemWriteM),
        .req_addr(ALUResultM),
        .wdata(WriteDataM),
        .rdata(RdataM)
    );


endmodule