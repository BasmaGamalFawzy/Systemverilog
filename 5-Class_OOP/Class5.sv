// we study Objects copy methods
// Using Sallow Copy "new"
class first; 
logic flag, carry;

function new (input logic flag=0 , input logic carry=0);
 this.flag =flag;
 this.carry = carry ;
endfunction

extern function void display();

endclass

function void first ::display();
$display ("flag = %0b, Carry = %0b", flag, carry);
endfunction 

class second;
logic [3:0] data;
first alu1, alu2;

function new (input logic [3:0] data= 4'h0 , input logic carry =0 , input logic flag =0);
  this.data = data;
  alu1 = new(carry, flag);
  alu2 = new(carry, flag+1);
endfunction 

function void display();
  $display("Data = %0h", data);
  $display("ALU1:");
  alu1.display();
  $display("ALU1:");
  alu2.display();
endfunction

endclass

module tb; 

second top1, top2;

initial begin 
top1 = new(4'hA, 1'b0, 1'b1);
$display ("The orignal object:");
top1.display(); 

top2 = new top1; // Sallow copy constructor
$display ("The Copied object:");
top2.display();

top2.alu1.flag = 1'b1 ; //change the copy so the original must not change
$display ("The orignal object NO EDIT:");
top1.display();

$display ("The Copied object after edit flag:");
top2.display();

// here we find also the original object is editted
// As sallow copy using new copied data memebers & the hanelers of aggregated classes 
// not the data itself rathher their location in memory
end
endmodule