// distrbution constraints
// := equal & :/ divide operators


class generator;
 randc bit [3:0] a , b ;

 constraint con_data
  {
    a dist { 0 :=1 , [1:3] := 6 };
    // 0 has 1 , 1 has 6 , 2 has 6 , 3 has 6
    // so propability of 0 is 1/(1+6+6+6) = 1/19
    // so propability of 1,2,3 is 6/(1+6+6+6) = 6/19
    b dist { 0 :/ 1 , [1:3] :/ 6};
   // 0 has 1 , 1 has 6/3 = 2 , 2 has 6/3 = 2 , 3 has 6/3 = 2
   // so propability of 0 is 1/(1+2+2+2) = 1/7
   // so propability of 1,2,3 is 2/(1+2+2+2) = 2/7
  }

  endclass

module tb();
  generator g;
  initial
  begin
    for (int i = 0; i < 10; i++) begin
      g = new();
      if (g.randomize()) 
        $display("A used := has value = %0d, B used :/ has value = %0d", g.a , g.b);
      else 
        $display("Randomization failed");
      
    end
end
endmodule       