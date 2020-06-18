import uvm_pkg::*;

class asm_gen_simple_config_textonly extends uvm_object;
	
	string subsection_names[$];
	int num_instructions[$];
	instr_category_bm allowed_types[$];
	
	function new(const ref string names[$], const ref int num_i[$], const ref instr_category_bm at[$]);
		subsection_names = names;
		num_instructions = num_i;
		allowed_types = at;
	endfunction
	
endclass;
