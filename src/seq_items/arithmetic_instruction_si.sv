
import uvm_pkg::*;
import riscv_instruction_properties::*;

class arithmetic_instruction_si;// extends instruction_base_si;
	
	function new();
		super.new(name);
		case(format) inside
			
			R_FORMAT:
				raw_bits = {get_func7(name), rs2, rs1, get_func3(name), rd, get_opcode(name)};
			
			U_FORMAT:
				raw_bits = {u_imm, rd, get_opcode(name)};
			
			I_FORMAT_SHIFT:
				raw_bits = {get_func7(name), is_shamt, rs1, get_func3(name), rd, get_opcode(name)};

			I_FORMAT:
				raw_bits = {i_imm, rs1, get_func3(name), rd, get_opcode(name)};

		endcase
	endfunction
	
endclass