// use pure virtual Class 
// pure virtual class is a prototype for others 
// write it without body 

virtual class virtual_class;
    // pure virtual function
    pure virtual function void display();
        // no body or endfunction but must be defined in all extened classes
endclass        

class child1 extends virtual_class;
    function new();
        // constructor
    endfunction

    // implementation of pure virtual function
    function void display();
        $display("This is child1 class");
    endfunction
endclass            

module tb;
    // this will give a run time error because we can't declare an object of type virtual_class
    //virtual_class obj1; 
    
    child1 obj2;
    initial begin
        obj2 = new(); // create an object of type child1
        obj2.display(); // this will call the implementation in child1
    end
endmodule   