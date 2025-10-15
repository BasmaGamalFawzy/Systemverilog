// extern constraints

class generator;
 randc logic [3:0] a , b , c;

 // here we have semicolon after constraint declaration
 extern constraint con_data ; 
endclass

// here we can't use c for a or b if there is constrain on C 
// gives run time error by constraints solver
constraint generator::con_data 
{ a inside {[0:5] , [10:15] , 20} ;
  !(b inside {[4:6]}) ;
  c == a + b ;
}

module tb();
generator g ;

initial begin
    for (int i = 0 ; i < 10 ; i++) begin
        g = new();
        if (g.randomize())
          $display(" A= %0d , B= %0d , C= %0d" , g.a , g.b , g.c);
        else
          $display("Randomization is Failed");  
    end
    end

endmodule
