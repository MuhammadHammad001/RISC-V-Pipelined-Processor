module imem(rst, req_addr, out);
    input logic rst;
    input logic [31:0]  req_addr;
    output logic [31:0]  out;

    //instruction memory (cache) to store the instructions.
    logic [31:0] mem [1023:0];

    assign out = (rst) ? mem[req_addr[31:2]] : 32'd0;

    //read the instructions from the hex file at the start of the execution.imem
    initial begin
        $readmemh("/home/hammad/Tools/VCS/workspace/workspace/RISC-V-Pipelined-Processor/verif/tb/riscv_asm/imem_file.hex", mem);
    end

endmodule