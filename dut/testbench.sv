module tb();
	import uvm_pkg::*;
	
	logic clk;
	
	masterif vif(.*);
	soc_top soc_top_inst(.*, .mif(vif));
	
	byte progmem[int]; //Associative array for entire cpu memory space
	
	UVM_FILE regdebugfile;
	
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
		//$fwrite(regdebugfile, "yoyo");
		regdebugfile = $fopen("reg_debug_file.txt", "w");
		uvm_config_db#(virtual masterif)::set(null, "", "vif", vif);
		uvm_config_db#(UVM_FILE)::set(null, "*", "regdebugfile", regdebugfile);
		
		run_test();
		$fclose(regdebugfile);
	end

endmodule
