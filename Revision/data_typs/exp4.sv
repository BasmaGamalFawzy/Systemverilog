// Declare both a packed and an unpacked array and show how data storage differs.

module top;

 logic [7:0] pac_arr ;
 logic unpac_arr [7:0] ;

initial begin
    // treated as vector 
    pac_arr = 8'b10101010 ;
    // each element is independent
    unpac_arr = '{1 , 0, 1, 0, 1, 0, 1, 0} ;
    $display("packed = %b", pac_arr);
    $display("unpacked = %p", unpac_arr);
end

endmodule