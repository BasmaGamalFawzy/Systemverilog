// event_order
// merage events


module tb();

event e1, e2 ,e3 ;

initial begin
    #10ns ->  e1; 
    #10ns ->  e2; 
    #10ns ->  e3; 
    e1 = e2 ; // merge e1 and e2 
    #10ns -> e1; // e1 & e2 both triggered
    #10ns -> e2; // e3 triggered
    $finish;
end

// wait_order not yet implemented in Cadence Xcelium & Questasim
/*
initial begin
    wait_order(e1, e2, e3) 
    $display(": Event sequence e1 -> e2 -> e3 is triggered at time %0t", $time); 
    else $display("Thread2: Event sequence FAILED at time %0t", $time);
end
*/
always begin
    wait (e1.triggered);
    $display("e1 triggered at time %0t", $time);
end

always begin
    wait (e2.triggered);
    $display("e2 triggered at time %0t", $time);
end

endmodule