import uvm_pkg::*;

class test_base extends uvm_test;
	`uvm_component_utils(test_base)

	sys_env          env;
	virtual masterif vif;
	UVM_FILE         regdebugfile;
	regwriter rwriter;
	
	UVM_FILE assembly_file_out;
	asm_gen_simple_config_textonly aconfig;
	
	string section_list[$] = {"_start", "_main", "8", "test_done", "write_tohost", "exit"};
	int num_instructions_per_section[$] = {32, 10, 1, 1, 1, 2};
	instr_category_bm categories_in_each_section[$] = {LOAD, LOAD | STORE | ARITHMETIC, STORE, STORE, STORE, STORE};
		
	function new(string name, uvm_component parent);
		super.new(name, parent);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
	endfunction

	virtual function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);

		uvm_root::get().print_topology();
		uvm_factory::get().print();
		
		assembly_file_out = $fopen("out/arithmetic_test.S", "w");

		uvm_config_db#(UVM_FILE)::set(null, "*", "assembly_file_out", assembly_file_out);
		
		uvm_config_db#(UVM_FILE)::get(null, "", "regdebugfile", regdebugfile);
		set_report_id_file_hier("REGFILE", regdebugfile);
		set_report_id_action("REGFILE", UVM_DISPLAY | UVM_LOG);

		uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);

	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = sys_env::type_id::create("env", this);
		rwriter = regwriter::type_id::create("rwriter", this);
		
		aconfig = new(section_list, num_instructions_per_section, categories_in_each_section);
		
		uvm_config_db#(asm_gen_simple_config_textonly)::set(this, "*", "asm_gen_simple_config_textonly", aconfig);
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
	
	virtual function void final_phase(uvm_phase phase);
		super.final_phase(phase);
		$fclose(assembly_file_out);
	endfunction
	
endclass