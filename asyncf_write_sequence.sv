//-------------------------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE SEQUENCE - random stimulus-------------
//-------------------------------------------------------------------------

class asyncf_write_sequence extends uvm_sequence #(asyncf_write_sequence_item);
   
  `uvm_object_utils(asyncf_write_sequence)
  rand logic winc;
  
  //------------------------------------------------------
  //------------Constructor
  //------------------------------------------------------
  function  new(string name= "asyncf_write_sequence");
    super.new(name);
  endfunction 
  
  //`uvm_declare_p_sequencer(asyncf_write_sequencer)
  
  function void build_phase(uvm_phase phase);
    `uvm_info("Up_sequence","enter into the up_sequence",UVM_MEDIUM)
  endfunction
  //------------------------------------------------------
  //create, randomize and send the item to driver
  //------------------------------------------------------
  virtual task body();
    asyncf_write_sequence_item req;
    repeat(2) begin 
     `uvm_do(req)
    end
  endtask  

endclass

//------------------------------------------------------
// write_sequence - "write" type
//------------------------------------------------------
class asyncf_wr_sequence extends uvm_sequence #(asyncf_write_sequence_item);
  
 // asyncf_write_sequence wr_seq;
  //parameter Burst_len = 10;
  
  `uvm_object_utils(asyncf_wr_sequence)
  
  //------------------------------------------------------
  //------------Constructor
  //------------------------------------------------------
  function  new(string name= "asyncf_wr_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    for (int i=0; i<10; i++) begin
      `uvm_do_with(req,{req.winc == 1; req.Burst_ID == i;})
      `uvm_info(get_type_name(),$sformatf("winc: %0h, wdata: %0h Burst_ID: %0h",req.winc,req.data,req.Burst_ID),UVM_LOW)	

    end
  endtask
  
   
  
endclass