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
    this.gen2driv = gen2driv;
    this.ended = ended;
  endfunction
  
  task main();
    repeat(repeat_count) begin
       tr = new();
    if( !tr.randomize() ) $fatal("Gen:: tr randomization failed");      
    gen2driv.put(tr);
      $info($time,"GENERATOR repeat_count: %d winc:%h rinc:%h wdata:%h",++count, tr.winc,tr.rinc,tr.wdata);
    end
    -> ended;
  endtask
  
endclass
