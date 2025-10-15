// Argument pass by value, the argument passing mechanism works by copying each argument into the metho memory area.
// Argument pass by reference, a reference to the original argument is passed to the method.
// Argument pass by constant reference are not allowed to be modified.


module task2();

int x, y, z;

task display();
$display("x = %0d, y = %0d, z = %0d", x, y, z);
endtask 

task send_value(input int a , b, output int c);
c = a + b;
#2 display(); //Z will not be updated
endtask

// Usually ref is used with larage data structures like arrays, classes, and structs to avoid copying the entire structure.
/* with ref parameters the task must be automatic,
as multiple concurrent or nested calls to the task can overwrite each other's data, 
causing unpredictable behavior or race conditions.
Automatic tasks allocate a new stack frame (local scope) per call, isolating execution and ensuring safe concurrent behavior
critical when ref parameters are used to pass variables by reference. */
// Automatic tasks allocate unique, stacked storage for each task call.

task automatic send_ref(ref int a, b, c);
c= a+ b;
#2 display();
endtask

// if we want to pass a variable by reference but not allow the method to modify it, we can use const ref.
task automatic send_const_ref(const ref int a, b, ref int c);
c = a + b;
#2 display(); // z will be updated
endtask     

initial begin
x = 10;
y = 20;
z = 50;
send_value(x,y,z);
display();
send_ref(x,y,z);
send_const_ref(x,y,z);
end
endmodule