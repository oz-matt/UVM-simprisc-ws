package simprisc_uvm_includes;

	`include "src/pkg/riscv_instruction_properties.svh"
	`include "src/seq_items/instruction_base_si.sv"
	`include "src/seq_items/arithmetic_instruction_si.sv"
	`include "src/seq_items/store_instruction_si.sv"
	`include "src/seq_items/load_instruction_si.sv"
	
	`include "asmgen/asmgen_data_types.sv"
	`include "asmgen/asm_gen_simple_config_textonly.sv"
	`include "asmgen/simple_generated_instruction_list_textonly.sv"
	
	`include "src/regwriter.sv"

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

