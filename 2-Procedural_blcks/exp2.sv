// inital & always procedural blocks can group statments with two methods 
// 1-Sequential block, also called begin-end block
// 2-Parallel block, also called fork-join block

module tb();
int data1 ,data2;
event done;
// generator block
task generator;
    for(int i = 0; i < 10; i++) begin
        #10ns ;
        data1 = $urandom_range(0, 100);
        $display("Generator:data sent = %0d", data1);
        
    end
    -> done;
endtask
 
task driver;
forever begin // statements from that begin to it's end are executed sequentially
@(data1) begin
    data2 = data1 ;
    $display("Driver: data received = %0d", data2);
end
end
endtask


task finish_all;
    wait(done.triggered);
    $display("Finish: All data received");
    $finish;
endtask

initial begin
    // Sequential block
    fork
    generator();
    driver();
    finish_all();
    join
end
endmodule