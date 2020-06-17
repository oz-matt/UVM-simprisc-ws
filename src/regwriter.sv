
import uvm_pkg::*;

class regwriter extends uvm_component;
	`uvm_component_utils(regwriter)
	
	UVM_FILE regdebugfile;
	virtual masterif                         vif;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		uvm_config_db#(UVM_FILE)::get(null, "", "regdebugfile", regdebugfile);
		uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);
	endfunction
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		foreach(vif.rx[i])
			$fwrite(regdebugfile, "reg%d: %X\n", i, vif.rx[i]);
	endfunction
	
endclass;