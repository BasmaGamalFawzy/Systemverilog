// post randomization function
// pre randomization function

class generator;
randc bit [3:0] a , b , c ;
int min , max ;

// this wrong as pre & post randomization can't take arguments
// LRM & VCS, Cadence , Questa the same
// However, aldec riviera-pro the only simulator that allows this

/*function void pre_randomize( input int min , input int max);
 this.min=min;
 this.max=max;
endfunction */

function void pre_randomize();
  $display("pre_randomize called");
endfunction

function void post_randomize();
 $display ("A= %0d, B=%0d, C=%0d", a, b, c);
endfunction 

function void edges(input int min, input int max);
  this.min = min;
  this.max = max;
endfunction

constraint con_data 
  { a inside {[min:max]};
    b inside {[min:max]};
    c == a + b;
  }

endclass


module tb();
generator g;
initial begin
for (int i =0; i <10 ; i++) begin
    g = new();
    // LRM says that pre_randomize can't take arguments
    //g.pre_randomize(0, 15);
    g.edges(0, 15);
    g.randomize();
end
end

endmodule
