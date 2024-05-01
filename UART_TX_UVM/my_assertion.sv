`timescale 1ns/10ps
module my_assertion (

input clk , 
input busy,
input data_valid,
input TX_OUT,
input rst,
input par_en
);



property busy_c;

      @(posedge clk) disable iff(!rst) $rose(data_valid) |-> ##[1:2] $rose(busy) or ##[1:2] $stable(busy) ; 

endproperty

chk_busy : assert property(busy_c) $display($stime,,,"\t\t %m PASS"); else $display("Error");
cvg_busy : cover  property(busy_c) ;


property data_c;

      @(posedge clk) disable iff(!rst) $rose(busy) |-> ##[10:11] $fell(busy) or ##[10:11] $stable(busy) ; 

endproperty

chk_data : assert property(data_c);
cvg_data : cover property(data_c);
endmodule
