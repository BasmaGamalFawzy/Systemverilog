//task can take arguments as iput and output but no return
// task can use # (delay) or @ (always - fork/join)
// task can call another task of funcation

module tasktest ();

int a, b, add;

// task can take arguments as iput and output but no return
task add_task1 (input int a, input int b, output int add);
add = a + b;
endtask

// task can access variables defined in the same module as the task
task add_task2 ();
a = 12;
b = 13;
add = a + b;
endtask 

function void display ();
$display("a = %0d, b = %0d, add = %0d", a, b, add);
endfunction

task stimulus();
a=10;
b=20;
add_task1(a,b,add);
display();

#10 a= 12;
b=13;
add_task1(a,b,add);
display();    
endtask



initial begin
    a = 10;
    b = 20;
    add_task1(a, b, add);
    display();
    add_task2();
    display();
    stimulus();
end
endmodule