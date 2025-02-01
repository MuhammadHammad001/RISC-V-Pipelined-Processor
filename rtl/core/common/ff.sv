module ff(clk, rst, inp, out);
    input  logic clk;
    input  logic rst;
    input  logic [31: 0]inp;
    output logic [31: 0]out;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            out <= 32'h0;
        end
        else begin
            out <= inp;
        end
    end

endmodule