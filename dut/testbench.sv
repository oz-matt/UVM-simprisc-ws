module tb();
	import uvm_pkg::*;
	
	logic clk;
	
	masterif vif(.*);
	soc_top soc_top_inst(.*, .mif(vif));
	
	byte progmem[int]; //Associative array for entire cpu memory space
	
	initial begin
		clk <= 0;
		forever #10 clk <= !clk;
	end
	
	initial begin
		$fsdbDumpfile("novas.fsdb");
		$fsdbDumpvars();
		$fsdbDumpon;
		//#500
		//$finish;
	end
	
	initial begin
		uvm_config_db#(virtual masterif)::set(null, "", "vif", vif);
		run_test();
		end

endmodule
