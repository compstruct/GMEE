module mult16exact (a,b,y); 

input [15:0] a;
input [15:0] b; 

output [31:0] y; 
 
 
assign y = a*b ;
     
endmodule 
