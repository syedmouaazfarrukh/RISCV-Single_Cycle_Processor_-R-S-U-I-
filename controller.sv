module controller(

    input logic [31:0] instruction,
    output logic [2:0] rd_mask,
    output logic [3:0] alu_op,
    output logic rg_wr_en, sel_b, wb_sel, rd_en, wr_en, sel_a
);

    logic [6:0] opcode, funct7;
    logic [2:0] funct3;


    always_comb begin
    
        opcode = instruction[6:0];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];


// R - Type instructions - Their opcode is 0110011

        if 
        (opcode == 7'b0110011) begin

            
            wb_sel = 0; rd_en = 0; sel_b = 0; wr_en = 0; 
            rg_wr_en = 1;
            rd_mask = 3'b000;
            
            case (funct3)

                3'b001: alu_op = 4'b0100;
                3'b010: alu_op = 4'b0101;
                3'b011: alu_op = 4'b0110;
                3'b100: alu_op = 4'b0111;
                3'b110: alu_op = 4'b0010;
                3'b111: alu_op = 4'b0011;
                
                3'b101: begin
                    if (funct7 == 7'b0000000) alu_op = 4'b1000;
                    else if (funct7 == 7'b0100000) alu_op = 4'b1001; end
                
                3'b000: begin
                    if (funct7 == 7'b0000000) alu_op = 4'b0000;
                    else if (funct7 == 7'b0100000) alu_op = 4'b0001;end

                default: alu_op = 4'b1111;                
            
            endcase end 




// I - Type instructions - Their opcode is 0010011

        else if 
        (opcode == 7'b0010011) begin

            sel_a = 0; wb_sel = 0; rd_en = 0; wr_en = 0;
            sel_b = 1; rg_wr_en = 1;
            rd_mask = 3'b000;
            
            
            case (funct3)

                3'b000: alu_op = 4'b0000;
                3'b010: alu_op = 4'b0101;
                3'b011: alu_op = 4'b0110;
                3'b100: alu_op = 4'b0111;
                3'b110: alu_op = 4'b0010;
                3'b111: alu_op = 4'b0011;
                3'b001: alu_op = 4'b0100;
                
                3'b101: begin
                    if (funct7 == 7'b0000000) alu_op = 4'b1000;
                    else if (funct7 == 7'b0100000) alu_op = 4'b1001; end

                default: alu_op = 4'b1111;

            endcase end 



// I - Type (load) instructions - Their opcode is 0000011 

        else if 
        (opcode == 7'b0000011) begin

            wb_sel = 1; rd_en = 1; sel_b = 1; rg_wr_en = 1;
            sel_a = 0; wr_en = 0;
            alu_op = 4'b0000;
            

            case (funct3)
                
                3'b000: rd_mask = 3'b011;
                3'b001: rd_mask = 3'b001;
                3'b010: rd_mask = 3'b000;
                3'b100: rd_mask = 3'b100;
                3'b101: rd_mask = 3'b010;
                
                default: rd_mask = 3'b111;
            
            endcase end



// I - Type (store) instructions - Their opcode is 0100011 


        else if 
        (opcode == 7'b0100011) begin
            
            sel_a = 0; wb_sel = 0; rd_en = 0; rg_wr_en = 0;
            sel_b = 1; wr_en = 1;
            alu_op = 4'b0000;
            
            case (funct3)
            
                3'b000: rd_mask = 3'b010;
                3'b001: rd_mask = 3'b001;
                3'b010: rd_mask = 3'b000;
            
            endcase end



// U - Type (Load) instructions - Their opcode is 0110111 


        else if 
        (opcode == 7'b0110111) begin
            
            wr_en = 0; sel_a = 0; wb_sel = 0; rd_en = 0;
            sel_b = 1; rg_wr_en = 1;
            alu_op = 4'b1010;
            rd_mask = 3'b000;end




// U - Type (Arithmetic) instructions - Their opcode is 0010111 

        else if 
        (opcode == 7'b0010111) begin
            
            sel_b = 1; rg_wr_en = 1; sel_a = 1; wb_sel = 0; rd_en = 0;
            wr_en = 0;
            rd_mask = 3'b000;
            alu_op = 4'b0000;end





        else begin
            
            rg_wr_en = 0; sel_b = 0; wr_en = 0; sel_a = 0; wb_sel = 0; rd_en = 0;
            alu_op = 4'b1111;
            rd_mask = 3'b000;end

    
    end

endmodule