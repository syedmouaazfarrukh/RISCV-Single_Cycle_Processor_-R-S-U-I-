module pc_increment(

    input logic [31:0] pc_inc_input,
    output logic [31:0] pc_inc_output

);

    assign pc_inc_output = pc_inc_input + 4;

endmodule