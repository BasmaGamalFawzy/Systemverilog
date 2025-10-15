// interface: basics


// we use interface to group signal together 
// interface act as class

// clk is external signal that is compatable with the interface and can be used inside it
// clk shall be passed to the interface in the top testbench module
// declare signals internal to an interface if you want each instance of that interface to have a different values for each instance. 
// declare signals as ports of an interface if you wanted to share that signals value across other instances (same interface or different interfaces or modules). 
// shared clock would be a good candidate for this.
// making the clock external, the interface can be used with different clock signals or even with modules that don't require a clock

// paramertized interface with width=8

interface cir_if #(width=8) (input logic clk);
    logic [width-1:0] a , b , c;
endinterface

module cir (cir_if cif);
always_ff @(posedge cif.clk) begin
    cif.c <= cif.a + cif.b; 
end
endmodule

module tb();

logic clk=0;

// () is a must for interface 
// cir_if tif(); 


// we need to pass the clock to the interface
// cir_if tif(clk);


// for changing the parameters use the follwing defination
cir_if #(.width(4)) tif(clk) ;

// positional association dut's interface then tb's interface
cir U (.cif(tif));

initial forever #5ns clk = ~clk; 

initial begin 
    
    for (int i = 0; i < 10; i++) begin
        tif.b = i;
        tif.a = i + 1;
        @(posedge clk); // wait for the clock edge
        #1ns $display("a = %0d, b = %0d, c = %0d", tif.a, tif.b, tif.c);
    end
    $finish; // end simulation
end


endmodule
