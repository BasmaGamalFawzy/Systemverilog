// Example on logic as reg substatue + Events + byte
module exp1 ();
logic a , b , c , d;
event s ; 
byte x ;


initial begin 
    // event cant be put inside display or monitor 
   $monitor("a=%b , b=%b , c=%b , d=%b , x=%b" , a ,b , c , d,x); 
    a <= 1 ;
    b <= 0 ;
    // time now can take units:s,us,ms,ns: no space & can be float 
    #10ns ->s; 
    
    
end

assign c = a ^ b ; 

always @(*) begin
 d = a + b ;    
 x='1;
end

always @(s)
d=0;

endmodule 

