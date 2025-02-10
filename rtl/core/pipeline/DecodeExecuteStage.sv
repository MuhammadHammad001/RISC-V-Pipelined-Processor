module RegisterDE(clk, rst_n, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, rs1_data, rs2_data, PCD_out, immExtD, PCPlus4D_out, RdD,
                  RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, rs1_data_E, rs2_data_E, PCE, immExtE, PCPlus4E, RdE
);
    input  logic         clk;
    input  logic         rst_n;
    input  logic         RegWriteD;
    input  logic [1:0]   ResultSrcD;
    input  logic         MemWriteD;
    input  logic         JumpD;
    input  logic         BranchD;
    input  logic [3:0]   ALUControlD;
    input  logic         ALUSrcD;
    input  logic [31: 0] rs1_data;
    input  logic [31: 0] rs2_data;
    input  logic [31: 0] PCD_out;
    input  logic [31: 0] immExtD;
    input  logic [31: 0] PCPlus4D_out;
    input  logic [4:0]   RdD;

    output logic         RegWriteE;
    output logic [1:0]   ResultSrcE;
    output logic         MemWriteE;
    output logic         JumpE;
    output logic         BranchE;
    output logic [3:0]   ALUControlE;
    output logic         ALUSrcE;
    output logic [31: 0] rs1_data_E;
    output logic [31: 0] rs2_data_E;
    output logic [31: 0] PCE;
    output logic [31: 0] immExtE;
    output logic [31: 0] PCPlus4E;
    output logic [4:0]   RdE;

    //asynch. reset (active low)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            RegWriteE   <= 1'b0;
            ResultSrcE  <= 2'b0;
            MemWriteE   <= 1'b0;
            JumpE       <= 1'b0;
            BranchE     <= 1'b0;
            ALUControlE <= 3'b0;
            ALUSrcE     <= 1'b0;
            rs1_data_E  <= 32'h0;
            rs2_data_E  <= 32'h0;
            PCE         <= 32'h0;
            immExtE     <= 32'h0;
            PCPlus4E    <= 32'h0;
            RdE         <= 5'h0;
        end
        else begin
            RegWriteE   <= RegWriteD;
            ResultSrcE  <= ResultSrcD;
            MemWriteE   <= MemWriteD;
            JumpE       <= JumpD;
            BranchE     <= BranchD;
            ALUControlE <= ALUControlD;
            ALUSrcE     <= ALUSrcD;
            rs1_data_E  <= rs1_data;
            rs2_data_E  <= rs2_data;
            PCE         <= PCD_out;
            immExtE     <= immExtD;
            PCPlus4E    <= PCPlus4D_out;
            RdE         <= RdD;
        end
    end

endmodule