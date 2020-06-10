module tb();
  logic clk, nreset;
  
  initial begin
    clk <= 0;
    forever #1 clk <= !clk;
  end
  
  soc_top soc_top_inst(.*);
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    nreset <= 0;
    //vif.nreset <= 0;
    #4
    nreset <= 1;
    //vif.nreset <= 1;

    //vif.execute_write(0, 'hb4b4b4b4);

    //vif.execute_write(0, 'hb4b4b4b4);
    //vif.execute_read(0); //Value then avilable in vif.so_data

    //$display("Read data: %X", vif.so_data);
   
    
    #50;
    //disp_rx(cpu_inst.mif.rx);
    //disp_umem(cpu_inst.umem_inst.umemory);
    $finish;
  end
  
endmodule

function void disp_rx(input logic[31:0] h[31:0]);
  $display("rx[0]: %X", h[0]);
  $display("rx[1]: %X", h[1]);
  $display("rx[2]: %X", h[2]);
  $display("rx[3]: %b", h[3]);
endfunction

function void disp_umem(input reg[7:0] h[0:255]);
  $display("umem[0]: %X", h[0]);
  $display("umem[1]: %X", h[1]);
  $display("umem[2]: %X", h[2]);
  $display("umem[3]: %X", h[3]);
  $display("umem[4]: %X", h[4]);
  $display("umem[5]: %X", h[5]);
endfunction
