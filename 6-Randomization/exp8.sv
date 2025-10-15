// turn on/off randomization two ways
// 1- rand.mode
// 2- passing who to randomize using randomize() function
// turn on/off constraints 

class generator;
 randc bit [4:0] a, b, c;
 bit [4:0] u, v ;

 constraint con_a { a inside {[0:10] , 13}; }
 constraint con_b { b dist {[0:15] :/100};}
 constraint con_c { c == a; }
 endclass

 module tb;
 generator g; 

 initial begin 
    $display("Randomize a , b, c but u & v are constants");
    for(int i = 0; i < 10; i++) begin
        g = new();
        g.randomize();
        $display("a = %2d, b = %2d, c = %2d , u = %2d, v = %2d", g.a, g.b, g.c , g.u, g.v);
    end

    $display("Randomize a , b, c but Turn off C = A constraint");
    for(int i = 0; i < 10; i++) begin
        g= new();
        g.con_c.constraint_mode(0); // turn off constraint
        g.randomize();
        $display("a = %2d, b = %2d, c = %2d , u = %2d, v = %2d", g.a, g.b, g.c , g.u, g.v);
    end

    $display("Randomize a , c, u but b , v are constants using randomize()");
    for(int i = 0; i < 10; i++) begin
        g= new(); // this reinstate the constrains & initialize the variables
        // g.randomize(a , u);
        // that is equivlant to 
        // g.a.rand_mode(1);
        // g.u.rand_mode(1);
        // g.b.rand_mode(0);
        // g.c.rand_mode(1);
        // g.v.rand_mode(0);
        g.con_c.constraint_mode(0); // turn off c constraint
        g.randomize(a , u) with { u inside {[0:10] , 13}; };  // inline constraints
       // this gonna fail as c == a & c must be zero but a is random from 6:10 and 13
       // here we can edit a range to be inside {[0:10] , 13} but a will remain zero
       // or we can turn off c constraint
       // or we can make c also randomized
        $display("a = %2d, b = %2d, c = %2d , u = %2d, v = %2d", g.a, g.b, g.c , g.u, g.v);
    end

    $display("Randomize u , v but a , b , c are constants using rand_mode() & inline randomize()");
    for(int i = 0; i < 10; i++) begin
        g= new();
        g.a.rand_mode(0); // gonna fail if a has no zero in its range inside the constraint
        g.b.rand_mode(0);
        g.c.rand_mode(0);
       // we can't use rand_mode with u & v as they are constants
       //g.u.rand_mode(1);
       //g.v.rand_mode(1);
       // we use $urandom_range() to randomize u & v
        g.u = $urandom_range(0, 15);
        g.v = $urandom_range(0, 15);
        g.randomize();
        $display("a = %2d, b = %2d, c = %2d , u = %2d, v = %2d", g.a, g.b, g.c , g.u, g.v);
        
    end
 end

 endmodule