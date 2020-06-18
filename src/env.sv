import uvm_pkg::*;

class sys_env extends uvm_env;
	`uvm_component_utils(sys_env)

	tb_scoreboard                       scbd;
	agt                                 agent;
	oagt                                oagent;
	drv                                 drv_inst;
	uvm_sequencer#(instruction_base_si) drv_side_sequencer;

	virtual masterif vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	virtual function void start_of_simulation();
		uvm_config_db#(virtual masterif)::get(null, "", "vif", vif);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		agent = agt::type_id::create("agent", this);
		oagent = oagt::type_id::create("oagent", this);
		//scbd = tb_scoreboard::type_id::create ("scbd", this);
		drv_side_sequencer = uvm_sequencer#(instruction_base_si)::type_id::create("drv_side_sequencer", this);
		drv_inst = drv::type_id::create("drv", this);
	endfunction: build_phase

	virtual function void connect_phase (uvm_phase phase);
		super.connect_phase (phase);
		//agent.mon.analysis_port.connect(scbd.axp_in);
		//oagent.mon.analysis_port.connect(scbd.axp_out);
		drv_inst.seq_item_port.connect(drv_side_sequencer.seq_item_export);
	endfunction

endclass: sys_env
