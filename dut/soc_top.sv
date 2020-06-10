module soc_top(
  input logic clk,
  input logic nreset
);
  
  
  mdriver_int#(32,9) vif(.*);
  master_wrapper master_wrapper_inst(.io(vif.slave), .mem(aximem_inst.axim));
  cpu cpu_inst(.*, .io(aximem_inst.mem));
  sindrv sindrv_inst(.io(vif.master));
  aximem aximem_inst();
  
endmodule