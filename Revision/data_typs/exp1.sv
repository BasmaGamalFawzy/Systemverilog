// Create a 1D bit array of size 8.
// Initialize it with binary values. 
// Write a program that inverts each bit and displays both original and inverted values.

module top ();

bit [7:0] a = 8'b10101010;

initial begin
    $display("Original value: %b", a);
    $display("Inverted value: %b", ~a);
end

endmodule