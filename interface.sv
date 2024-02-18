interface fifo_intf #(parameter DSIZE = 8,
                      parameter ASIZE = 8
                     ) 
                     (input logic wclk, rclk, wrst_n, rrst_n);
  
  
  
  //declaring the signals
  logic  winc;  
  logic  rinc; 
  logic  [DSIZE-1:0] wdata;
  logic  [DSIZE-1:0] rdata;
  logic  wfull;
  logic  rempty;
  int ID;
  
endinterface
