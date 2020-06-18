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
		
		$fwrite(assembly_file_out, ".globl _start\n");
		$fwrite(assembly_file_out, ".section .text\n");
		
		foreach(aconfig.subsection_names[i]) begin
			$fwrite(assembly_file_out, $sformatf("%s:\n", aconfig.subsection_names[i]));
			for(int j=0; j<aconfig.num_instructions[i]; j++) begin
				
			end
	
		end

	endfunction
	
	
	
	
	
	static function instruction_base_si get_rand_instruction(int typemask);
		
		instr_category_bm new_mask = get_rand_type_from_mask(typemask);
		
		instruction_base_si hi;
		
		$display("rand:%s", new_mask.name());
		
		if(typemask) begin
			store_instruction_si hi6 = new();
			$cast(hi, hi6);
		end
		else begin
			load_instruction_si hi9 = new();
			$cast(hi, hi9);
		end
		
		return hi;
	endfunction
	
	static function instr_category_bm get_rand_type_from_mask(int mask);
		int rand_pick, bit_pick;
		int bitq[$];
		instr_category_bm new_bm;
		
		for(int i=0;i<32;i++) begin
			if(mask & (1 << i)) bitq.push_back(i);
		end
		
		rand_pick = $urandom_range(bitq.size(), 1);
		
		bit_pick = bitq[rand_pick - 1];
		
		$cast(new_bm, 1 << bit_pick);

		return new_bm;
		
	endfunction
	
endclass
