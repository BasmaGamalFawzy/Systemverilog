// we study Objects copy methods
// Using custom Copy function 

class first; 
logic flag, carry;

function new (input logic flag=0 , input logic carry=0);
 this.flag =flag;
 this.carry = carry ;
endfunction

extern function void display();

function first copy();
 first copy_obj= new();
  copy_obj.flag = flag;
  copy_obj.carry = carry;
return copy_obj;
endfunction 

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
  $display("ALU2:");
  alu2.display();
endfunction


function second copy();
 second copy_obj= new();
 copy_obj.data = this.data;
 copy_obj.alu1 = alu1.copy();
 copy_obj.alu2 = alu2.copy();
 //   copy_obj.alu1.carry = alu1.carry ;
 //   copy_obj.alu1.flag  = alu1.flag ;
 //   copy_obj.alu2.carry = alu2.carry;
 //   copy_obj.alu2.flag  = alu2.flag; 
 return copy_obj;
endfunction
endclass

module tb; 

second top1, top2 , top3;

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

top3 = new ();
top3 = top1.copy(); // Custom copy function

$display ("The Copied object using custom copy function:");
top3.display();
top3.alu1.flag = 1'b0 ; //change the copy so the original must not change
$display ("The orignal object NO EDIT:");
top1.display();
$display ("The Copied using custom copy object after edit flag:");
top3.display();
end
endmodule