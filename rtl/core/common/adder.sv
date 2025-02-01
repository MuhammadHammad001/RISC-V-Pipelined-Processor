module adder(inp1, inp2, out);
    input  logic [31:0]  inp1;
    input  logic [31:0]  inp2;
    output logic [31:0]  out;

    assign out = inp1+inp2;

endmodule