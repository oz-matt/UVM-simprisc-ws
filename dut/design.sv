`include "masterif.sv"
`include "defines.sv"
`include "instruction_parser.sv"
`include "imem.sv"
`include "umem.sv"
`include "axim.sv"
`include "adc_handoff.sv"
`include "sindrv.sv"
`include "soc_top.sv"
`include "lfsr5.sv"
  
module cpu (
  input clk,
  input nreset,
  aximem.mem io
);

  masterif mif(.*);

  imem imem_inst(mif.imem);
  umem umem_inst(.io(mif.umem), .mem(io));
  

  instruction_parser instruction(mif.instruction);
  
  
  logic[31:0] jump;
  
  bit take_branch;
  
  bit rd_w_en;
  assign rd_w_en = instruction.name inside {LW, LH, LHU, LB, 
    LBU, ADDI, SLTI, SLTIU, ANDI, ORI, XORI, ADD, SUB, 
    SLT, SLTU, AND, OR, XOR, SLL, SRL, SRA, JAL, SLLI,
    SRLI, SRAI, LUI, AUIPC} ? 1 : 0;
  
  bit on_branch_instrution;
  assign on_branch_instruction = instruction.name inside {BEQ, 
    BNE, BLT, BLTU, BGE, BGEU} ? 1 : 0;
  
  always @(posedge clk) begin
    if(!nreset) begin
      //mif.pc <= 0;
    end
    else begin
      if(instruction.name == JAL)
        mif.pc <= mif.pc + jump;
      else if (instruction.name == JALR)
        mif.pc <= jump;
      else if (on_branch_instruction) begin
        if (take_branch)
          mif.pc <= jump;
        else
          mif.pc <= mif.pc + instruction.size;
      end
      else
        mif.pc <= mif.pc + instruction.size;
    end
  end
  
  
  always_comb begin
    if(instruction.size == 4) begin
    casex ({instruction.aluc, instruction.funct3, instruction.opcode})
      11'bxxxx0110111: instruction.name = LUI;
      11'bxxxx0010111: instruction.name = AUIPC;
      11'bxxxx1101111: instruction.name = JAL;
      11'bx0001100111: instruction.name = JALR;
      11'bx0001100011: instruction.name = BEQ;
      11'bx0011100011: instruction.name = BNE;
      11'bx1001100011: instruction.name = BLT;
      11'bx1011100011: instruction.name = BGE;
      11'bx1101100011: instruction.name = BLTU;
      11'bx1111100011: instruction.name = BGEU;
      11'bx0000000011: instruction.name = LB;
      11'bx0010000011: instruction.name = LH;
      11'bx0100000011: instruction.name = LW;
      11'bx1000000011: instruction.name = LBU;
      11'bx1010000011: instruction.name = LHU;
      11'bx0000100011: instruction.name = SB;
      11'bx0010100011: instruction.name = SH;
      11'bx0100100011: instruction.name = SW;
      11'bx0000010011: instruction.name = ADDI;
      11'bx0100010011: instruction.name = SLTI;
      11'bx0110010011: instruction.name = SLTIU;
      11'bx1000010011: instruction.name = XORI;
      11'bx1100010011: instruction.name = ORI;
      11'bx1110010011: instruction.name = ANDI;
      11'b00010010011: instruction.name = SLLI;
      11'b01010010011: instruction.name = SRLI;
      11'b11010010011: instruction.name = SRAI;
      11'b00000110011: instruction.name = ADD;
      11'b10000110011: instruction.name = SUB;
      11'b00010110011: instruction.name = SLL;
      11'b00100110011: instruction.name = SLT;
      11'b00110110011: instruction.name = SLTU;
      11'b01000110011: instruction.name = XOR;
      11'b01010110011: instruction.name = SRL;
      11'b11010110011: instruction.name = SRA;
      11'b01100110011: instruction.name = OR;
      11'b01110110011: instruction.name = AND;
      11'bx0000001111: instruction.name = FENCE;
      11'b00001110011: 
        if(instruction.ebit == 1'b1)
          instruction.name = EBREAK;
        else
          instruction.name = ECALL;
      default: instruction.name = NOP;
    endcase    
    end
    else if (instruction.size == 2) begin
      casex({instruction.c_ubits, instruction.c_12bit, instruction.c_umbits, instruction.c_lmbits, instruction.c_lbits})
        10'b000xxxxx00: instruction.name = C_ADDI4SPN;
        10'b001xxxxx00: instruction.name = C_FLD;
        10'b010xxxxx00: instruction.name = C_LW;
        10'b011xxxxx00: instruction.name = C_FLW;
        10'b101xxxxx00: instruction.name = C_FSD;
        10'b110xxxxx00: instruction.name = C_SW;
        10'b111xxxxx00: instruction.name = C_FSW;
        10'b000xxxxx01: begin
          if(instruction.instruction[12:2] == 0)
            instruction.name = C_NOP;
          else
            instruction.name = C_ADDI;
        end  
        10'b001xxxxx01: instruction.name = C_JAL;
        10'b010xxxxx01: instruction.name = C_LI;
        10'b100x00xx01: instruction.name = C_SRLI;
        10'b100x01xx01: instruction.name = C_SRAI;
        10'b100x10xx01: instruction.name = C_ANDI;
        10'b1000110001: instruction.name = C_SUB;
        10'b1000110101: instruction.name = C_XOR;
        10'b1000111001: instruction.name = C_OR;
        10'b1000111101: instruction.name = C_AND;
        10'b101xxxxx01: instruction.name = C_J;
        10'b110xxxxx01: instruction.name = C_BEQZ;
        10'b111xxxxx01: instruction.name = C_BNEZ;
        
        10'b000xxxxx10: instruction.name = C_SLLI;
        10'b001xxxxx10: instruction.name = C_FLDSP;
        10'b011xxxxx10: instruction.name = C_FLWSP;
        10'b1000xxxx10: begin
          if(instruction.instruction[6:2] == 0)
            instruction.name = C_JR;
          else
            instruction.name = C_MV;
        end  
        10'b1001xxxx10: begin
          if(instruction.instruction[11:2] == 0)
            instruction.name = C_EBREAK;
          else if(instruction.instruction[6:2] == 0)
            instruction.name = C_JALR;
          else
            instruction.name = C_ADD;
        end  
        10'b101xxxxx10: instruction.name = C_FSDSP;
        10'b110xxxxx10: instruction.name = C_SWSP;
        10'b111xxxxx10: instruction.name = C_FSWSP;
      endcase
    end
  end
  
  logic[31:0] rdbuffer;
  
  always_comb begin
    if(!mif.nreset) begin
      mif.mem_addr = 0;
      jump = 1;
    end
    else begin
      case (instruction.name)
        
        LW: begin //Load 32-bit val at umem[rx[rs1] + imm] into rd
          mif.mem_rw = 0;
          mif.mem_addr = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm);
          rdbuffer = mif.mem_rdata;
          $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        LH: begin //Load 16-bit val (sign extended to 32-bits) at umem[rx[rs1] + imm] into rd
          mif.mem_rw = 0;
          mif.mem_addr = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm);
          rdbuffer = `SIGN_EXTEND32(16, mif.mem_rdata);
          $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        LHU: begin //Load 16-bit val (zero extended to 32-bits) at umem[rx[rs1] + imm] into rd
          mif.mem_rw = 0;
          mif.mem_addr = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm);
          rdbuffer = {16'h0000, mif.mem_rdata[15:0]};
          $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        LB: begin //Load 8-bit val (sign extended to 32-bits) at umem[rx[rs1] + imm] into rd
          mif.mem_rw = 0;
          mif.mem_addr = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm);
          rdbuffer = `SIGN_EXTEND32(8, mif.mem_rdata);
          $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        LBU: begin //Load 8-bit val (zero extended to 32-bits) at umem[rx[rs1] + imm] into rd
          mif.mem_rw = 0;
          mif.mem_addr = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm);
          rdbuffer = {24'h000000, mif.mem_rdata[7:0]};
          $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        SW, SH, SB: begin //Store 32, 16 or 8 bit val from rs2 into umem[rx[rs1] + imm]
          mif.mem_rw = 1; //umem controller uses instruction.funct3 to determine write width
          mif.mem_addr = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.s_imm);
          mif.mem_wdata = mif.rx[instruction.rs2];
          $display("rd; %X", umem.umemory[mif.mem_addr]);
        end
        
        ADDI: begin
          rdbuffer = mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm);
           $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        SLTI: begin
          rdbuffer = ($signed(mif.rx[instruction.rs1]) < $signed(`SIGN_EXTEND32(12, instruction.i_imm))) ? 32'h00000001 : 32'h00000000;
           $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        SLTIU: begin
          rdbuffer = (mif.rx[instruction.rs1] < `SIGN_EXTEND32(12, instruction.i_imm)) ? 32'h00000001 : 32'h00000000;
          $display("rs1: %X, simm: %X", mif.rx[instruction.rs1], `SIGN_EXTEND32(12, instruction.i_imm));
        end
        
        ANDI: begin
          rdbuffer = mif.rx[instruction.rs1] & `SIGN_EXTEND32(12, instruction.i_imm);
          $display("rs1: %X, simm: %X", mif.rx[instruction.rs1], `SIGN_EXTEND32(12, instruction.i_imm));
        end
        
        ORI: begin
          rdbuffer = mif.rx[instruction.rs1] | `SIGN_EXTEND32(12, instruction.i_imm);          
          $display("rs1: %X, simm: %X", mif.rx[instruction.rs1], `SIGN_EXTEND32(12, instruction.i_imm));
        end
        
        XORI: begin
          rdbuffer = mif.rx[instruction.rs1] ^ `SIGN_EXTEND32(12, instruction.i_imm);
          $display("rs1: %b, simm: %b", mif.rx[instruction.rs1], `SIGN_EXTEND32(12, instruction.i_imm));
        end
        
        ADD: begin
          rdbuffer = mif.rx[instruction.rs1] + mif.rx[instruction.rs2];
          $display("rs1: %d, simm: %d", mif.rx[instruction.rs1], mif.rx[instruction.rs2]);
        end
        
        SUB: begin
          rdbuffer = mif.rx[instruction.rs2] - mif.rx[instruction.rs1];
          $display("rs1: %x, simm: %x", mif.rx[instruction.rs1], mif.rx[instruction.rs2]);
        end
        
        SLT: begin
          rdbuffer = $signed(mif.rx[instruction.rs1]) < $signed(mif.rx[instruction.rs2]) ? 32'h00000001 : 32'h00000000;
           $display("rd; %X", mif.rx[instruction.rd]);
        end
        
        SLTU: begin
          rdbuffer = (mif.rx[instruction.rs1] < mif.rx[instruction.rs2]) ? 32'h00000001 : 32'h00000000;
          $display("rs1: %X, simm: %X", mif.rx[instruction.rs1], `SIGN_EXTEND32(12, instruction.i_imm));
        end
        
        AND: begin
          rdbuffer = mif.rx[instruction.rs1] & mif.rx[instruction.rs2];
          $display("rs1: %X, simm: %X", mif.rx[instruction.rs1], mif.rx[instruction.rs2]);
        end
        
        OR: begin
          rdbuffer = mif.rx[instruction.rs1] | mif.rx[instruction.rs2];
          $display("rs1: %X, simm: %X", mif.rx[instruction.rs1], mif.rx[instruction.rs2]);
        end
        
        XOR: begin
          rdbuffer = mif.rx[instruction.rs1] ^ mif.rx[instruction.rs2];
          $display("rs1: %b, simm: %b", mif.rx[instruction.rs1], mif.rx[instruction.rs2]);
        end
        
        SLL: begin
          rdbuffer = mif.rx[instruction.rs1] << {mif.rx[instruction.rs2]}[4:0];
          $display("rs1: %b, simm: %b", mif.rx[instruction.rs1], {mif.rx[instruction.rs2]}[4:0]);
        end
           
        SRL: begin
          rdbuffer = mif.rx[instruction.rs1] >> {mif.rx[instruction.rs2]}[4:0];
          $display("rs1: %b, simm: %b", mif.rx[instruction.rs1], {mif.rx[instruction.rs2]}[4:0]);
        end
                
        SRA: begin
          rdbuffer = $signed(mif.rx[instruction.rs1]) >>> {mif.rx[instruction.rs2]}[4:0];
          $display("rs1: %b, simm: %b", mif.rx[instruction.rs1], {mif.rx[instruction.rs2]}[4:0]);
        end
        
        JAL: begin
          jump = 2 * `SIGN_EXTEND32(20, instruction.j_imm);
          rdbuffer = mif.pc + 4;
          $display("pc:%d, rd: %d jump: %d", mif.pc, mif.rx[instruction.rd], jump);
        end
        
        JALR: begin
          jump = {{mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm)}[31:1], 1'b0};
          rdbuffer = mif.pc + 4;
          $display("pc:%d, rd: %d gump: %d", mif.pc, mif.rx[instruction.rd], {{mif.rx[instruction.rs1] + `SIGN_EXTEND32(12, instruction.i_imm)}[31:1], 1'b0});
        end
        
        BEQ: begin
          jump = mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm);
          take_branch = (mif.rx[instruction.rs1] == mif.rx[instruction.rs2]) ? 1 : 0;
          $display("pc:%d, rx[rs1]:%d, rx[rs2]:%d, bump: %d", mif.pc, mif.rx[instruction.rs1], mif.rx[instruction.rs2], mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm));
        end
        
        BNE: begin
          jump = mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm);
          take_branch = (mif.rx[instruction.rs1] != mif.rx[instruction.rs2]) ? 1 : 0;
          $display("pc:%d, rx[rs1]:%d, rx[rs2]:%d, bump: %d", mif.pc, mif.rx[instruction.rs1], mif.rx[instruction.rs2], mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm));
        end
        
        BLT: begin
          jump = mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm);
          take_branch = ($signed(mif.rx[instruction.rs1]) < $signed(mif.rx[instruction.rs2])) ? 1 : 0;
          $display("pc:%d, rx[rs1]:%d, rx[rs2]:%d, bump: %d", mif.pc, mif.rx[instruction.rs1], mif.rx[instruction.rs2], mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm));
        end
        
        BLTU: begin
          jump = mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm);
          take_branch = (mif.rx[instruction.rs1] < mif.rx[instruction.rs2]) ? 1 : 0;
          $display("pc:%d, rx[rs1]:%d, rx[rs2]:%d, bump: %d", mif.pc, mif.rx[instruction.rs1], mif.rx[instruction.rs2], mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm));
        end
        
        BGE: begin
          jump = mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm);
          take_branch = ($signed(mif.rx[instruction.rs1]) >= $signed(mif.rx[instruction.rs2])) ? 1 : 0;
          $display("pc:%d, rx[rs1]:%d, rx[rs2]:%d, bump: %d", mif.pc, mif.rx[instruction.rs1], mif.rx[instruction.rs2], mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm));
        end
        
        BGEU: begin
          jump = mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm);
          take_branch = (mif.rx[instruction.rs1] >= mif.rx[instruction.rs2]) ? 1 : 0;
          $display("pc:%d, rx[rs1]:%d, rx[rs2]:%d, bump: %d", mif.pc, mif.rx[instruction.rs1], mif.rx[instruction.rs2], mif.pc + 2 * `SIGN_EXTEND32(12, instruction.b_imm));
        end
        
        SLLI: begin
          rdbuffer = mif.rx[instruction.rs1] << instruction.rs2;
          $display("rs1: %b, sha: %b", mif.rx[instruction.rs1], instruction.rs2);
        end
           
        SRLI: begin
          rdbuffer = mif.rx[instruction.rs1] >> instruction.rs2;
          $display("rs1: %b, sha: %b", mif.rx[instruction.rs1], instruction.rs2);
        end
           
        SRAI: begin
          rdbuffer = $signed(mif.rx[instruction.rs1]) >>> instruction.rs2;
          $display("SRAI: rs1: %b, sha: %b", mif.rx[instruction.rs1], instruction.rs2);
        end
        
        LUI: begin
          rdbuffer = {instruction.u_imm, 12'b000000000000};
        end
        
        AUIPC: begin
          rdbuffer = {instruction.u_imm, 12'b000000000000} + mif.pc;
          $display("SRAI: rs1: %b, sha: %b", mif.rx[instruction.rs1], instruction.rs2);
        end
        
        FENCE: begin
        end
          
        ECALL: begin
        end
          
        EBREAK: begin
        end
        
        C_NOP: begin
        end
        
      endcase
    end
  end
  
  always @(posedge clk or negedge mif.nreset) begin
    if(!mif.nreset) begin
      //mif.rx = '{default:32'h00000000};
      mif.rx[0] = 0;
      mif.rx[1] = 0;
      mif.rx[2] = 4;
      mif.rx[3] = 44;
      mif.rx[4] = 'hfffffffe;
    end
    else begin
      if(rd_w_en)
        mif.rx[instruction.rd] <= rdbuffer;      
    end
  end
  
        //$display("lw: addr:%X, rs1:%X, rd:%X, imm:%X, rdata:%X, full:%X, res:%X", mif.mem_addr, instruction.rs1, instruction.rd, instruction.i_imm, mif.mem_rdata, mif.instruction, mif.rx[instruction.rd]);
  
endmodule