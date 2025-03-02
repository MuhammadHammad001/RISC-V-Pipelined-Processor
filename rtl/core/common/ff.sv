module ff(clk, rst_n, Stall, inp, out);
    input  logic clk;
    input  logic rst_n;
    input  logic Stall;
    input  logic [31: 0]inp;
    output logic [31: 0]out;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 32'h0;
        end
        else if (Stall) begin
            out <= out;
        end
        else begin
            out <= inp;
        end
    end

endmodule