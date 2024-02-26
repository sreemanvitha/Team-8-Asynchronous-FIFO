//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE AGENT----------------------
//-------------------------------------------------------------

class asyncf_read_agent extends uvm_agent;
  
  //-------------------------------------------------------------
  //component instances
  //-------------------------------------------------------------
  asyncf_read_sequencer    sqr;
  asyncf_read_monitor      mon;
  asyncf_read_driver       drv;
  
  `uvm_component_utils(asyncf_read_agent)
   
  //------------------------------------------------------
  //------------Constructor
  //------------------------------------------------------
  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction 
   
  //------------------------------------------------------
  //------------Build Phase
  //------------------------------------------------------
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     sqr = asyncf_read_sequencer::type_id::create("sqr", this);
     mon = asyncf_read_monitor::type_id::create("mon", this);
     drv = asyncf_read_driver::type_id::create("drv", this);
  endfunction 
  
  //------------------------------------------------------
  //------------connect Phase
  //------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

endclass 


