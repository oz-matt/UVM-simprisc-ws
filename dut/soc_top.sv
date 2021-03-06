`include "dut/masterif.sv"
`include "dut/defines.sv"
`include "dut/instruction_parser.sv"
//`include "dut/imem.sv"
`include "dut/umem.sv"
`include "dut/axim.sv"
`include "dut/adc_handoff.sv"
`include "dut/sindrv.sv"
`include "dut/design.sv"
`include "dut/lfsr5.sv"
	
	module soc_top(
	input logic clk,
	masterif mif
);
	
	
	mdriver_int#(32,9) vif(.clk(clk), .nreset(mif.nreset));
		
	master_wrapper master_wrapper_inst(.io(vif.slave), .mem(aximem_inst.axim));
	cpu cpu_inst(.*, .io(aximem_inst.mem), .mif(mif));
	sindrv sindrv_inst(.io(vif.master));
	aximem aximem_inst();
	
endmodule