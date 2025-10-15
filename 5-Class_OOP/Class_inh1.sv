// basic inherentence example 
// Using super to call parent class constructor

class basic; 
 int a ; 

 function new (input int a = 4);
    this.a= a;
 endfunction;

 function void display();
    $display("This the Parent Class: a = %0d", a);
 endfunction;
 endclass   

 class extra extends basic; 
 int b; 

 function new (input int a = 5 , input int b = 6);
    // here we use super to call same name function but in the parent class 
    // to pass the value of a to it 
    super.new(a);
    this.b = b;
 endfunction;
  function void display();
    // here we use super to call same name function but in the parent class 
    // to pass the value of a to it 
    super.display();
    $display("This the Child Class: a = %0d, b = %0d", a, b);

  endfunction;


 endclass

 module tb; 
 extra obj = new(14 , 6);

 initial begin
    obj.display();
 end 
 endmodule



