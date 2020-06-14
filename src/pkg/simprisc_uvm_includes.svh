package simprisc_uvm_includes;
	
	`include "src/pkg/riscv_instruction_properties.svh"
	`include "src/seq_items/instruction_base_si.sv"
	//`include "src/seq_items/arithmetic_instruction_si.sv"
	
	`include "src/seq_packet.sv"
	`include "src/imon.sv" 
	`include "src/omon.sv"
	`include "src/seq.sv"
	`include "src/driver.sv" 
	`include "src/agt.sv"
	`include "src/oagt.sv"
	`include "src/scoreboard.sv"
	
	`include "src/scoreboard/sb_comparator.sv"
	`include "src/scoreboard/sb_predictor.sv"
	`include "src/scoreboard/sb_calc_exp.sv"
	`include "src/scoreboard/tb_scoreboard.sv" 

	`include "src/env.sv" 
	
	`include "src/tbase.sv" 
	
endpackage

