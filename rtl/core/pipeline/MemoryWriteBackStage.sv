module RegisterMW(clk, rst_n, RegWriteM, ResultSrcM, ALUResultM, RdataM, RdM, PCPlus4M,
                    RegWriteW, ResultSrcW, ALUResultW, RdataW, RdW, PCPlus4W
);
    input  logic         clk;
    input  logic         rst_n;
    input  logic         RegWriteM;
    input  logic [1:  0] ResultSrcM;
    input  logic [31: 0] ALUResultM;
    input  logic [31: 0] RdataM;
    input  logic [4:  0] RdM;
    input  logic [31: 0] PCPlus4M;

    output logic         RegWriteW;
    output logic [1: 0] ResultSrcW;
    output logic [31: 0] ALUResultW;
    output logic [31: 0] RdataW;
    output logic [4:  0] RdW;
    output logic [31: 0] PCPlus4W;


    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            RegWriteW  <= 1'h0;
            ResultSrcW <= 2'h0;
            ALUResultW <= 32'h0;
            RdataW     <= 32'h0;
            RdW        <= 32'h0;
            PCPlus4W   <= 32'h0;
        end
        else begin
            RegWriteW  <= RegWriteM;
            ResultSrcW <= ResultSrcM;
            ALUResultW <= ALUResultM;
            RdataW     <= RdataM;
            RdW        <= RdataM;
            PCPlus4W   <= PCPlus4M;
        end
    end


endmodule