// Unpacked array methods
// foreach , size , delete , insert , push_back , pop_back , pop_front , find , find_index , find_first , find_last , count
// sum , product , and , or , xor   

module top ();
// a : 6 rows [5:0], 4 columns [3:0] , each with 8 packed bits [7:0]  
  bit [7:0] a [5:0] [3:0];
// b : 6 rows [5:0], each with 4 packed blocks of 8 bits [3:0][7:0]
  bit [3:0][7:0] b [5:0];
// c : 2D unpacked int array initilized in declaration
  int c [0:3][0:2] = '{ '{12, 8 , 2 } , '{ 5 , 20 , 16 }  , '{ 9 , 7 , 5 } ,'{6 , 0 , 4} };
// d : 2D unpacked int array not initilized in declaration
  int d [1:6][0:5] ;
  int sum = 0;
  int arr[$];

initial begin
  $display(" Using foreach to iterate through arrays" );
  // iterate through array using foreach you don't need to know the size of array
  // for each dimension you need a loop variable, you declare its postion the use it

  // here a iterate only 2 dimentions i for row & j for column
  foreach(a[i,j]) begin 
    a[i][j] = $urandom_range(0,10) ;
  end 
  // here b iterate only 1 dimention i for row and row has 4 packed blocks of 8 bits 
  foreach(b[i]) begin 
    b[i]    = $urandom_range(0,100) ;
  end
  foreach(d[i,j]) begin 
    d[i][j] = $urandom_range(0,100);
  end 
  
  
  //------------------------------------reduction methods----------------------------------------------------------------------
  $display("a array=%p", a);
  // reduction methods: arr.sum() , arr.product() , arr.and() , arr.or() , arr.xor()
  // reduction method works on 1D array so for 2D we go row by row 
  // if you add 8-bit members the result will also be 8-bit so if the sum exceed 255 it will roll over
  // reduction using with():
  // first it select the members that meet the with condition or apply the operation within with
  // then apply the reduction method on the selected members
  $display("Using reduction methods"); 
  $display("a[1] = %p", a[1]);
  $display("a[1] all members sum=%d", a[1].sum());
  $display("a[1] after incrementing each member sum=%0d", a[1].sum with (item+1));
  $display("a[1] 3 < member < 20 sum=%0d", a[1].sum with (item > 3)); // not working ???
  $display ("reducing all members of a 2D array");

  foreach (a[i,j]) 
    sum = sum + a[i][j];
  $display("a all members using foreach sum=%0d", sum);
   // using int'() force result to be int (32-bit) to avoid roll over or truncation to 8 bits
  // item.sum with (item) : a has 6 row so we have 6 items
  // each item is a 1D array of 4 members that need to be reduced 
  // after reduction, it  is a 1D array of 6 memmbers that can now be reduced 
   $display("a all members sum=%0d", int'(a.sum() with (item.sum with (item))));
  //------------------------------------Array locator methods----------------------------------------------------------------------
  $display("Using searching methods");
  $display("a array=%p", a);
  $display("b array=%p", b);
  $display("c array=%p", c);
  $display("d array=%p", d);

  
  // arr.find() , arr.find_index() 
  
  //  arr.find_first() , arr.find_last() ,  arr.find_first_index() , arr.find_last_index()
  // All works only with 1D array so for 2D we go row by row
  // they return unpacked array so print with %0p & store in unpacked array
  // first element is the farmost leftmost element in the array
  // last element is the farmost rightmost element in the array
  
   arr = c[1].find with (item > 5) ;
   $display(" c items > 5   =%0p " , arr);
   $display(" c[1] first element=%0p " , c[1].find_first() with (item == 5) );
   $display(" c[1] first index  =%0p " , c[1].find_first_index() with (item == 5) );
   $display(" c[1] last element =%0p " , c[1].find_last() with (item == 5) );
   $display(" c[1] last index   =%0p " , c[1].find_last_index() with (item == 5) );
   

  // find min & max unique values works well with 1D array they return an array with single value
  // while find unique return an array with all unique values
  // for 2D it search first column and return array with the whole row of the found value as result
  $display ("min = %0p max=%0p of c array", c.min(), c.max());
  foreach (c[i]) begin
    $display (" for row c[%0d] min = %0p max= %0p", i ,c[i].min, c[i].max);
  end
  foreach (c[i]) begin
    $display (" for row c[%0d] unique values = %0p", i , c.unique);
  end
  
end



endmodule