
import uvm_pkg::*;
import riscv_instruction_properties::*;

class instruction_base_si extends uvm_sequence_item;
	
	rand riscv_instr_format_t format;
	rand riscv_instr_name_t name;
	
	rand bit[4:0] rs1, rs2, rd;
	
	bit[31:0] raw_bits;
	
	
	`uvm_object_utils(instruction_base_si)
	
	
	function new(string inst_name = "instruction_base_si");
		super.new(inst_name);
		endfunction
		
	virtual function bit[31:0] get_raw_bits();
		return raw_bits;
	endfunction
	
	function bit [6:0] get_opcode(riscv_instr_name_t instr_name);
		case (instr_name) inside
			LUI                                                          : get_opcode = 7'b0110111;
			AUIPC                                                        : get_opcode = 7'b0010111;
			JAL                                                          : get_opcode = 7'b1101111;
			JALR                                                         : get_opcode = 7'b1100111;
			BEQ, BNE, BLT, BGE, BLTU, BGEU                               : get_opcode = 7'b1100011;
			LB, LH, LW, LBU, LHU                                : get_opcode = 7'b0000011;
			SB, SH, SW                                               : get_opcode = 7'b0100011;
			ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, NOP    : get_opcode = 7'b0010011;
			ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND            : get_opcode = 7'b0110011;
			FENCE, FENCEI                                                : get_opcode = 7'b0001111;
			ECALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI   : get_opcode = 7'b1110011;
			endcase
	endfunction

	function bit [2:0] get_func3(riscv_instr_name_t instr_name);
		case (instr_name) inside
			JALR       : get_func3 = 3'b000;
			BEQ        : get_func3 = 3'b000;
			BNE        : get_func3 = 3'b001;
			BLT        : get_func3 = 3'b100;
			BGE        : get_func3 = 3'b101;
			BLTU       : get_func3 = 3'b110;
			BGEU       : get_func3 = 3'b111;
			LB         : get_func3 = 3'b000;
			LH         : get_func3 = 3'b001;
			LW         : get_func3 = 3'b010;
			LBU        : get_func3 = 3'b100;
			LHU        : get_func3 = 3'b101;
			SB         : get_func3 = 3'b000;
			SH         : get_func3 = 3'b001;
			SW         : get_func3 = 3'b010;
			ADDI       : get_func3 = 3'b000;
			NOP        : get_func3 = 3'b000;
			SLTI       : get_func3 = 3'b010;
			SLTIU      : get_func3 = 3'b011;
			XORI       : get_func3 = 3'b100;
			ORI        : get_func3 = 3'b110;
			ANDI       : get_func3 = 3'b111;
			SLLI       : get_func3 = 3'b001;
			SRLI       : get_func3 = 3'b101;
			SRAI       : get_func3 = 3'b101;
			ADD        : get_func3 = 3'b000;
			SUB        : get_func3 = 3'b000;
			SLL        : get_func3 = 3'b001;
			SLT        : get_func3 = 3'b010;
			SLTU       : get_func3 = 3'b011;
			XOR        : get_func3 = 3'b100;
			SRL        : get_func3 = 3'b101;
			SRA        : get_func3 = 3'b101;
			OR         : get_func3 = 3'b110;
			AND        : get_func3 = 3'b111;
			FENCE      : get_func3 = 3'b000;
			FENCEI     : get_func3 = 3'b001;
			ECALL      : get_func3 = 3'b000;
			EBREAK     : get_func3 = 3'b000;
			CSRRW      : get_func3 = 3'b001;
			CSRRS      : get_func3 = 3'b010;
			CSRRC      : get_func3 = 3'b011;
			CSRRWI     : get_func3 = 3'b101;
			CSRRSI     : get_func3 = 3'b110;
			CSRRCI     : get_func3 = 3'b111;
			ECALL, EBREAK : get_func3 = 3'b000;
		endcase
	endfunction

	function bit [6:0] get_func7(riscv_instr_name_t instr_name);
		case (instr_name)
			SLLI   : get_func7 = 7'b0000000;
			SRLI   : get_func7 = 7'b0000000;
			SRAI   : get_func7 = 7'b0100000;
			ADD    : get_func7 = 7'b0000000;
			SUB    : get_func7 = 7'b0100000;
			SLL    : get_func7 = 7'b0000000;
			SLT    : get_func7 = 7'b0000000;
			SLTU   : get_func7 = 7'b0000000;
			XOR    : get_func7 = 7'b0000000;
			SRL    : get_func7 = 7'b0000000;
			SRA    : get_func7 = 7'b0100000;
			OR     : get_func7 = 7'b0000000;
			AND    : get_func7 = 7'b0000000;
			FENCE  : get_func7 = 7'b0000000;
			FENCEI : get_func7 = 7'b0000000;
			ECALL  : get_func7 = 7'b0000000;
			EBREAK : get_func7 = 7'b0000000;
		endcase
	endfunction
	
		function string output2string();
			return $sformatf("data=%X", raw_bits);
		endfunction
		
		function string convert2string();
			return $sformatf("data=%X", raw_bits);
		endfunction
endclass