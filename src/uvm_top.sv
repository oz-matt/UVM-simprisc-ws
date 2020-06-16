program automatic uvm_top;
  import uvm_pkg::*;
  import riscv_instruction_properties::*;

  initial begin
    $timeformat(-9, 1, "ns", 10);
    run_test();
  end

endprogram
