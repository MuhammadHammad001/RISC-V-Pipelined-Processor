module imem_tb();

    logic rst;
    logic [31:0]  req_addr;
    logic [31:0]  out;

    imem imem_tb(
        .rst(rst),
        .req_addr(req_addr),
        .out(out)
    );

    initial begin
        //first -> verify that on reset, we get a zero at output.
        rst = 0;
        #10
        rst = 0;
        req_addr = 32'd4;

        #1
        $display("Output out = %d", out);

        //once, the reset is off, then get expected requested address value.
        #10
        rst = 1;
        req_addr = 32'd4;

        #1
        $display("Output out = %d", out);

        #10
        rst = 1;
        req_addr = 32'd20;

        #1
        $display("Output out = %d", out);
        #100

        $finish;
    end

    initial begin
        $dumpvars();
        $dumpfile("result.vcd");
    end
endmodule