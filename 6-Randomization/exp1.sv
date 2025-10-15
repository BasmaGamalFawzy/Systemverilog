// randomzation is the basic knowledge for generator to buil comlex sequence of stimuli
// For global signal, testnench top module is the best place to randomize
// For Data & Control signal, the best place to randomize is the generator module
// Generator is a pesudo-random number generator

// Here we use rand to generate a random number

module dut (input logic [3:0] a , b , output logic [3:0] c);
assign c = a + b ;
endmodule

class generator; 
 rand  logic [3:0] a ;
 randc logic [3:0] b;
 // rand generate random values that can be repeated 
 // randc generate unrepeated random values
endclass

module tb;
generator gen =new();
logic [3:0] a , b , c;
dut U (a, b, c); // right way to use class variable in port instantiation

// wrong way to use class variable in port instiantiation
// dut U (gen.a, gen.b, gen.c);
initial begin 
        for (int i = 0; i <= 10 ; i++) begin
        
    // randomize function return 1 if the randomzation is successful 
    // rather than only write gen.randomize(), we use the function return 
    // to check if the randomization is successful
    // this is a good practice but not necessary
        if (gen.randomize())
            $display("Randomization successful");
        else $display("Randomization failed");
        a = gen.a;
        b = gen.b;
        #10ns $display("a = %0d, b = %0d , Results= %0d", a, b , c);
        
    end
end    


endmodule