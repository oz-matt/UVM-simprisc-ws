import uvm_pkg::*;

//`include "uvm/seq.sv" 
//`include "uvm/driver.sv"

class agt extends uvm_agent;
	`uvm_component_utils(agt)
	
	virtual masterif vif;
	drv drv_inst;
	uvm_sequencer#(seq_packet) drv_side_sequencer;
		iMonitor mon;
		uvm_analysis_port #(seq_packet) analysis_port;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		
		if (is_active == UVM_ACTIVE) begin // is_active flag set for agents containing Seq, Driver and Monitor
																			// is_active flag cleared for agents containing only Monitor
			drv_side_sequencer = uvm_sequencer#(seq_packet)::type_id::create("drv_side_sequencer", this);
			drv_inst = drv::type_id::create("drv", this);
		end
		
				mon = iMonitor::type_id::create("mon", this);
		
				analysis_port = new("analysis_port", this);
		
		uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);
		uvm_config_db#(virtual masterif)::set(this, "*", "vif", vif);
		
	endfunction: build_phase
	
	virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

			if (is_active)
				drv_inst.seq_item_port.connect(drv_side_sequencer.seq_item_export);
		mon.analysis_port.connect(this.analysis_port);
		endfunction: connect_phase

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

		if (vif == null) begin
			`uvm_fatal("CFGERR", "Interface for input agent not set");
		end
	endfunction: end_of_elaboration_phase
		
	task run_phase(uvm_phase phase);
		phase.raise_objection(this); 
		begin seq seq1; 
			seq1 = seq::type_id::create("seq"); 
			seq1.start(drv_side_sequencer); 
		end
		phase.drop_objection(this); 
	endtask
		
endclass