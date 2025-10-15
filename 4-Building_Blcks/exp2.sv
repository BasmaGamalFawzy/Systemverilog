// interface: modport , virtual interface inside class
// modport is used to give diffrent modes of access to the ports

interface bus #(width=8) (input logic clk);
  logic wr, rd , en;
  logic [width-1:0] data_in, data_out;
  modport master (input clk, rd,
                  output wr, en, 
                  ref data_in, data_out);
                  

  modport slave (input clk, wr, en,
                 output rd,
                 ref data_in, data_out);


endinterface


module bus_master (bus.master _if);

always@ (posedge _if.clk) begin
 _if.wr = 1 ;
 _if.en = 1;
 _if.data_in = $urandom_range(0,50);
 #2ns ;
 if(_if.rd == 1) begin 
    _if.wr = 0;
    _if.en = 0;
    $display("Data Put by Master: %0d", _if.data_in);
 end
 
end
endmodule

// we could use bus _if without specifying the modport
// and specify the modport in the module instantiation    
module bus_slave (bus _if);
always @(posedge _if.clk) begin
    _if.rd = 0;
    #1ns;
    _if.data_out = _if.data_in; 
    _if.rd = 1;
    $display("Data Read by Slave: %0d", _if.data_out); 
 end

endmodule  

module tb();
  logic clk = 0;
  bus #(.width(8)) bus_if(clk);
  
  bus_master master_inst (._if(bus_if));
  
  // here we specify the modport in the interface instantiation both ways OK
  bus_slave slave_inst (._if(bus_if.slave));

  initial forever #10ns clk = ~clk; 

  initial begin 
     #100ns $finish; // end simulation
  end

endmodule