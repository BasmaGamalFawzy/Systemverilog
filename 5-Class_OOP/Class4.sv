// we here use a class within a class 
// which also called aggregated class

class first;
  logic [3:0] a;
  logic [3:0] b;
  function new (input logic [3:0] a = 4'b1010, input logic [3:0] b = 4'b0101);
    this.a = a;
    this.b = b;
  endfunction

  extern function void display();
endclass 

function void first::display();
  $display("a = %b, b = %b", a, b); 
endfunction

class second;
  first obj1;
  first obj2;
  int x , y ;
// we must call the constructor of the first class to use its methods & data members
  function new ();
    obj1 = new();
    obj2 = new(4'b1111, 4'b0000);
    x = 5;
    y = 10;
  endfunction

function void display();
    $display("Object 1: ");
    obj1.display();
    $display("Object 2: ");
    obj2.display();
    $display("x = %0d, y = %0d", x, y);
endfunction
endclass  


module tb ();
  second obj;
  initial begin
    obj = new();
    obj.display();
  end

endmodule