
import uvm_pkg::*;
import riscv_instruction_properties::*;

class arithmetic_instruction_si extends instruction_base_si;

	`uvm_object_utils(arithmetic_instruction_si)

	rand bit[11:0] i_imm;
	rand bit[4:0]  is_shamt;
	rand bit[19:0] u_imm;

	function new(string inst_name = "arithmetic_instruction_si");
		super.new(inst_name);
	endfunction

	virtual function bit[31:0] get_raw_bits();
		case(format) inside
			R_FORMAT: return {get_func7(name), rs2, rs1, get_func3(name), rd, get_opcode(name)};
			U_FORMAT: return {u_imm, rd, get_opcode(name)};
			I_FORMAT_SHIFT: return {get_func7(name), is_shamt, rs1, get_func3(name), rd, get_opcode(name)};
			I_FORMAT: return {i_imm, rs1, get_func3(name), rd, get_opcode(name)};
		endcase
	endfunction
	
	virtual function string get_asm_string();
		case(format) inside
			R_FORMAT: return $sformatf("\t\t%s\tx%0d,x%0d,x%0d", name.name(), rd, rs1, rs2);
			U_FORMAT: return $sformatf("\t\t%s\tx%0d,%0d", name.name(), rd, u_imm);
			I_FORMAT_SHIFT: return $sformatf("\t\t%s\tx%0d,x%0d,%0d", name.name(), rd, rs1, is_shamt);
			I_FORMAT: return $sformatf("\t\t%s\tx%0d,x%0d,%0d", name.name(), rd, rs1, $signed(`SIGN_EXTEND32(12, i_imm)));
		endcase
	endfunction
	
	constraint c_ari {
		format inside {R_FORMAT, U_FORMAT, I_FORMAT, I_FORMAT_SHIFT};
		(format == R_FORMAT) -> name inside {ADD, SLT, SLTU, AND,
			OR, XOR, SLL, SRL, SUB, SRA};
		(format == U_FORMAT) -> name inside {LUI, AUIPC};
		(format == I_FORMAT_SHIFT) -> name inside {SLLI, SRLI, SRAI};
		(format == I_FORMAT) -> name inside {ADDI, SLTI, ANDI, ORI, XORI};
	};

endclass