module HazardUnit( rs1E, rs2E, rdM, rdW, RegWriteM, RegWriteW,
                    ForwardAE, ForwardBE);
    //Stall logic signals.
    input  logic [ 4: 0] rs1E, rs2E;
    input  logic [ 4: 0] rdM, rdW;
    input  logic         RegWriteM, RegWriteW;
    output logic [ 1: 0] ForwardAE, ForwardBE;

    //Flush logic signals.



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


endmodule