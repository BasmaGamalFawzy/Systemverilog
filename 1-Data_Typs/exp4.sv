// enum as type & practical application in state machine
module exp4 ();

typedef enum logic [1:0] { s0 , s1 , s2 ,s3  } state;
state pr , nxt ; 

event clk ;

initial begin 
nxt = nxt.first(); 
forever begin
    #1ns -> clk ; 
end 
end

always @(clk) begin 
if (nxt == nxt.last) $stop ;
nxt = nxt.next();    
end 

always @(nxt) begin
   pr = nxt ;
   $display ("pr=%s   pr_code=%b" , pr.name() , pr) ;
end
endmodule