// Real-Time Histogram Generation
// Problem Statement: 
// Given a stream of real numbers stored in a dynamic array, categorize them into buckets (e.g., 0–1, 1–2, ..., 9–10) 
// and display a histogram using associative arrays.

module top();
real data[] ; 
int hist [string] = '{default : 0}; 

function void histogram(real x);
    string key ;
    automatic int value = $floor(x); // floor
    key = $sformatf("%0d-%0d", value , value + 1);
    hist[key] = hist[key] + 1 ;
    $display("x = %0f  value = %0d key = %0s", x , value ,key);
    
endfunction

function void print();
  string key ;
  
 for (int i= 0 ; i < 15 ; i++) begin
    key = $sformatf("%0d-%0d", i , i + 1);
    if (hist.exists(key)) 
        $display("%0s : %0d", key , hist[key]) ;
    else 
        $display("%0s : %0d", key , 0) ;
    
  end
endfunction

initial begin
    data = new[20];
    for (int i = 0 ; i < 20 ; i++) begin
        data[i] = $urandom_range(0 , 999) / 100.00;
        histogram(data[i]);
    end
    print();
    $display(" data = %p", data);
end


endmodule 