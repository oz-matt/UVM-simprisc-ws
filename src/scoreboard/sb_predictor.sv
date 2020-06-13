class sb_predictor extends uvm_subscriber #(arithmetic_instruction_si);
	`uvm_component_utils(sb_predictor)

	uvm_analysis_port #(arithmetic_instruction_si) results_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		results_ap = new("results_ap", this);
	endfunction

	function void write(arithmetic_instruction_si t);
		arithmetic_instruction_si exp_tr;

		exp_tr = sb_calc_exp(t);
		results_ap.write(exp_tr);
	endfunction 
	
	extern function arithmetic_instruction_si sb_calc_exp(arithmetic_instruction_si t); 
	

endclass 