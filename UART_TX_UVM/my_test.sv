package my_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_env_pkg::*;
import my_sequence_pkg::*;
import my_config_db_pkg::*;


class my_test extends uvm_test;

`uvm_component_utils(my_test);

my_env          env         ;
my_sequence     main_seq    ;
// data_valid_sequence dv_seq  ;
// my_config_db    cfg         ;

function new(string name = "my_test" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("MY_TEST","BUILD_PHASE",UVM_MEDIUM);

  env       = my_env         :: type_id :: create("env"      ,this)   ;
  main_seq  = my_sequence    :: type_id :: create("main_seq" ,this)   ;
  // dv_seq    = data_valid_sequence :: type_id :: create ("data_valid_seq",this);
//   cfg       = my_config_db   :: type_id :: create("cfg"      ,this)   ;
  
  
// if(!uvm_config_db#(virtual BFM_if)::get(this, "", "bfm_if", cfg.dut_vif))
// 	`uvm_fatal("MY_TEST" , "FATAL PUTTING BFM INTERFACE in CONFIG_DB");
 
// if(!uvm_config_db#(virtual INTERNALS_if)::get(this,"","internals_if", cfg.internals_if))
//   `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");
 
//  uvm_config_db#(my_config_db)::set(this, "*", "CFG", cfg);

endfunction 


task run_phase(uvm_phase phase);
//   fork
//     begin 
//    phase.raise_objection(this);
//    dv_seq.start(env.agent.sqr);
//   // `uvm_warning("MY_TEST","MAIN TEST START.."); 
  
  
//    phase.drop_objection(this);
// end 
begin
  phase.raise_objection(this);
  // dv_seq.start(env.agent.sqr);
  // `uvm_warning("MY_TEST","MAIN TEST START.."); 
   main_seq.start(env.agent.sqr);
  
   phase.drop_objection(this);
end
  // join

  
endtask



endclass	
endpackage	