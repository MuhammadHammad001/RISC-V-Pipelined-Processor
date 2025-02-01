module mux2x1(inp1, inp2, sel, out);
    input   logic [31:0]    inp1;
    input   logic [31:0]    inp2;
    input   logic           sel ;
    output  logic [31:0]    out ;

    assign out = (sel) ? inp2 : inp1;
    // always_comb begin
    //     if (sel == 1)
    //         out = inp1;
    //     else
    //         out = inp2;
    // end
endmodule