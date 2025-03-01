module HazardUnit( rs1E, rs2E, rdM, rdW, RegWriteM, RegWriteW, ResultSrcE, Rs1D, Rs2D, RdE,
                    ForwardAE, ForwardBE, StallF, StallD, FlushE);

    //Stall logic signals.
    input  logic [ 4: 0] rs1E, rs2E;
    input  logic [ 4: 0] rdM, rdW;
    input  logic         RegWriteM, RegWriteW;
    output logic [ 1: 0] ForwardAE, ForwardBE;

    //Flush logic signals.
    input  logic [ 1: 0] ResultSrcE;
    input  logic [ 4: 0] Rs1D, Rs2D, RdE;
    output logic StallF, StallD, FlushE;


    //Stall Logic.
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


    always_comb begin
        if ((ResultSrcE) && ((Rs1D == RdE) | (Rs2D == RdE))) begin
            StallD = 1;
            StallF = 1;
            FlushE = 1;
        end
        else begin
            StallD = 0;
            StallF = 0;
            FlushE = 0;
        end
    end

endmodule