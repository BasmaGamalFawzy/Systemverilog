// conditional coverage

module adder (input [1:0] a, b,  output [2:0] sum);
assign sum = a + b;
endmodule 

module top ();
logic [1:0] a, b;
logic [2:0] sum;
logic rst ;

initial begin 
    rst = 1'b1;
    #5 rst = 1'b0;
end

adder dut (a, b, sum);  

covergroup cg ;
option.per_instance = 1 ; // for detailed analysis
coverpoint a iff (!rst); // count only if & only if (iff) rst is 0
coverpoint b ;
endgroup

cg c = new();
initial begin
    for (int i = 0; i < 10; i++) begin   
        a = $urandom ;
        b = $urandom ;
        #1;
        $display("Rst=%d, a = %d, b = %d, sum = %d", rst,a, b, sum);
    end
end

endmodule