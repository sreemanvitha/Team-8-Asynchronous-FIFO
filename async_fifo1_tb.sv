// Code your testbench here
// or browse Examples
module top;

  parameter DSIZE = 8;
  parameter ASIZE = 8;
  
  parameter Burst_len = 512;
  parameter WRITE_FREQ = 240000;
  parameter READ_FREQ = 400000;

  real write_clk_pd = ((1.0/(WRITE_FREQ * 1e3)) * 1e9);
  real read_clk_pd = ((1.0/(READ_FREQ * 1e3)) * 1e9);
  
  wire [DSIZE-1:0] rdata;
  wire wfull;
  wire rempty;
  reg [DSIZE-1:0] wdata;
  reg winc, wclk, wrst_n;
  reg rinc, rclk, rrst_n;

  // Model a queue for checking data
  reg [DSIZE-1:0] verif_data_q[$];
  reg [DSIZE-1:0] verif_wdata;


  // Instantiate the FIFO
  async_fifo1 #(DSIZE, ASIZE) dut (.*);

  initial begin
    wclk = 1'b0;
    rclk = 1'b0;

   fork
      forever #(write_clk_pd/2) wclk = ~wclk;
      forever #(read_clk_pd/2) rclk = ~rclk;
   join
  end

  initial begin
    winc = 1'b0;
    wdata = '0;
    wrst_n = 1'b0;
    repeat(5) @(posedge wclk);
    wrst_n = 1'b1;

    for (int i=0; i<200; i++) begin
      for(int j=0; j< Burst_len; j++) begin
        @(posedge wclk iff !wfull);
        winc = 1;
        if (winc) begin
          wdata = $urandom;
          verif_data_q.push_front(wdata);
        end
      end
    end
    #5;
  end

  initial begin
    rinc = 1'b0;
    rrst_n = 1'b0;
    repeat(40) @(posedge rclk);
    rrst_n = 1'b1;

    for (int i=0; i<200; i++) begin 
      for(int j=0; j< Burst_len; j++) begin
        rinc = 1;
        @(posedge rclk iff !rempty)        
          if(rinc) begin
          verif_wdata = verif_data_q.pop_back();      
          assert(rdata === verif_wdata) else $error($time,"Checking failed: expected wdata = %h, rdata = %h",verif_wdata, rdata);
          end
        rinc = 0;
        repeat(2) @(posedge rclk);
      end
    end
    #50;
    $finish;
  end

  
  
endmodule
