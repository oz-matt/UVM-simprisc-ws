import uvm_pkg::*;

class iMonitor extends uvm_monitor;
	`uvm_component_utils(iMonitor)

	virtual masterif vif;

	uvm_analysis_port #(instruction_base_si) analysis_port;


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);

		analysis_port = new("analysis_port", this);

	endfunction: build_phase
	virtual task run_phase(uvm_phase phase);

		instruction_base_si tr;
		forever begin
			@(posedge vif.clk);
			//tr = instruction_base_si::type_id::create("tr", this);
			//tr.data = vif.instruction_raw;
			//$display("raw: %X", vif.instruction_raw);
			//`uvm_info("Got_Input_Packet", {"\n", vif.instruction_raw}, UVM_MEDIUM);
			analysis_port.write(tr);
		end

	endtask: run_phase
endclass: iMonitor