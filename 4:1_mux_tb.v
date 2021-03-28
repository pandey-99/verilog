//testbench for 2:1 mux



`timescale 1ns/1ps

module test;
  reg [3:0] a,b,c,d;
  reg S0,S1;
  wire [3:0] op;
   
   mux uut(.a(a),.b(b),.c(c),.d(d), .S0(S0),.S1(S1),.op(op));
   
   initial  begin
    S0=0;
    S1=0;
    a=4'b0000;
    b=4'b0000;
    c=4'b0000;
    d=4'b0000;
    $dumpfile("mux4:1_tb.vcd");
    $dumpvars(0,test);
  
    #10 S0=1;a=4'b0001;
    #10 S0=0;S1=1;a=4'b1001; b=4'b0001;c=4'b0101;d=4'b0011;
    #10 S0=1;S1=1;a=4'b1101; b=4'b0101;c=4'b1101;d=4'b0001;
    #10 S0=0;S1=0;a=4'b1111; b=4'b0111;c=4'b0101;d=4'b0011;
    #10 S0=1;S1=0;a=4'b0001; b=4'b1101;c=4'b1101;d=4'b1011;
    #10 S0=0;S1=1;a=4'b1001; b=4'b1111;c=4'b0111;d=4'b1011;
    #10 S0=1;S1=1;a=4'b1000; b=4'b0000;c=4'b0100;d=4'b0010; 
    #10 S0=0;S1=0;a=4'b0001; b=4'b1001;c=4'b1101;d=4'b1011;
    #10 $finish;
  end
endmodule
