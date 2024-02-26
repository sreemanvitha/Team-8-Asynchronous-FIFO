//---------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE SEQUENCER--------------
//---------------------------------------------------------

class asyncf_write_sequencer extends uvm_sequencer #(asyncf_write_sequence_item);

  `uvm_component_utils(asyncf_write_sequencer)
  
  //------------------------------------------------------
  //------------Constructor
  //------------------------------------------------------
  function new(string name = "asyncf_write_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction 
   

endclass

