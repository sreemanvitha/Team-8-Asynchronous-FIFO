//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE SEQUENCE ITEM--------------
//-------------------------------------------------------------

class asyncf_write_sequence_item extends uvm_sequence_item;
   
   rand bit[7:0] data;
   rand logic winc;
   rand int Burst_ID;

   //-------------------------------------------------------------
   //----------utility and field macros---------------------------
   //-------------------------------------------------------------
   `uvm_object_utils_begin(asyncf_write_sequence_item)
      `uvm_field_int(data, UVM_ALL_ON)
      `uvm_field_int(winc, UVM_ALL_ON)
      `uvm_field_int(Burst_ID, UVM_ALL_ON)
   `uvm_object_utils_end

   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_write_sequence_item");
     super.new();
   endfunction
  
   function void build_phase(uvm_phase phase);
     `uvm_info("Up_sequence_item","enter into the up_sequence_item",UVM_MEDIUM)
   endfunction


endclass

