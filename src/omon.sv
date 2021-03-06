import uvm_pkg::*;

class oMonitor extends uvm_monitor;
	`uvm_component_utils(oMonitor)

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
		//if(vif.mem_rw) begin
		//tr.data = vif.mem_wdata;
		//`uvm_info("Got_Output_Packet", {"\n", vif.mem_wdata}, UVM_MEDIUM);
		//analysis_port.write(tr);
		//end
		end

	endtask: run_phase
endclass: oMonitor