//`include "transaction.sv"
class coverage;
parameter DSIZE = 8;
  transaction tr;

  
 // Create a coverage group
  covergroup cg;// @(posedge tr.wclk);
    c1: coverpoint tr.winc {bins a1={0};
		bins a2={1};
}
    c2: coverpoint tr.rinc {bins b1 = {0};
                     bins b2 = {1};
                     }
    c3: coverpoint tr.wdata {bins b3   = {[0:30]};
	              bins b4 = {[30:70]};
		      bins b5 = {[70:100]};
		      bins b6 = {[100:140]};
		      bins b7 = {[140:70]};
		      bins b8 = {[170:210]};
		      bins b9 = {[210:255]};
					  }
	c4: coverpoint tr.rdata  {bins b10   = {[0:30]};
	                  bins b11 = {[30:70]};
					  bins b12 = {[70:100]};
					  bins b13 = {[100:140]};
					  bins b14 = {[140:70]};
					  bins b15 = {[170:210]};
					  bins b16 = {[210:255]};
					  }
	c5: coverpoint tr.wfull {bins b17 = {0,1};}
	c6: coverpoint tr.rempty {bins b19 = {0,1};}
  endgroup : cg
  
   function new();
        cg=new();
    endfunction

    task sample(transaction tr);
        this.tr=tr;
        cg.sample();
endtask
endclass