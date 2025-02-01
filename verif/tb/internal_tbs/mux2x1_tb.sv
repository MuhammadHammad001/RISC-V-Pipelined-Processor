module mux2x1_tb ();
    //Declare signals
    logic [31:0]    inp1;
    logic [31:0]    inp2;
    logic           sel ;
    logic [31:0]    out ;

    //Instancing mux module here
    mux2x1 mux(
        .inp1(inp1),
        .inp2(inp2),
        .sel(sel),
        .out(out)
    );

    initial begin
        inp1 = '0;
        inp2 = '0;
        sel  = '0;
        #10;

        $display("Output out = %d", out);

        inp1 = 32'd10;
        inp2 = 32'd20;
        sel  = 1'b0;
        #10;

        $display("Output out = %d", out);

        inp1 = 32'd10;
        inp2 = 32'd20;
        sel  = 1'b1;
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