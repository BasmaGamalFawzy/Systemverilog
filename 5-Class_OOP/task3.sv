// test somthings about task

module tb();
bit [1:0] a , b ;

// this won't work as a and b are passed by value
task swap_wrong (input bit [1:0] a , b) ;
  bit [1:0] temp ;
  temp = a ;
  a = b ;
  b = temp ;
endtask

task automatic swap (ref bit [1:0] a , b) ;
  bit [1:0] temp ;
  temp = a ;
  a = b ;
  b = temp ;
endtask

initial begin
  a = 2'b01 ;
  b = 2'b10 ;
  $display("Before swap: a = %b, b = %b", a, b);
  swap_wrong(a, b);
  $display("After swap_wrong: a = %b, b = %b", a, b);
  swap(a, b);
  $display("After swap: a = %b, b = %b", a, b);
 end

endmodule
