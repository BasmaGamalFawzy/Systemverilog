// Function take variables do calculate and return output
// Explore function returns by different methods
// Function doen't have # (delay) or @ (always - fork/join)


module func ();

int a , b , res; 


// use function names as return
function int sum1 (int a=10, int b);// if a is not passed it will be 10
// if b is not passed it will be 0
sum1 = a + b;    
endfunction

// use return
function int sum2 (int a, int b);
return a + b;    // using return terminates the function nothing after return will be executed
endfunction


// use return & function name
function int sum_inc (int a, int b);
sum_inc = a + b;
return sum_inc+1;    
endfunction

// use output for multiple return
// after funcation we must use void
// we send where to store the output
function void sum3 (int a, int b , output int res);
res = a + b;
endfunction

// we can also use struct return for multiple return
// we can also use array for multiple return

// we can send value as input and edit it to be returned
function int editor_inout (inout int x);
x =x  + 10;
return x; // must use return with inout
endfunction

// we can send value as input and edit it to be returned without change var
function automatic int editor_inoutA (inout int res);
res = res + 10;
return res; // must use return with inout
endfunction

// we can send varible as whole to be edited using ref but it must be automatic
function automatic void editor_ref (ref int res);
res = res + 10;
endfunction

// we can access variables defined in the same module as the function
function  int sum_acc ();
return a + b;
endfunction

initial begin
    a=10;
    b=12;
    $display ("Sum method#1= %0d",sum1(a,b));
    $display ("Sum method#1 with default= %0d",sum1(,b));
    $display ("Sum method#2= %0d",sum2(a,b));
    $display ("Incremented Sum = %0d",sum_inc(a,b));
    sum3(a,b,res);
    $display ("Sum method#3= %0d",res);
    $display ("Sum Access= %0d",sum_acc()); 
    $display ("Testing sending inout parameter with static function"); 
    $display ("sent res= %0d recived res= %0d ",res, editor_inout(res));
    $display ("res after function call= %0d",res);

    $display ("Testing sending inout parameter with automatic function"); 
    $display ("sent res= %0d recived res= %0d ",res, editor_inoutA(res));
    $display ("res after function call= %0d",res);

    $display ("Testing sending ref parameter"); 
    $display ("sent res= %0d",res);
    editor_ref(res);
    $display ("res after function call= %0d",res);

end


endmodule