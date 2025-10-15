// associative array
// their index doesn't need to be continuous
// their index can be int , string , enum , class, struct, user defined typeor any data type
// their index can be mixed data types if we use [*] as index type
// we can use foreach to access associative array all members 


//---------------------------------methods--------------------------------
// .delete(index) to delete specific member
// we can use .next() to access associative array members one by one
// .next() can be used with enum data type to get next enum value
// .next() return 0 if there is no more members to access
// .next() return 1 if there is more members to access

module top ();

int j; 
string index ;


typedef struct { int x = 0 , y = 4 ;
                 string name =" " ;} my_struct;

// Assoicative array with known index type
int a1 [int] = '{ default : 5 }; // array initialization with different value than default
int a2 [string];
my_struct s [int] ;
// Assoicative array with mixed type index can be int or string
int a3 [*];


// typedef enum logic [1:0] { s0 , s1 , s2 , s3  } my_enum ;
// my_enum enum1 = "s0" ;
initial begin
// non of the assiociative array is created 
// the following will create member then assign default value the increment it by 1
$display("a1 = %p size=%0d", a1 , a1.size());
$display("s  = %p size=%0d", s  , s.size());
a1[200]++; 
s[7].x = 50;
s[20].y = 100;
s[60].name = "ali";
$display("a1 = %p size=%0d", a1 , a1.size());
$display("s  = %p size=%0d", s  , s.size());
// this will override a1 previous values and create new members
a1 = '{25: 3 , 50 : 4 , 75: 5};
$display("a1 = %p size=%0d", a1 , a1.size());
// this will add new member without overriding previous members
a1[100]=10;
$display("a1 = %p size=%0d", a1 , a1.size());

// string index
a2 = '{"first":5 , "finial": 20};
a2["mid"]=15;
$display("a2 = %p size=%0d", a2 , a2.size());

// mixed index
a3[1]=6  ;
a3["red"]=77; 
a3[3'b101]=7; 
a3[10000]=8;
// the following will print the index in ascii code 
$display("a3 = %p size=%0d", a3 , a3.size());

// printing members using foreach and .next()
//1- foreach:
foreach (a1[i])   $display ("a1[%0d] = %0d", i , a1[i]) ;
foreach (a2[i])   $display ("a2[%0s] = %0d", i , a2[i]) ;
// Wildcard Indexed Associative Arrays are not allowed in foreach loops 
// foreach (a3[i])   $display ("a3[%p] = %0d", i , a3[i]) ;
foreach (s[i])    $display ("s[%0d] = {x=%0d , y=%0d , name = %s}", i , s[i].x , s[i].y , s[i].name) ;

//2- arr.next()
// loop ilterator need to be declared before loop but it doesn't need to be incremented
while (a1.next(j) ) $display ("a1[%0d] = %0d", j , a1[j]) ;
while (a2.next(index) ) $display ("a2[%0s] = %0d", index , a2[index]) ;
// before reusing j, remeber to reset it to 0
// array.first(ref index) : is a function retruns 0 if the array is empty and 1 if the array is not empty
// and assign the first index of the array to the ref index
j= 0;
while (s.next(j) ) $display ("s[%0d] = {x=%0d , y=%0d , name = %s}", j , s[j].x , s[j].y , s[j].name) ;
// next() function won't work with wildcard indexed array


// methods 
// The exists() function checks whether an element exists at the specified index within the given array. It
// returns 1 if the element exists; otherwise, it returns 0.
if (a1.exists(100) ) $display ("a1[%0d] exists", 100) ;
else begin 
    a1[100] = 10;
    $display ("a1[%0d] created", 100) ; end
if (a1.exists(33) ) $display ("a1[%0d] exists", 33) ;
else begin 
    a1[33] = 10;
    $display ("a1[%0d] created", 33) ; end

if (a2.exists("all")) $display ("a2[all] exists & = %0d", a2["all"]) ;
else begin 
    a2["all"] = 10;
    $display ("a2[all] created & = %0d", a2["all"]) ; end
$display("a2 = %p size=%0d", a2 , a2.size());

if (a2.exists("all")) begin
    $display ("a2[all] exists & will be deleted");
    a2.delete("all"); end

$display("a2 = %p size=%0d", a2 , a2.size());
end
endmodule