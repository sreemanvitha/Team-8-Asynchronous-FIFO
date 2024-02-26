 //------------------------------------------------------
//----------ASYNCHRONOUS FIFO READ MONITOR---------------
//-------------------------------------------------------

class asyncf_read_monitor extends uvm_monitor;

   virtual read_if rd_if;

   `uvm_component_utils(asyncf_read_monitor)
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_read_monitor", uvm_component parent);
      super.new(name, parent);
   endfunction
  

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual read_if)::get(this, "", "rd_if", rd_if))
         `uvm_fatal("asyncf_down_mornitor", "virtual interface must be set for down_if!!!")
   endfunction

     virtual task run_phase(uvm_phase phase);
       asyncf_read_sequence_item req;
       while(1) begin
         req = new("req");
         collect_one_pkt(req);
       end
     endtask
     
   task collect_one_pkt(asyncf_read_sequence_item tr);
     while(1) begin
       @(posedge rd_if.rclk);
        break;
   end

   tr.data = rd_if.rdata;
   @(posedge rd_if.rclk);
endtask
     

endclass


