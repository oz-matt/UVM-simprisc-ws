package simprisc_uvm_includes;
	
	import igen_utils::*;
	import riscv_instruction_properties::*;
	import instruction_sequences::*;
	
	//`include "asmgen/asmgen_data_types.sv"
	`include "asmgen/asm_gen_simple_config_textonly.sv"
	`include "asmgen/simple_generated_instruction_list_textonly.sv"
	
	`include "src/regwriter.sv"

	`include "src/seq_packet.sv"
	`include "src/imon.sv"
	`include "src/omon.sv"
	`include "src/simple_instruction_sequence_textonly.sv"
	`include "src/driver.sv"
	`include "src/agt.sv"
	`include "src/oagt.sv"
	`include "src/scoreboard.sv"

	`include "src/scoreboard/sb_comparator.sv"
	`include "src/scoreboard/sb_predictor.sv"
	`include "src/scoreboard/sb_calc_exp.sv"
	`include "src/scoreboard/tb_scoreboard.sv"

	`include "src/env.sv"
	
	`include "tests/tbase.sv"


endpackage

