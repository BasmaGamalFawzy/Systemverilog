module adder (input [1:0] a, b, output [2:0] sum);
assign sum = a + b;
endmodule

module top ();
  logic [1:0] a, b;
  logic [2:0] sum;
adder dut (a, b, sum);
// we won't create bins so the simulator will create them automatically
// by default each coverpoint's value will have a bin up to 64 bins
// or we can say that the coverpoint is 6 bits long : 64 = 2^6
covergroup cg_in ;
  option.per_instance = 1 ; // for detailed analysis 
  option.name = "COVERAGE A&B"; // set name for the covergroup
  option.goal = 55 ; // this set the coverage goal for the covergroup instance : cg1
  type_option.goal = 60 ; // this set the coverage goal for the covergroup type: cg_in
  option.at_least = 3; // each bin need to he hit at least 3 times
  option.auto_bin_max = 2; // divide the coverpoint value to be only two bins 
    cp_a: coverpoint a {
    option.weight = 3 ; // edit a weight
    option.goal = 60 ;  // edit a goal
  }
cp_b: coverpoint b ;
endgroup

//covergroup cg_out @(sum);
//coverpoint a ;   
//coverpoint b; 
//endgroup

cg_in  cg1 = new();
//cg_out cg2 = new();
initial begin 
  for (int i = 0; i < 10; i = i + 1) begin
        a = $urandom ;
        b = $urandom;
        #10;
        $display("a = %0d, b = %0d, sum = %0d", a, b, sum);
        cg1.sample(); 
    end
    
end

endmodule