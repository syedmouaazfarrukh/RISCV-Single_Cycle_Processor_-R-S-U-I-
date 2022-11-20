module tb_riscv();

    logic clk, reset;

    risc_v dut(.clk(clk), .reset(reset));

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        reset = 1;
        #10 reset = 0;
        #500; $stop;
    end

endmodule