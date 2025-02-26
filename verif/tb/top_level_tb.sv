module top_level_tb ();
logic clk,rst_n;

PipelinedProcessor TOPLevel (.clk(clk),.rst_n(rst_n));

initial begin
    clk<=0;
    forever begin
        #1 clk<=~clk;
    end
end
initial begin
    #1
    rst_n<=0;
    #1
    rst_n<=1;
    #10000
    $finish;
end

initial begin
    $dumpvars();
    $dumpfile("result.vcd");
end

endmodule