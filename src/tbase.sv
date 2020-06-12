class test_base extends uvm_test;
	`uvm_component_utils(test_base)
	
	sys_env env;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction

	virtual function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		uvm_root::get().print_topology();
		uvm_factory::get().print();
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		env = sys_env::type_id::create("env", this);
	endfunction
	
	
	task run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_warning("", "Hello World!");
		phase.raise_objection(this); 
		begin seq seq1; 
			seq1 = seq::type_id::create("seq"); 
			seq1.start(env.drv_side_sequencer); 
		end
		phase.drop_objection(this); 
	endtask
endclass