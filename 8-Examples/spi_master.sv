// spi master design & SV Verification
// spi interfaces with ADC/DAC & flash memory 
// as they need to be configured & send their data at a higher rate than I2C
parameter int width = 8;


interface spi_master_if (input logic clk);
 logic [width-1:0] data_in; // input - the data to be the master to be sent
 logic [width-1:0] data_out; // output - the data recived by the master to be sent to the controller
 logic rst; // input control line from controller - reset
 logic tx_en; // input control line from controller - send data
 logic ready; // output flag to controller that spi can send data
 logic miso; // input data bit from slave to master
 logic cs; // ouput active low control line enable the slave 
 logic sclk; // output clock for the slave
 logic mosi; // output data bit from master to slave
 logic [1:0] mode;// mode: bit 0:CPOL bit 1:CPHA

 modport dut (input clk, rst, tx_en, data,
               output cs, sclk, mosi);
endinterface

module spi_master(spi_master_if _if);
typedef enum logic [1:0] { idle , start_tx , send_data ,end_tx } state;
state pr , nxt ; 
int count = 0;
logic [width-1:0] data = _if.data_in;
logic m_clk; 

assign _if.mosi = data[width-1];
assign _if.data_out = data;


// feedback logic
always @(posedge _if.clk) begin
    if (_if.rst) begin
        pr <= idle; 
        count <= 0; end
    else begin
        pr <= nxt; end
end

// next state logic
always @* begin
    case (pr)
        idle: 
            if (_if.tx_en) 
                nxt = start_tx; 
            else           
                nxt = idle; 
        start_tx:    
                nxt = send_data; 
        send_data: 
            if (count == width-1)  
                nxt= end_tx; 
            else 
                nxt = send_data; 
        end_tx:       
                nxt = idle;             
    endcase
end 

// output logic
always @* begin
    case (pr)
        idle: begin
            _if.cs = 1;
            _if.sclk = mode[0]; // CPOL setting
            _if.mosi = 0; 
            _if.ready = 1; end
        start_tx: begin
            _if.cs = 0;
            #n*Tclk sclk = !sclk;
            _if.mosi = 0; end
        send_data: begin
            _if.cs = 0;
            _if.sclk = 0;
            data [width-2-count] = data[width-1-count]; 
            count = count + 1; end
        end_tx: begin
            _if.cs = 1;
            _if.sclk = mode[0]; // CPOL setting
            _if.mosi = 0; end
    endcase
end 

// sclk rate logic
//clk is much faster than the rate of the SPI clock 
//Baud Rate Generator
// mode[0]: CPOL : 0 start bit is zero, 1 start bit is one
// mode[1]: CPHA : 0 sample on the leading edge of the clock, 1 sample on the trailing edge
always @(posedge _if.clk) begin 

end 


// mode selection logic
always @* begin
    case (pr)
     idle: 
        _if.sclk = mode[0]; // CPOL setting 
    
     start_tx: 
    
    endcase
            
//

endmodule