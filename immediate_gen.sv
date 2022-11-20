module immediate_gen(

    input logic [31:0] instruction,
    output logic [31:0] extended_imm
);

    logic [6:0] opcode, funct7;
    logic [2:0] funct3;
    logic [11:0] bit12_imm;
    logic [19:0] bit20_imm;
    logic [4:0] shamt;


    always_comb begin
        
        opcode = instruction[6:0];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];

        

        if (opcode == 7'b0010011) begin
            
            bit12_imm = instruction[31:20];

            if (funct3 == 3'b101 && funct7 == 7'b0100000) begin
                shamt = bit12_imm[4:0];
                //Zero Extension
                extended_imm = {27'b0, shamt};end 
            else begin
                //Extension of 12 bit - sign ext
                extended_imm = {{20{bit12_imm[11]}}, bit12_imm};end end


        else if 
            (opcode == 7'b0000011) begin
            bit12_imm = instruction[31:20];
            extended_imm = {{20{bit12_imm[11]}}, bit12_imm};end


        else if 
            (opcode == 7'b0100011) begin
            bit12_imm = {instruction[31:25], instruction[11:7]};
            extended_imm = {{20{bit12_imm[11]}}, bit12_imm};end


        else if 
            (opcode == 7'b0110111 || opcode == 7'b0010111) begin
            bit20_imm = instruction[31:12];
            extended_imm = {bit20_imm, 12'b0};end

    end

endmodule