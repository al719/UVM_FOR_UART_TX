package my_scoreboard_pkg;

import uvm_pkg::*             ;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;
// import PARAMETERS_PKG::*      ;


class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

uvm_analysis_export   #(my_sequence_item) sb_export ;
uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo   ;

 // uvm_analysis_imp      #(my_sequence_item , my_scoreboard) sb_export ;

virtual dut_if dut_vif                              ;

my_sequence_item     data_to_check                  ;


bit expected_parity;
logic [7:0] data_p ;
logic [7:0] collected_data;
int counter = 0;
int correct_count = 0;
int error_count   = 0;

function new(string name = "my_scoreboard" , uvm_component parent = null);
	super.new(name,parent);
endfunction


  // function void write(my_sequence_item  pkt);
  // 	data_to_check = pkt ;
  // endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sb_export     = new("sb_export" , this);
	sb_fifo       = new("sb_fifo"   , this);
  data_to_check = new ("data_to_check");


   if(!uvm_config_db#(virtual dut_if)::get(this,"","dut_if", dut_vif))
  `uvm_fatal("MY_TEST" , "FATAL PUTTING INTERNALS INTERFACE in CONFIG_DB");

	`uvm_info("MY_SCOREBOARD","BUILD_PHASE",UVM_MEDIUM);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
   sb_export.connect(sb_fifo.analysis_export);	
endfunction


function void end_of_elaboration_phase (uvm_phase phase);
  super.end_of_elaboration_phase (phase);                         
endfunction


int key = 0;
task run_phase(uvm_phase phase);
	super.run_phase(phase);

    forever begin 
         `uvm_info(get_type_name(),"SCORE ",UVM_MEDIUM);
          sb_fifo.get(data_to_check);
          if(dut_vif.Data_Valid) begin
            data_p = data_to_check.P_DATA;
          end
          if(!dut_vif.busy) begin 
            @(posedge dut_vif.CLK);
            collected_data = 8'b0;
            counter = 0;
          end
          else if(counter == 10) begin
            @(posedge dut_vif.CLK);
            collected_data = 8'b0;
            counter = 0;
          
          end else begin 

            // sb_fifo.get(data_to_check);
            if(counter == 0) begin
              // counter = (counter+1)%10;
              counter++;
              continue;
            end
              collected_data[counter-1] = data_to_check.TX_OUT;
              // counter = (counter+1)%10;
              counter++;
              
       end 
       if(counter == 9) begin
         check_data(collected_data , data_p);
       end
      end 
      
endtask

task check_data(input [7:0] actual_data , expected_data);
  begin
    if(actual_data != expected_data) begin
      `uvm_info(get_type_name(),"Failed through score board",UVM_LOW);
      error_count++;
    end else begin
      `uvm_info(get_type_name(),"Succes through score board",UVM_LOW);
      correct_count++;
    end
  end
endtask : check_data

task check_parity(input bit expected_parity , actual_parity);
  begin
      if(expected_parity != actual_parity) begin
        `uvm_info(get_type_name(),"Failed through score board",UVM_HIGH);
      end else begin
        `uvm_info(get_type_name(),"Succes through score board",UVM_HIGH);
      end
  end
endtask : check_parity

// function void check_phase (uvm_phase phase);
// super.check_phase(phase);

// endfunction



function void report_phase(uvm_phase phase);
	super.report_phase(phase);

 
endfunction



function void final_phase (uvm_phase phase);
	super.final_phase(phase);

endfunction

endclass	

endpackage	