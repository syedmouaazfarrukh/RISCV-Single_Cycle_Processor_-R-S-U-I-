module mux2x1(

    input logic sel,
    input logic [31:0] a, b,
    output logic [31:0] out

);

    assign out = (sel == 0)? a : b;


endmodule