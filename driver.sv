class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual fifo_intf fifo_vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual fifo_intf fifo_vif,mailbox gen2driv);
    //getting the interface
    this.fifo_vif = fifo_vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(!fifo_vif.wrst_n);
    fifo_vif.winc <= 0;
    fifo_vif.rinc <= 0;
    fifo_vif.wdata <= 0; 
    wait(fifo_vif.wrst_n);
  endtask
  
  //drivers the transaction items to interface signals
  task main;
    
    forever begin   
      transaction tr;
      gen2driv.get(tr);
      @(posedge fifo_vif.wclk);
       fifo_vif.winc <= tr.winc;
       fifo_vif.rinc <= tr.rinc;
       fifo_vif.wdata <= tr.wdata;
       @(posedge fifo_vif.wclk);
      no_transactions++;
      $info($time,"[DRIVER]  no_transactions:%d winc:%h rinc:%h wdata:%h",no_transactions, fifo_vif.winc,fifo_vif.rinc,fifo_vif.wdata);
    end
    
   
  endtask
endclass
