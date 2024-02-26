//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE TEST-----------------------
//-------------------------------------------------------------
class asyncf_write_test extends asyncf_base_test;

   `uvm_component_utils(asyncf_write_test)
  
   //-------------------------------------------------------------
   // sequence instance
   //-------------------------------------------------------------
   asyncf_wr_sequence w_seq;
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_write_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
  
   //------------------------------------------------------
   //------------Build Phase
   //------------------------------------------------------
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      w_seq = asyncf_wr_sequence::type_id::create("w_seq");
   endfunction
  
   //------------------------------------------------------
   //------------Run Phase - starting the test
   //------------------------------------------------------
   task run_phase(uvm_phase phase); 
     phase.raise_objection(this);
     w_seq.start(env.wr_agnt.sqr);
     phase.drop_objection(this);
     phase.phase_done.set_drain_time(this, 50);
   endtask

endclass



