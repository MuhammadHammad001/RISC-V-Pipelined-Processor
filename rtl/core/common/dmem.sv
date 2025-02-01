module dmem(clk, rst_n, we, req_addr, wdata, rdata);
    input  logic         clk;
    input  logic         rst_n;
    input  logic         we;                //write enable
    input  logic [31: 0] req_addr;          //address at which we want to write/read the data at/from
    input  logic [31: 0] wdata;             //data to be written in the instruction memory
    output logic [31: 0] rdata;             //data read from the memory

    logic [31:0] dmem [1023:0] = '{default: 32'b0};     //assign initially zero.

    // Reads are combinational.
    assign rdata = dmem[req_addr];

    // Writes are sequential.
    always_ff @(posedge clk) begin
        if (we) begin
            dmem[req_addr] <= wdata;
        end
    end
endmodule