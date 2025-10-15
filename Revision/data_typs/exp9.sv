// Use a struct (with an enum and an integer field) as a key for an associative array. 
// Store register configuration values and implement a lookup feature

module top();
    typedef enum logic [2:0] {R0 , R1 , R2 , R3 , R4 , R5 , R6 , R7} reg_file; 
    typedef struct { reg_file regs ;
                     int num ;} reg_conf;
    int arr[reg_conf] ;

   initial begin
    for (int i = 0; i < 8; i++) begin
        arr[i].regs = $sformat("R%d", i);
        arr[i].num = i;
    end
   end
endmodule