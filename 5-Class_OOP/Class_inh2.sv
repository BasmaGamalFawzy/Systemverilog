// use polymorphism array of base
// use upcasting
// use :: the scope resolution operator 
// use downcasting



class base;
int a ; 
function new (input int a = 4);
    this.a = a;
endfunction;

virtual function void display();
    $display("This is the Base Class: a = %0d", a);
endfunction;    

function void non_virtual();
    $display("This is a non-virtual function in the Base Class: a = %0d", a);
endfunction;

endclass;    

class derived1 extends base;
int b;  
function new (input int a = 5 , input int b = 6);
    super.new(a);
    this.b = b; 
endfunction;    

function void display();
    $display("This is the Derived1 Class: a = %0d, b = %0d", a, b);
endfunction;  

function void non_virtual();
    $display("This is a non-virtual function in the Derived1 Class: a = %0d, b = %0d", a, b);    
endfunction;
endclass;    

class derived2 extends base;
int c;  
function new (input int a = 6 , input int c = 7);
    super.new(a);
    this.c = c; 
endfunction;    

function void display();
    $display("This is the Derived2 Class: a = %0d, c = %0d", a, c);
endfunction;   

function void non_virtual();
    $display("This is a non-virtual function in the Derived2 Class: a = %0d, c = %0d", a, c);    
endfunction;
endclass;    

module tb ();    
derived1 obj1=new();  
derived2 obj2=new();
derived1 obj3;
base array[4];

initial begin
    array[0]= new();
    // upcasting in 3 different ways
    array[1]= derived1::new();
    array[2]= obj2 ; 
    $cast (array[3], obj1);

    for (int i = 0; i < 4; i++) begin
        array[i].display();
        array[i].non_virtual();
    end 

    
    // this is not allowed & give compilation error
    // we can't access the derive class member using upcasted base pointer
    // $display(" C of derived2 class: %0d", array[2].c);
    // $display(" C of derived1 class: %0d", array[1].c);
    $display(" We can't access the derived class members using base class pointer");
   
   // So we need Downcasting



   // we can only downcast upcasted handler from the same class    

    // Both are not allowed & give runtime error
    // $cast (obj3, array[0]); 
    // base handler can't be downcasted to derived class handler
    // $cast (obj3, array[2]); 
    // derived1 handler can't be downcasted to derived2 handler
    

    // this is allowed & no Downcast needed as there are already handler for it
    $display(" C of derived2 class: %0d", obj2.c);
    obj2.display();
    obj2.non_virtual();
    
     
    // this Downcast is needed to access array[1] b
    $cast (obj3, array[1]); 
    $display(" This is DownCasting");
    obj3.display();
    obj3.non_virtual();
    $display(" B of derived1 class: %0d", obj3.b);
    
end
endmodule





