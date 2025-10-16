// creating bins 
typedef enum bit [1:0] {add , sub , mul , div} op_code ;
module alu (input logic [3:0] a, b, c , input op_code op ,  output logic [6:0] res);
always @(*) begin
    case(op)
        add : res = a + b + c ;
        sub : res = a - b - c ;
        mul : res = a * b;
        div : res = a / b ; 
    endcase
end
endmodule 
module top ();
  logic [3:0] a, b , c;
  logic [6:0] res;
  op_code op ;
  alu dut (a, b, c, op , res);  

covergroup cg ;
option.per_instance = 1 ; // for detailed analysis
// create bins with combined values
coverpoint a {
    bins zero = {0} ; // track 0
    bins low  = {1,2,3} ; // track 1,2,3
    bins mid  = {[4:9]} ; // track 4,5,6,7,8,9 
    bins high = {10 , [11:15]} ; // track 10,11,12,13,14,15
} // no semicolon after {}
// we create for each value a bin
coverpoint b {
    bins b0 = {0} ;
    bins b1 = {1} ;
    bins b2 = {2} ;
    bins b3 = {3} ;
    // all the unused value, will be put in the default bin and counted without details
    bins b_unused = default ; 
} 
// we create array the most used method 
coverpoint c {
    // not specifying the array size create bins according to the number of values
    bins c_low[]   = {[0:3]}  ; // create bins for 0,1,2,3 -> c[0], c[1], c[2], c[3]
    bins c_mid[4]  = {[4:7]}  ; // create only 4 bins for 4,5,6,7 -> c[0], c[1], c[2], c[3]
    bins c_high[4] = {[8:15]} ; // create only 4 bins for 8 values so each bin covers 2 values
}
endgroup
cg my_cg = new();
initial begin
    for (int i = 0; i < 10; i++) begin   
        a  = $urandom ;
        b  = $urandom ;
        c  = $urandom ;
        op = $urandom ;
        #1;
      $display(" Operation:%0s: a = %d, b = %d, c = %d, res = %d",op.name(), a, b, c , res);
        my_cg.sample();
    end
end

endmodule