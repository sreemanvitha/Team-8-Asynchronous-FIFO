
class generator;
  
  //declaring transaction class 
  rand transaction tr;
  
  //repeat count, to specify number of items to generate
  int  repeat_count;
  int count;
  //mailbox, to generate and send the packet to driver
  mailbox gen2driv;
  
  //event
  event ended;
  
  //constructor
  function new(mailbox gen2driv,event ended);
    //getting the mailbox handle from env, in order to share the transaction packet between the generator and driver, the same mailbox is shared between both.
    this.gen2driv = gen2driv;
    this.ended = ended;
  endfunction
  
  //main task, generates(create and randomizes) the repeat_count number of transaction packets and puts into mailbox
  task main();

  for(int i = 0; i<repeat_count; i++) begin 
    tr = new();
    if(i<=repeat_count/2) assert(tr.randomize() with {tr.winc == '1; tr.rinc == '0;tr.ID == i;}) else $fatal("Gen:: tr randomization failed");
    if(i>repeat_count/2) assert(tr.randomize() with {tr.winc == '0; tr.rinc == '1;tr.ID == i;}) else $fatal("Gen:: tr randomization failed");
      
    gen2driv.put(tr);
      $display($time,"\t\t\t\t\t\tGENERATOR ID:%h repeat_count: %d winc:%h rinc:%h wdata:%h rdata:%h",tr.ID, ++count, tr.winc,tr.rinc,tr.wdata,tr.rdata);
    end
    -> ended;
  endtask
  
endclass