class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual fifo_intf fifo_vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual fifo_intf fifo_vif,mailbox gen2driv);
    this.fifo_vif = fifo_vif;
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
      @(negedge fifo_vif.wclk);
      //if(1) /*tr.winc | tr.rinc)*/begin
         fifo_vif.winc <= tr.winc;  
         fifo_vif.wdata <= tr.wdata;
         fifo_vif.ID <= tr.ID;
        tr.wfull = fifo_vif.wfull;
         fifo_vif.rinc <= tr.rinc;
        tr.rempty = fifo_vif.rempty;



         if(tr.rinc) begin
           @(negedge fifo_vif.rclk);   //idle cycle 1
           fifo_vif.rinc <= '0;
           @(negedge fifo_vif.rclk);   //idle cycle 2
         end
      //end
      no_transactions++;
      $display($time,"\t\t\t\t\t\t\t\t\t\t\t\t[DRIVER] ID:%d no_transactions:%d winc:%h rinc:%h wdata:%h rdata:%h",fifo_vif.ID,no_transactions, fifo_vif.winc,fifo_vif.rinc,fifo_vif.wdata,fifo_vif.rdata);
    end  
   
  endtask
endclass
