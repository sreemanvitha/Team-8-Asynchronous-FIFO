//------------------------------------------------------
//----------ASYNCHRONOUS FIFO READ DRIVER--------------
//------------------------------------------------------
class asyncf_read_driver extends uvm_driver#(asyncf_read_sequence_item);

   virtual read_if rd_if;
   logic no_tr = 1'b0;

  `uvm_component_utils(asyncf_read_driver)
  
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_read_driver", uvm_component parent);
      super.new(name, parent);
   endfunction

   //------------------------------------------------------
   //------------Build Phase
   //------------------------------------------------------
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual read_if)::get(this, "", "rd_if", rd_if))
         `uvm_fatal("asyncf_down_driver", "virtual interface must be set for down_if!!!")
   endfunction
       
   //------------------------------------------------------
   //------------Run Phase
   //------------------------------------------------------
   virtual task run_phase(uvm_phase phase);
     rd_if.rinc  <= 1'b1;
     while(!rd_if.rrst_n)
       @(posedge rd_if.rclk);
       fork
          while(1) begin

            seq_item_port.get_next_item(req);
            no_tr = 1'b0;
            drive_one_pkt(req);
            no_tr = 1'b1;
            seq_item_port.item_done();
          end
          while (1) begin
            drive_nothing();
          end
       join

   endtask
     
   virtual task drive_one_pkt(asyncf_read_sequence_item tr);
     @(posedge rd_if.rclk);
     while(1) begin
       if (rd_if.rempty) begin
         rd_if.rinc <= 1'b0;
         @(posedge rd_if.rclk);
       end
       else begin
         rd_if.rinc<= 1'b1;
         break;
       end
     end
   endtask

   virtual task drive_nothing();
     @(posedge rd_if.rclk);
     if (no_tr) rd_if.rinc<= 1'b1; 
     `uvm_info(get_type_name(),$sformatf("rd_if.rinc: %0h, rd_if.rdata: %0h",rd_if.rinc,rd_if.rdata),UVM_LOW)	

   endtask

endclass


