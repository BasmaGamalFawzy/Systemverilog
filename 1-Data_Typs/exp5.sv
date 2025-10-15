// Packed and Unpacked Arrays
//--------------------------------------------------------------
// SystemVerilog supports both packed arrays and unpacked arrays of data. 
// Packed array : dimensions declared before the data identifier name.
// Unpacked array is used to refer to the dimensions declared after the data identifier name.

// Packed array:
// declare it with a range like arr[7:0] not arr[8]
// can be multi-dimensional
// can be made only of (bit, logic, reg), enumerated types, other packed arrays and packed structures


// Unpacked arry:
// can be declared with constant integer expression arr [size] the same as arr [0:size-1].
// can be fixed-size, dynamic arrays, associative arrays, queues 
// can be formed from any data type, including other packed or unpacked arrays 

module top ();

//-----------------------------------------------------------------------------------
// packed array 
//-------------------------------------------------
// in packed array the closest square bracket to name is the vector size
// arr[MSB:LSB]: means when you assign a value the left most bit is assigned to the number written in MSB
// and the right most bit is assigned to LSB
logic [7:0] a;  // packed array, a is treated as vector with a[7] as MSB and a[0] as LSB
logic [0:7] b;  // a[0] is MSB and a[7] is LSB 
// int packed array is not allowed only reg , bit , logic
// int [7:0] c; // error
initial begin
$display("----------------------------------------------------------------------------------");
$display("Packed Array");
$display("---------------------------------------");
a = 8'b10101010;
b = 8'b10101010;
$display("a[7]=%b  a[0]=%b", a[7], a[0]); // a[7]=1 , a[0]=0
$display("b[7]=%b  b[0]=%b", b[7], b[0]); // b[7]=0 , b[0]=1
end 

// 2D packed array: 
// can be visualized as a long vector that is divided into blocks each block has a given size
// declare it as arr[blocks][size]
// logic [3:0][7:0] arr: saves 32 bits , as 4 blocks of 8 bits each , block 0 is MSB
// access it all as arr , access it per block as: arr[block number] , access it as bit as arr[block number][bit index]

logic [0:3][7:0] arr1;

// making 3D packed array
// we still have long horizontal vector but divided into zones each zone has blocks and each block has size
// declare it as: arr[Zone] [block] [size] arr
// access it as whole: arr , per zone: arr[zone] , per block: arr[zone][block] , per bit:arr[zone][block][bit index]
logic [0:1][0:3][7:0] arr2;

initial begin 
#10
$display("----------------------------------------------------------------------------------");
$display("2D packed array");
$display("---------------------------------------");
// arr1[0]=10101010 , arr1[1]=11110000 , arr1[2]=11110000 , arr1[3]=10101010
arr1 = 32'b10101010111100001111000010101010; 
$display("arr1=%b", arr1);
$display("arr1[0]=%b", arr1[0]);
$display("arr1[1]=%b", arr1[1]);
$display("arr1[2]=%b", arr1[2]);
$display("arr1[3]=%b", arr1[3]);
arr1[0] = 8'b00001111; // change block 0
$display("after change arr1[0]=%b", arr1[0]);
arr1[0][0] = 1'b0; // change block 0 bit 0 to 0
$display("after change arr1[0][0]=%b", arr1[0][0]);
$display("----------------------------------------------------------------------------------");
$display ("3D packed Array");
$display("---------------------------------------");
arr2[0] = arr1 ;
arr2[1] = ~ (arr1);
$display ("3D array= %b", arr2);
$display ("Zone 1 block 3 byte = %b", arr2[1][3]);
end

//---------------------------------------------------------------------------------------
// Unpacked array
//-------------------------------------------------
// the allocated meomery is random so it can't be treated as a vector
// can be made of any data type: int , bit , logic , reg , struct , class , enum , packed array , unpacked array  
// can be dynamic , associative , queue or fixed size
// SV offers array methods that operate only on unpacked arrays, 
// include array searching, array ordering and array reduction 

// 2D unpacked array
// declare it as arr [rows] [columns]
// access it element by element as arr[row][column]

// unpacked array is assigned using curly braces '{arr[0] value , arr[1] value , ... , arr[n-1] value}
int arr3 [4] = '{1,2,3,4}; // 1D unpacked array

// 2D unpacked array with 2 rows and 5 columns
// assigned as '{'{row0 col0 , row0 col1 , ... , row0 col4} , '{row1 col0 , row1 col1 , ... , row1 col4}}
int arr4 [0:1] [0:4]='{'{1,2,3,4,5},'{6,7,8,9,10}};
initial begin ;
  #20
  $display("----------------------------------------------------------------------------------");
  $display("Unpacked Array");
  $display("---------------------------------------");
  $display("unpacked array print all=%p", arr3); // right
  $display("unpacked array[0]=%0d", arr3[0]);
  $display("----------------------------------------------------------------------------------");
  $display(" 2D unpacked array element by element printing");
  $display("---------------------------------------");
  for (int i = 0; i < 2; i++) begin
    for (int j = 0; j < 5; j++)
    $display("array [%0d][%0d]=%0d", i, j, arr4[i][j]);
  end 
  // as a is unpacked to access a raw we use %p 
  $display("2D unpacked array print all=%p", arr4); 
  // note: if you have logic arr[0:1][7:0],
  // even arr[0] is a 8-bit raw but it isn't a 8-bit vector 
  // so arr[0] = 8'b10101010 is wrong
  // Cannot assign a packed type 'bit[7:0]' to an unpacked type 'reg $[7:0]'
  arr4[0] = '{11,12,13,14,15}; // right
  $display("after change 2D unpacked array print all=%p", arr4);
end

//-------------------------------------------------------------------------------------------------------
// Memories: Packed + Unpacked Arrays
//-------------------------------------------------------------------
// A one-dimensional array with elements of types reg, logic, or bit is also called a memory. 
// Memory arrays can be used to model (ROMs),(RAMs), and register files. 
// An element of the packed dimension in the array is known as a memory element or word.

// memory array of 256 8-bit elements. The array indices are 0 to 255
logic [7:0] mem [0:255];
initial begin
#30
$display("----------------------------------------------------------------------------------");
$display("Memory using packed + unpacked array");
$display("---------------------------------------");
for (int i = 0; i <= 255 ; i++)   mem[i] = 0;
mem[5] = 8'b10101010; // Write to word at address 5
$display("you can display memory location %3d = %b", 5, mem[5]);
$display("you can display memory location %3d = %b", 10, mem[10]); 
// as each location is packed you can access the bits by their index
// first select the location: mem[5] then from this vector select the bit: mem[5][3]
$display("you can access a bit number %0d of memory location %0d = %b", 3, 5, mem[5][3]);
end

// arrays as type
typedef logic [1:0][7:0] regX2;
regX2 [2:1] reg_wide  ; // packed array equivalent to logic [2:1][1:0][7:0] reg_wide
regX2 reg_file [15:0] ; // unpacked array of 16 elements each element is packed array of 2 blocks each block has 8 bits
// equivalent to logic [1:0][7:0] regfile [15:0]
initial begin
#40
$display("----------------------------------------------------------------------------------");
$display("Arrays as type");
$display("---------------------------------------");
reg_wide[1] = {8'b10101010, 8'b11001100}; // Write to word at address 0
reg_file[3] =  {8'b10101010, 8'b11001100}; // Write to word at address 3
$display("memory location 1 of reg_wide = %b", reg_wide[1]);
$display("memory location 3 of reg_file = %b", reg_file[3]);        
end



endmodule