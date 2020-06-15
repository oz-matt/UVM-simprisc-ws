import uvm_pkg::*;

//`include "uvm/seq.sv" 
//`include "uvm/driver.sv"

class agt extends uvm_agent;
	`uvm_component_utils(agt)
	
	virtual masterif vif;
		iMonitor mon;
		uvm_analysis_port #(load_instruction_si) analysis_port;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		
		
				mon = iMonitor::type_id::create("mon", this);
		
				analysis_port = new("analysis_port", this);
		
		uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);
		uvm_config_db#(virtual masterif)::set(this, "*", "vif", vif);
		
	endfunction: build_phase
	
	virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

		mon.analysis_port.connect(this.analysis_port);
		endfunction: connect_phase

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

		if (vif == null) begin
			`uvm_fatal("CFGERR", "Interface for input agent not set");
		end
	endfunction: end_of_elaboration_phase
	
		
endclass