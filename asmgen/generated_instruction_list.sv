import uvm_pkg::*;

class generated_instruction_list extends uvm_object;
	`uvm_object_utils(generated_instruction_list)
	
	asm_section_s asm_sections[$];
	
	function new(string name = "generated_instruction_list");
		super.new(name);
		`uvm_warning("REGFILE", $sformatf("yikes:%d", 7));
	endfunction
	
endclass
