 // testbench for the booth multiplier



`timescale 1ns/1ps
`include "booth_mul.v"
module booth_mul_tb();
  reg [3:0] X,Y;
  wire [7:0]Z;
   booth_mul uut(.X(X),.Y(Y),.Z(Z));

initial begin

$dumpfile("booth_mul_tb.vcd");
$dumpvars(0,booth_mul_tb);

end 
   initial  begin
 X=8'b00000000;
    Y=8'b00000000;
   
     #10 X=8'b1000; Y=8'b0001;
     #10 X=8'b0001; Y=8'b0110;
     #10 X=8'b0001; Y=8'b0010;
     #10 X=8'b0111; Y=8'b0010;
     #10 X=8'b0001; Y=8'b0010;
     #10 X=8'b0001; Y=8'b0110;
     #10 X=8'b0001; Y=8'b0110;
     #10 X=8'b1001; Y=8'b0010;
     #10 X=8'b1111; Y=8'b0110;
     
     #10 $finish;
  end
endmodule
