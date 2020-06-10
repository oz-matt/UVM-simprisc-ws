`ifndef DEFINES_SV
`define DEFINES_SV

`define SIGN_EXTEND32(n, r) {{(32-n){r[n-1]}}, r[n-1:0]} 
// Sign-extend a value of n bits to 32 bits

typedef enum integer {
    //RV32I base instructions
    LUI, AUIPC, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU,
    BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW, ADDI,
    SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI,
    ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR,
    AND, FENCE, ECALL, EBREAK, NOP, 
  
    //C-extension instructions
    C_ADDI4SPN, C_FLD, C_LW, C_FLW, C_FSD, C_SW, 
    C_FSW, C_NOP, C_ADDI, C_JAL, 
    C_LI, C_SRLI, C_SRAI, C_ANDI, C_SUB, C_XOR, 
    C_OR, C_AND, C_J, C_BEQZ, C_BNEZ, C_SLLI, 
    C_FLDSP, C_FLWSP, C_JR, C_MV, C_EBREAK, 
    C_JALR, C_ADD, C_FSDSP, C_SWSP, C_FSWSP
  } rv32i_t;

typedef enum integer {
    i32BIT, i16BIT
} isize_t;

typedef enum integer {
    ALU_ADD, ALU_SUB, ALU_NOT, 
    ALU_LS, ALU_RS, ALU_AND, ALU_OR, ALU_LT
  } alu_code_t;

`endif