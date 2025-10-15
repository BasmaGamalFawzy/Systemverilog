// mailbox: Basic , put(), get()
class generator;
mailbox mbx;
randc int data;
constraint con_data { data inside {[0:50]};}

task put_data;   
   mbx.put(data);
   $display("Generator: send data: %0d @ %0t", data, $time);
endtask

endclass

class driver;
mailbox mbx; 
int data;

task get_data();
    mbx.get(data);
    $display("Driver: received data: %0d @ %0t", data, $time);
endtask

endclass

module tb;
generator gen;
driver drv; 
mailbox mbx;
initial begin
    gen = new();
    drv = new();
    mbx = new();
    gen.mbx = mbx;  
    drv.mbx = mbx;
    repeat (10) begin
       gen.randomize(); 
    fork
        gen.put_data();
        drv.get_data();
    join
    end
end
endmodule
