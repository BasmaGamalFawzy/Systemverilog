// initial , final
// always, always_comb, always_latch, always_ff

module tb();

logic [3:0] a , b , c; 
logic

// initial block groups statements together and executes them once at the start of the simulation.
initial begin
    $display("Inital Block Message: Simulation started at time %0t", $time);
    #100ns $finish; // End the simulation
end 

// final procedure executes when simulation ends due to an explicit or implicit call to $finish.
final begin
    $display("Finial Block Massage:Simulation finished at time %0t", $time);
end 

// General purpose always procedure groups statements together execute them repeatedly.
always begin
    #10ns $display("This message is displayed every 10 nanoseconds Time NOW=%0t", $time);
end 

// always@() excutes whenever there is a change in its sensitivity list.
// always@* is a safer way to write combinational logic
// as it automatically infers the sensitivity list based on the signals used within the block.

always @* begin
    // This block will execute on every positive edge of the clock signal.
    $display("Clock edge detected at time %0t", $time);
end

// always_comb block is used to modal combinational logic. 
always_comb begin 
c = a + b; 
end

//always_latch block is used to model latch behavior.
always_latch begin
    if (a == 1'b1) begin
        c = b; // If a is high, assign b to c
    end else begin
        c = 4'b0000; // Otherwise, assign c to zero
    end
end

// always_ff block is used to model sequential logic.
// The always_ff block is used for modeling flip-flops and other sequential elements.
always_ff @(posedge a) begin
    c <= b; // On the positive edge of a, assign b to c
end

endmodule