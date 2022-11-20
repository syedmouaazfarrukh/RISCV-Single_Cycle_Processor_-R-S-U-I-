module data_memory(

    input logic clk, wr_en, rd_en, 
    input logic [2:0] rd_mask,
    input logic [31:0] addr_datamem, wdata,
    output logic [31:0] rdata
);

    logic [7:0] datamem [4096];
    logic [15:0] hw_data;
    logic [7:0] b_data;

    initial begin
        $readmemh("data.mem", datamem);
    end


// In case of reading from data memory, rd_en is set to be 1 by the controller 
//and we get into the following combinational block.
  
    always_comb begin

        if (rd_en) begin
            
            case (rd_mask)
                
                //In case of Full Word
                3'b000: rdata = {datamem[addr_datamem+3], datamem[addr_datamem+2], datamem[addr_datamem+1], datamem[addr_datamem]};
                
                //In case of Half Word - sign-ext
                3'b001: begin
                    hw_data = {datamem[addr_datamem+1], datamem[addr_datamem]};
                    rdata = {{16{hw_data[15]}}, hw_data};end
                
                //In case of Half Word - zero-ext
                3'b010: begin
                    hw_data = {datamem[addr_datamem+1], datamem[addr_datamem]};
                    rdata = {16'b0, hw_data};end
                
                //In case of Byte - sign ext
                3'b011: begin
                    b_data = datamem[addr_datamem];
                    rdata = {{24{b_data[7]}}, b_data}; end
                
                //In case of Byte - zero-ext
                3'b100: begin
                    b_data = datamem[addr_datamem];
                    rdata = {24'b0, b_data};end
                
                default: rdata = 0;

            endcase
        
        end
    
    end




// In case of wrtiting to data memory, wr_en is set to be 1 by the controller 
//and we get into the following combinational block.
  
    always_ff @(posedge clk) begin
  
        if (wr_en) begin
  
            case (rd_mask)
  
                //In case of Full Word
                3'b000: begin
                    datamem[addr_datamem] = wdata[7:0];
                    datamem[addr_datamem+1] = wdata[15:8];
                    datamem[addr_datamem+2] = wdata[23:16];
                    datamem[addr_datamem+3] = wdata[31:24];end
                
                //In case of Half Word
                3'b001: begin
                    datamem[addr_datamem] = wdata[7:0];
                    datamem[addr_datamem+1] = wdata[15:8];end

                //In case of Byte
                3'b010: datamem[addr_datamem] = wdata[7:0];
  
            endcase
  
            $writememh("datamem.mem", datamem);
  
        end
  
    end

endmodule