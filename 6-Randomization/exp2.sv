// randomize with constraints
// no semicolon after constraint declaration
// after any condition, there must be a semicolon
// we use curly braces to define constraints


class generator;
 randc logic [3:0] a , b ;

 // this is a way to combine the constraints
 constraint con_data { a < 12 ;  a > 2 ; b == 3;} 

 // this is a better way to do each member's constraint sepeartely 
constraint con_a { a < 12 ; a > 2;}
constraint con_b { b == 3;}
endclass


module tb();
generator g = new();

initial begin
    for (int i = 0 ; i < 10 ; i++) begin
    if(g.randomize())
    $display("a = %0d, b = %0d", g.a, g.b);  
    else
    $display(" Randomization Failed");
    end

end

endmodule