module Writeback(RegWriteW, ResultSrcW, ALUResultW, RdataW, RdW, PCPlus4W,
                    RdW_out, RegWriteW_out, ResultW
);

    input  logic         RegWriteW;
    input  logic [1:  0] ResultSrcW;
    input  logic [31: 0] ALUResultW;
    input  logic [31: 0] RdataW;
    input  logic [4:  0] RdW;
    input  logic [31: 0] PCPlus4W;

    output logic [4:  0] RdW_out;
    output logic         RegWriteW_out;
    output logic [31: 0] ResultW;

    //direct connections
    assign RegWriteW_out = RegWriteW;
    assign RdW_out       = RdW;

    mux3x1 muxWB(
        .inp1(ALUResultW),
        .inp2(RdataW),
        .inp3(PCPlus4W),
        .sel(ResultSrcW),
        .out(ResultW)
    );



endmodule