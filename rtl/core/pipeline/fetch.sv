module fetch(clk, rst_n, PCSrcE, PCTargetE, PCF_curr, PCPlus4FD, InstrFD);
    input  logic clk;
    input  logic rst_n;
    input  logic PCSrcE;
    input  logic [31: 0] PCTargetE;
    output logic [31: 0] PCF_curr;
    output logic [31: 0] PCPlus4FD;
    output logic [31: 0] InstrFD;

    //interal signals
    logic [31: 0] PCF_next;

    //mux instance
    mux2x1 pc_selector(
        .inp1(PCPlus4FD),
        .inp2(PCTargetE),
        .sel(PCSrcE),
        .out(PCF_next)
        );

    //PC flop instance
    ff PC_Flop(
        .clk(clk),
        .rst_n(rst_n),
        .inp(PCF_next),
        .out(PCF_curr)
    );

    //instruction memory instance
    imem imem(
        .rst_n(rst_n),
        .req_addr(PCF_curr),
        .out(InstrFD)
    );

    //PC Adder Instance
    adder PCAdder(
        .inp1(PCF_curr),
        .inp2(32'h4),
        .out(PCPlus4FD)
    );

endmodule