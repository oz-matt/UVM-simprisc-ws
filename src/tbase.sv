import uvm_pkg::*;

class test_base extends uvm_test;
	`uvm_component_utils(test_base)

	sys_env          env;
	virtual masterif vif;
	UVM_FILE         regdebugfile;
	regwriter rwriter;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction

	virtual function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);

		uvm_root::get().print_topology();
		uvm_factory::get().print();

		uvm_config_db#(UVM_FILE)::get(null, "", "regdebugfile", regdebugfile);
		set_report_id_file_hier("REGFILE", regdebugfile);
		set_report_id_action("REGFILE", UVM_DISPLAY | UVM_LOG);

		uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);


	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = sys_env::type_id::create("env", this);
		rwriter = regwriter::type_id::create("rwriter", this);
	endfunction


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		begin seq seq1;
			seq1 = seq::type_id::create("seq");
			seq1.start(env.drv_side_sequencer);
		end
		phase.drop_objection(this);

	endtask
endclass