//---------------------------------------------------------
//----------ASYNCHRONOUS FIFO READ SEQUENCER---------------
//---------------------------------------------------------

class asyncf_read_sequencer extends uvm_sequencer #(asyncf_read_sequence_item);
  
  `uvm_component_utils(asyncf_read_sequencer) 
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_read_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction 
  
endclass

