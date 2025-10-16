//  transtion coverpoints

module top;
int x_a[10] = '{1,1,2,3,1,1,1,2,3,1};
int y_a[10] = '{2,1,4,3,4,5,4,7,8,9};
int z_a[10] = '{2,1,4,3,4,5,4,9,8,7};
int x, y, z;

covergroup cg;
    coverpoint x {
        bins x123  = (1 => 2 => 3 ); // count transitions from 1 to 2 and 2 to 3
        // 2 times
        bins x111  = (1[*3]); // search for 1,1,1
        // 1 time
        bins x1r[] = (1[*2:3]); // search for 1 ,1 or 1,1,1
        // 4 times if lumbed , 
        // 3 times 1,1 & once 1,1,1
    }
    coverpoint y
    {
        bins y247_1 = (2 => 4[->3] => 7); 
        // search for 2 , three non-consecutive 4 followed directly by 7
        // once
        bins y247_2 = (2 => 4[=3] => 7); 
        // search for 2 , three non-consecutive 4 followed by 7
        // once
    }
    coverpoint z
    {
        bins z247_1 = (2 => 4[->3] => 7); 
        // search for 2 , three non-consecutive 4 followed directly by 7
        // NONE
        bins z247_2 = (2 => 4[=3] => 7); 
        // search for 2 , three non-consecutive 4 followed by 7
        // once
    }
endgroup 

cg cg_inst = new;

initial begin
    for (int i = 0; i < 10; i++) begin
        x=x_a[i];
        y=y_a[i];
        z=z_a[i];
        #2; 
        cg_inst.sample();
    end
end

endmodule