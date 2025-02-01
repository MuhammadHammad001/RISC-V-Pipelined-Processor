module regfile(clk, rst_n, rs1_reg, rs2_reg, rd_reg, wdata, we, rs1_data, rs2_data);
    input  logic         clk;
    input  logic         rst_n;
    input  logic         we;
    input  logic [4 : 0] rs1_reg;
    input  logic [4 : 0] rs2_reg;
    input  logic [4 : 0] rd_reg;
    input  logic [31: 0] wdata;
    output logic [31: 0] rs1_data;
    output logic [31: 0] rs2_data;

    logic [31: 0] regfile [31: 0];          //register file.

    // Reads are combinational
    assign rs1_data = regfile[rs1_reg];
    assign rs2_data = regfile[rs2_reg];

    // Writes are sequential.
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin                                   //in case of a reset.
            for (int i = 0; i < 32; i++) begin              //reset the whole register file.
                regfile[i] <= 32'b0;
            end
        end
        else begin
            if (we && rd_reg != 0) begin
                regfile[rd_reg] <= wdata;
            end
        end
    end

endmodule