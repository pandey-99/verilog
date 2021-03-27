/*16 bit multiplier using data path and control path*/

/*  ///////  WELCOME  ////////*/


`timescale 1ns/1ps


module mul_data (equalZ,loadA,loadB,loadP,clrP,decB,data_in,clk);                // output and input to the data path
input loadA,loadB,loadP,clrP,decB,clk;
input[15:0] data_in;
output equalZ;
wire [15:0] X,Y,Z,Bout,bus;
assign bus= data_in;
  PIPO1 A (.dout(X),.d_in(bus),.ld(loadA),.clk(clk));                          // parallel in and parallel op register A
  PIPO2 P (.dout(Y),.din(Z),.ld(loadP),.clr(clrP),.clk(clk));                  // parallel in and parallel op register P
  CNTR B (.Bout(Bout),.data_in(bus),.ld(loadB),.decB(decB),.clk(clk));         // counter
  Add AD (.out(Z),.in1(X),.in2(Y));                                            // adder
  EqualZ COMP (.equalZ(equalZ),.Bout(Bout));                                   // comparator
endmodule




module PIPO1 (dout,d_in,ld,clk);                                              // module parallel in and parallel op register A
input [15:0] d_in;
input ld,clk;
output reg [15:0] dout;
always@(posedge clk)
if (ld) dout<=d_in;
endmodule




module PIPO2 (dout,din,ld,clr,clk);                                        // module parallel in and parallel op register P
input [15:0] din;
input ld,clr,clk;
output reg [15:0] dout;
always@(posedge clk)
if(clr) dout<=16'b0;
else if(ld) dout<=din;
endmodule



module Add (out,in1,in2);                                              // adder module
input [15:0] in1,in2;
output reg [15:0] out;
always @(*)
out=in1+in2;
endmodule



module EqualZ (equalZ,Bout);                                          //comparator module
input [15:0]Bout;
output equalZ;
assign equalZ=(Bout==1);
endmodule



module CNTR (Bout,data_in,ld,decB,clk);                          // counter module
input [15:0] data_in;
input ld,decB,clk;
output reg [15:0] Bout;
always @(posedge clk)
if(ld) Bout<=data_in;
else if (decB) Bout<=Bout-1;
endmodule




module controller (loadA,loadB,loadP,clrP,decB,done,clk,equalZ,start);                // controller module output and input
input clk,equalZ,start; 
output reg loadA,loadB,loadP,clrP,decB,done;
reg [2:0] state;
parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100;
always@(posedge clk)
begin
case (state)
  S0: if (start) state<=S1;                                    // if start =1 we will move to state S1 
  S1: state<=S2;                                                                              
  S2: state<=S3;  
  S3: if (equalZ) state<=S4;                                  // remain in state S3 until equalZ=1
  S4: state<=S4; 
  default: state<=S0;
endcase
end
always @ (state)
begin
case (state)
S0: begin #1 loadA=0;loadB=0;loadP=0;clrP=0;decB=0; end
S1: begin #1 loadA=1; end
S2: begin #1 loadA=0;loadB=1;clrP=1; end
S3: begin #1 loadB=0;loadP=1;clrP=0;decB=1; end
S4: begin #1 done=1;loadB=0;loadP=0;decB=0; end
default: begin #1 loadA=0;loadB=0;loadP=0;clrP=0;decB=0; end
endcase
end
endmodule






