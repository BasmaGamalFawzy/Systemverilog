// Design a sparse matrix using a two-level associative array 
// where only non-zeroelements are stored.
// Provide functionality to insert,retrieve, and print elements in matrix form.

module top ();
int arr [int][int] = '{default : 0}; 

function void insert (int x , int y , int value) ;
    if (value == 0 && arr[x][y] != 0)
        arr[x].delete(y);
    else if (value != 0)
        arr[x][y] = value ;
endfunction

function int retrieve (int x , int y) ;
// check if row exist then check if column exist
    if (arr.exists(x) && arr[x].exists(y) )
    return arr[x][y] ;
    else return 0;
endfunction

function void print (int x , int y) ;
    for (int i = 0 ; i < x ; i++) begin
     for (int j = 0 ; j < y ; j++)
         $write("%3d ", retrieve(i,j));
     $write("\n");
    end
endfunction 

initial begin
    insert(0,0,10);
    insert(0,1,20);
    insert(1,0,30);
    insert(1,1,40);
    insert(2,2,50);
    insert(3,3,60);
    insert(3,3,0);
    print(5,5);
end

endmodule 