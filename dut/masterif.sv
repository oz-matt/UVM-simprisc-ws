interface masterif (
  input logic clk,
  input logic nreset
);
  
  logic[31:0] rx [31:0];
  logic[31:0] pc = 32'h80000000;
  
  wire[31:0] rx1;
  wire[31:0] rx2;
  wire[31:0] rx3;
  wire[31:0] rx0;
  assign rx1=rx[1];
  assign rx2=rx[2];
  assign rx3=rx[3];
  assign rx0=rx[0];
  
  logic[31:0] instruction;
  
  logic[31:0] mem_wdata;
  logic[31:0] mem_rdata;
  logic[31:0] mem_addr;
  logic mem_rw;
  
  modport imem (
    input pc,
    output instruction,
    input nreset
  );
  
  modport umem (
    input clk,
    input instruction,
    input mem_wdata,
    output mem_rdata,
    input mem_addr,
    input mem_rw
    //input axi_mem_w,
    //input axi_mem_addr,
    //input axi_mem_data
  );
  
endinterface

interface aximem ();

  logic[31:0] axi_mem_data;
  logic[8:0] axi_mem_addr;
  logic axi_mem_w;
  
  modport mem (
    input axi_mem_w,
    input axi_mem_addr,
    input axi_mem_data
  );
  
  modport axim (
    output axi_mem_w,
    output axi_mem_addr,
    output axi_mem_data
  );
  
endinterface
