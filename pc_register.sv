module pc_register(
    
    input clk, reset, 
    input logic [31:0] pc_input, 
    output logic [31:0] pc_output
);


	always_ff@(posedge clk)
        
        begin

            if (!reset) begin
               pc_output = pc_input;end
            
            else begin
                pc_output = 0;end
        
        end
        

endmodule
