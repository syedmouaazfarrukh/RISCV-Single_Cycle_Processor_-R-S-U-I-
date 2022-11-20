module datapath(
	input logic clk, reset, rg_wr_en, sel_b, wb_sel, rd_en, wr_en, sel_a,
	input logic [2:0] rd_mask,
	input logic [3:0] alu_op,
	output logic [31:0] instruction
);
	
	logic [31:0] rdata1, rdata2, extended_imm;
	logic [31:0] pc_out, pc_in, alu_out, alu_b, rdata_dm, wdata_rf, alu_a;
	
	
	register_file 		REG_FILE	(.clk(clk), .reset(reset), .rg_wr_en(rg_wr_en),.wdata(wdata_rf), .raddr1(instruction[19:15]), .raddr2(instruction[24:20]), .waddr(instruction[11:7]),
						   			 .rdata1(rdata1), .rdata2(rdata2));
	alu 				ALU			(.A(alu_a), .B(alu_b), .alu_op(alu_op), .alu_out(alu_out));
	instruction_memory  INS_MEM		(.addr_insmem(pc_out), .instruction(instruction));
	pc_register 		PC_REG		(.clk(clk), .reset(reset), .pc_input(pc_in), .pc_output(pc_out));
	pc_increment 		PC_INCRE	(.pc_inc_input(pc_out), .pc_inc_output(pc_in));
	immediate_gen 		IMME_GEN	(.instruction(instruction), .extended_imm(extended_imm));
	mux2x1 				IMME_MUX	(.sel(sel_b), .a(rdata2), .b(extended_imm), .out(alu_b));
	data_memory 		DATA_MEM	(.clk(clk), .rd_en(rd_en), .rd_mask(rd_mask), .addr_datamem(alu_out), .wdata(rdata2), .rdata(rdata_dm), .wr_en(wr_en));
	mux2x1 				WTBK_MUX	(.sel(wb_sel), .a(alu_out), .b(rdata_dm), .out(wdata_rf));
	mux2x1 				ALU_A_MUX	(.sel(sel_a), .a(rdata1), .b(pc_out), .out(alu_a));


endmodule      

