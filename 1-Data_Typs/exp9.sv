// queue 
// 0 representing the first,and $ representing the last
module top ();
// queue size is adaptable so e use $ to represent the size
int a [$];

initial begin
// unlike arrary we don't put ' before {}
a= {5,6,7,8,9};
$display("Queue=%p  size= %0d",a , a.size());
$display("Queue first element= %0d",a[0]);
$display("Queue last  element= %0d",a[$]);
$display("Queue from 2 to 4  = %0p",a[2:4]);

$display("\n\nUsing insert method to insert 100 in 3rd position");
a.insert(3 , 100);
$display("Queue=%p  size=%0d",a , a.size());

$display("\n\nUsing delete method to delete 3rd position");
a.delete(3);
$display("Queue=%p  size=%0d",a , a.size());

$display("\n\nUsing push_front method to insert in the front 50");
a.push_front(50);
$display("Queue=%p  size=%0d",a , a.size());

$display("\n\nUsing push_back method to insert in the back 80");
a.push_back(80);
$display("Queue=%p  size=%0d",a , a.size());
 

$display("\n\nUsing foreach & pop_back to empty the queue");
foreach(a[i]) begin
$display ("Value %0d is out i=%0d", i ,  a.pop_back());
$display("Queue=%p  size=%0d",a , a.size()); end

a= {5,6,7,8,9};
$display("\n\n Refilling the Queue=%p  size=%0d",a , a.size());

$display("\n\nUsing foreach & pop_front to empty the queue");
foreach(a[i]) begin
$display ("Value %0d is out i=%0d", i,  a.pop_front());
$display("Queue=%p  size=%0d",a , a.size()); end
end
endmodule