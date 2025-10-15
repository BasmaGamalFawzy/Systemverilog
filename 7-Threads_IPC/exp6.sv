// The only difference between a generic (dynamic) mailbox and a parameterized mailbox is that for a
// parameterized mailbox, the compiler verifies that the calls to put, try_put, peek, try_peek, get, and
// try_get methods use argument types equivalent to the mailbox type so that all type mismatches are caught
// by the compiler and not at run time.

// Parameterized mailbox

class transaction;
randc int dataA , dataB;
randc bit [7:0] dataC;
constraint con_data1 { dataA inside {[0:50]};}
constraint con_data2 { dataB inside {[0:50]};}
constraint con_data3 { dataC inside {[0:50]};}
endclass

class generator;
mailbox #(transaction) mbx;
transaction t;


function new (mailbox #(transaction) mbx);
    this.mbx = mbx;
endfunction

task put_data;   
   mbx.put(t);
   $display("[Generator]: Transaction sent     :as DataA=%2d DataB=%2d DataC=%2h @ %0t", t.dataA, t.dataB, t.dataC, $time);
endtask

task run;
    forever begin
    t =new();
    t.randomize();
    put_data();
    #10ns;
    end
endtask
endclass

class driver;
mailbox #(transaction) mbx; 
transaction t;

function new(mailbox #(transaction) mbx);
 this.mbx = mbx;
endfunction 

task get_data;
    forever begin
    mbx.get(t);
    $display("[Driver]   : Transaction recevied :as DataA=%2d DataB=%2d DataC=%2h @ %0t", t.dataA, t.dataB, t.dataC, $time);
    end
endtask

task run;
 get_data;
endtask

endclass

module tb;
generator gen;
driver drv; 
mailbox #(transaction) mbx;
initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);
    
    
    fork
        gen.run();
        drv.run();
    join_none
    #100ns $finish;
    end

endmodule
