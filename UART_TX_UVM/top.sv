`timescale 1ns/10ps


import uvm_pkg::*    ;
`include "uvm_macros.svh"

import my_test_pkg::*;
// import PARAMETERS_PKG::*;


module top ;

////////////////////////////////////
//////////// INTERFACE /////////////
////////////////////////////////////


dut_if          dut_if()     ;


/////////////////////////////////////
///////// Design instance ///////////
/////////////////////////////////////

UART_TX DUT(
            .CLK          (dut_if.CLK)              ,
            .RST          (dut_if.RST)              ,
            .Data_Valid   (dut_if.Data_Valid)       ,
            .P_DATA       (dut_if.P_DATA)           ,
            .parity_type  (dut_if.parity_type)      ,
            .parity_enable(dut_if.parity_enable)    ,
            .busy         (dut_if.busy)             ,
            .TX_OUT       (dut_if.TX_OUT)           
            );



bind DUT my_assertion DUTA
(
 .TX_OUT    (dut_if.TX_OUT),
 .busy      (dut_if.busy),
 .clk       (dut_if.CLK),
 .data_valid(dut_if.Data_Valid),
 .rst       (dut_if.RST),
 .par_en    (dut_if.parity_enable)
);


///////////////////////////////////
///////// CLOCK GENERATION ////////
///////////////////////////////////

initial begin
dut_if.CLK = 0 ;
  forever begin
  #2.5 dut_if.CLK = ~ dut_if.CLK;		
  end
end


///////////////////////////////////
///////////// DATABASE ////////////
///////////////////////////////////

initial begin
uvm_config_db#(virtual dut_if)::set(null   , "*", "dut_if",dut_if)              ;    // BUS FUNCTIONAL MODEL
// $fsdbDumpfile("alaa.fsdb");
// $fsdbDumpvars;
//------ RUNNING THE TEST --------
run_test("my_test");	
end


endmodule

