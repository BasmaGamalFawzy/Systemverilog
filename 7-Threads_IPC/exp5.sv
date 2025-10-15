// mailbox: Basic , put(), get()

class transaction;
randc int dataA , dataB;
randc bit [7:0] dataC;
constraint con_data1 { dataA inside {[0:50]};}
constraint con_data2 { dataB inside {[0:50]};}
constraint con_data3 { dataC inside {[0:50]};}
endclass

class generator;
mailbox mbx;
transaction t;


function new (mailbox mbx);
    this.mbx = mbx;
endfunction

task put_data;   
   mbx.put(t);
   $display("[Generator]: Transaction sent     :as DataA=%2d DataB=%2d DataC=%2h @ %0t", t.dataA, t.dataB, t.dataC, $time);
endtask

task main;
    forever begin
    t =new();
    t.randomize();
    put_data();
    #10ns;
    end
endtask
endclass

class driver;
mailbox mbx; 
transaction t;

function new(mailbox mbx);
 this.mbx = mbx;
endfunction 

task get_data;
    forever begin
    mbx.get(t);
    $display("[Driver]   : Transaction recevied :as DataA=%2d DataB=%2d DataC=%2h @ %0t", t.dataA, t.dataB, t.dataC, $time);
    end
endtask

task main;
 get_data;
endtask

endclass

module tb;
generator gen;
driver drv; 
mailbox mbx;
initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx);
    
    
    fork
        gen.main();
        drv.main();
    join_none
    #100ns $finish;
    end

endmodule
