import uvm_pkg::*;

class sys_env extends uvm_env;
	`uvm_component_utils(sys_env)
	
	tb_scoreboard scbd;
	agt agent;
	oagt oagent;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction: new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		agent = agt::type_id::create("agent", this);
		oagent = oagt::type_id::create("oagent", this);
		scbd = tb_scoreboard::type_id::create ("scbd", this);
	endfunction: build_phase

	virtual function void connect_phase (uvm_phase phase);
		super.connect_phase (phase);
		agent.mon.analysis_port.connect(scbd.axp_in);
		oagent.mon.analysis_port.connect(scbd.axp_out);
	endfunction
	
endclass: sys_env
