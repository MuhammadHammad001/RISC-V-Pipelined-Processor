module adder_tb();
    logic [31:0] inp1;
    logic [31:0] inp2;
    logic [31:0] out;

    adder add(
        .inp1(inp1),
        .inp2(inp2),
        .out(out)
    );

    initial begin
        inp1 = '0;
        inp2 = '0;
        #10;

        $display("Output out = %d", out);

        inp1 = 32'd10;
        inp2 = 32'd20;
        #10;

        $display("Output out = %d", out);

        $finish;
    end

    //dump all the inputs and outputs to a waveform
    initial begin
        $dumpvars();
        $dumpfile("result.vcd");
    end

endmodule