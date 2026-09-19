// tb.v
`timescale 1ns/1ps

module tb;

  reg [3:0] a;
  reg [3:0] b;
  reg op;

  wire [3:0] result;

  // Instantiate Design Under Test (DUT)
  alu uut (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  task check;
    input [3:0] expected;
    begin
      #1;
      if (result !== expected)
        $display("FAIL: a=%0d b=%0d op=%0b result=%0d expected=%0d",
                 a, b, op, result, expected);
      else
        $display("PASS: a=%0d b=%0d op=%0b result=%0d",
                 a, b, op, result);
    end
  endtask

  initial begin

    // Addition test
    a = 4; b = 3; op = 0;
    check(7);

    // Tests sensitive-list fix (only 'op' changes)
    op = 1;
    check(1);

    // Subtraction tests (tests non-blocking / propagation fix)
    a = 5; b = 3; op = 1;
    check(2);

    a = 8; b = 3; op = 1;
    check(5);

    a = 7; b = 2; op = 1;
    check(5);

    // More addition tests
    a = 5; b = 6; op = 0;
    check(11);

    a = 9; b = 4; op = 0;
    check(13);

    // More subtraction tests
    a = 9; b = 4; op = 1;
    check(5);

    // 3 - 7 = -4 = 4'b1100 = 12 in unsigned decimal
    a = 3; b = 7; op = 1;
    check(12);

    $display("Testbench completed.");
    $finish;

  end

endmodule