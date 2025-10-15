// Write a SystemVerilog program to create a dynamic array of size n 
// and store the first n prime numbers

module top();
 parameter n=10;
 int arr[]=new[n];
 int index = 0 ;
 function is_prime(int num);
    for (int i = 2; i < num; i++) begin
        if (num % i == 0) return 0;
    end
    return 1;
endfunction
initial begin
      
     for (int i = 1; i < n; i++) begin
         if (is_prime(i)) arr[index++] = i;  
     end


    $display("Primes: %0p", arr);
 end
endmodule 