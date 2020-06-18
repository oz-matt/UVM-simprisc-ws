import uvm_pkg::*;

class simple_generated_instruction_list_textonly extends uvm_object;
	`uvm_object_utils(simple_generated_instruction_list_textonly)
	
	asm_subsection_t asm_subsections[$];
	load_instruction_si lins[$];
	
	string sub1, sub2;
	
	asm_gen_simple_config_textonly aconfig;
	UVM_FILE assembly_file_out;
	
	function new(string name = "simple_generated_instruction_list_textonly");
		super.new(name);
		
		uvm_config_db#(asm_gen_simple_config_textonly)::get(null, "", "asm_gen_simple_config_textonly", aconfig);
		uvm_config_db#(UVM_FILE)::get(null, "", "assembly_file_out", assembly_file_out);
		
		$fwrite(".globl _start\n");
		$fwrite(".section .text\n");
		
		foreach(aconfig.subsection_names[i]) begin
			$fwrite($sformatf("%s:\n", aconfig.subsection_names[i]));
			for(int j=0; j<aconfig.num_instructions[i]; j++) begin
				
			end
	
		end

	endfunction
	
endclass
