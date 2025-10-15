// Example on packed & unpacked structure
module exp2 ();

logic [8:0] t ; 

struct packed {
    byte b; 
    logic a ;
} st_packed;

struct  {
    logic ua ;
    byte ub;
    
} st_unpacked;

initial begin
t= 5 ; 
st_packed=t ; // work just fine
st_unpacked=t; // Error
$display("a=%b b=%b" , st_unpacked.a , st_unpacked.b);
$display("t=%b",t);
end 
    
endmodule