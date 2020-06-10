module adc_handoff(
  input logic clk,
  output logic[31:0] adcout
);
  
  logic[7:0] adcin [0:255];
  logic[7:0] ctr;
  
  initial begin
    $readmemh("adc.data", adcin);
    ctr = 0;
    adcout = 0;
  end
  
  always @(posedge clk) begin
    ctr <= ctr + 1;
    adcout <= (adcout << 8) | adcin[ctr];
  end
  
endmodule