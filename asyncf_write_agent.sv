//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE AGENT----------------------
//-------------------------------------------------------------

class asyncf_write_agent extends uvm_agent;

  //-------------------------------------------------------------
  //component instances
  //-------------------------------------------------------------
  asyncf_write_sequencer  sqr;
  asyncf_write_driver     drv;
  asyncf_write_monitor    mon;
  
  `uvm_component_utils(asyncf_write_agent)
   
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
    
     sqr = asyncf_write_sequencer::type_id::create("sqr", this);
     drv = asyncf_write_driver::type_id::create("drv", this);
     mon = asyncf_write_monitor::type_id::create("mon", this);
  endfunction: build_phase
  
  //------------------------------------------------------
  //------------connect Phase
  //------------------------------------------------------
  function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction


endclass 



