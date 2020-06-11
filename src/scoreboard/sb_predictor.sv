class sb_predictor extends uvm_subscriber #(seq_packet);
	`uvm_component_utils(sb_predictor)

	uvm_analysis_port #(seq_packet) results_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		results_ap = new("results_ap", this);
	endfunction

	function void write(seq_packet t);
		seq_packet exp_tr;

		exp_tr = sb_calc_exp(t);
		results_ap.write(exp_tr);
	endfunction 
	
	extern function seq_packet sb_calc_exp(seq_packet t); 
	

endclass 