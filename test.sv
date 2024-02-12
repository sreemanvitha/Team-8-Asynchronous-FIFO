`include "environment.sv"

program test(fifo_intf intf);
  int burst_length = 512;
  environment env;
  
  initial begin
    env = new(intf);
    env.gen.repeat_count = burst_length*30;  
    env.run();
  end
  
endprogram
