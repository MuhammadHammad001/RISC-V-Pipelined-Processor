module RegisterEM(clk, rst_n, RegWriteE_out, ResultSrcE_out, MemWriteE_out, ALUResultE, WriteDataE, RdE_out, PCPlus4E_out,
                    RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M
);
    input  logic         clk;
    input  logic         rst_n;
    input  logic [31: 0] RegWriteE_out;
    input  logic [1:  0] ResultSrcE_out;
    input  logic [31: 0] MemWriteE_out;
    input  logic [31: 0] ALUResultE;
    input  logic [31: 0] WriteDataE;
    input  logic [4:0]   RdE_out;
    input  logic [31: 0] PCPlus4E_out;

    output logic [31: 0] RegWriteM;
    output logic [1:  0] ResultSrcM;
    output logic [31: 0] MemWriteM;
    output logic [31: 0] ALUResultM;
    output logic [31: 0] WriteDataM;
    output logic [4:0]   RdM;
    output logic [31: 0] PCPlus4M;

    //asynch. reset (active low)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            RegWriteM  <= 32'h0;
            ResultSrcM <= 32'h0;
            MemWriteM  <= 32'h0;
            ALUResultM <= 32'h0;
            WriteDataM <= 32'h0;
            RdM        <= 5'h0;
            PCPlus4M   <= 32'h0;
        end
        else begin
            RegWriteM  <= RegWriteE_out;
            ResultSrcM <= ResultSrcE_out;
            MemWriteM  <= MemWriteE_out;
            ALUResultM <= ALUResultE;
            WriteDataM <= WriteDataE;
            RdM        <= RdE_out;
            PCPlus4M   <= PCPlus4E_out;
        end
    end

endmodule