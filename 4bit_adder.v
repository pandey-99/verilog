
`timescale 1ns/1ps
module full_adder( A, B, Cin, S, Cout);
 input wire [3:0] A, B;
 input wire Cin;
 output reg Cout;
 output reg [3:0] S ;
  reg [2:0] w;

  always @(A or B or Cin)
  begin 
       S[0] = A[0] ^ B[0] ^ Cin; 
       w[0] = A[0]&B[0] | (A[0]^B[0]) & Cin; 
       S[1] = A[1] ^ B[1] ^ w[0]; 
       w[1] = A[1]&B[1] | (A[1]^B[1]) & w[0]; 
       S[2] = A[2] ^ B[2] ^ w[1]; 
       w[2] = A[2]&B[2] | (A[2]^B[2]) & w[1]; 
       S[3] = A[3] ^ B[3] ^ w[2]; 
       Cout = A[3]&B[3] | (A[3]^B[3]) & w[2]; 

      

  end
endmodule
