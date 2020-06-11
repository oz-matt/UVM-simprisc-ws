import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	uvm_analysis_imp #(seq_packet, scoreboard) sb_aport;
	uvm_analysis_imp #(seq_packet, scoreboard) sb_outaport;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction: new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		sb_aport  = new("sb_aport", this);
		sb_outaport  = new("sb_outaport", this);
	endfunction: build_phase
	
		virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

	endfunction: connect_phase
	
	virtual function void write (seq_packet data);
		`uvm_info ("write", $sformatf("%m"), UVM_MEDIUM)
		data.print();
	endfunction
	
endclass: scoreboard
