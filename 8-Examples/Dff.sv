// interface
// non-blocking assignment in sequential logic
// always_ff
 //////////////////////////////////////////////////////////////
module dff (dff_iff _if);
// Sequential logic (FFs) use <= (non-blocking)	To model simultaneous updates at clock edges
always_ff @(posedge _if.clk) begin
if  (_if.rst) _if.data_out <= 1'b0;
else          _if.data_out <= _if.data_in;
end    
endmodule 


/////////////////////////////////////////////////////////////////////////////
// transaction is a high-level pins abstraction that foucs on functionality 
// and leaves out control signal as clk & rst 
// transaction is meant for the generator  
class transaction;
  rand logic data_in; // inputs preferably random
  logic      data_out;

  constraint con_data_in {data_in dist { 0:= 1 , 1:= 1};}

  function transaction copy();
    copy = new();
    copy.data_in  = data_in;
    copy.data_out = data_out;
  endfunction
endclass

//////////////////////////////////////////////////////////////////////////////
class generator;
transaction t;
mailbox #(transaction) gd_mbx, gs_mbx;
event done, next_scb;
int count;

// here we create a transaction handler & bind the mailbox with our mailbox
function new(mailbox #(transaction) gd_mbx, gs_mbx);
t = new();
this.gd_mbx  = gd_mbx;
this.gs_mbx  = gs_mbx;
endfunction


task run;
repeat(count) begin
    assert(t.randomize) else $error("[GEN] : RANDOMIZATION FAILED");
    $display("[GEN]: data_in = %0d", t.data_in);
    gd_mbx.put(t.copy);
    gs_mbx.put(t.copy);
    wait(next_scb.triggered); // wait for the scoreboard to finish
end
#10ns -> done;
endtask
endclass 

////////////////////////////////////////////////////////////////////////////////
// is meant for low levelinterfacing: driver with dut & dut with monitor
interface dff_iff(input logic clk);
 logic rst, data_in, data_out;
 modport dut (input clk, rst, data_in, output data_out);
endinterface

//////////////////////////////////////////////////////////////////////////////////////
class driver;
virtual dff_iff  _if;
transaction t;
event sent;
// mbx_ref to send the transaction to scoreboar as reference
mailbox #(transaction) dg_mbx;
event done;

function new(mailbox #(transaction) dg_mbx, virtual dff_iff _if );
   
    this.dg_mbx     = dg_mbx;
    this._if     = _if;
    t = new();
endfunction

task reset;
  _if.rst = 1'b1;
  $display("[DRV]: Resetting DUT");
  repeat(5) @(posedge _if.clk);
  _if.rst =1'b0;
  @(posedge _if.clk);
  $display("[DRV]: Resetting DUT is done");
endtask

task run();
    forever begin 
     dg_mbx.get(t);
     $display("[DRV]: data_in received = %0d", t.data_in);
     _if.data_in = t.data_in;
     $display("[DRV]: data_in sent to DUT = %0d", _if.data_in);
     #10ns-> sent;
    end
endtask
endclass


class monitor ;
transaction t;
virtual dff_iff _if;
event sent;

mailbox #(transaction) ms_mbx;


function new (mailbox #(transaction) ms_mbx, virtual dff_iff _if);
    t = new();
    this.ms_mbx = ms_mbx;
    this._if = _if;

    
endfunction

task run;
forever begin
    wait(sent.triggered); // wait for the driver to send data_in
    #20ns ;
    @(posedge _if.clk) begin
    //$display("[MON]: DUTdata_out = %0d", _if.data_out);
     t.data_out = _if.data_out;
     ms_mbx.put(t);
     $display("[MON]: data_out = %0d", t.data_out);
 end
end

endtask

endclass


////////////////////////////////////////////////////////////////////////////////
class scoreboard;
transaction t_g , t_m;
mailbox #(transaction) gs_mbx, ms_mbx;
event next_scb;
int fail = 0; // to count the number of mismatches

function new(mailbox #(transaction) gs_mbx, ms_mbx);
    this.gs_mbx = gs_mbx;
    this.ms_mbx = ms_mbx;
endfunction

task run;
    forever begin
        ms_mbx.get(t_m);
        $display("[SCB]: data_out from [MON]= %0d", t_m.data_out);
        gs_mbx.get(t_g);
        $display("[SCB]: data_in from  [GEN]= %0d", t_g.data_in);
        
        if (t_m.data_out != t_g.data_in) begin
        $error("[SCB]: Mismatch");   fail ++;
        end
        else $display("[SCB]: Match");
        #10ns -> next_scb;
    end
endtask

endclass

//////////////////////////////////////////////
class environment; 

virtual dff_iff _if;

mailbox  #(transaction) gd_mbx; // Gen & Drv mailbox
mailbox  #(transaction) gs_mbx; // Gen & sbr mailbox
mailbox  #(transaction) ms_mbx; // mon & sbr mailbox

generator gen;
driver drv; 
monitor mon;
scoreboard scb;




function new(virtual dff_iff _if, int count);

gd_mbx = new();
gs_mbx = new();
ms_mbx = new();

this._if = _if;

gen = new (gd_mbx, gs_mbx);
drv = new (gd_mbx, _if);
mon = new (ms_mbx, _if);
scb = new (gs_mbx, ms_mbx);

gen.count = count;


scb.next_scb = gen.next_scb;
drv.sent = mon.sent ;
endfunction





task pre_test();
$display("[ENV]: Pre-test setup");
drv.reset();
endtask


task test; 
$display("[ENV]: Starting test");
fork
    gen.run();
    drv.run();
    mon.run();
    scb.run();
join_none
endtask

task post_test;
wait (gen.done.triggered);
$display("[ENV]: Test is done");
$display("[ENV]: Number of tests Done = %0d", gen.count);
$display("[ENV]: Number of mismatches = %0d", scb.fail);
$finish;
endtask


task run();
pre_test();
test();
post_test();
endtask

endclass


////////////////////////////////////////////////////////////////////////////////
module tb;
logic clk=0;
int count;

dff_iff _if(clk);

always #10ns clk = ~clk; // clock generation

environment env;

dff dut(_if);

initial begin
    
    count = 3;
    env = new(_if , count);
    env.run();
end

/*
initial begin
    $dumpfile("dff.vcd");
    $dumpvars(0, tb);
    #1000ns;
    $finish;
end */
endmodule
