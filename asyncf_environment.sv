//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO ENVIRONMENT----------------------
//-------------------------------------------------------------


class asyncf_environment extends uvm_env;

   //-----------------------------------------
   //agent and scoreboard instances
   //-----------------------------------------
   asyncf_write_agent              wr_agnt;
   asyncf_read_agent               rd_agnt;
   
   `uvm_component_utils(asyncf_environment)
   
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_environment", uvm_component parent);
      super.new(name, parent);
   endfunction: new
  
   //------------------------------------------------------
   //------------Build Phase
   //------------------------------------------------------
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      wr_agnt = asyncf_write_agent::type_id::create("wr_agnt", this);
      rd_agnt = asyncf_read_agent::type_id::create("rd_agnt", this);
   endfunction


endclass


