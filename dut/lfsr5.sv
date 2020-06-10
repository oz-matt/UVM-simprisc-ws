module lfsr_5bit(
  input logic clk,
  input logic nreset,

  output logic[4:0] data
);

  logic[4:0] data_next;

always_comb begin
  data_next[4] = data[4]^data[1];
  data_next[3] = data[3]^data[0];
  data_next[2] = data[2]^data_next[4];
  data_next[1] = data[1]^data_next[3];
  data_next[0] = data[0]^data_next[2];
end

always @(posedge clk or negedge nreset)
  if(!nreset)
    data <= 5'h1f;
  else
    data <= data_next;

endmodule