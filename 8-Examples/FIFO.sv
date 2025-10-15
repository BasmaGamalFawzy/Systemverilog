interface fifo_if #(size=8) (input logic clk);
 logic rst , wr , rd;
 logic [size-1:0] data_in , data_out;
 logic full, empty;
endinterface
 

module fifo  (fifo_if _if);

parameter int depth = 4;
parameter int size  = 8;
int p_rd =0; 
int p_wr =0;
int count =0;

logic [size-1:0] mem [0: depth-1];

assign _if.full  = (count == depth) ? 1 : 0;
assign _if.empty = (count == 0)     ? 1 : 0;


always @(posedge _if.clk) begin

    if (_if.rst) begin
        p_rd  <= 0;
        p_wr  <= 0;
        count <= 0; end

    else if (_if.wr && !_if.full) begin
        mem[p_wr] <= _if.data_in;
        count <= count + 1; 

        if (p_wr  == depth-1) 
            p_wr = 0;
        else        
            p_wr = p_wr + 1; 
        // incrementing p_wr could have been 
        // p_wr <= (p_wr +1) % depth; 
    end

    else if (_if.rd && !_if.empty) begin
        _if.data_out <= mem[p_rd];
        count = count -1 ; 
       
        if (p_rd == depth-1) 
            p_rd = 0;  
        else        
            p_rd = p_rd + 1; 
        // incrementing p_rd could have been 
        // p_rd <= (p_rd +1) % depth; 
    end         
end 
endmodule


module tb();
logic clk=0;
fifo_if _if(clk);
fifo dut (_if);

task write (int value);
    _if.wr = 1;
    _if.rd = 0;
repeat (value) begin
        $display ("---------Writing ------");
        _if.data_in = $urandom_range(0, 10);
        @(posedge clk) begin
        $display("Writing value: %0d in stack[%0d]", _if.data_in, dut.p_wr-1);
        #1ns $display("After write: Write pointer: %0d, Read pointer: %0d, Count: %0d, Full: %b, Empty: %b", 
         dut.p_wr, dut.p_rd, dut.count, _if.full, _if.empty);
        #1ns $display("Stack[0]: %0d, Stack[1]: %0d, Stack[2]: %0d, Stack[3]: %0d", dut.mem[0], dut.mem[1], dut.mem[2], dut.mem[3]);
         end
        end
endtask 


task read (int value);
    _if.wr = 0;
    _if.rd = 1;
repeat (value) 
        $display ("---------Reading ------");
        @(posedge clk) begin   
        $display("Stack[0]: %0d, Stack[1]: %0d, Stack[2]: %0d, Stack[3]: %0d", dut.mem[0], dut.mem[1], dut.mem[2], dut.mem[3]);
        #1ns $display("Reading value: %0d in stack[%0d]", _if.data_out, dut.p_rd-1);
        $display("After read: Write pointer: %0d, Read pointer: %0d, Count: %0d, Full: %b, Empty: %b", 
        dut.p_wr, dut.p_rd, dut.count, _if.full, _if.empty);
        end
endtask


always forever #10ns clk = ~clk;

initial begin
    _if.rst = 1;
    #20ns _if.rst = 0;
   
    $display ("fill the FIFO with 4 values, then read them back");
    write(4);
      
    
     
    $display ("Read 3 FIFO values");
    read(3);

    
    $display ("Write 4 more FIFO values");
    write(4);

    $display ("Read 1 FIFO values");
    read(1);

     $finish;
     end    


endmodule