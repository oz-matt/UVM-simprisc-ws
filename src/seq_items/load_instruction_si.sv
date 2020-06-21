
import uvm_pkg::*;
import riscv_instruction_properties::*;

class load_instruction_si extends instruction_base_si;
	`uvm_object_utils(load_instruction_si)
	
	rand bit[11:0] i_imm;
	

	function new(string inst_name = "load_instruction_si");
		super.new(inst_name);
	endfunction

	virtual function bit[31:0] get_raw_bits();
		return {i_imm, rs1, get_func3(name), rd, get_opcode(name)};
	endfunction

	virtual function string get_asm_string();
		return $sformatf("\t\t%s\tx%0d,%0d(x%0d)", name.name(), rd, $signed(`SIGN_EXTEND32(12, i_imm)), rs1);
	endfunction
	
	constraint c_store {
		format inside {I_FORMAT};
		name inside {LW, LH, LHU, LB, LBU};
	};

endclass

