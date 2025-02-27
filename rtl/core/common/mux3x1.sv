module mux3x1 (
    input  logic [31:0] inp1,
    input  logic [31:0] inp2,
    input  logic [31:0] inp3,
    input  logic [1:0]  sel,
    output logic [31:0] out
);

    // Combinational logic to select output based on sel.
    always_comb begin
        case (sel)
            2'b00: out = inp1;
            2'b01: out = inp2;
            2'b10: out = inp3;
            default: out = 32'b0;  // For sel == 2'b11, or any unspecified value.
        endcase
    end

endmodule
