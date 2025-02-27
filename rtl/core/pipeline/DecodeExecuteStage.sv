module RegisterDE(clk, rst_n, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcAD, ALUSrcBD, rs1_regD, rs2_regD, rs1_data, rs2_data, PCD_out, immExtD, PCPlus4D_out, RdD,
                rs1_regE, rs2_regE, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcAE, ALUSrcBE, rs1_data_E, rs2_data_E, PCE, immExtE, PCPlus4E, RdE
);
    input  logic         clk;
    input  logic         rst_n;
    input  logic         RegWriteD;
    input  logic [1:0]   ResultSrcD;
    input  logic         MemWriteD;
    input  logic         JumpD;
    input  logic         BranchD;
    input  logic [3:0]   ALUControlD;
    input  logic         ALUSrcAD;
    input  logic         ALUSrcBD;
    input  logic [ 4: 0] rs1_regD;
    input  logic [ 4: 0] rs2_regD;
    input  logic [31: 0] rs1_data;
    input  logic [31: 0] rs2_data;
    input  logic [31: 0] PCD_out;
    input  logic [31: 0] immExtD;
    input  logic [31: 0] PCPlus4D_out;
    input  logic [ 4:0]  RdD;

    output logic [ 4: 0] rs1_regE;
    output logic [ 4: 0] rs2_regE;
    output logic         RegWriteE;
    output logic [1:0]   ResultSrcE;
    output logic         MemWriteE;
    output logic         JumpE;
    output logic         BranchE;
    output logic [3:0]   ALUControlE;
    output logic         ALUSrcAE;
    output logic         ALUSrcBE;
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
            ALUSrcAE    <= 1'b0;
            ALUSrcBE    <= 1'b0;
            rs1_data_E  <= 32'h0;
            rs2_data_E  <= 32'h0;
            PCE         <= 32'h0;
            immExtE     <= 32'h0;
            PCPlus4E    <= 32'h0;
            rs1_regE    <= 5'h0;
            rs2_regE    <= 5'h0;
            RdE         <= 5'h0;
        end
        else begin
            RegWriteE   <= RegWriteD;
            ResultSrcE  <= ResultSrcD;
            MemWriteE   <= MemWriteD;
            JumpE       <= JumpD;
            BranchE     <= BranchD;
            ALUControlE <= ALUControlD;
            ALUSrcAE    <= ALUSrcAD;
            ALUSrcBE    <= ALUSrcBD;
            rs1_data_E  <= rs1_data;
            rs2_data_E  <= rs2_data;
            PCE         <= PCD_out;
            immExtE     <= immExtD;
            PCPlus4E    <= PCPlus4D_out;
            rs1_regE    <= rs1_regD;
            rs2_regE    <= rs2_regD;
            RdE         <= RdD;
        end
    end

endmodule