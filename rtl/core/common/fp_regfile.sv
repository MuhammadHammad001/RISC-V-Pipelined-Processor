module regfile_fp (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         fp_we,
    input  logic [4 : 0] rs1_reg,  // Read address 1
    input  logic [4 : 0] rs2_reg,  // Read address 2
    input  logic [4 : 0] rs3_reg,  // Read address 3
    input  logic [4 : 0] rd_reg,   // Write address
    input  logic [31: 0] fp_wdata,     // Data to be written
    output logic [31: 0] rs1_data,  // Data from read port 1
    output logic [31: 0] rs2_data,  // Data from read port 2
    output logic [31: 0] rs3_data   // Data from read port 3
);

    // Declare a 32-word register file (each 32-bit wide)
    logic [31: 0] regfile [0: 31];

    // Combinational read ports.
    // These read operations are asynchronous and return the current value.
    assign rs1_data = regfile[rs1_reg];
    assign rs2_data = regfile[rs2_reg];
    assign rs3_data = regfile[rs3_reg];

    // Writes are sequential.
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < 32; i++) begin
                regfile[i] <= 32'b0;
            end
        end
        else if (fp_we && (rd_reg != 5'd0)) begin
            regfile[rd_reg] <= fp_wdata;
        end
    end

endmodule
