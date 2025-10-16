// bin filtering
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

covergroup cg ;
option.per_instance = 1 ; // for detailed analysis
// create bins filter using with & {} 
coverpoint a {
    bins a_even[]   = a with ((item > 0) && (item %2 == 0)) ; // create bins for each even value
    bins a_odd      = a with ((item > 0) && (item %2 == 1)) ; // create one bin for all odd values
    bins a_zero     = a with (item == 0) ;
    bins a_custom[] = {[2:6]} with (item %2 != 1) ; // create bins for 2,4,6
}
// use illegal bins 
coverpoint b {
    bins b_valid []= {[0:12]} ;
    illegal_bins b_invalid[] = {5, 6 , 11} ; // this will give error when b is 5 or 6 & exclude their occurance from coverage
    // all the unused value, will be put in the default bin and counted without details
    bins b_unused = default ; 
} 
// use ignore bins 
coverpoint c {
    bins c_ok[]   = {[0:7]}  ; 
    ignore_bins c_unused[]  = {2 , 5}  ; // won't add bins 2 & 5 to the coverage
}
// use wild cards
coverpoint d {
    wildcard bins d_bx0[] = {4'b000?} ; // return 0 , 1 
    wildcard bins d_bx1[] = {4'b001?} ; // return 2 , 3
    wildcard bins d_bx2[] = {4'b01??} ; // return 4, 5, 6, 7
    wildcard bins d_bx3[] = {4'b1???} ; // return 8, 9, 10, 11, 12, 13, 14, 15
    // to capture  Z you must specify it
    // x == don't care == ? but X is unknown
    // if I used ignore_bins some of d_b0x would be common in both ignore & not ignor so d_b0x will be empty and remve it all 
    wildcard bins d_X = {4'bX??? , 4'b?X?? , 4'b??X? , 4'b???X} ; 
    wildcard bins d_Z = {4'bZ??? , 4'b?Z?? , 4'b??Z? , 4'b???Z} ;
}
endgroup
cg my_cg = new();
initial begin
    for (int i = 0; i < 10; i++) begin   
        a  = $urandom ;
        b  = $urandom ;
        c  = $urandom ;
        d  = $urandom ;
        op = $urandom ;
        #1;
      $display(" Operation:%0s: a = %d, b = %d, c = %d, d = %d, res = %d",op.name(), a, b, c, d , res);
        my_cg.sample();
    end
end

endmodule