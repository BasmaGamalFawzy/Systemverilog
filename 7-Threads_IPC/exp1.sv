// Events used for communication between concurrent active processes 
// -> trigger event blocking 
// ->> trigger event non-blocking
// @() wait for edge event blocking & trigger must happen in following time step
// wait(name.triggered) wait for level event non blocking the trigger can happen at same time step
// name.triggered : triggere is a method that returns 1 when the name has changed its value
module tb();
// Declare an event
event e;

initial begin
    #10ns ->  e;
    #10ns ->  e; // blocking trigger
    #10ns ->> e; // non-blocking trigger
end

initial begin
    // blocking wait for event e to be triggered
    @(e); // Wait here until an event in e be triggered
    $display("Thread1 @():Event e triggered #1 at time %0t", $time);
    #10ns @(e);
    $display("Thread1 @():Event e triggered #2 at time %0t", $time);
    #10ns @(e);
    $display("Thread1 @():Event e triggered #3 at time %0t", $time);
end
initial begin
    // non-blocking wait for event e to be triggered
    wait(e.triggered); 
    $display("Thread2: Event e1 triggered #1 at time %0t", $time); 
    #10ns wait(e.triggered);
    $display("Thread2: Event e1 triggered #2 at time %0t", $time); 
    #10ns wait(e.triggered);
    $display("Thread2: Event e1 triggered #3 at time %0t", $time); 
       
end

endmodule