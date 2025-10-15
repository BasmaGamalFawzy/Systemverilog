/* Create a Class consisting of 3 data members each of unsigned integer type. 
Initialize them to 45,78, and 90. 
Use the display function to print the values on the console. */
class first;
   int a;
   int b;
   int c;
endclass //first

module tb ();
    first obj;
    initial begin
        obj = new();
        obj.a = 45;
        obj.b = 78;
        obj.c = 90;
        $display("a = %d, b = %d, c = %d", obj.a, obj.b, obj.c);
    end
endmodule