// verilog code for the booth multiplier
/* booth multiplier is a sign multiplier */

////////// WELCOME ////////////////

module booth_mul(X, Y, Z);                                // X,Y arethe input and Y is output
  input [3:0] X, Y;                                       // X,Y are of 4 bit
  output [7:0] Z;                                         // Z is of 8 bit
  reg  [7:0] Z;                                          
       reg [1:0] temp;
       integer count;
       reg Q_1;                                  
       always @ (X, Y)
       begin
       Z = 8'd0;
       Q_1 = 1'd0;

       for (count = 0; count < 4; count = count + 1)
       begin
       temp = {X[count], Q_1};
       case (temp)
         2'd2 : Z [7 : 4] = Z [7 : 4] + (~Y+1);                        
       2'd1 : Z [7 : 4] = Z [7 : 4] + Y;
       default : Z [7 : 4] = Z [7 : 4] ;
       endcase
       Z = Z >> 1;
       Z[7] = Z[6];
       Q_1 = X[count];
           end
       if (Y == 4'd8)
         begin
               Z = - Z;
          end
      end
      endmodule
