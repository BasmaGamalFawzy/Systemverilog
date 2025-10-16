// covergroup name (ref variables, input argus) @(sampling event)
// covergroup name (ref variables, input args) with sample function (input args)

typedef enum bit [1:0] {add , sub , mul , div} op_code ;
module alu (input logic [3:0] a, b, input logic clk , rstn , input op_code op ,  output logic [6:0] res);
always @(posedge clk) begin
    if (!rstn) begin
        res = 0;
    end else begin
    case(op)
        add : res = a + b ;
        sub : res = a - b ;
        mul : res = a * b ;
        div : res = a / b ; 
    endcase
end
end
endmodule 
module top ();
  logic [3:0] a, b ;
  logic clk =0 ;
  logic rstn = 1 ;
  logic [6:0] res;
  op_code op ;
  alu dut (a, b, clk, rstn, op , res);  

initial    for (int i = 0; i < 20; i++) 
#5 clk = ~clk ;
  

covergroup cg (ref [3:0] a , b) with function sample  ( op_code op,  logic rstn); 
option.per_instance = 1 ; 
coverpoint a {
 bins a[] = {[0:15]}; // bins for a
}
coverpoint b {
 bins b[] = {[0:15]}; // bins for b
}
coverpoint op {
 bins op[] = {add, sub, mul, div};
}
coverpoint rstn
{
 bins rstn[] = {0, 1}; // bins for reset signal
}

cross rstn, op, a; 
cross rstn, op, b;
endgroup
cg cg_inst = new(a, b); 


initial begin
    
    for (int i = 0; i < 10; i++) begin   
        a  = $urandom ;
        b  = $urandom ;
        op = $urandom ;
        rstn = $urandom; 
        @(posedge clk);
       $display(" Operation is %0s: a = %d, b = %d, , rstn = %b, res = %d",op.name(), a, b, rstn , res);
        cg_inst.sample(op, rstn); // now we can pass argument when we call sample rather than at new 
    end
    
end

endmodule