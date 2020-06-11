
class riscv_instruction_32b extends uvm_object;
	
	riscv_instr_category_t category;
	riscv_instr_group_t group; // Not implemented yet
	
	rand riscv_instr_name_t name;
	
	rand bit[3:0] rd, rs1, rs2;
	rand bit[11:0] i_imm;  
	rand bit[11:0] s_imm;
	rand bit[11:0] b_imm;
	rand bit[19:0] u_imm;
	rand bit[19:0] j_imm;
	
	
	bit[31:0] rawbits;
	
	function new(
				riscv_instr_group_t requested_group,
				riscv_instr_category_t requested_category
		);
		
		category = requested_category;
    group = requested_group;
	endfunction
	
	
	constraint c_instruction_by_category {
		category == LOAD -> name inside {LB, LH, LW, LBU, LHU};
		category == STORE -> name inside {SB, SH, SW};
		category == SHIFT -> name inside {SLL, SLLI, SRL, SRLI, SRA, SRAI};
		category == ARITHMETIC -> name inside {ADD, ADDI, NOP, SUB, LUI, AUIPC};
		category == LOGICAL -> name inside {XOR, XORI, OR, ORI, AND, ANDI};
		category == COMPARE -> name inside {SLT, SLTI, SLTU, SLTIU};
		category == BRANCH -> name inside {BEQ, BNE, BLT, BGE, BLTU, BGEU};
		category == JUMP -> name inside {JAL, JALR};
		category == SYNCH -> name inside {FENCE, FENCEI};
		category == SYSTEM -> name inside {ECALL, EBREAK, URET, SRET, MRET, DRET, WFI};
		//category == COUNTER -> name inside {};
		category == CSR -> name inside {CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI};
		//category == CHANGELEVEL -> name inside {};
		//category == TRAP -> name inside {};
		//category == INTERRUPT -> name inside {};
		//category == AMO -> name inside {};
	}
	
endclass