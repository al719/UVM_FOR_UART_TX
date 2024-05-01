package my_monitor_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


import my_sequence_item_pkg::*;


class my_monitor extends uvm_monitor;

`uvm_component_utils(my_monitor);

uvm_analysis_port #(my_sequence_item)  mon_port ;

virtual dut_if dut_vif ;

my_sequence_item  rsp_seq_item ;

function new(string name = "my_monitor" , uvm_component parent = null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	mon_port = new("mon_port" , this);
	// `uvm_info("MY_MONITOR","BUILD_PHASE",UVM_MEDIUM);
	if(!uvm_config_db#(virtual dut_if)::get(null, "", "dut_if", dut_vif))
			`uvm_fatal("","doesn't read stimulus through monitor")

endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever begin
	rsp_seq_item = my_sequence_item:: type_id :: create("rsp_seq_item");
     @(posedge dut_vif.CLK);    
     
     `uvm_info("MY_MONITOR","MONITOR IS CAPTURING",UVM_MEDIUM);
    
     rsp_seq_item.busy 			= dut_vif.busy 			;
     rsp_seq_item.TX_OUT 		= dut_vif.TX_OUT 		;
     rsp_seq_item.Data_Valid 	= dut_vif.Data_Valid	;
     rsp_seq_item.parity_enable = dut_vif.parity_enable	;
     rsp_seq_item.parity_type   = dut_vif.parity_type	;	
     rsp_seq_item.P_DATA        = dut_vif.P_DATA		;

	 mon_port.write(rsp_seq_item)                    ;
     
	end
 
endtask

endclass	
endpackage	