package my_sequence_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"


class my_sequence_item extends uvm_sequence_item;

`uvm_object_utils(my_sequence_item);


//////// INPUTS //////////

 rand logic                        RST                 ;
 // logic                             CLK                 ;
  logic                        Data_Valid          ;
 rand logic          [7:0]         P_DATA              ;
 rand logic                        parity_type         ;
 rand logic                        parity_enable       ;

 // rand logic [3:0]                  periodic_rate       ;
 // logic [7:0] ser_data;
  
  ///////// OUTPUTS ///////// 
logic TX_OUT ;
logic busy   ;
int count = 0;
 

function new(string name = "my_sequence_item");
	super.new(name);
endfunction


// function void pre_randomize();

// endfunction
// function void post_randomize();

// endfunction
// function void post_randomize();
    
// endfunction
// constraint rate {
//     rate inside {10 , 11};
// }
// constraint data_v {
//             data_v == 1; 
// }

constraint reset_c {
    RST dist {1'b1 :/ 99 , 1'b0 :/ 1 };
}

constraint parity {
    parity_enable dist {0:= 50 , 1:=50};
    parity_type dist {[0:1]:/100};
}



endclass	
endpackage	