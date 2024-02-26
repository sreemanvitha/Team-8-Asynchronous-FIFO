//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO READ TEST-----------------------
//-------------------------------------------------------------
class asyncf_read_test extends asyncf_base_test;

  `uvm_component_utils(asyncf_read_test)
  
   //-------------------------------------------------------------
   // sequence instance
   //-------------------------------------------------------------
   asyncf_rd_sequence r_seq;
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
  function new(string name = "asyncf_read_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
  
   //------------------------------------------------------
   //------------Build Phase
   //------------------------------------------------------
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     r_seq = asyncf_rd_sequence::type_id::create("r_seq");
   endfunction
  
   //------------------------------------------------------
   //------------Run Phase - starting the test
   //------------------------------------------------------
   task run_phase(uvm_phase phase); 
     phase.raise_objection(this);
     r_seq.start(env.rd_agnt.sqr);
     phase.drop_objection(this);
     phase.phase_done.set_drain_time(this, 50);
   endtask

endclass



