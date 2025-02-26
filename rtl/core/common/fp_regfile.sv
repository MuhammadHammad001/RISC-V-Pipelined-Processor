module fp_regfile (
    input  logic         clk,        // Clock signal
    input  logic         rst_n,      // Asynchronous reset
    // Read port 1
    input  logic [4:0]   rs1_addr,   // Floating-point source register 1 address
    output logic [31:0]  rs1_data,   // Data from source register 1
    // Read port 2
    input  logic [4:0]   rs2_addr,   // Floating-point source register 2 address
    output logic [31:0]  rs2_data,   // Data from source register 2
    // Write port
    input  logic         write_en,   // Write enable signal
    input  logic [4:0]   rd_addr,    // Destination register address
    input  logic [31:0]  rd_data     // Data to be written to the destination register
);

  // Floating point register file: 32 registers of 32-bit each
  logic [31:0] reg_file [0:31];

  // Asynchronous reset and synchronous write operation.
  // Note: In RISC-V, the integer register x0 is hardwired to 0.
  // For floating point registers (f0-f31), there is no such restriction,
  // so we allow all registers to be written.
  integer i;
  always_ff @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
      // Reset all floating point registers to 0
      for (i = 0; i < 32; i = i + 1) begin
        reg_file[i] <= 32'd0;
      end
    end else if (write_en) begin
      // Write operation: update the register specified by rd_addr
      reg_file[rd_addr] <= rd_data;
    end
  end

  // Combinational read ports.
  // These read operations are asynchronous and return the current value.
  assign rs1_data = reg_file[rs1_addr];
  assign rs2_data = reg_file[rs2_addr];

endmodule
