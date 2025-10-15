// Keywords used: this, super, local
// randcase
// ransequence Not yet


class parent;
  randc bit [3:0] a, b;
  function new();
  a = 10 ; 
  endfunction
endclass

class generator extends parent;
  randc bit [3:0] c, d;
endclass

module tb();
generator g ; 
bit [3:0] a , b , c , d ;

initial begin
   for (int i = 1; i < 10; i++) begin
      a = i ; b = i + 1; c = i + 2; d = i + 3;
      g = new();
      g.randomize() with  { a <  local::a;
                            b == local::b;
                            c == super.a ; // super.a == a of the class
                            d >  local::d; } ;

// The randomize() with constraint block can reference both class properties and variables local to the method call. 
// Names are resolved by searching first in the scope of the randomize() with object class followed by 
// a search of the scope containing the method call—the local scope. 
// The local:: qualifier modifies the resolution search order. 
// When applied to an identifier within an inline constraint, 
// the local:: qualifier bypasses the scope of the [randomize() with object] class 
// and resolves the identifier in the local scope.

// without binding, names are resolved by searching first in the scope of the randomize() with object class followed by a search of the scope containing the method call—the local scope.
// Names qualified only by this or super shall bind to the class of the object handle used in the randomize() with method call.
// 
     $display("a: %0d, b: %0d, c: %0d, d: %0d", g.a, g.b, g.c, g.d);
      
      end

    $display(" randcase example:");
    
    for (int i = 1; i < 10; i++) begin
      g.randomize();
      $display(" randcase With weights");
      randcase
        5: g.randomize() with { a == i;};
        2: g.randomize() with { b == i;};
        1: g.randomize() with { c == i;};
        0: g.randomize() with { d == i;};
        // first case has probability 5/8, second case has probability 2/8, third case has probability 1/8, fourth case has probability 0
      endcase
      $display("a: %0d, b: %0d, c: %0d, d: %0d", g.a, g.b, g.c, g.d); 
      $display(" randcase with expression weights");
      randcase
        (i <= 5 ? 5:1 ): g.randomize() with { a == i;}; 
        (i >  8 ? 2:0 ): g.randomize() with { b == i;};
      endcase
      $display("a: %0d, b: %0d, c: %0d, d: %0d", g.a, g.b, g.c, g.d);
   end
end


endmodule
 

