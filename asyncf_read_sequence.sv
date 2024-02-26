//-------------------------------------------------------------------------
//----------ASYNCHRONOUS FIFO READ SEQUENCE - random stimulus-------------
//-------------------------------------------------------------------------

class asyncf_read_sequence extends uvm_sequence #(asyncf_read_sequence_item);
   
   `uvm_object_utils(asyncf_read_sequence)
   
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function  new(string name= "asyncf_read_sequence");
      super.new(name);
   endfunction
  
   function void build_phase(uvm_phase phase);
     `uvm_info("READ_sequence","enter into the down_sequence",UVM_MEDIUM)
   endfunction
  
   //------------------------------------------------------
   //create, randomize and send the item to driver
   //------------------------------------------------------
   virtual task body();
      asyncf_read_sequence_item req;
      repeat(2) begin 
        `uvm_do(req)
      end
   endtask
  

endclass

//------------------------------------------------------
// READ_sequence - "Read" type
//------------------------------------------------------
class asyncf_rd_sequence extends uvm_sequence #(asyncf_read_sequence_item);
  
  
  `uvm_object_utils(asyncf_rd_sequence)
  
  //------------------------------------------------------
  //------------Constructor
  //------------------------------------------------------
  function  new(string name= "asyncf_rd_sequence");
    super.new(name);
  endfunction
  
  
  virtual task body();
    asyncf_read_sequence_item req;
    //repeat(10) begin
      `uvm_do_with(req,{req.rinc == 1;})
    //end
  endtask
  
endclass

