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
clk=1'b0;
#3 start=1'b1;
#500 $finish;
end
always #5 clk=~clk;
initial begin
#10 data_in=15;
#20 data_in=9;
end
initial
begin
$monitor($time,"%d %b", DP.Y,done);
$dumpfile("mul.vcd"); $dumpvars (0,mul_test);
end
endmodule
