package my_coverage_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

class my_coverage extends uvm_component;

`uvm_component_utils(my_coverage);

uvm_analysis_export   #(my_sequence_item) cov_export;
uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo  ;  
my_sequence_item      data_to_cover                 ;



covergroup cg;

p_data : coverpoint data_to_cover.P_DATA  { //iff (data_to_cover.RST)
	bins data_max_min[2] = {8'hff,8'h0};
	bins data[] = {[1:254]}; 
} 

dv : coverpoint data_to_cover.Data_Valid  {//iff(data_to_cover.RST)
	bins dv_0 = {0};
	bins dv_1 = {1};
	bins dv_0_1 = (0=>1);
	bins dv_1_0 = (1=>0);
	bins dv_pulse = (0=>1=>0);
}
 
dv_data : cross dv , p_data {
	bins datamax_dv = binsof(p_data.data_max_min[0]) && binsof(dv.dv_pulse);
	bins datamin_dv = binsof(p_data.data_max_min[1]) && binsof(dv.dv_pulse);
	bins data_dv 	= binsof(p_data.data) && binsof(dv.dv_pulse);
}

endgroup




function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cov_export    = new("cov_export" , this);
	cov_fifo      = new("cov_fifo"   , this);
	data_to_cover = new("data_to_cover");
	`uvm_info("MY_COVERAGE","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	cov_export.connect(cov_fifo.analysis_export);
endfunction


function new(string name = "my_coverage" , uvm_component parent = null);
	super.new(name,parent);
	cg = new();
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);
    forever begin
    	cov_fifo.get(data_to_cover);
    	`uvm_info("MY_COVERAGE","COVERAGE's CAPTURING",UVM_MEDIUM);

    	cg.sample();
    end
endtask



endclass	
endpackage	