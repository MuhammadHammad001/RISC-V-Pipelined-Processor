module controlunit_tb;
    // Testbench signals
    logic [31:0] InstrD;
    logic RegWriteD;
    logic [1:0] ResultSrcD;
    logic MemWriteD;
    logic JumpD;
    logic BranchD;
    logic [3:0] ALUControlD;
    logic ALUSrcD;
    logic [2:0] ImmSrcD;

    // Instantiate the control unit
    controlunit dut (
        .InstrD(InstrD),
        .RegWriteD(RegWriteD),
        .ResultSrcD(ResultSrcD),
        .MemWriteD(MemWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD),
        .ALUControlD(ALUControlD),
        .ALUSrcD(ALUSrcD),
        .ImmSrcD(ImmSrcD)
    );

    initial begin
        InstrD = 32'h003100B3;
        #10;
        $display("Instruction: %h | RegWriteD: %b | ResultSrcD: %b | MemWriteD: %b | JumpD: %b | BranchD: %b | ALUControlD: %b | ALUSrcD: %b | ImmSrcD: %b",
                 InstrD, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, ImmSrcD);
        InstrD = 32'h000023B7;
        #10;
        $display("Instruction: %h | RegWriteD: %b | ResultSrcD: %b | MemWriteD: %b | JumpD: %b | BranchD: %b | ALUControlD: %b | ALUSrcD: %b | ImmSrcD: %b",
                 InstrD, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, ImmSrcD);
        InstrD = 32'h007E2023;
        #10;
        $display("Instruction: %h | RegWriteD: %b | ResultSrcD: %b | MemWriteD: %b | JumpD: %b | BranchD: %b | ALUControlD: %b | ALUSrcD: %b | ImmSrcD: %b",
                 InstrD, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, ImmSrcD);

        $finish;
    end

    //dump all the inputs and outputs to a waveform
    initial begin
        $dumpvars();
        $dumpfile("result.vcd");
    end

endmodule
