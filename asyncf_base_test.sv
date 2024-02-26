//-------------------------------------------------------------
//----------ASYNCHRONOUS FIFO BASE TEST------------------------
//-------------------------------------------------------------


class asyncf_base_test extends uvm_test;

   `uvm_component_utils(asyncf_base_test)
  
   //-------------------------------------------------------------
   //environment instance
   //-------------------------------------------------------------
   asyncf_environment env;
   
   //------------------------------------------------------
   //------------Constructor
   //------------------------------------------------------
   function new(string name = "asyncf_base_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   //------------------------------------------------------
   //------------Build Phase
   //------------------------------------------------------
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     
      // create the env
      env  =  asyncf_environment::type_id::create("env", this);
   endfunction
  
   //------------------------------------------------------
   //------------Report Phase
   //------------------------------------------------------
  function void end_of_elaboration();
       print();
  endfunction
  
   //------------------------------------------------------
   //------------Report Phase
   //------------------------------------------------------
   function void report_phase(uvm_phase phase);
      uvm_report_server svr;
      super.report_phase(phase);

      svr = uvm_report_server::get_server();
      if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
         `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
         `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
         `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      end
      else begin
         `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
         `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
         `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      end
   endfunction
   
endclass

