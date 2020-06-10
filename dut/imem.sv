module imem(masterif.imem io);
  
  //bit[31:0] imemory[0:255];
  byte imemory[int];
  
  initial begin
    $readmemb("prog.data", imemory);
    $display("imem0:%X, %X, %X, %X", imemory[0], imemory[1], imemory[2], imemory[3]);
  end
  
  always_comb
    io.instruction = {imemory[io.pc+3], imemory[io.pc+2], imemory[io.pc+1], imemory[io.pc]};
  endmodule
