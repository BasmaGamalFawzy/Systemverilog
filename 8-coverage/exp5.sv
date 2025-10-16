// reusable class-like coverage group
// coverage group accepts only ref variables which it wll be tracked
// & input which will be consumed by coverpoint but no out or inout
typedef enum bit [1:0] {add , sub , mul , div} op_code ;
module alu (input logic [3:0] a, b, c , d , input op_code op ,  output logic [6:0] res);
always @(*) begin
    case(op)
        add : res = a + b + c + d;
        sub : res = a - b - c ;
        mul : res = a * b;
        div : res = a / b ; 
    endcase
end
endmodule 
module top ();
  logic [3:0] a, b , c , d;
  logic [6:0] res;
  op_code op ;
  alu dut (a, b, c, d, op , res);  

covergroup cg (ref [3:0] x, input string cp_id , input int low , mid , high) ;
option.per_instance = 1 ; // for detailed analysis
option.name = cp_id ; // set name of the covergroup
coverpoint x {
    bins low[]  = {[0:low-1]} ;
    bins mid[]  = {[low:mid-1]} ;
    bins high[] = {[mid:high]} ;    
}
endgroup
cg cg_a = new(a,  " a" , 5 , 10 , 15) ;
cg cg_b = new(b,  " b" , 5 , 10 , 15) ;
cg cg_c = new(c,  " c" , 5 , 10 , 15) ;
cg cg_d = new(d,  " d" , 5 , 10 , 15) ;
initial begin
    for (int i = 0; i < 10; i++) begin   
        a  = $urandom ;
        b  = $urandom ;
        c  = $urandom ;
        d  = $urandom ;
        op = $urandom ;
        #1;
      $display(" Operation:%0s: a = %d, b = %d, c = %d, d = %d, res = %d",op.name(), a, b, c, d , res);
        cg_a.sample();
        cg_b.sample();
        cg_c.sample();
        cg_d.sample();
    end
end

endmodule