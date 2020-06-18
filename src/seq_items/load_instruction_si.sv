
import uvm_pkg::*;
import riscv_instruction_properties::*;

class load_instruction_si extends instruction_base_si;

	`uvm_object_utils(load_instruction_si)

	rand bit[11:0] i_imm;

	function new(string inst_name = "load_instruction_si");
		super.new(inst_name);
	endfunction

	virtual function bit[31:0] get_raw_bits();
		raw_bits = {i_imm, rs1, get_func3(name), rd, get_opcode(name)};
		return raw_bits;
	endfunction

	constraint c_store {
		format inside {I_FORMAT};
		name inside {LW, LH, LHU, LB, LBU};
		i_imm == 0;
	};

endclass

