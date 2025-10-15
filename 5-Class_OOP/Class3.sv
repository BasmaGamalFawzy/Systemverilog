// We here use external functions 

class pci ;

logic [31:0] addr;
logic [2:0] sel;

// we don't write void with new() function
function new();
addr= '0 ; 
sel = 3'b010; 
endfunction 

extern function void display();
endclass 

function void pci::display();
$display (" The address is=%0h The Selection is=%0b",addr , sel);
endfunction 



module tb ();
pci obj;
initial begin
obj= new();
obj.display();
end

endmodule