module register_file( 

   input   logic  clk,   rg_wr_en, reset,
   input   logic [4:0]   raddr1, raddr2, waddr,
   input   logic [31:0]  wdata,
   output  logic [31:0]  rdata1,
   output  logic [31:0]  rdata2

);

   reg [31:0] register_array [31:0];


   initial begin
      $readmemh("regfile.mem", register_array); end


   assign rdata1 = register_array[raddr1];
   assign rdata2 = register_array[raddr2];


   always_ff @(posedge clk) begin

      if (rg_wr_en) begin
         
         register_array[waddr] = wdata;
         $writememh("regfile.mem", register_array);end
         
   end
   
endmodule

