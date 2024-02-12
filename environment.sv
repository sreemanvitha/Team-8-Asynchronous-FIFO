`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment;
  
  generator gen;
  driver driv;
  
  event gen_ended;
  
  mailbox gen2driv;
  
  virtual fifo_intf fifo_vif;
  
  function new(virtual fifo_intf fifo_vif);
    this.fifo_vif = fifo_vif;
    gen2driv = new();
    gen = new(gen2driv,gen_ended);
    driv = new(fifo_vif,gen2driv);
  endfunction
  
  task pre_test();
    driv.reset();
  endtask
  
  task test();
    fork
      gen.main();
      driv.main();
    join_any
  endtask
  
  task post_test();
    wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
  endtask
  
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass
