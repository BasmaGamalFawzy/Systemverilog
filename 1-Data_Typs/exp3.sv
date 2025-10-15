// enumerated type declares a set of integral named constants



module exp3 ();

// an one time declaration 
// yellow has corresponding value of 0 , red has corresponding value of 1 , green has corresponding value of 2
enum {yellow, red , green} colors;

initial begin
#10ns; 
for(int i = 0; i < colors.num ; i++) begin
$display("Colors: member #%0d is %s with code %0d", i+1 , colors.name() , colors);
colors = colors.next();
end
$display("-------------------------");
end

// we can use number to declare that enum as much as we want 
typedef enum { first , second , third , forth , fifth , sixth , last } number;
number n1 ; 
initial begin
#20ns; 
for(int i = 0; i < n1.num ; i++) begin
$display("Numbers using next()  : member #%0d is %s with code %0d", i+1 , n1.name() , n1);
$display("Numbers using loop var: member #%0d is %s with code %0d", i+1 , number'(i) , i);

n1 = n1.next();
end
$display("-----------------------------------------");
end
// we can assign the representing number of each enum as 

// c is automatically assigned the increment-value of 8 
typedef enum {a=3, b=7, c} alp;
alp n2 ; 

initial begin
#30ns; 
n2 = n2.first(); // as alp don't start coding from zero we need this to ensure the enum counter start 
for(int i = 0; i < n2.num ; i++) begin
$display("Alphabets: member #%0d is %0s with code %0d", i+1 , n2.name() , n2);
n2 = n2.next();
end
$display("-------------------------");
end

// add=10, sub0=11, sub1=12, sub3=13, jmp6=14, jmp7=15, jump8=16 
typedef enum { add=10, sub[3], jmp[6:8] } ops;
ops n3;
initial begin
#40ns; 
n3 = n3.first();
for(int i = 0; i < n3.num ; i++) begin
$display("Operations: member #%0d is %s with code %0d", i+1 , n3.name() , n3);
n3 = n3.next();
end
$display("-------------------------");
end

// register0=1, register1=2, register2=10, register3=11, register4=12
typedef enum { register[2] = 1, register[2:4] = 10 } vr;
vr n4;
initial begin
#40ns; 
n4 = n4.first();
for(int i = 0; i < n4.num ; i++) begin
$display("Register: member #%0d is %s with code %0d", i+1 , n4.name() , n4);
n4 = n4.next();
end
$display("-------------------------");
end

// here each state size is represented and limitted by 2 bits 
// s0=00, s1=01, s2=10, s3=11
typedef enum bit [1:0] {s0 , s1 , s2 , s3} state;
state n5;
initial begin
#50ns; 
n5 = n5.first();
for(int i = 0; i < n5.num ; i++) begin
$display("States: member #%0d is %s with code %b", i+1 , n5.name() , n5);
n5 = n5.next();
end
$display("-------------------------");
end

// here we limit the size furthr more and  custom 
// t0 size is 8 bits & is assigned value of 3
// t1 size is 3 bits & is assigned value of 2
// t2 size is 8 bits & is assigned value of 25
// t3 size is 8 bits & is assigned value of 26
typedef enum bit [7:0] { t0 = 'd3 , t1=3'd7 , t2 ='d25 , t3 , t4} asm;
asm n6;
initial begin
#60ns; 
n6 = n6.first();
for(int i = 0; i < n6.num ; i++) begin
$display("ASM States: member #%0d is %s with code %0d", i+1 , n6.name() , n6);
n6 = n6.next();
end
$display("-------------------------");
end

initial begin
#70ns;
$display (" We here try the methods");    

// The first() method returns the first enumeration value
// The last() method returns the last enumeration value
// The name() method returns the string representation of the given enumeration value

//$display ("Colors members are %0s, %0s, %0s", colors'(0), colors'(1), colors'(2));
n1 = n1.first() ; // this is enum method gets first item of number & put it in n1
// while(1) : It is an infinite loop which will run till a break statement is issued explicitly.
// while (1) = forever
while (1) begin
$display ("Numbers Using next(2) method:", n1.name());
if (n1==n1.last())
break ; 
n1=n1.next(2); // increment the enum counter br two positions
end  
end 
endmodule