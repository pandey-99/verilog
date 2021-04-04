//4:1 mux
 
 `timescale 1ns/1ps 

  module mux(a,b,c,d,S0,S1,op);  

   input [3:0] a,b,c, b;                             //4 bit input a,b,c,d
     input  S0,S1;                                   // S0,S1 is select line
     output[3:0] op;
     assign op= S1? (S0?a:b):(S0?c:d);

  endmodule
