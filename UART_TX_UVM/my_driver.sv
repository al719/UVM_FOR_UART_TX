package my_driver_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class my_driver extends uvm_driver #(my_sequence_item);

`uvm_component_utils(my_driver);

virtual dut_if dut_vif ;
my_sequence_item stim_seq_item ;



function new(string name = "my_driver" , uvm_component parent = null);
	super.new(name,parent);

endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	// `uvm_info("MY_DRIVER","BUILD_PHASE",UVM_MEDIUM);
	if(!uvm_config_db #(virtual dut_if) :: get(this , "" , "dut_if" , dut_vif))
			`uvm_fatal("","failed to read interface through driver");
endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	stim_seq_item = my_sequence_item :: type_id :: create ("stim_seq_item" , this);
	seq_item_port.get_next_item(stim_seq_item);
        drive();
	seq_item_port.item_done(stim_seq_item);
	end 
endtask : run_phase



task drive(); 
  @(negedge dut_vif.CLK);
  dut_vif.RST 					= stim_seq_item.RST 										; 
  dut_vif.P_DATA 				= stim_seq_item.P_DATA									;
  dut_vif.Data_Valid 		= stim_seq_item.Data_Valid							;
  dut_vif.parity_enable = stim_seq_item.parity_enable						;
  dut_vif.parity_type   = stim_seq_item.parity_type							;
`uvm_info("MY_DRIVER","DRIVE FUN",UVM_MEDIUM);
	
endtask 


endclass	
endpackage	