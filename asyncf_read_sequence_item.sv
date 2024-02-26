//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO READ SEQUENCE ITEM--------------
//-------------------------------------------------------------

class asyncf_read_sequence_item extends uvm_sequence_item;

   rand bit rinc;
   rand bit[7:0] data; 

   //-------------------------------------------------------------
   //----------utility and field macros---------------------------
   //-------------------------------------------------------------
   `uvm_object_utils_begin(asyncf_read_sequence_item)
      `uvm_field_int(rinc, UVM_ALL_ON)
     `uvm_field_int(data, UVM_ALL_ON)
   `uvm_object_utils_end
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_read_sequence_item");
      super.new();
   endfunction
  
endclass

