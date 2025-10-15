//Create a task that will generate stimulus for addr , wr, and en signal 
//as mentioned in a waveform of the Instruction tab.
// Assume address is 6-bit wide while en and wr both are 1-bit wide.
// The stimulus should be sent on a positive edge of 25 MHz clock signal.

module exp();

time clk_p=25; 
bit clk , wr, en; 
bit [5:0] addr;

task display ();
$monitor("Time=%0d en=%0b wr=%0b addr=%0d", $time, en , wr, addr);
endtask




task gen_addr();
addr=12;
#(clk_p) addr=14;
#(clk_p) addr=23;
#(clk_p) addr=48;
#(clk_p) addr=56;
endtask 

task gen_en();
en=0;
#(clk_p/2) en=1;
#(2*clk_p) en=0;
endtask

task gen_wr();
wr=0;
#(clk_p/2) wr=1;
#(2*clk_p) en=0;
endtask

initial begin
clk=0; 
forever  #(clk_p/2) clk = ~clk;
end 

initial
fork
    display();
    gen_addr();
    gen_wr();
    gen_en();   
    #(5*clk_p) $finish;  
join 

endmodule 

