class sb_predictor extends uvm_subscriber #(instruction_base_si);
	`uvm_component_utils(sb_predictor)

	uvm_analysis_port #(instruction_base_si) results_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		results_ap = new("results_ap", this);
	endfunction

	function void write(instruction_base_si t);
		instruction_base_si exp_tr;

		exp_tr = sb_calc_exp(t);
		results_ap.write(exp_tr);
	endfunction 
	
	extern function instruction_base_si sb_calc_exp(instruction_base_si t); 
	

endclass 