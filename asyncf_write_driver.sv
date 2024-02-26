//------------------------------------------------------
//----------ASYNCHRONOUS FIFO WRITE DRIVER--------------
//------------------------------------------------------

class asyncf_write_driver extends uvm_driver#(asyncf_write_sequence_item);

   virtual write_if wr_if;
   logic no_tr = 1'b0;

   `uvm_component_utils(asyncf_write_driver)
  
  //------------------------------------------------------
  //------------Constructor
  //------------------------------------------------------
  function new(string name = "asyncf_write_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
   
  //------------------------------------------------------
  //------------Build Phase
  //------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     if(!uvm_config_db#(virtual write_if)::get(this, "", "wr_if", wr_if))
       `uvm_fatal("NO_WR_IF",{"virtual interface must be set for:",get_full_name(),".wr_if"});      
  endfunction: build_phase
  
  
  //------------------------------------------------------
  //------------Run Phase
  //------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    wr_if.wdata <= 8'b0;
    wr_if.winc  <= 1'b0;
    while(!wr_if.wrst_n)
    @(posedge wr_if.wclk);
   
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
     
  endtask:run_phase
  
  
  //------------------------------------------------------
  //drive_one_pkt - transaction level to signal level
  //drives the value's from seq_item to interface signals
  //------------------------------------------------------
  virtual task drive_one_pkt(asyncf_write_sequence_item tr);
    // byte unsigned     data_q[];
    // int  data_size;

     //data_size = tr.pack_bytes(data_q) / 8; 
    //for (int i = 0; i < 10; i++ ) begin
     @(posedge wr_if.wclk);
       while(1) begin
         if (wr_if.wfull) begin
           wr_if.winc <= 1'b0;
           @(posedge wr_if.wclk);
         end
         else begin
           wr_if.winc<= 1'b1;
           wr_if.wdata <= tr.data;   //data_q[i];
           wr_if.Burst_ID <= tr.Burst_ID;
           break;
         end
      // end
  end
    `uvm_info(get_type_name(),$sformatf("wr_if.winc: %0h, wr_if.wdata: %0h wr_if.Burst_ID: %0h",wr_if.winc, wr_if.wdata,wr_if.Burst_ID),UVM_LOW)	

  endtask
  
  virtual task drive_nothing();
     @(posedge wr_if.wclk);
     if (no_tr) wr_if.winc<= 1'b0; 
  endtask

endclass: asyncf_write_driver

