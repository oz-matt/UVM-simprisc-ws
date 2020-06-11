package simprisc_uvm_includes;
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
endpackage

