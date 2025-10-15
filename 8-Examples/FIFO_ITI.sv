
//------------------------------------------------------------------------------------------------------------------------------ 
module FIFO #(parameter depth = 4 , width = 16) (input clk , rst , w , r , [width-1:0] data_in , output reg [width-1:0] data_out);  
parameter MSB = $clog2(depth)-1; 
reg  [width-1:0] stack [depth -1 : 0 ] ;
reg [MSB: 0] r_p = 0 , w_p = 0 ;  
wire full, empty ; 
reg overflow =0;  
integer ocup = 0;   

assign empty = (ocup ==  0)   ? 1'b1 : 1'b0 ; 
assign full  = (ocup == depth)? 1'b1 : 1'b0 ;   

task push () ; begin 
    stack[w_p] = data_in ; 
    ocup = ocup + 1 ;  
  if (w_p==(depth-1)) begin 
    overflow = 1'b1;  
    w_p = 0 ;  end  
  else w_p =  w_p + 1 ; end 
endtask   


task pop ();  begin 
    data_out = stack[r_p] ; 
    ocup = ocup-1 ;  
    if (r_p==(depth-1)) begin  
        r_p = 0 ; overflow =1'b0;  end  
    else r_p = r_p + 1 ;  end 
endtask  

always @(posedge clk ) begin 
    if (rst == 1) begin  
        r_p  = 0 ; 
        w_p  = 0 ; 
        ocup = 0 ; end 
    else if (w==1 & r==0) begin 
        if ((!full && !overflow) || (overflow && (w_p < r_p)) )      
        push ;   end   
    else if (w==0 & r==1) begin  
        if ((!overflow && (r_p < w_p)) || (!empty && overflow) )      
        pop ; end  
    else if (w==1 & r==1) begin   
        if (empty)   data_out = data_in ;    
        else    begin   
        pop; 
        push;    end 
        end 
end 
endmodule 



// FIFO 
module FIFO_tb ;  
parameter depth = 3 , width = 16, Tclk= 10; 
reg clk = 0, rst , w , r ; 
reg [width-1:0] data_in ; 
wire [width-1:0] data_out;  

FIFO #(depth,width) U (clk , rst , w , r , data_in , data_out) ;   

always forever #(Tclk/2) clk= ~clk ;  

initial begin  rst = 1 ;  
#Tclk rst = 0 ;   
// Make stack above full  
w = 1 ; r = 0 ; 
$display ("We Write into 3 depth values buffer: 1 , 2 , 3 , 4 (note 4 will not be stored)"); 
data_in = 16'h00_01 ; 
#Tclk data_in = 16'h00_02 ; 
#Tclk data_in = 16'h00_03 ; 
// add extra value than depth  
#Tclk data_in = 16'h00_04 ; 
// stack has 1 , 2 , 3  
$display ("We read two values buffer: 1 , 2 "); 
w = 0 ; r = 1 ;  
#Tclk $display (" Output =%0d" , data_out); 
#Tclk $display (" Output =%0d" , data_out); 
r = 0 ;  
// stack has 3 
$display ("We Write another 3 values in the buffer: 5 , 6 , 7 (note 7 will not be stored)"); w = 1 ; data_in = 16'h00_05 ; #Tclk data_in = 16'h00_06 ; #Tclk data_in = 16'h00_07 ; w = 0 ; 
// stack has 3 , 5 , 6 
$display ("We Write & read at same time: write 8  & read 3"); 
w = 1 ;  r = 1 ;  
data_in = 16'h00_08 ;  
#Tclk $display (" Output =%0d" , data_out); 
// stack has 5 , 6 , 8  
$display ("We read all: 5 , 6 , 8 "); 
w = 0 ; r = 1 ; #Tclk 
$display (" Output =%0d" , data_out); 
#Tclk $display (" Output =%0d" , data_out); 
#Tclk $display (" Output =%0d" , data_out); 
$stop ; end  
endmodule