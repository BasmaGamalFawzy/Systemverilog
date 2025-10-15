// Dynamic array 

module top ();
//-------------------------------------Dynamic Array-----------------------------------
// Dynamic array:
// unpacked array with no size at declaration & requires allocation before use
// can be multi-dimentional with one or more dynamic dimention 
// allocation: name = new[size] (optional init value) ;
// you can allocate it during declaration or during usage
// you can reallocate it & change its size any time
// you can deallocation: name.delete() ;
// you can get size: name.size() ;
// you can access element: name[index] ;
//-----------------------------------------------------------------------------------
// dynamic array size is variable that can be set & even change multiple times by:
// new function or new function + copy array
// initialization with {}
// take the size of another assigned array 
//-----------------------------------------------------------------
// Dynamic array allocated with new[size]
int arr1 [] = new[5] ; // allocate with size 5 
// Dynamic array allocated with initial values
int arr2 [] = '{9,1,8,3,4,4};
int arr3 [] = '{9,1,8};
// Dynamic array allocated with new[the need size from the array](arr)
int arr4 [] = new[3](arr2);
int loc []; 

// Multi-dimentional dynamic array
// new can only allocate the first dimention & other dimentions need to be allocated later

// here un-accepted form of multi-dynamic array
//-------------------------------------------------------------------------
// 1: int arr[][] = new[2][3]; // not allowed new sets only the first dimention
// 2: int arr1[3][] = new[2];  int arr2[4][][] = new[2];  int arr3[1][][2]= new[2];
// not allowed as arr not dynamic even it has dynamic sub-arrays
// a dynmic sub-arras can be allocated in procedure block
// arr1[0] = new[2] ok 
// arr2[0]= new[2]  // create in row 0 two columns but still the 3rd dim not allocated
// arr2[0][0] = new[3] // ok create in row 0 col 0 three 3rd dim
// arr2[0][]  = new[3] // NOT ok as syntax error - dimension without subscript on left hand side
// arr2[1][0] = new[3] // NOT ok as arr2[1] not allocated yet
//-------------------------------------------------------------------------

int m_arr1[][] = new[2]; // create 2 rows each has dynmaic columns
// columns are set inside initial block by either way
int m_arr2[2][][]; // fixed array with dynamic sub-arrays

initial begin
// arr1 initial 
$display("arr1=%p  size=%0d", arr1, arr1.size()); 
// change size of arr1 using arr2
arr1 = arr2;
$display("arr1=%p  size=%0d", arr1, arr1.size());
// change size of arr1 using arr3
arr1 = arr3;
$display("arr1=%p  size=%0d", arr1, arr1.size());
// see how new[]() works in arr4
$display("arr4=%p  size=%0d", arr4, arr4.size());
// reallocate arr1 with new size
arr1 = new[6];
$display("arr1=%p  size=%0d", arr1, arr1.size());
// deallocate arr1
arr1.delete();
$display("arr1=%p  size=%0d", arr1, arr1.size());

// multi-dimentional dynamic array
m_arr1[0] = new[3]; // add 3 columns to row 0
m_arr1[1] = new[2]; // add 2 columns to row 1
$display("\nMulti-dimentional dynamic array");
$display("m_arr1=%p  size=%0d", m_arr1, m_arr1.size());
//----------------------------------------------------------------------------------------------------------
// fixed array with dynamic sub-arrays
//----------------------------------------
// m_arr2[0][] = new[2]; // ERROR 
// correct 
m_arr2[0] = new[2]; // add 2 columns to row 0
m_arr2[0][0] = new[3]; // add 3 to 3rd dim in row 0 col 0

// run time error as m_arr2[1] not allocated yet
// m_arr2[1][0] = new[4]; // add 4 to 3rd dim in row 1 col 0
// correct way to allocate row 1
m_arr2[1] = new[2]; // add 2 columns to row 1
m_arr2[1][0] = new[4]; // add 4
// using m_arr2.size() won't work 
$display("m_arr2=%p  ", m_arr2 );

// array methods , go for 1D arrays

// reduction methods : sum , product, or , xor
$display("\nArray methods: Sum");
$display("arr1=%p  sum=%0d", arr1, arr1.sum());
$display("arr2=%p  sum=%0d", arr2, arr2.sum());
$display("arr3=%p  sum=%0d", arr3, arr3.sum());
$display("arr4=%p  sum=%0d", arr4, arr4.sum());
$display("\nArray methods:Sum with condition");
$display("arr2=%p  sum(item>3)=%0d", arr2, arr2.sum() with ((item > 3)* item));

// min, max 
$display("arr2=%p  min=%0p", arr2, arr2.min() );
$display("arr2=%p  max=%0p", arr2, arr2.max() );
$display("arr2=%p  min(item>3)=%0p", arr2, arr2.min() with ((item > 3) ?  item : 1000) );
$display("arr2=%p  max(item<9)=%0p", arr2, arr2.max() with ((item < 9) * item) ); 

// find & find_index & find_first_index & find_last_index
$display("\nArray methods: find with condition");
$display("arr2=%p  find(item>3)=%0p", arr2, arr2.find() with (item > 3) );
$display("arr2=%p  find(item==4) indces=%0p", arr2, arr2.find_index() with (item == 4) );
$display("arr2=%p  find(item==4) first index=%0p", arr2, arr2.find_first_index() with (item == 4) );  
$display("arr2=%p  find(item==4) last index =%0p", arr2, arr2.find_last_index() with (item == 4) );
$display("arr2=%p  find(item==4) last index =%0p", arr2, arr2.find_last_index(x) with (x == 4) );


// sort & reverse
$display("\nArray methods: sort & reverse");
$display("arr2 before anything=%p  ", arr2 );
arr2.sort();
$display("arr2 after sort=%p  ", arr2 );
arr2.shuffle();
$display("arr2 after shuffle=%p  ", arr2 );
arr2.reverse();
$display("arr2 after reverse=%p  ", arr2 );
arr2.rsort();
$display("arr2 after rsort=%p  ", arr2 );
end
    
endmodule