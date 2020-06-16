
import uvm_pkg::*;
import riscv_instruction_properties::*;

class store_instruction_si extends instruction_base_si;

  `uvm_object_utils(store_instruction_si)

  rand bit[11:0] s_imm;

  function new(string inst_name = "store_instruction_si");
    super.new(inst_name);
  endfunction

  virtual function bit[31:0] get_raw_bits();

    raw_bits = {s_imm[11:5], rs2, rs1, get_func3(name), s_imm[4:0], get_opcode(name)};

    return raw_bits;
  endfunction

  constraint c_store {
    format inside {S_FORMAT};
    name inside {SW, SH, SB};
  };

endclass
