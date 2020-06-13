
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
		CSRRCI,
		// RV32M instructions
		MUL,
		MULH,
		MULHSU,
		MULHU,
		DIV,
		DIVU,
		REM,
		REMU,
		// RV64M instructions
		MULW,
		DIVW,
		DIVUW,
		REMW,
		REMUW,
		// RV32F instructions
		FLW,
		FSW,
		FMADD_S,
		FMSUB_S,
		FNMSUB_S,
		FNMADD_S,
		FADD_S,
		FSUB_S,
		FMUL_S,
		FDIV_S,
		FSQRT_S,
		FSGNJ_S,
		FSGNJN_S,
		FSGNJX_S,
		FMIN_S,
		FMAX_S,
		FCVT_W_S,
		FCVT_WU_S,
		FMV_X_W,
		FEQ_S,
		FLT_S,
		FLE_S,
		FCLASS_S,
		FCVT_S_W,
		FCVT_S_WU,
		FMV_W_X,
		FCVT_L_S,
		FCVT_LU_S,
		FCVT_S_L,
		FCVT_S_LU,
		// RV64I
		LWU,
		LD,
		SD,
		ADDIW,
		SLLIW,
		SRLIW,
		SRAIW,
		ADDW,
		SUBW,
		SLLW,
		SRLW,
		SRAW,
		// RV32C
		C_LW,
		C_SW,
		C_LWSP,
		C_SWSP,
		C_ADDI4SPN,
		C_ADDI,
		C_LI,
		C_ADDI16SP,
		C_LUI,
		C_SRLI,
		C_SRAI,
		C_ANDI,
		C_SUB,
		C_XOR,
		C_OR,
		C_AND,
		C_BEQZ,
		C_BNEZ,
		C_SLLI,
		C_MV,
		C_EBREAK,
		C_ADD,
		C_NOP,
		C_J,
		C_JAL,
		C_JR,
		C_JALR,
		// RV64C
		C_ADDIW,
		C_SUBW,
		C_ADDW,
		C_LD,
		C_SD,
		C_LDSP,
		C_SDSP,
		// RV128C
		C_SRLI64,
		C_SRAI64,
		C_SLLI64,
		C_LQ,
		C_SQ,
		C_LQSP,
		C_SQSP,
		// RV32FC
		C_FLW,
		C_FSW,
		C_FLWSP,
		C_FSWSP,
		// RV32DC
		C_FLD,
		C_FSD,
		C_FLDSP,
		C_FSDSP,
		// RV32A
		LR_W,
		SC_W,
		AMOSWAP_W,
		AMOADD_W,
		AMOAND_W,
		AMOOR_W,
		AMOXOR_W,
		AMOMIN_W,
		AMOMAX_W,
		AMOMINU_W,
		AMOMAXU_W,
		// RV64A
		LR_D,
		SC_D,
		AMOSWAP_D,
		AMOADD_D,
		AMOAND_D,
		AMOOR_D,
		AMOXOR_D,
		AMOMIN_D,
		AMOMAX_D,
		AMOMINU_D,
		AMOMAXU_D,
		// Supervisor instruction
		DRET,
		MRET,
		URET,
		SRET,
		WFI,
		SFENCE_VMA,
		// You can add other instructions here
		INVALID_INSTR
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

	typedef enum integer {
		J_FORMAT,
		U_FORMAT,
		I_FORMAT,
		I_FORMAT_SHIFT,
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

	typedef enum bit [3:0] {
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
	} riscv_instr_cateogry_t;
	
	
	function bit [6:0] get_opcode();
		case (instr_name) inside
			LUI                                                          : get_opcode = 7'b0110111;
			AUIPC                                                        : get_opcode = 7'b0010111;
			JAL                                                          : get_opcode = 7'b1101111;
			JALR                                                         : get_opcode = 7'b1100111;
			BEQ, BNE, BLT, BGE, BLTU, BGEU                               : get_opcode = 7'b1100011;
			LB, LH, LW, LBU, LHU, LWU, LD                                : get_opcode = 7'b0000011;
			SB, SH, SW, SD                                               : get_opcode = 7'b0100011;
			ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, NOP    : get_opcode = 7'b0010011;
			ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, MUL,
			MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU                    : get_opcode = 7'b0110011;
			ADDIW, SLLIW, SRLIW, SRAIW                                   : get_opcode = 7'b0011011;
			MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU                    : get_opcode = 7'b0110011;
			FENCE, FENCEI                                                : get_opcode = 7'b0001111;
			ECALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI   : get_opcode = 7'b1110011;
			ADDW, SUBW, SLLW, SRLW, SRAW, MULW, DIVW, DIVUW, REMW, REMUW : get_opcode = 7'b0111011;
			ECALL, EBREAK, URET, SRET, MRET, DRET, WFI, SFENCE_VMA       : get_opcode = 7'b1110011;
			default : `uvm_fatal(`gfn, $sformatf("Unsupported instruction %0s", instr_name.name()))
		endcase
	endfunction

	// Get opcode for compressed instruction
	function bit [1:0] get_c_opcode();
		case (instr_name) inside
			C_ADDI4SPN, C_FLD, C_FLD, C_LQ, C_LW, C_FLW,
			C_LD, C_FSD, C_SQ, C_SW, C_FSW, C_SD            : get_c_opcode = 2'b00;
			C_NOP, C_ADDI, C_JAL, C_ADDIW, C_LI, C_ADDI16SP,
			C_LUI, C_SRLI, C_SRLI64, C_SRAI, C_SRAI64,
			C_ANDI, C_SUB, C_XOR, C_OR, C_AND, C_SUBW,
			C_ADDW, C_J, C_BEQZ, C_BNEZ                     : get_c_opcode = 2'b01;
			C_SLLI, C_SLLI64, C_FLDSP, C_LQSP, C_LWSP,
			C_FLWSP, C_LDSP, C_JR, C_MV, C_EBREAK, C_JALR,
			C_ADD, C_FSDSP, C_SQSP, C_SWSP, C_FSWSP, C_SDSP : get_c_opcode = 2'b10;
			default : `uvm_fatal(`gfn, $sformatf("Unsupported instruction %0s", instr_name.name()))
		endcase
	endfunction

	function bit [2:0] get_func3();
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
			LWU        : get_func3 = 3'b110;
			LD         : get_func3 = 3'b011;
			SD         : get_func3 = 3'b011;
			ADDIW      : get_func3 = 3'b000;
			SLLIW      : get_func3 = 3'b001;
			SRLIW      : get_func3 = 3'b101;
			SRAIW      : get_func3 = 3'b101;
			ADDW       : get_func3 = 3'b000;
			SUBW       : get_func3 = 3'b000;
			SLLW       : get_func3 = 3'b001;
			SRLW       : get_func3 = 3'b101;
			SRAW       : get_func3 = 3'b101;
			MUL        : get_func3 = 3'b000;
			MULH       : get_func3 = 3'b001;
			MULHSU     : get_func3 = 3'b010;
			MULHU      : get_func3 = 3'b011;
			DIV        : get_func3 = 3'b100;
			DIVU       : get_func3 = 3'b101;
			REM        : get_func3 = 3'b110;
			REMU       : get_func3 = 3'b111;
			MULW       : get_func3 = 3'b000;
			DIVW       : get_func3 = 3'b100;
			DIVUW      : get_func3 = 3'b101;
			REMW       : get_func3 = 3'b110;
			REMUW      : get_func3 = 3'b111;
			C_ADDI4SPN : get_func3 = 3'b000;
			C_FLD      : get_func3 = 3'b001;
			C_LQ       : get_func3 = 3'b001;
			C_LW       : get_func3 = 3'b010;
			C_FLW      : get_func3 = 3'b011;
			C_LD       : get_func3 = 3'b011;
			C_FSD      : get_func3 = 3'b101;
			C_SQ       : get_func3 = 3'b101;
			C_SW       : get_func3 = 3'b110;
			C_FSW      : get_func3 = 3'b111;
			C_SD       : get_func3 = 3'b111;
			C_NOP      : get_func3 = 3'b000;
			C_ADDI     : get_func3 = 3'b000;
			C_JAL      : get_func3 = 3'b001;
			C_ADDIW    : get_func3 = 3'b001;
			C_LI       : get_func3 = 3'b010;
			C_ADDI16SP : get_func3 = 3'b011;
			C_LUI      : get_func3 = 3'b011;
			C_SRLI     : get_func3 = 3'b100;
			C_SRLI64   : get_func3 = 3'b100;
			C_SRAI     : get_func3 = 3'b100;
			C_SRAI64   : get_func3 = 3'b100;
			C_ANDI     : get_func3 = 3'b100;
			C_SUB      : get_func3 = 3'b100;
			C_XOR      : get_func3 = 3'b100;
			C_OR       : get_func3 = 3'b100;
			C_AND      : get_func3 = 3'b100;
			C_SUBW     : get_func3 = 3'b100;
			C_ADDW     : get_func3 = 3'b100;
			C_J        : get_func3 = 3'b101;
			C_BEQZ     : get_func3 = 3'b110;
			C_BNEZ     : get_func3 = 3'b111;
			C_SLLI     : get_func3 = 3'b000;
			C_SLLI64   : get_func3 = 3'b000;
			C_FLDSP    : get_func3 = 3'b001;
			C_LQSP     : get_func3 = 3'b001;
			C_LWSP     : get_func3 = 3'b010;
			C_FLWSP    : get_func3 = 3'b011;
			C_LDSP     : get_func3 = 3'b011;
			C_JR       : get_func3 = 3'b100;
			C_MV       : get_func3 = 3'b100;
			C_EBREAK   : get_func3 = 3'b100;
			C_JALR     : get_func3 = 3'b100;
			C_ADD      : get_func3 = 3'b100;
			C_FSDSP    : get_func3 = 3'b101;
			C_SQSP     : get_func3 = 3'b101;
			C_SWSP     : get_func3 = 3'b110;
			C_FSWSP    : get_func3 = 3'b111;
			C_SDSP     : get_func3 = 3'b111;
			ECALL, EBREAK, URET, SRET, MRET, DRET, WFI, SFENCE_VMA : get_func3 = 3'b000;
			default : `uvm_fatal(`gfn, $sformatf("Unsupported instruction %0s", instr_name.name()))
		endcase
	endfunction

	function bit [6:0] get_func7();
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
			SLLIW  : get_func7 = 7'b0000000;
			SRLIW  : get_func7 = 7'b0000000;
			SRAIW  : get_func7 = 7'b0100000;
			ADDW   : get_func7 = 7'b0000000;
			SUBW   : get_func7 = 7'b0100000;
			SLLW   : get_func7 = 7'b0000000;
			SRLW   : get_func7 = 7'b0000000;
			SRAW   : get_func7 = 7'b0100000;
			MUL    : get_func7 = 7'b0000001;
			MULH   : get_func7 = 7'b0000001;
			MULHSU : get_func7 = 7'b0000001;
			MULHU  : get_func7 = 7'b0000001;
			DIV    : get_func7 = 7'b0000001;
			DIVU   : get_func7 = 7'b0000001;
			REM    : get_func7 = 7'b0000001;
			REMU   : get_func7 = 7'b0000001;
			MULW   : get_func7 = 7'b0000001;
			DIVW   : get_func7 = 7'b0000001;
			DIVUW  : get_func7 = 7'b0000001;
			REMW   : get_func7 = 7'b0000001;
			REMUW  : get_func7 = 7'b0000001;
			ECALL  : get_func7 = 7'b0000000;
			EBREAK : get_func7 = 7'b0000000;
			URET   : get_func7 = 7'b0000000;
			SRET   : get_func7 = 7'b0001000;
			MRET   : get_func7 = 7'b0011000;
			DRET   : get_func7 = 7'b0111101;
			WFI    : get_func7 = 7'b0001000;
			SFENCE_VMA: get_func7 = 7'b0001001;
			default : `uvm_fatal(`gfn, $sformatf("Unsupported instruction %0s", instr_name.name()))
		endcase
	endfunction
	
endpackage