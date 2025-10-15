// randomize with constraints
// use inside method for constraint

class generator;
 randc logic [4:0] a , b , c;
 
 constraint con_data { a inside { [0:5] , [10:15] , 20} ;
                       b inside { [2:8] , 12} ;
                       !(c inside {[5:31]}) ;
                       }
// a will have values: 0 1 2 3 4 5 10 11 12 13 14 15 20
// b will have values: 2 3 4 5 6 7 8 12 
// c won't have values: from 5 to 31

 

endclass

module tb();
 generator g = new();

 initial begin 
    for(int i = 0 ; i < 10 ; i++) begin 
        if(g.randomize())
         $display (" A= %0d , B= %0d , C= %0d" , g.a , g.b , g.c);
        else $display("Ranomization is Failed");
    end
 end
endmodule


