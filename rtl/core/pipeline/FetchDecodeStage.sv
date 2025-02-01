module RegisterFD(clk, rst, InstrFD, PCF_curr, PCPlus4FD, InstrD, PCD, PCPlus4D);
    input   logic         clk;
    input   logic         rst;
    input   logic [31: 0] InstrFD;
    input   logic [31: 0] PCF_curr;
    input   logic [31: 0] PCPlus4FD;
    output  logic [31: 0] InstrD;
    output  logic [31: 0] PCD;
    output  logic [31: 0] PCPlus4D;

    //asynch. reset (active low)
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            InstrD   <= 32'h0;
            PCD      <= 32'h0;
            PCPlus4D <= 32'h0;
        end
        else begin
            InstrD   <= InstrFD;
            PCD      <= PCF_curr;
            PCPlus4D <= PCPlus4FD;
        end
    end

endmodule