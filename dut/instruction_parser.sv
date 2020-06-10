interface instruction_parser (
  input logic[31:0] instruction
);
  
  //32-bit instruction parsing
  wire[6:0] opcode;
  wire[4:0] rd,rs1,rs2;
  wire[2:0] funct3;
  wire[6:0] funct7;
  wire[11:0] i_imm;  
  wire[11:0] s_imm;
  wire[11:0] b_imm;
  wire[19:0] u_imm;
  wire[19:0] j_imm;
  wire aluc;
  wire ebit;
  
  //16-bit instruction parsing
  wire[2:0] c_ubits;
  wire[1:0] c_lbits;
  wire[0:0] c_12bit;
  wire[1:0] c_umbits;
  wire[1:0] c_lmbits;
  
  rv32i_t name;
  byte size;
  
  always_comb begin
    if(instruction[0] == 1 && instruction[1] == 1)
      size = 4;
    else
      size = 2;
  end

  
  assign opcode = (size == 4) ? instruction[6:0] : 0;
  assign rd = (size == 4) ? instruction[11:7] : 0;
  assign funct3 = (size == 4) ? instruction[14:12] : 0;
  assign rs1 = (size == 4) ? instruction[19:15] : 0;
  assign rs2 = (size == 4) ? instruction[24:20] : 0;
  assign funct7 = (size == 4) ? instruction[31:25] : 0;
  assign i_imm = (size == 4) ? instruction[31:20] : 0;
  assign u_imm = (size == 4) ? instruction[31:12] : 0;
  assign aluc = (size == 4) ? instruction[30] : 0;
  assign ebit = (size == 4) ? instruction[20] : 0;
  
      assign s_imm = (size == 4) ? {instruction[31:25], instruction[11:7]} : 0;
      assign j_imm = (size == 4) ? {instruction[31], instruction[19:12], instruction[20], instruction[30:21]} : 0;
      assign b_imm = (size == 4) ? {instruction[31], instruction[7], instruction[30:25], instruction[11:8]} : 0;
  
  assign c_ubits = (size == 2) ? instruction[15:13] : 0;
    assign c_lbits =  (size == 2) ? instruction[1:0] : 0;
      assign c_12bit =  (size == 2) ? instruction[12] : 0;
  assign c_umbits =  (size == 2) ? instruction[11:10] : 0;
  assign c_lmbits =  (size == 2) ? instruction[6:5] : 0;
    
endinterface
