// Class is a user-defined data type that allows you to create objects
// with specific properties and methods. Use for REUSABLE CODE

class first;
    bit [3:0] a;
    bit [3:0] b;
endclass //first

module tb ();
    first obj; //create an object of class first using the idnetifier obj
    initial begin
        obj = new(); // allocate memory for the object so obj oesn't point to NULL
        obj.a = 4'b1010; // here we acess the data members of the class using the object        obj.b = 4'b0101;
        $display("a = %b, b = %b", obj.a, obj.b);
    end

    obj = NULL; // deallocate memory for the object
endmodule