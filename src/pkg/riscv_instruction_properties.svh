`ifndef RISCV_INSTRUCTION_PROPERTIES
`define RISCV_INSTRUCTION_PROPERTIES

package riscv_instruction_properties;

	typedef enum bit [4:0] {
		RV32I,
		RV64I,
		RV32M,
		RV64M,
		RV32A,
		RV64A,
		RV32F,
		RV32FC,
		RV64F,
		RV32D,
		RV32DC,
		RV64D,
		RV32C,
		RV64C,
		RV128I,
		RV128C
	} riscv_instr_group_t;

	typedef enum {
		// RV32I instructions
		LUI,
		AUIPC,
		JAL,
		JALR,
		BEQ,
		BNE,
		BLT,
		BGE,
		BLTU,
		BGEU,
		LB,
		LH,
		LW,
		LBU,
		LHU,
		SB,
		SH,
		SW,
		ADDI,
		SLTI,
		SLTIU,
		XORI,
		ORI,
		ANDI,
		SLLI,
		SRLI,
		SRAI,
		ADD,
		SUB,
		SLL,
		SLT,
		SLTU,
		XOR,
		SRL,
		SRA,
		OR,
		AND,
		NOP,
		FENCE,
		FENCEI,
		ECALL,
		EBREAK,
		CSRRW,
		CSRRS,
		CSRRC,
		CSRRWI,
		CSRRSI,
		CSRRCI
	} riscv_instr_name_t;

	typedef enum bit [4:0] {
		ZERO = 5'b00000,
		RA,
		SP,
		GP,
		TP,
		T0,
		T1,
		T2,
		S0,
		S1,
		A0,
		A1,
		A2,
		A3,
		A4,
		A5,
		A6,
		A7,
		S2,
		S3,
		S4,
		S5,
		S6,
		S7,
		S8,
		S9,
		S10,
		S11,
		T3,
		T4,
		T5,
		T6
	} riscv_reg_t;

	typedef enum {
		J_FORMAT=0,
		U_FORMAT=1,
		I_FORMAT=2,
		I_FORMAT_SHIFT=3,
		B_FORMAT,
		R_FORMAT,
		S_FORMAT,
		CI_FORMAT,
		CB_FORMAT,
		CJ_FORMAT,
		CR_FORMAT,
		CL_FORMAT,
		CS_FORMAT,
		CSS_FORMAT,
		CIW_FORMAT
	} riscv_instr_format_t;

	/*typedef enum bit [3:0] {
		LOAD = 0,
		STORE,
		SHIFT,
		ARITHMETIC,
		LOGICAL,
		COMPARE,
		BRANCH,
		JUMP,
		SYNCH,
		SYSTEM,
		COUNTER,
		CSR,
		CHANGELEVEL,
		TRAP,
		INTERRUPT,
		AMO
	} riscv_instr_category_t;
	*/
	
	typedef enum bit[31:0] {
		LOAD            = (1 << 0),
		STORE           = (1 << 1),
		SHIFT           = (1 << 2),
		ARITHMETIC      = (1 << 3),
		LOGICAL         = (1 << 4),
		COMPARE         = (1 << 5),
		BRANCH          = (1 << 6),
		JUMP            = (1 << 7),
		SYNCH           = (1 << 8),
		SYSTEM          = (1 << 9),
		COUNTER         = (1 << 10),
		CSR             = (1 << 11),
		CHANGELEVEL     = (1 << 12),
		TRAP            = (1 << 13),
		INTERRUPT       = (1 << 14),
		AMO             = (1 << 15)
	} instr_category_bm;
	

endpackage

`endif