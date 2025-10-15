// Randomization operators 
// Implication, Equivalence , and if/else 


class generator;
 randc bit en , rst ;
 randc bit wr , oe; 
 randc bit [3:0] a , b;

 constraint con_en  { en dist {0:=10 , 1:=90} ;}
 constraint con_rst {rst dist {0:=90 , 1:=10} ;}
 // constraint with Implication
 constraint con_en_rst { (en == 1) -> (rst == 0) ;}
 // means if en is 1 then rst must be 0 
 // if en is 0 then rst can be 0 or 1


 // constraint with Equivalence
 constraint con_wr_oe { (wr == 1) <-> (oe == 0) ;}
 // means if wr is 1 then oe must be 0
 // if oe is 0 then wr must be 1 
 // goes both ways


 // constraint with if/else
    constraint con_a_b { 
        if (a == 0)  b == 1;
        else if (a == 1)  
        {b > 2;
         b < 6; }
        else if (a == 2) 
        { b inside {[10:15] , 7};
          b dist {7 := 1 , [10:15] := 5}; }
        else if (a == 4) b == 4;
        else if (a == 5) b == 5;
        else b == 9; // for a = 5
    }

 
endclass


module tb ();
 generator g;
    initial begin
    $display("Randomization with Implication");
    for (int i = 0; i < 10; i++) begin
        g = new();
        if (g.randomize()) 
        $display("En= %0d, Rst= %0d", g.en , g.rst);
        else 
        $display("Randomization failed");
    end

    $display("Randomization with Equivalence ");
    for (int i = 0; i < 10; i++) begin
        g = new();
        if (g.randomize()) 
        $display("WR= %0d, OE= %0d", g.wr , g.oe);
        else 
        $display("Randomization failed");
    end 
    $display("Randomization with if/else");
    for (int i = 0; i < 10; i++) begin
        g = new();
        if (g.randomize()) 
        $display("A= %0d, B= %0d", g.a , g.b);
        else 
        $display("Randomization failed");
    end
    end
endmodule



