module risc_v(

    input logic clk, reset

);

    logic rg_wr_en, wb_sel, sel_b, rd_en, wr_en, sel_a;
    logic [31:0] instruction;
    logic [2:0] rd_mask;
    logic [3:0] alu_op;


    datapath DATAPATH(

        .clk(clk), .reset(reset), .rg_wr_en(rg_wr_en), .sel_b(sel_b), .alu_op(alu_op), .instruction(instruction), 
        .wb_sel(wb_sel), .rd_en(rd_en), .rd_mask(rd_mask), .wr_en(wr_en), .sel_a(sel_a));

    controller CONTROLLER(

        .instruction(instruction), .rg_wr_en(rg_wr_en), .sel_b(sel_b), .wb_sel(wb_sel), 
        .rd_en(rd_en), .rd_mask(rd_mask), .alu_op(alu_op), .wr_en(wr_en), .sel_a(sel_a));



endmodule