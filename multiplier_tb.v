//testbench for multiplier using data path and control path


`timescale 1ns/1ps
`include "control_data.v"


module mul_test;
reg [15:0] data_in;
reg clk, start;
wire done;
mul_data DP(equalZ,loadA,loadB,loadP,clrP,decB,data_in,clk);
controller CON (loadA,loadB,loadP,clrP,decB,done,clk,equalZ,start);
initial
  begin
    clk=1'b0;                  // setting the initial value of the clock
    #3 start=1'b1;             // set the start signal to to 1 to start the operation
    #100 $finish;              // finish the operation at 100ns
  end
always #5 clk=~clk;        // toggling the clock every 5ns
  initial 
    begin 
      #10 data_in=15;           // data in is provided on the bus
      #20 data_in=9;
    end
initial
   begin
     $monitor($time,"%d %b", DP.Y,done);                  // to see the output on the moniter 
     $dumpfile("mul.vcd"); $dumpvars (0,mul_test);        // variable values dump
   end
endmodule
