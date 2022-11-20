module alu(
   
   input logic [31:0] A, B,  		// ALU 32-bit Inputs                 
   input logic [3:0] alu_op,		// ALU Operation selection bits
   output logic [31:0] alu_out 		// ALU 8-bit Output
);
    
    always_comb begin
        case(alu_op)
		
            4'b0000: alu_out = A + B ; 								//for addition
            4'b0001: alu_out = A - B; 								//for subtraction, we taking 2's complement
            4'b0010: alu_out = A | B;								//Logical OR
            4'b0011: alu_out = A & B;								//Logical AND               
            4'b0100: alu_out = A << B;								//sll
            4'b0101: alu_out = $signed(A) < $signed(B);				//slt               
            4'b0110: alu_out = A < B;								//sltu              
            4'b0111: alu_out = A ^ B; 								//xor               
            4'b1000: alu_out = A >> B;								//srl        
            4'b1001: alu_out = A >>> B;								//sra
            4'b1010: alu_out = B;
               
        endcase
    end

endmodule

