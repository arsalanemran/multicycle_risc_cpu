module flopenr #(parameter WIDTH = 64)
(input logic clk, reset, en,
input logic [WIDTH-1:0] d,
output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset)
if (reset) q <= 64'b0;
else if (en) q <= d;

endmodule