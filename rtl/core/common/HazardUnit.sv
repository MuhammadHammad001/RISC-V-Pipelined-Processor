module HazardUnit( rs1E, rs2E, rdM, rdW, RegWriteM, RegWriteW, ResultSrcE, Rs1D, Rs2D, RdE, PCSrcE, JumpD, BusyF, DoneF,
                    ForwardAE, ForwardBE, StallF, StallD, FlushD, FlushE);

    //Forwarding logic signals.
    input  logic [ 4: 0] rs1E, rs2E;
    input  logic [ 4: 0] rdM, rdW;
    input  logic         RegWriteM, RegWriteW;
    output logic [ 1: 0] ForwardAE, ForwardBE;

    //Stall and Flush logic signals for loads.
    input  logic [ 1: 0] ResultSrcE;
    input  logic [ 4: 0] Rs1D, Rs2D, RdE;
    output logic StallF, StallD, FlushE;

    //Flush logic signals for Control Instructions.
    input  logic PCSrcE;
    output logic FlushD;
    input  logic JumpD;

    //Floating point instruction logic signals.
    input  logic BusyF, DoneF;

    //Forwarding Logic.
    always_comb begin
        if (((rs1E == rdM) && RegWriteM) && (rs1E != 0)) begin
            ForwardAE = 2'b01;
        end
        else if (((rs1E == rdW) && RegWriteW) && (rs1E != 0)) begin
            ForwardAE = 2'b10;
        end
        else begin
            ForwardAE = 2'b00;
        end
    end

    always_comb begin
        if (((rs2E == rdM) && RegWriteM) && (rs2E != 0)) begin
            ForwardBE = 2'b01; // Forward from MEM stage
        end
        else if (((rs2E == rdW) && RegWriteW) && (rs2E != 0)) begin
            ForwardBE = 2'b10; // Forward from WB stage
        end
        else begin
            ForwardBE = 2'b00; // No forwarding
        end
    end

    assign StallF = ((ResultSrcE && ((Rs1D == RdE) || (Rs2D == RdE))) || BusyF);
    assign StallD = ((ResultSrcE && ((Rs1D == RdE) || (Rs2D == RdE))) || BusyF);
    assign FlushE = PCSrcE || (ResultSrcE && ((Rs1D == RdE) || (Rs2D == RdE)));
    assign FlushD = PCSrcE || JumpD;

endmodule