module regfile(
    input  logic         clk,
    input  logic         rst_n,
    input  logic         we,
    input  logic [4 : 0] rs1_reg,
    input  logic [4 : 0] rs2_reg,
    input  logic [4 : 0] rd_reg,
    input  logic [31: 0] wdata,
    output logic [31: 0] rs1_data,
    output logic [31: 0] rs2_data
);

    logic [31: 0] regfile [31: 0];  // Register file

    // Read logic with bypassing
    assign rs1_data = ((we && (rs1_reg == rd_reg) && (rs1_reg != 0)) ? wdata : regfile[rs1_reg]);
    assign rs2_data = ((we && (rs2_reg == rd_reg) && (rs2_reg != 0)) ? wdata : regfile[rs2_reg]);

    // Writes are sequential
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < 32; i++) begin
                regfile[i] <= 32'b0;
            end
        end
        else if (we && (rd_reg != 0)) begin
            regfile[rd_reg] <= wdata;
        end
    end

endmodule
