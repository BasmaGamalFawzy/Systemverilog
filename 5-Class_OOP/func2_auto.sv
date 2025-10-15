// functions by default automatic 
// automatic variable is recreated at each call the deleted
// static varible is created only once and keep its value betwwen calls
module func();

//static funcation parameters

function int f_static ();
int a; // a is static
// a is locally defined even it is static you can't access it outside
a = a+1;
return a;
endfunction

function int f_dynamic ();
automatic int b;
b = b+1;
return b;
endfunction


initial 
begin
    for (int i=1 ; i<10 ; i++) begin
        $display("a=%0d b=%0d",f_static(),f_dynamic());
    end
end



endmodule