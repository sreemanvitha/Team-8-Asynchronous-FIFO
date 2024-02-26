 //------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE MONITOR-------------
//------------------------------------------------------

class asyncf_write_monitor extends uvm_monitor;

   virtual write_if wr_if;

   `uvm_component_utils(asyncf_write_monitor)
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_write_monitor", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual write_if)::get(this, "", "wr_if", wr_if))
         `uvm_fatal("asyncf_up_mornitor", "virtual interface must be set for up_if!!!")
   endfunction

   virtual task run_phase(uvm_phase phase);
   asyncf_write_sequence_item req;
   while(1) begin
     req = new("req");
     collect_one_pkt(req);
   end
endtask
  task collect_one_pkt(asyncf_write_sequence_item tr);
   
   while(1) begin
     @(posedge wr_if.wclk);
      if(wr_if.winc) break;
   end
   
   tr.data = wr_if.wdata;
   @(posedge wr_if.wclk);
endtask
     
endclass


