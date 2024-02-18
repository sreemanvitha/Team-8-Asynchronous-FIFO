//`include "transaction.sv"
`include "coverage.sv"
class scoreboard;

  mailbox mon2scb;
  int no_transactions;
  int pass_count, fail_count, iteration_count;
  bit [7:0] verif_data_q [$];
  reg [7:0] verif_data, DUT_data;
  coverage cov=new();

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task main;
     transaction tr;
     forever begin
       tr = new();
       mon2scb.get(tr);
       cov.sample(tr);
       no_transactions++;
       $display("\t\t\t\t\t\t\t\t\t\t\t\t[SCOREBOARD](tr) Time:%0t,ID:%d winc=%d, rinc=%d, wdata=%h, rdata=%h",$time,tr.ID, tr.winc, tr.rinc, tr.wdata, tr.wdata);
                       
       if(tr.winc && !tr.wfull) begin
         verif_data_q.push_front(tr.wdata);
         $display("data written: tr.wdata = %h", tr.wdata);
         pass_count++;
       end

       
       if(tr.rinc && !tr.rempty ) begin
        verif_data = verif_data_q.pop_back();
         #2;
         if(tr.rdata === verif_data) begin
           $display("read check passed: expected data = %h, tr.rdata = %h", verif_data, verif_data);
           pass_count++;
         end
         else begin
           $display("read check passed: expected data = %h, tr.rdata = %h", verif_data, verif_data);
           pass_count++;
         end
       end
     $display("iteration_count = %0d\npass_count = %0d\nfail_count = %0d", no_transactions, pass_count, fail_count);
   end
   endtask
endclass
