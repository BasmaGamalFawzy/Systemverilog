
// — System tasks and system functions that open and close files
   // $fopen system function and the $fclose system task 
   // $fopen ( file_name , type ): returns a32-bit multichannel descriptor or a 32-bit file descriptor
   // we can use this descriptor to read and write data to a file
   // type can be: 
      // "r": open for read , 
      // "w": Truncate to zero length or create for writing
      // "a": Append; open for writing at end of file (EOF), or create for writing
      // "r+": Open for update (reading and writing)
      // "w+": Truncate or create for update
      // "a+": open or create for update at EOF 
    // EOF = -1 means we reached to the end of the file , 
    // $feof(descriptor): returns 1 if we reached to the end of the file
    // $fclose (descriptor): close file, returns 1 on success and 0 on failure
// — System tasks that output values into files
    // $writememb ( fd , memory_array_name , start_addr , finish_addr ) 
    // $writememh ( fd , memory_array_name , start_addr , finish_addr )
    //   | $fdisplay | $fdisplayb | $fdisplayh | $fdisplayo
    //   | $fwrite   | $fwriteb   | $fwriteh   | $fwriteo
    //   | $fstrobe  | $fstrobeb  | $fstrobeh  | $fstrobeo
    //   | $fmonitor | $fmonitorb | $fmonitorh | $fmonitoro
// — System tasks and system functions that read values from files and load into variables or memories
    // file_read_functions: 

     // $fgetc ( fd ) : reads a byte from the file specified by fd & returns its value
     // $ungetc ( c , fd ): reads a byte from the file specified by fd & returns its value in c
     // $fgets ( str , fd ): reads a line from the file specified by fd & stores it in str

     // $sscanf ( str , format , args ): given string
     // $fscanf ( fd , format , args ):  string from a file
     // Both are system tasks that read characters, interpret them according to a format, and store the results. 
     // Both expect as arguments a control string, format, and a set of arguments specifying where to place the results.
     
     // $fread ( integral_var , fd )
     // $fread ( mem , fd , start , count )

     // $readmemb ( fd , memory_array_name  , start_addr , finish_addr ) 
     // $readmemh ( fd , memory_array_name  , start_addr , finish_addr ) 
     

module top ();

// create an associative array
int switch [string];
logic [63:0] mem1 [0:255];
int i ;
string s ; 

// open file to read it content
int r_file = $fopen("switch.txt","r");
int m_file = $fopen("f.mem" , "r"); 
int g_file = $fopen("get.txt" , "r");
// open or create a file to append at EOF (End of File)
int w_file = $fopen("res.txt","a+");

initial begin
// reading given number of arguments in a file line by line
// while the end of the file is not reached
while(! $feof(r_file)) begin 
// first line is treated as string given to fscanf
    // we have 2 % tells the task to get two arguments
    // search for a decimal number and store it in i
    // search for a string and store it in s
$fscanf (r_file , "%d %s" , i , s) ; 
// use the results in the associative array
switch[s]=i ; 
end
$fclose(r_file);
$display("switch=%p" , switch);

// use $fgets to read a line from a file stored in s and return number of characters read
i = $fgets (s, g_file);
$display("i=%0d , s=%s" , i , s);


// memory file reading: 
// $readmemb ( fd , memory_array_name  , start_addr , finish_addr ) 
// $readmemh ( fd , memory_array_name  , start_addr , finish_addr ) 
// The text file to be read shall contain only the following:
    // — White space (spaces, newlines, tabs, and formfeeds)
    // — Comments (both types of comment are allowed)
    // — Binary or hexadecimal numbers with no length or base format specified
    // — (x or X), (z or Z), and the underscore ( _ ) can be used as in a SystemVerilog
    // — White space and/or comments shall be used to separate the numbers.
    // — Each number encountered is assigned to a successive word element of the memory.
    // — Addressing is controlled both by specifying start and/or finish addresses in the system task invocation 
    // and by specifying addresses in the data file.
    // When addresses appear in the data file, the format is an at character (@) followed by a hexadecimal number,
    // as follows: @hh...h
// can work with multidimensional unpacked arrays

// load hex file to memory
$readmemh("f.mem" , mem1);
for (int i = 0 ; i < 16 ; i++) 
$display("mem1[%0d] = %0b" ,  i , mem1[i]);
$display("mem1[50] = %0b" ,  mem1[50]);
$display("mem1[51] = %0b" ,  mem1[51]);
$display("mem1[52] = %0b" ,  mem1[52]);

$readmemh("f.mem" , mem1, 100);
for (int i = 100 ; i < 116 ; i++) 
$display("mem1[%0d] = %0b" ,  i , mem1[i]);

$readmemh("f.mem" , mem1, 200, 182);
for (int i = 182 ; i < 201 ; i++) 
$display("mem1[%0d] = %0b" ,  i , mem1[i]);


// write to file 


end
    
endmodule