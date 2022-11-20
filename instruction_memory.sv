module instruction_memory(

	input [31:0] addr_insmem, 
	output[31:0] instruction
);

	reg [7:0] insmem_size [1024];

	
    initial begin
		$readmemh("instmem.mem", insmem_size); end

	assign instruction = {
                         insmem_size[addr_insmem], insmem_size[addr_insmem+1], 
                         insmem_size[addr_insmem+2], insmem_size[addr_insmem+3]
                         };

endmodule 

