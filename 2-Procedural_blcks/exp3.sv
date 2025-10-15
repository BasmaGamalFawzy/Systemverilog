// fork/join, fork/join_any, fork/join_none Example

module tb();

task first;
 $display("First task Started at %0t", $time);
 #20ns $display("First task Completed at %0t", $time);
endtask

task second;
 $display("Second task Started at %0t", $time);
 #30ns $display("Second task Completed at %0t", $time);
endtask   

task third;
 $display("Third task Started at %0t", $time);
endtask


initial begin
// join: waits for all the statements to complete before exiting the fork block
    $display("Normal fork/join Example at %0t", $time);
    fork
    first;
    second;
    join
    third;

// join_any : waits until any of the statements ends to exit the fork block & other statements continue to run in the background
    $display("fork/Join_any Example at %0t", $time);
    fork
    first;
    second;
    join_any
    third;
    
// join_none: allows the statements to run parallel in the background without waiting for any to exit the fork
    $display("fork/Join_none Example at %0t", $time);
    fork
    first;
    second;
    join_none
    third;
   #50ns $finish;
end


endmodule