// Create an associative array to map register names (strings) to their values. 
// Display all key-value pairs.

module top; 
 int reg_file[string] ; 

initial begin
    reg_file["R0"] = 0 ;
    reg_file["R1"] = 1 ;
    reg_file["R2"] = 2 ;
    
    foreach (reg_file[key]) begin
        $display("%s = %0d", key, reg_file[key]);
    end
end

endmodule