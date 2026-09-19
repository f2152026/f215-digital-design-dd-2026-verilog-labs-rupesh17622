// alu.v
// 1-bit-opcode ALU: op=0 -> add, op=1 -> sub. 4-bit operands.

module alu (
  input        [3:0] a,
  input        [3:0] b,
  input              op,     // 0 = add, 1 = sub
  output reg  [3:0] result
);

  reg [3:0] b_inv;
  reg [3:0] b_twos;

  // Use @(*) to automatically monitor all inputs and internal signals
  always @(*) begin
    case (op)
      1'b0: begin
        result = a + b;
      end
      1'b1: begin
        // Use blocking (=) assignments so intermediate signals update sequentially in 0-time
        b_inv  = ~b;
        b_twos = b_inv + 1'b1;
        result = a + b_twos;
      end
    endcase
  end

endmodule