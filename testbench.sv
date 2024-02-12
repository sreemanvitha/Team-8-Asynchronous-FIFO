`include "interface.sv"
`include "test.sv"

module top;
  parameter DSIZE = 8;
  parameter ASIZE = 8;
  
  parameter Burst_len = 512;
  parameter WRITE_FREQ = 240000;
  parameter READ_FREQ = 400000;

  real write_clk_pd = ((1.0/(WRITE_FREQ * 1e3)) * 1e9);
  real read_clk_pd = ((1.0/(READ_FREQ * 1e3)) * 1e9);
  
  bit wclk,rclk;
  bit wrst_n, rrst_n;

  // Instantiate the FIFO
  async_fifo1 #(DSIZE, ASIZE) dut (.winc(intf.winc),
                                   .wclk(intf.wclk), 
                                   .wrst_n(intf.wrst_n), 
                                   .rinc(intf.rinc), 
                                   .rclk(intf.rclk), 
                                   .rrst_n(intf.rrst_n), 
                                   .wdata(intf.wdata), 
                                   .rdata(intf.rdata), 
                                   .wfull(intf.wfull), 
                                   .rempty(intf.rempty)
                                  );
  
   fifo_intf #(DSIZE, ASIZE) intf(wclk, rclk, wrst_n, rrst_n);
   test t1(intf);

  initial begin
    wclk = 1'b0;
    rclk = 1'b0;  
    wrst_n = 1'b0;
    rrst_n = 1'b0;
    #25 wrst_n = 1'b1; rrst_n = 1'b1;
    
    fork
      forever #(write_clk_pd/2) wclk = ~wclk;
      forever #(read_clk_pd/2) rclk = ~rclk;
    join
    
  end
  
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
end
  
endmodule



