module dmem(
    input  logic         clk,
    input  logic         rst_n,
    input  logic         we,                // Write enable.
    input  logic [31:0]  req_addr,          // 32-bit byte address.
    input  logic [31:0]  wdata,             // Data to be written.
    output logic [31:0]  rdata              // Data read.
);

    //Only Load word and Store word are supported.

    // Declare a 1024-word memory (words are 32-bit wide).
    // Note: Since we have 1024 words, the index is 10 bits wide.
    logic [31:0] dmem [0:1023];

    // Sequential write: on a positive clock edge (with asynchronous active-low reset).
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end else if (we) begin
            dmem[req_addr[11:2]] <= wdata;
        end
    end


    // Read logic with bypassing for Read-After-Write (RAW)
    assign rdata = (we && (req_addr[11:2] == req_addr[11:2])) ? wdata : dmem[req_addr[11:2]];

endmodule
