class monitor;
  
  //creating virtual interface handle
  virtual fifo_intf fifo_vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  int no_transactions;
  
  function new(virtual fifo_intf fifo_vif,mailbox mon2scb);
    this.fifo_vif = fifo_vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    forever begin
    transaction tr;
    tr = new();


      @(posedge fifo_vif.rclk);
		tr.winc     = fifo_vif.winc;
                tr.wdata    = fifo_vif.wdata;
		tr.wfull    = fifo_vif.wfull; 
                tr.rinc     = fifo_vif.rinc;
		tr.rdata    = fifo_vif.rdata;
                tr.rempty   = fifo_vif.rempty; 
                tr.ID       = fifo_vif.ID;  
    mon2scb.put(tr);
    no_transactions++;
      $display($time,"\t\t\t\t\t\t\t\t\t\t\t\t[MONITOR] ID:%d no_transactions:%d winc:%h rinc:%h wdata:%h rdata:%h",tr.ID, no_transactions, tr.winc,tr.rinc,tr.wdata,tr.rdata);
    end
  endtask
endclass
