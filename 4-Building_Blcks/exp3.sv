//interface: virtual interface inside class

interface data_if (input logic clk);
logic [7:0] a;
endinterface

class bus;
 rand logic [7:0] data;
 constraint con_data { data inside {[0:50] , 60};}

 function bus copy ();
    bus my_bus = new();
    my_bus.data = data;
    return my_bus;
 endfunction

endclass

class transaction;

// using interface in class: we must use virtual interface
// NO () in interface declaration inside class
bus my_bus; 
virtual data_if _if; 

// constructor
function new (virtual data_if _if);
    my_bus = new();
    this._if = _if;
endfunction

// copy function
function transaction copy ();
    transaction t = new(_if);
    t.my_bus = my_bus.copy();
    // not needed as interface is shared resource
    // t._if = _if; 
    return t;
endfunction    

task run;
my_bus.randomize();
_if.a = my_bus.data + 1;
endtask



endclass 

module tb;

logic clk =0; 
data_if _if(clk); // virtual interface

transaction t1 = new(_if);
transaction t2;

initial forever #5 clk = ~clk; // clock generation

initial begin
    repeat (10) begin
    t1.run();
    t2 = t1.copy();
    $display("Transaction 1: data = %0d, a = %0d", t1.my_bus.data, t1._if.a);
    $display("Transaction 2: data = %0d, a = %0d", t2.my_bus.data,t2._if.a);
    t2.my_bus.data = 10; // change the copy
    t2._if.a = 10; 
    $display("After changing Transaction 2: data = %0d, a = %0d", t2.my_bus.data, t1._if.a);
    $display("Transaction 1 after change in Transaction 2: data = %0d, a = %0d", t1.my_bus.data, t2._if.a);
    end
    $finish;
end 

endmodule






