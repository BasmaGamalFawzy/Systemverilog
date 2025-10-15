// Write a program that concatenates two strings and displays the
// combined string and its length.

module top ();
  string s1 = "Hello";
  string s2 = "World";
  string s_combined = {s1 ," " , s2 };

  initial begin
    $display("s1 = %s", s1);
    $display("s2 = %s", s2);
    $display("s_combined = %s", s_combined);
    $display("s_combined length = %0d", s_combined.len());
  end

endmodule