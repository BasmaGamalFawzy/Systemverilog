// 3 , 2 , 6 , 7 -> 1 
typedef enum bit [1:0] {s0 , s1 , s2 , s3} state ;
module fsm (input logic [2:0] x, input logic clk , rstn , output logic f);
state pr , nxt ;

always @(*)
    case (pr)
        s0 : begin
             f = 0 ;
             if (x==3) nxt = s1 ;
             else nxt = s0 ; end
        s1 : begin
             f = 0 ;
             if (x==2) nxt =s2 ;
             else if (x==3) nxt = s1 ;
             else nxt = s0 ; end
        s2 : begin
             f = 0 ;
             if (x==6) nxt =s3 ;
             else if (x==3) nxt = s1 ;
             else nxt = s0 ; end
        s3 : begin
             if (x==7) begin nxt =s0 ; f=1 ; end
             else if (x==3) begin nxt = s1 ; f=0 ; end
             else begin nxt = s0 ; f=0 ; end end
             
    endcase

always @(posedge clk) begin
    if (!rstn) begin
        pr <= s0 ;
    end
    else begin
        pr <= nxt ;
    end
end

endmodule 
module top ();
  logic [2:0] x ;
  logic clk =0 ;
  logic rstn = 0 ;
  logic f ;
  fsm dut (x, clk, rstn, f);  

initial    for (int i = 0; i < 20; i++) 
#5 clk = ~clk ;
  
covergroup cg  @(posedge clk) ; // only when rstn is 1
    option.per_instance = 1 ; // for detailed analysis
    coverpoint dut.pr iff (rstn) {
        bins s0 = {s0};
        bins s1 = {s1};
        bins s2 = {s2};
        bins s3 = {s3};
    }
    coverpoint x iff (rstn) {
        bins x[] = {[0:7]}; 
        ignore_bins x_ignore = {0,1,4,5}; // ignore these values
    }
    coverpoint f iff (rstn) {
        bins f0 = {0};
        bins f1 = {1};
    }
endgroup 



cg cg_inst = new() ;


initial begin
    @(negedge clk) 
    rstn = 1 ;     
    x    = 3 ;
    #1;
    $display(" Current state is %0s Next state is %0s: X = %d, F = %d", dut.pr.name(),dut.nxt.name(), x, f);
    @(negedge clk)
    x    = 2 ;
    #1;
    $display(" Current state is %0s Next state is %0s: X = %d, F = %d", dut.pr.name(),dut.nxt.name(), x, f);
    @(negedge clk)
    x    = 6 ;
    #1;
    $display(" Current state is %0s Next state is %0s: X = %d, F = %d", dut.pr.name(),dut.nxt.name(), x, f);
    @(negedge clk)
    x    = 7 ;
    #1;
    $display(" Current state is %0s Next state is %0s: X = %d, F = %d", dut.pr.name(),dut.nxt.name(), x, f);
end
endmodule