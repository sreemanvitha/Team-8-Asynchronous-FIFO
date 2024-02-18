class transaction;
  parameter DSIZE = 8;
  parameter ASIZE = 8;
  rand bit   winc; 
  rand bit   rinc; 
  rand int ID;
  randc bit  [DSIZE-1:0] wdata;
       bit  [DSIZE-1:0] rdata;
       bit  wfull;
       bit  rempty;
  
  //constraint c{ winc == 1 ;}
  
  function void post_randomize();
    $display($time,"[TRANSACTION] ID:%d winc:%h rinc:%h wdata:%h", ID,winc,rinc,wdata);
  endfunction
 
endclass
