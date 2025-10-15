// we try here to create custom construction funcation new()

// that is the best parctice 
class ex_new1;
int a , b ; 
function new(input int ain = 4 , input int bin=0) ;
 a = ain;
 b = bin;
 endfunction
 
 endclass

//When a method has an argument with the same name as a class property,
// this is used to clearly refer to the class property.
class ex_new2;
int a , b ; 
function new(input int a= 4 , input int b=0) ;
 this.a = a;
 this.b = b;
 endfunction
 
 endclass
 module tb ;

ex_new1 obj11 , obj21 , obj31 ; 
ex_new2 obj12 , obj22 , obj32 ; 

initial begin 
  obj11 = new ( , 3);
  obj21 = new ();
  obj31 =new (7 , 1);
  obj12 = new ( , 3);
  obj22 = new ();
  obj32 =new (.b(7) , .a(1)); // postion calling to the function

  $display ("Object 11: a = %0d, b = %0d", obj11.a, obj11.b);
  $display ("Object 21: a = %0d, b = %0d", obj21.a, obj21.b);
  $display ("Object 31: a = %0d, b = %0d", obj31.a, obj31.b);
  $display ("Object 12: a = %0d, b = %0d", obj12.a, obj12.b);
  $display ("Object 22: a = %0d, b = %0d", obj22.a, obj22.b);
  $display ("Object 32: a = %0d, b = %0d", obj32.a, obj32.b);
end
  
 endmodule