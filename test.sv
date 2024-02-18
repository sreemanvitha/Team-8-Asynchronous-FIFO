`include "environment.sv"

program test(fifo_intf intf);

  environment env;
  //int BURST_LENGTH = 512;
  //int BURST_COUNT = 10;
  initial begin
    env = new(intf);
    env.gen.repeat_count = 100*1; //BURST_LENGTH*BURST_COUNT;  
    env.run();
  end
  
endprogram
