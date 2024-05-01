package my_sequence_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;

// class data_valid_sequence extends uvm_sequence #(my_sequence_item);

// `uvm_object_utils(data_valid_sequence);
//                        ;
// my_sequence_item stim_seq_item ;

// function new(string name = "data_valid_sequence");
// 	super.new(name);
// 	 `uvm_info("MY_SEQUENCE","SEQ CREATED",UVM_MEDIUM);
// endfunction


// task body();

// 	stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");
// 	`uvm_info("MY_SEQUENCE","BEFORE START ITEM",UVM_MEDIUM);  
// 	repeat(10)begin // # of test sequences
    
//       start_item(stim_seq_item);
//       `uvm_info("MY_SEQUENCE","AFTER START ITEM",UVM_MEDIUM);
//       stim_seq_item.Data_Valid = 0;
//       #5;
//       stim_seq_item.Data_Valid = 1;
//       #5;
//       stim_seq_item.Data_Valid = 0;
//       finish_item(stim_seq_item);
//       get_response(stim_seq_item);
// 	  `uvm_info("MY_SEQUENCE","AFTER FINISH ITEM",UVM_MEDIUM);
	
// 	end
// endtask


// endclass

//////////////////////////////////////////////////////////////



class my_sequence extends uvm_sequence #(my_sequence_item);

`uvm_object_utils(my_sequence);
                       ;
my_sequence_item stim_seq_item ;

function new(string name = "my_sequence");
	super.new(name);
	 `uvm_info("MY_SEQUENCE","SEQ CREATED",UVM_MEDIUM);
endfunction

// task pre_body();
//  	begin  
//  	start_item(stim_seq_item); 
//  	  stim_seq_item.Data_Valid = 0;
//  	  stim_seq_item.parity_enable = 0;
//  	  stim_seq_item.RST = 0;
//  	  stim_seq_item.parity_type = 0;
//  	  stim_seq_item.P_DATA = 0;
//       #5;
//       stim_seq_item.Data_Valid = 1;
//       #5;
//       stim_seq_item.Data_Valid = 0;
//        finish_item(stim_seq_item);
//       get_response(stim_seq_item);
//     end
// endtask
task body();

	stim_seq_item = my_sequence_item :: type_id :: create("stim_seq_item");
	`uvm_info("MY_SEQUENCE","BEFORE START ITEM",UVM_MEDIUM);  
	repeat(5000) begin // # of test sequences
    
      start_item(stim_seq_item);
      `uvm_info("MY_SEQUENCE","AFTER START ITEM",UVM_MEDIUM);
      if(stim_seq_item.count < 10) begin
	      
	      stim_seq_item.Data_Valid = 1'b0;
	      assert(stim_seq_item.randomize());
	      stim_seq_item.count++;

  	  end else begin
	  	  stim_seq_item.Data_Valid = 1'b1;
	  	  stim_seq_item.count = 0;
	  	  // stim_seq_item.ser_data = stim_seq_item.P_DATA;
  	  end
      finish_item(stim_seq_item);
      get_response(stim_seq_item);
	  `uvm_info("MY_SEQUENCE","AFTER FINISH ITEM",UVM_MEDIUM);
	
	end
endtask


endclass
	


endpackage	