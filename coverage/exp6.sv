// cross coverage & @ 

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

initial    for (int i = 0; i < 200; i++) 
#5 clk = ~clk ;
  

covergroup cg @(posedge clk) ; // here we wont need to manually call saample for any instance
option.per_instance = 1 ; // for detailed analysis
coverpoint a {
 bins a_low = {[0:5]};  
 bins a_mid = {[6:10]};
 bins a_high = {[11:15]};
}
coverpoint b {
 bins b[] = {[0:5]}; // bins for b
}
coverpoint op {
    bins  add = {add};
    bins  sub = {sub};
    //bins  mul = {mul};
    //bins  div = {div};
   
}
coverpoint rstn
{
    //bins rstn_0  = {0}; 
    bins rstn_1  = {1}; 
}

// cross rstn, op, a; // gives all combinations of rstn, op, and a
// binsof -> detemines the bin that you need 
// binsof(a) means all bins of coverpoint a
// binsof (op.add) means only add bin of coverpoint op
// ! binsof (rstn.zero) means not zero bin of coverpoint rstn & all the rest bins
// binsof (b) interset {[2:10]} means all bins that cover the range of 2 to 10
c: cross  rstn, op , b , a
{
    bins c1 = (binsof (op.add) &&  binsof (b) intersect {[2:4]} ) with (a < 5) ; 

    bins c2 = binsof (rstn) with (a == b);
    // c3 : a_low from 0 to 5 , mid from 6 to 10 , high from 11 to 15
    // a_low (6 values) & b[0] : matches 6 tuples : ok
    // a_low (6 values) & b[1] : matches 6 tuples : ok
    // a_low (5 values) & b[2] : matches 5 tuples : out 
    // a_low (4 values) & b[3] : matches 4 tuples : out
    // a_low (3 values) & b[4] : matches 3 tuples : out
    // a_low (2 values) & b[5] : matches 2 tuples : out 
    // a_mid (6 values) & b[0] : matches 6 tuples : ok
    // a_mid (0 values) & b[1] : matches 0 tuples : out
    bins c3 = c with (a + b < 7 ) matches 6; 
    }

endgroup
cg cg_inst = new() ;


initial begin
    
    for (int i = 0; i < 100; i++) begin   
        a  = $urandom ;
        b  = $urandom ;
        op = $urandom ;
        rstn = $urandom; 
        @(posedge clk);
       $display(" Operation is %0s: a = %d, b = %d, , rstn = %b, res = %d",op.name(), a, b, rstn , res);
    end
    
end

endmodule