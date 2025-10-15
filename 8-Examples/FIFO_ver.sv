parameter int size = 8;
parameter int depth = 4;


interface fifo_if (input logic clk);
 logic rst , wr , rd;
 logic [size-1:0] data_in , data_out;
 logic full, empty;
endinterface
 

module fifo  (fifo_if _if);
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
        p_wr <= (p_wr +1) % depth; 
    end
    else if (_if.rd && !_if.empty) begin
        _if.data_out <= mem[p_rd];
        count = count -1 ; 
        p_rd <= (p_rd +1) % depth; 
    end         
end 
endmodule


class transaction;
rand logic op;
logic wr, rd;
logic [size-1:0] data_in;
logic [size-1:0] data_out;
logic empty, full; 
constraint con_op{ op dist { 0:= 1 , 1:= 1};}

function transaction copy();
    copy = new();
    copy.op = op;
    copy.wr = wr;   
    copy.rd = rd;
    copy.data_in = data_in;
    copy.data_out = data_out;
    copy.empty = empty;
    copy.full = full;
endfunction
endclass


class generator;
transaction t , t_copy;
mailbox #(transaction) gd_mbx;
int count;
event done , next; 

function new(mailbox #(transaction) gd_mbx);
   t = new();
   this.gd_mbx = gd_mbx;
endfunction 

task run;
repeat (count) begin
    assert(t.randomize) else $error("[GEN] : RANDOMIZATION FAILED");
    gd_mbx.put(t.copy);
    $display("[GEN]: Generated Operation: %0b", t.op);   
    @(next);
end 
#1ns-> done; 
endtask;
endclass

class driver;
virtual fifo_if _if;
transaction t; 
event sent; 
mailbox #(transaction) gd_mbx;

function new(virtual fifo_if _if, mailbox #(transaction) gd_mbx);
    this._if = _if;
    this.gd_mbx = gd_mbx;
endfunction

task reset;
$display("[DRV]: Resetting FIFO");
 _if.rst = 1; 
 repeat (10) @(posedge _if.clk) 
 _if.rst = 0; 
@(posedge _if.clk);
$display("[DRV]: Reset Done");
$display("------------------------------------------");
endtask

task read; 
$display("[DRV]: Reading from FIFO");
@(posedge _if.clk);
 _if.rd <= 1;
 _if.wr <= 0; 
 @(posedge _if.clk);
 #1ns;
 if (_if.empty)
    $display("[DRV]: FIFO is empty, cannot read");
  else
    $display("[DRV]: Read Data: %0d", _if.data_out); 
-> sent;
_if.rd <= 0;
@(posedge _if.clk);
endtask 

task write;
$display("[DRV]: Writing to FIFO");
@(posedge _if.clk);
_if.wr <= 1;
_if.rd <= 0; 
if (_if.full) 
$display("[DRV]: FIFO is full, cannot write");
else begin
t.data_in = $urandom_range(0, 50);
_if.data_in <= t.data_in;
$display("[DRV]: Writing Data: %0d", t.data_in);
end
 -> sent; 
 @(posedge _if.clk);
 _if.wr <= 0;
 @(posedge _if.clk);
endtask

task run;
forever begin
    gd_mbx.get(t);
    if      (t.op == 0) write();  
    else if (t.op == 1) read();
end
endtask
endclass

class monitor;
transaction t;
virtual fifo_if _if; 
mailbox #(transaction) ms_mbx;
event sent;

function new(virtual fifo_if _if, mailbox #(transaction) ms_mbx);
    this._if = _if;
    this.ms_mbx = ms_mbx;
    t = new();
endfunction

task run;
forever begin
  @(sent); // wait for driver write/read
  #1ns;
  t.wr = _if.wr;
  t.rd = _if.rd;
  t.data_in = _if.data_in;
  t.empty = _if.empty;
  t.full = _if.full;
  t.data_out = _if.data_out;
  ms_mbx.put(t);
  $display("[MON]:SENT wr = %0b, rd = %0b, data_in = %0d, empty = %0b, full = %0b, data_out = %0d", t.wr, t.rd, t.data_in, t.empty, t.full, t.data_out);
end
endtask
endclass
    

class scoreboard;
transaction t;
mailbox #(transaction) ms_mbx;
event next; 
int err = 0;
logic [size-1:0] mem [$] ;
logic [size-1:0] ref_d ;

function new(mailbox #(transaction) ms_mbx);
    this.ms_mbx = ms_mbx;
endfunction

task run;
forever begin
    ms_mbx.get(t);
    $display("[SCB]: Received wr = %0b, rd = %0b, data_in = %0d, empty = %0b, full = %0b, data_out = %0d", t.wr, t.rd, t.data_in, t.empty, t.full, t.data_out);
    if (t.wr==1) 
        if (!t.full) begin
        mem.push_front(t.data_in);
        $display("[SCB]: Writing Data= %0d in the queue", t.data_in);
        end 
        else $display("[SCB]: Write Operation Failed, FIFO is full");

    else if (t.rd==1) 
        if (!t.empty) begin
        ref_d = mem.pop_back();
            if (ref_d == t.data_out) $display("[SCB]: Read Operation Success -> Data = %0d removed from queue", t.data_out);
            else begin
            err = err + 1; 
            $display("[SCB]:  ERROR -> Read Operation Failed -> Acual Data = %0d, Expected Data = %0d", t.data_out, ref_d); end
        end
        else 
        $display("[SCB]: Read Operation Failed -> FIFO is empty");
    #1ns -> next;    
end    
endtask




endclass

class environment;
generator gen;
driver drv; 
monitor mon;
scoreboard scb; 
virtual fifo_if _if; 
mailbox #(transaction) gd_mbx,  ms_mbx; 
 

function new(virtual fifo_if _if, int count);
    this._if = _if;
    gd_mbx = new();
    ms_mbx = new();
    gen = new(gd_mbx);
    drv = new(_if, gd_mbx);
    mon = new(_if, ms_mbx);
    scb = new(ms_mbx);
    gen.count = count; 
    gen.next = scb.next;
    drv.sent = mon.sent;
endfunction

task pre_test;
$display("[ENV]: Starting Test.......");
drv.reset();
endtask

task test;
fork
    gen.run();
    drv.run();
    mon.run();
    scb.run();
join_none
endtask

task post_test;
@(gen.done);
$display("[ENV]: Test Completed");
$display("[ENV]: Errors = %0d", scb.err);
$finish;    
endtask

task run;
pre_test;
test;
post_test;
endtask

endclass


module tb;
environment env;
int count;
logic clk=0; 

fifo_if _if(clk);

fifo dut (_if);

always #10ns clk = ~clk;

initial begin
    count = 50;
    env = new(_if, count);
    env.run();
end

endmodule
