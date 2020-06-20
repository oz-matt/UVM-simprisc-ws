`ifndef IGEN_UTILS
`define IGEN_UTILS

package igen_utils;
	
	import riscv_instruction_properties::*;
	import instruction_sequences::*;
	
	function instruction_base_si get_rand_instruction(int typemask);
		
		instr_category_bm new_mask = get_rand_type_from_mask(typemask);
		instruction_base_si ret;
		
		case(new_mask)
			LOAD : begin
				load_instruction_si li = new();
				ret = li;
			end
			STORE : begin
				store_instruction_si si = new();
				ret = si;
			end
			ARITHMETIC : begin
				arithmetic_instruction_si ai = new();
				ret = ai;
			end
		endcase
		
		return ret;
	endfunction
	
	function instr_category_bm get_rand_type_from_mask(int mask);
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
	
endpackage

`endif
