// Implement a jagged 2D array (i.e., rows of different lengths) using an array of dynamic arrays. 
// Write code to initialize and print all elements properly aligned

module top ();
int arr[][] ; 
function int create_row(int x, int y);
    if (x >= arr.size()) return 0;
    arr[x] = new[y];
    return 1;
endfunction

function void print_rows (int x);
    for (int i = 0 ; i < x ; i++) begin
     for (int j = 0 ; j < arr[i].size() ; j++)
         $write("%3d ", arr[i][j]);
     $write("\n");
    end
endfunction

initial begin
    arr = new[3];
    if ( create_row(0, 3)== 0) $display ("error creating row out of bound");
    arr[0][0] = 1;
    arr[0][1] = 2;
    arr[0][2] = 3;
    if ( create_row(1, 5)== 0) $display ("error creating row out of bound");
    arr[1][0] = 4;
    arr[1][1] = 5;
    arr[1][2] = 6;
    arr[1][3] = 7;
    arr[1][4] = 8;
    if ( create_row(2, 1)== 0) $display ("error creating row out of bound");
    arr[2][0] = 9;
    if ( create_row(7, 3)== 0) $display ("error creating row out of bound");
    print_rows(arr.size());
end 


endmodule 