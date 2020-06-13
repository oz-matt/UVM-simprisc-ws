
import uvm_pkg::*;
import riscv_instruction_properties::*;

class arithmetic_instruction_si extends uvm_sequence_item;
	
	rand riscv_instr_format_t format;
	rand riscv_instr_name_t name;
	
	rand bit[4:0] rs1, rs2, rd;
	
	rand bit[11:0] i_imm;
	rand bit[4:0] is_shamt;
	rand bit[19:0] u_imm;
	
	
	constraint c_solveorder {
		solve format before name;
		format inside {R_FORMAT, U_FORMAT, I_FORMAT, I_FORMAT_SHIFT};
	}
	
	constraint c_ari {
		(format == R_FORMAT) -> name inside {ADD, SLT, SLTU, AND, 
					OR, XOR, SLL, SRL, SUB, SRA};
		(format == U_FORMAT) -> name inside {LUI, AUIPC};
		(format == I_FORMAT_SHIFT) -> name inside {SLLI, SRLI, SRAI};
		(format == I_FORMAT) -> name inside {ADDI, SLTI, ANDI, ORI, XORI};
	};
	
endclass