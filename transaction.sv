class transaction;
  parameter DSIZE = 8;
  parameter ASIZE = 8;
  rand bit   winc; 
  rand bit   rinc; 
  randc bit  [DSIZE-1:0] wdata;
       bit  [DSIZE-1:0] rdata;
       bit  wfull;
       bit  rempty;
  
  constraint c1 { winc == 1;}
  
  function void post_randomize();
    $display($time,"[TRANSACTION] winc:%h rinc:%h wdata:%h",winc,rinc,wdata);
  endfunction
 
endclass
